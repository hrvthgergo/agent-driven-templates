# Implementation Map: `/init` Workflow Guards Creation

This document defines the step-by-step implementation plan for creating the concrete **Guards** (Workflows, Rules, Templates, Skills, and Hooks) that govern the `/init` workflow. Each step details the planned actions and technical reasons, explicitly linking back to the documented design decisions.

---

## 1. Overview & Objectives

The objective of this phase is to construct the master guard assets under `fullstack_software_dev/init/guards/`. 

### Role of this Implementation Map vs. Theoretical Baselines
*   **Theoretical & Architectural Baselines**: [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md), [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md), [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md), and [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, baselines, and state machine rules so they can be implemented in any AI agent framework (e.g. OpenAI Codex, Claude Code, Cursor, or Antigravity).
*   **Antigravity Execution Guideline**: This document (`implementation_map.md`) is the specific, concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** by creating master guard assets (`workflows/init.md`, `rules/init-grill.md`, `templates/PROCESS_STATUS.md`, `templates/phase-1-summary.md`, `skills/init-scaffolder/SKILL.md`, `hooks/pre-commit-plan-validator.sh`) under `fullstack_software_dev/init/guards/`.

---

## 2. Documented Design Decision Matrix

The implementation plan directly realizes the following design blueprints and `/grill-me` alignment decisions:

| Design Decision / Principle | Documented Source File | Applied Guard Component |
| :--- | :--- | :--- |
| **Hybrid Docker Handling Strategy** | [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L25-L53) | `rules/init-grill.md` (Baseline 1) & `skills/init-scaffolder/SKILL.md` |
| **Standard Guards Folder Layout** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md) | `rules/init-grill.md` (Baseline 2) & `skills/init-scaffolder/SKILL.md` |
| **Sequential Q1–Q10 Neutral Q&A Schema** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L51-L189) | `rules/init-grill.md` & `workflows/init.md` |
| **Permanent Q&A Audit Log (`GRILL_STATUS.md`)** | [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md) & `/grill-me` Q3 | `rules/init-grill.md` & `templates/` |
| **Release/Feature Governance (`PROCESS_STATUS.md`)** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md) | `templates/PROCESS_STATUS.md` & `workflows/init.md` |
| **Relative Symlinks & 3-Part Check** | [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L10-L24) & `/grill-me` Q5 | `skills/init-scaffolder/SKILL.md` |
| **Decoupled Brownfield Flow (No Restructuring)** | [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L14-L15) | `workflows/init.md` & `skills/init-scaffolder/SKILL.md` |
| **Pre-Commit Safety Interceptor** | [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L87-L88) & `/grill-me` Q2 | `hooks/pre-commit-plan-validator.sh` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Scaffold Guard Master Directory Tree

*   **List of Actions**:
    1.  Create root directory: `fullstack_software_dev/init/guards/`.
    2.  Create subdirectories:
        *   `fullstack_software_dev/init/guards/workflows/`
        *   `fullstack_software_dev/init/guards/rules/`
        *   `fullstack_software_dev/init/guards/templates/`
        *   `fullstack_software_dev/init/guards/skills/init-scaffolder/`
        *   `fullstack_software_dev/init/guards/hooks/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Implements the decision from `/grill-me` Question 1 alignment to maintain master guard templates under `fullstack_software_dev/init/guards/` for central management before deploying into target project `.agents/` directories during `/init`.
    *   *Folder Taxonomy*: Strictly mirrors the agentic control directory structure documented in [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md#L10-L16).

---

### Step 2: Implement Stateful Workflow Playbook (`workflows/init.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/guards/workflows/init.md`.
    2.  Define YAML frontmatter (`name: init`, `description: Bootstrapping workflow for Guards framework`).
    3.  Implement the 6-step state machine execution nodes:
        *   **Node S1 (Check Environment)**: Executes `docker info` to verify Docker engine availability and privileges.
        *   **Node S2 (Q&A Grill Gate)**: Invokes the interview engine adhering to `rules/init-grill.md`.
        *   **Node S3 (Lightweight Layer Scan & Linking)**: Surface-level layer directory scanning without codebase restructuring.
        *   **Node S4 (Scaffolding Workspace & `PROCESS_STATUS.md`)**: Invokes `skills/init-scaffolder/SKILL.md` to deploy `.agents/`, symlinks, Docker files, and initial status templates.
        *   **Node S5 (Git Hook Registration)**: Registers remote origin and installs `hooks/pre-commit-plan-validator.sh`.
        *   **Node S6 (Initialization Done)**: Reports initialization summary and available next commands.
    4.  Implement CLI parameter handling:
        *   `/init --release <version>`: Creates Git branch `release/<version>` and deploys release-bound `PROCESS_STATUS.md`.
        *   `/init --feature <feature_name>`: Creates Git branch `feature/<feature_name>` and deploys feature-bound `PROCESS_STATUS.md`.
        *   `/init --add-layer <layer_name>`: Introduces a new sub-repo `codebase-<layer_name>`, registers its `src/` symlink, provisions its `Dockerfile`, and updates `docker-compose.yml`.
        *   `/init --dry-run`: Previews proposed files, symlinks, Docker configs, and status sheets without writing to disk.
        *   `/init --force`: Overwrites default `.agents/` rules/workflows while preserving custom phase blueprints.
*   **Reasons & Design Decision Links**:
    *   *Step-by-Step Lifecycle*: Realizes the 6-node execution design documented in [init_workflow.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L62-L89).
    *   *Parameter Behaviors*: Implements parameter rules documented in [init_workflow.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L96-L103) and `/grill-me` Question 4 flag alignment.
    *   *Decoupled Brownfield Rule*: Enforces the no-restructuring constraint during `/init`, referencing [init_workflow.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L14-L15).

---

### Step 3: Implement Neutral Q&A Grill Rule Guard (`rules/init-grill.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/guards/rules/init-grill.md`.
    2.  Encode **Unchangeable Baseline Enforcement**:
        *   *Baseline 1*: Hybrid Docker Handling Strategy (zero questions asked).
        *   *Baseline 2*: Standard Guards folder layout (zero questions asked).
    3.  Encode **Prompting Law**:
        *   Forbid all `[Recommended]` labels.
        *   Enforce neutral choice lists with a mandatory final free-text input option (`Other / Free-text (...)`).
    4.  Encode **Sequential Q1 to Q10 Execution Prompts**:
        *   Q1 (Scope & Purpose), Q2 (Local System Folders with Q2.a path listing & version-control auto-detection for remotes, Q2.b folder creation), Q3 (Cloud Docs with scan failure clarification), Q4 (Additional Remotes Q4.a), Q5 (Cloud Provider Q5.a), Q6 (Architecture Pattern), Q7 (Layer Scope), Q8 (Software Stack), Q9 (Agent Guiders), and Q10 (Summary Verification & Open Reflection).
    5.  Encode **Audit Log Persistence**:
        *   Maintain `.agents/plans/GRILL_STATUS.md` permanently alongside `PROCESS_STATUS.md` as an audit log of all Q&A questions and answers.
*   **Reasons & Design Decision Links**:
    *   *Baselines*: Implements unchangeable baselines documented in [init_questions.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L12-L30).
    *   *Q1–Q10 Sequence & Neutral Law*: Implements the exact question list, neutral option formatting, Q2.a version-control auto-detection, Q3 scan clarification, and Q10 recap matrix documented in [init_questions.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md#L51-L189).
    *   *Audit Persistence*: Realizes the permanent audit log decision from `/grill-me` Question 3 alignment and [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md).

---

### Step 4: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/guards/templates/PROCESS_STATUS.md`:
        *   Header with Target Release/Feature, Git Branch, Date, and Active Workflow.
        *   **Block 1 (Workflow Execution Matrix)**: Status table tracking `/init`, `/process-history`, `/plan` (with sub-rows 3.1–3.5 for Phase 1 to Phase 5), `/implement`, `/verify`, and `/release`.
        *   **Block 2 (Datestamped Daily Execution History)**: Immutable daily log format timestamped by `### [YYYY-MM-DD]`.
    2.  Create `fullstack_software_dev/init/guards/templates/phase-1-summary.md`:
        *   Sections for Project Purpose, Scope, Key Milestones, Documentation URLs, Software Architecture Pattern, Tech Stack, and Workspace Folder Maps.
*   **Reasons & Design Decision Links**:
    *   *Process Guard*: Implements the 2-block release and feature lifecycle document documented in [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md).
    *   *Plan Status Consolidation*: Realizes the decision to consolidate 5-phase planning status into `PROCESS_STATUS.md` Block 1, removing `PLAN_STATUS.md`.
    *   *Phase 1 Blueprint*: Provides the initial architectural summary file scaffolded during Step 4 as specified in [init_workflow.md Node C1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L57).

---

### Step 5: Implement Multi-Repo & Hybrid Docker Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/guards/skills/init-scaffolder/SKILL.md` with YAML frontmatter (`name: init-scaffolder`).
    2.  Define **Directory Scaffolding Procedures**:
        *   Create `antigravity-workspace/` and `.agents/` (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/`).
    3.  Define **Relative Symbolic Linking & 3-Part Verification Procedures**:
        *   Create relative symlinks under `src/` (e.g., `ln -s ../../codebase-layout/src src/layout`).
        *   Execute 3-part verification check: (1) verify symlink attribute exists, (2) confirm link target resolves to an active directory catching dangling links, and (3) assert relative pathing for cross-machine/CI portability.
    4.  Define **Hybrid Docker Scaffolding Procedures**:
        *   Scaffold `docker/dev.Dockerfile` (agent sandbox) and `docker/docker-compose.yml` (orchestrator) in `antigravity-workspace/`.
        *   Scaffold standalone `Dockerfile` specs inside each defined `codebase-<layer_name>` sub-repository.
    5.  Define **Brownfield Folder Linking Procedures**:
        *   Link existing source/doc folders into `phase-1-summary.md` without running any codebase restructuring.
*   **Reasons & Design Decision Links**:
    *   *Multi-Repo Symlinks & Verification*: Implements relative symlinking and the 3-part verification check established in [multi_repo_architecture.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L10-L24) and `/grill-me` Question 5 alignment.
    *   *Hybrid Docker Handling Strategy*: Implements the containerization setup specified in [multi_repo_architecture.md Section 2](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md#L25-L53).
    *   *Brownfield Decoupling*: Ensures `/init` links folders without refactoring, linking to [init_workflow.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L14-L15).

---

### Step 6: Implement Pre-Commit Validator Safety Hook (`hooks/pre-commit-plan-validator.sh`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/init/guards/hooks/pre-commit-plan-validator.sh`.
    2.  Write bash validation logic:
        *   Check that `.agents/plans/PROCESS_STATUS.md` exists.
        *   Verify that `PROCESS_STATUS.md` contains Block 1 and Block 2 formatting.
        *   Check that required phase blueprints exist for active in-progress workflows.
        *   Exit with code `0` if valid; exit with code `1` and print error trace if validation fails.
    3.  Add installation instructions for Step 5 (S5) (`cp` to `.git/hooks/pre-commit` and `chmod +x`).
*   **Reasons & Design Decision Links**:
    *   *Safety Interceptor*: Implements the pre-commit validation hook specified in [init_workflow.md Node S5](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md#L87-L88) and `/grill-me` Question 2 alignment.

---

### Step 7: Verification & Testing

*   **List of Actions**:
    1.  Validate execution permissions on shell scripts (`chmod +x fullstack_software_dev/init/guards/hooks/pre-commit-plan-validator.sh`).
    2.  Verify YAML frontmatter in `workflows/init.md`, `rules/init-grill.md`, and `skills/init-scaffolder/SKILL.md`.
    3.  Verify all markdown links across created guard files to ensure no broken references exist.
    4.  Verify full structural alignment with [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md).
*   **Reasons & Design Decision Links**:
    *   *Quality Assurance*: Ensures all master guard artifacts are syntax-valid, executable, and fully ready for deployment during `/init`.

---

## 4. Verification & Readiness Checklist

- `[ ]` Step 1: Scaffold Guard Master Directory Tree (`fullstack_software_dev/init/guards/`)
- `[ ]` Step 2: Implement Workflow Playbook (`workflows/init.md`)
- `[ ]` Step 3: Implement Neutral Q&A Grill Rule (`rules/init-grill.md`)
- `[ ]` Step 4: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)
- `[ ]` Step 5: Implement Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)
- `[ ]` Step 6: Implement Pre-Commit Validator Hook (`hooks/pre-commit-plan-validator.sh`)
- `[ ]` Step 7: Perform Syntax, Link, and Execution Verification
