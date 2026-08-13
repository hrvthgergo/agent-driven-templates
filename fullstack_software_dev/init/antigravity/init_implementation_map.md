# Implementation Map: `/init` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/init` workflow within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to the documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `fullstack_software_dev/init/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md), [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md), [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md), and [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, baselines, and state machine rules so they can be implemented in any AI agent environment (e.g. OpenAI Codex, Claude Code, Cursor, or Antigravity).
*   **Antigravity Implementation Guideline**: This document (`init_implementation_map.md`) is the specific, concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining multi-step state machine nodes (e.g. `init.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing baselines and prompting laws (e.g. `init-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures and scripts for scaffolding and verification (e.g. `init-scaffolder/SKILL.md`).
    *   **Hooks (`hooks/`)**: Interceptor shell scripts enforcing safety gates prior to Git commits (e.g. `pre-commit-plan-validator.sh`).
    *   **Templates (`templates/`)**: Standardized starter document formats deployed into `agent-workspace/plans/<branch_name>/` (e.g. `PROCESS_STATUS.md`, `phase-1-summary.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and `/grill-me` alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Hybrid Docker Strategy** | [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L71-L95) | Rule & Skill Primitives | `rules/init-grill.md` (Baseline 1) & `skills/init-scaffolder/SKILL.md` |
| **Pure Control Plane (`agent-workspace/`) & Sub-Repo Layout** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md) | Rule & Skill Primitives | `rules/init-grill.md` (Baseline 2) & `skills/init-scaffolder/SKILL.md` |
| **Process Mode Selection (Quick & Simple vs. Full)** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L57-L75) | Rule & Workflow Primitives | `rules/init-grill.md` & `workflows/init.md` |
| **Sequential Q1–Q11 Neutral Q&A Schema** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L51-L189) | Rule & Workflow Primitives | `rules/init-grill.md` & `workflows/init.md` |
| **Permanent Q&A Audit Log (`GRILL_STATUS.md`)** | [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md) & `/grill-me` Q3 | Rule & Template Primitives | `rules/init-grill.md` & `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` |
| **Branch Governance & Matrix (`PROCESS_STATUS.md`)** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/init.md` |
| **Pure Relative Symlinks & 3-Part Check** | [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L7-L35) & `/grill-me` Q5 | Skill Primitive | `skills/init-scaffolder/SKILL.md` |
| **Decoupled Brownfield Flow (No Restructuring)** | [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L126-L134) | Workflow & Skill Primitives | `workflows/init.md` & `skills/init-scaffolder/SKILL.md` |
| **Pre-Commit Safety Interceptor** | [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L169-L179) & `/grill-me` Q2 | Hook Primitive | `hooks/pre-commit-plan-validator.sh` |
| **Workflow Context Notification Law** | [user_guide.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/user_guide.md#L53-L67) | Rule, Workflow & Template Primitives | `rules/init-grill.md`, `workflows/init.md` & `templates/PROCESS_STATUS.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Clean & Delete Existing Guard Assets

*   **List of Actions**:
    1.  Inspect directory `fullstack_software_dev/init/antigravity/guards/`.
    2.  If `fullstack_software_dev/init/antigravity/guards/` exists and contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`, `hooks/`), remove all existing sources inside `fullstack_software_dev/init/antigravity/guards/`.
*   **Reasons & Design Decision Links**:
    *   *Clean Slate & Idempotency Guarantee*: Ensures that prior, partial, or outdated guard files are completely purged before scaffolding new master guard assets, guaranteeing a clean, repeatable, and idempotent implementation run.

---

### Step 2: Scaffold Antigravity Guard Master Directory Tree

*   **List of Actions**:
    1.  Create Antigravity tier-3 guard root directory: `fullstack_software_dev/init/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `fullstack_software_dev/init/antigravity/guards/workflows/`
        *   `fullstack_software_dev/init/antigravity/guards/rules/`
        *   `fullstack_software_dev/init/antigravity/guards/templates/`
        *   `fullstack_software_dev/init/antigravity/guards/skills/init-scaffolder/`
        *   `fullstack_software_dev/init/antigravity/guards/hooks/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Implements the decision from `/grill-me` Question 1 alignment and `summary.md` 3-Tier scaffold rationale to maintain master Antigravity guard primitives under `fullstack_software_dev/init/antigravity/guards/` for central management before deploying into target project `.agents/` directories during `/init`.
    *   *Folder Taxonomy*: Strictly mirrors the agentic control directory structure documented in [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md#L9-L16).

---

### Step 3: Implement Stateful Workflow Playbook (`workflows/init.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/antigravity/guards/workflows/init.md`.
    2.  Define YAML frontmatter (`name: init`, `description: Bootstrapping workflow for Guards framework in Antigravity`).
    3.  Implement the 7-step state machine execution nodes using Antigravity workflow syntax:
        *   **Node S1 (Check Environment & Branch Initialization)**: Executes `docker info` to verify Docker engine availability/privileges, initializes Git context, creates/checks out the `initial` branch for greenfield runs, or creates/checks out a `feature/<feature_name>` branch for re-runs in an already initialized workspace.
        *   **Node S2 (Q&A Grill Gate)**: Invokes the interview engine adhering to `rules/init-grill.md`.
        *   **Node S3 (Lightweight Layer Scan & Linking)**: Surface-level layer directory scanning without codebase restructuring.
        *   **Node S4 (Execution Acceptance Gate)**: Synthesizes gathered info, displays understanding summary and planned steps, and requests user approval (or bypasses prompt in `--auto` mode).
        *   **Node S5 (Scaffolding Workspace & `PROCESS_STATUS.md`)**: Invokes `skills/init-scaffolder/SKILL.md` to deploy `agent-workspace/` control structures, `plans/<branch_name>/` subfolder, `codebase-devops` sub-repo (`.github/`, `docker/`), `codebase-*` sub-repo skeletons, relative symlinks, `.gitkeep` files, and initial status templates.
        *   **Node S6 (Git Hook Registration & Remote Setup)**: Registers remote origins and installs `hooks/pre-commit-plan-validator.sh`.
        *   **Node S7 (Initialization Done)**: Reports initialization summary and available next commands (`/plan` or `/process`).
    4.  Implement CLI parameter handling:
        *   `/init`: Default interactive execution (creates `initial` branch on greenfield; creates `feature/<feature_name>` branch on re-runs).
        *   `/init --auto`: Automatic execution mode. Bypasses interactive Node S4 acceptance prompt and executes all planned scaffolding tasks.
        *   `/init --feature <feature_name>`: Explicitly creates Git branch `feature/<feature_name>` and deploys feature-bound `PROCESS_STATUS.md`.
        *   `/init --add-layer <layer_name>`: Introduces a new sub-repo `codebase-<layer_name>`, registers its `src/` symlink, provisions its `Dockerfile`, and updates `codebase-devops/docker/docker-compose.yml`.
        *   `/init --dry-run`: Previews proposed files, symlinks, Docker configs, and status sheets without writing to disk.
        *   `/init --force`: Overwrites default `.agents/` rules/workflows while preserving custom phase blueprints.
*   **Reasons & Design Decision Links**:
    *   *Step-by-Step Lifecycle*: Realizes the 7-node execution design documented in [init_workflow.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L75-L180).
    *   *Parameter Behaviors*: Implements parameter rules documented in [init_workflow.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L194-L211) and `/grill-me` alignment.
    *   *Decoupled Brownfield Rule*: Enforces the no-restructuring constraint during `/init`, referencing [init_workflow.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L26-L28).

---

### Step 4: Implement Neutral Q&A Grill Rule Guard (`rules/init-grill.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/antigravity/guards/rules/init-grill.md`.
    2.  Encode **Unchangeable Baseline Enforcement**:
        *   *Baseline 1*: Hybrid Docker Handling Strategy (zero questions asked).
        *   *Baseline 2*: Pure Agent Control Plane & Sub-Repository Layout (zero questions asked).
    3.  Encode **Prompting Law**:
        *   Forbid all `[Recommended]` labels.
        *   Enforce neutral choice lists with a mandatory final free-text input option (`Other / Free-text (...)`).
    4.  Encode **Sequential Q1 to Q10 Execution Prompts**:
        *   Q1 (Scope & Purpose), Q2 (Local System Folders with Q2.a path listing & version-control auto-detection for remotes, Q2.b folder creation), Q3 (Cloud Docs with scan failure clarification), Q4 (Additional Remotes Q4.a), Q5 (Cloud Provider Q5.a), Q6 (Architecture Pattern), Q7 (Layer Scope), Q8 (Software Stack), Q9 (Agent Guiders), and Q10 (Summary Verification & Open Reflection).
    5.  Encode **Audit Log Persistence**:
        *   Maintain `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` permanently alongside `PROCESS_STATUS.md` as an audit log of all Q&A questions and answers.
*   **Reasons & Design Decision Links**:
    *   *Baselines*: Implements unchangeable baselines documented in [init_questions.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L12-L30).
    *   *Q1–Q10 Sequence & Neutral Law*: Implements the exact question list, neutral option formatting, Q2.a version-control auto-detection, Q3 scan clarification, and Q10 recap matrix documented in [init_questions.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L51-L189).
    *   *Audit Persistence*: Realizes the permanent audit log decision from `/grill-me` Question 3 alignment and [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md).

---

### Step 5: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/antigravity/guards/templates/PROCESS_STATUS.md`:
        *   Header with Target Release/Feature, Git Branch, Date, and Active Workflow.
        *   **Block 1 (Workflow Execution Matrix)**: Status table tracking `/init`, `/process`, `/plan` (with sub-rows 3.1–3.6 for Phase 1 to Phase 6), `/implement`, `/verify`, and `/release`.
        *   **Block 2 (Datestamped Daily Execution History)**: Immutable daily log format timestamped by `### [YYYY-MM-DD]`.
    2.  Create `fullstack_software_dev/init/antigravity/guards/templates/phase-1-summary.md`:
        *   Sections for Project Purpose, Scope, Key Milestones, Documentation URLs, Software Architecture Pattern, Tech Stack, and Workspace Folder Maps.
*   **Reasons & Design Decision Links**:
    *   *Process Guard*: Implements the 2-block release and feature lifecycle document documented in [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md).
    *   *Plan Status Consolidation*: Realizes the decision to consolidate 6-phase planning status into `PROCESS_STATUS.md` Block 1, removing `PLAN_STATUS.md`.
    *   *Phase 1 Blueprint*: Provides the initial architectural summary file scaffolded during Step 4 as specified in [init_workflow.md Node C1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L67-L70).

---

### Step 6: Implement Multi-Repo & Hybrid Docker Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/antigravity/guards/skills/init-scaffolder/SKILL.md` with YAML frontmatter (`name: init-scaffolder`, `description: Antigravity skill for workspace scaffolding, relative symlinking, and Docker provisioning`).
    2.  Define **Directory Scaffolding & `.gitkeep` Preservation Procedures**:
        *   Create `agent-workspace/` (`.agents/` with `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`; `plans/<branch_name>/`; `docs/`; `src/`).
        *   Create `codebase-devops/` sub-repository (`.github/workflows/`, `docker/`, `config/`, `src/`, `tests/`).
        *   Create `codebase-<layer_name>` sub-repositories (`src/`, `config/`, `tests/`, `.github/workflows/`).
        *   Provision a `.gitkeep` file inside **every scaffolded directory node** to guarantee that empty placeholder folders (e.g. `skills/`, `hooks/`, `sidecars/`) and scaffolded sub-repo layouts are fully tracked, preserved, and synchronized on remote Git origins immediately after `/init` runs.
    3.  Define **Relative Symbolic Linking & 3-Part Verification Procedures**:
        *   Create relative symlinks under `agent-workspace/src/` (e.g., `ln -s ../../codebase-devops/src devops`, `ln -s ../../codebase-layout/src layout`, `ln -s ../../codebase-engine/src engine`).
        *   Assert **symlink purity**: Every entry point inside `agent-workspace/src/` MUST be a relative symlink pointing to an underlying `codebase-*` sub-repo.
        *   Execute 3-part verification check: (1) verify symlink attribute exists, (2) confirm link target resolves to an active directory catching dangling links, and (3) assert relative pathing for cross-machine/CI portability.
    4.  Define **Hybrid Docker Scaffolding Procedures**:
        *   Scaffold `codebase-devops/docker/dev.Dockerfile` (agent sandbox) and `codebase-devops/docker/docker-compose.yml` (orchestrator).
        *   Scaffold standalone `Dockerfile` specs inside each defined `codebase-<layer_name>` sub-repository.
    5.  Define **Brownfield Folder Linking Procedures**:
        *   Link existing source/doc folders into `phase-1-summary.md` without running any codebase restructuring.
*   **Reasons & Design Decision Links**:
    *   *Multi-Repo Symlinks & Verification*: Implements relative symlinking and the 3-part verification check established in [multi_repo_architecture.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L8-L34) and `/grill-me` Question 5 alignment.
    *   *Hybrid Docker Handling Strategy*: Implements the containerization setup specified in [multi_repo_architecture.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L71-L95).
    *   *Brownfield Decoupling*: Ensures `/init` links folders without refactoring, linking to [init_workflow.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L26-L28).

---

### Step 7: Implement Pre-Commit Validator Safety Hook (`hooks/pre-commit-plan-validator.sh`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/antigravity/guards/hooks/pre-commit-plan-validator.sh`.
    2.  Write bash validation logic:
        *   Check active Git branch and resolve corresponding plan path `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`.
        *   Verify that `PROCESS_STATUS.md` contains Block 1 and Block 2 formatting.
        *   Check that required phase blueprints exist for active in-progress workflows.
        *   Exit with code `0` if valid; exit with code `1` and print error trace if validation fails.
    3.  Add installation instructions for Step 5 (S5) (`cp` to `.git/hooks/pre-commit` and `chmod +x`).
*   **Reasons & Design Decision Links**:
    *   *Safety Interceptor*: Implements the pre-commit validation hook specified in [init_workflow.md Node S6](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L169-L179) and `/grill-me` Question 2 alignment.

---

### Step 8: Verification & Testing

*   **List of Actions**:
    1.  Validate execution permissions on shell scripts (`chmod +x fullstack_software_dev/init/antigravity/guards/hooks/pre-commit-plan-validator.sh`).
    2.  Verify YAML frontmatter in `workflows/init.md`, `rules/init-grill.md`, and `skills/init-scaffolder/SKILL.md`.
    3.  Verify all markdown links across created guard files to ensure no broken references exist.
    4.  Verify full structural alignment with [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md).
*   **Reasons & Design Decision Links**:
    *   *Quality Assurance*: Ensures all master guard artifacts are syntax-valid, executable, and fully ready for deployment during `/init`.

---

### Step 9: Workflow E2E Testing

*   **List of Actions**:
    1.  Execute the end-to-end greenfield test scenario collected and designed in [init_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/antigravity/init_tests.md) inside an isolated test sandbox (`/tmp/test-init-workspace`).
    2.  Simulate `/init` command execution and prompt responses for Q1 through Q10.
    3.  Run and evaluate all automated validation assertions:
        *   Verify Docker engine status (`docker info`) and `initial` branch creation (`git branch --show-current`).
        *   Assert permanent audit log creation (`agent-workspace/plans/initial/GRILL_STATUS.md`).
        *   Assert Node S4 Execution Acceptance Gate prompt summary presentation and acceptance record in `GRILL_STATUS.md` (and `--auto` bypass mode execution).
        *   Assert `agent-workspace/` control directory scaffold (`.agents/rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/initial/`).
        *   Assert `codebase-devops/` infrastructure sub-repo scaffold (`.github/workflows/`, `docker/dev.Dockerfile`, `docker/docker-compose.yml`, `config/`).
        *   Assert `agent-workspace/plans/initial/PROCESS_STATUS.md` matrix and daily history log entries.
        *   Assert `agent-workspace/plans/initial/phase-1-summary.md` blueprint metadata.
        *   Assert layer sub-repository creation (`codebase-layout/`, `codebase-engine/`).
        *   Assert relative symbolic links under `agent-workspace/src/` (`devops`, `layout`, `engine` $\rightarrow$ `../../codebase-X/src`) and execute the 3-part verification check.
        *   Assert symlink purity (no non-symlink folders inside `agent-workspace/src/`).
        *   Assert pre-commit safety hook installation (`.git/hooks/pre-commit` executable check).
    4.  Evaluate test pass/fail metrics and record validation results.
*   **Reasons & Design Decision Links**:
    *   *Final Validation Round*: Serves as the final validation round to evaluate the operational behavior and complete integration of all created master guard primitives (`workflows/init.md`, `rules/init-grill.md`, `skills/init-scaffolder/SKILL.md`, `hooks/pre-commit-plan-validator.sh`, and templates) against the test scenario in [init_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/antigravity/init_tests.md).

---

## 4. Verification & Readiness Checklist

- `[ ]` Step 1: Clean & Delete Existing Guard Assets (`fullstack_software_dev/init/antigravity/guards/`)
- `[ ]` Step 2: Scaffold Antigravity Guard Master Directory Tree (`fullstack_software_dev/init/antigravity/guards/`)
- `[ ]` Step 3: Implement Stateful Workflow Playbook (`workflows/init.md`)
- `[ ]` Step 4: Implement Neutral Q&A Grill Rule (`rules/init-grill.md`)
- `[ ]` Step 5: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)
- `[ ]` Step 6: Implement Multi-Repo & Hybrid Docker Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)
- `[ ]` Step 7: Implement Pre-Commit Validator Hook (`hooks/pre-commit-plan-validator.sh`)
- `[ ]` Step 8: Perform Syntax, Link, and Execution Verification
- `[ ]` Step 9: Execute Workflow E2E Testing (`init_tests.md` final validation round)
