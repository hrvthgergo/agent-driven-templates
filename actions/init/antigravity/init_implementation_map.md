# Implementation Map: `/init` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/init` workflow within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to the documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `actions/init/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [init_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md), [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md), [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/summary.md), and [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/multi_repo_architecture.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, baselines, and state machine rules so they can be implemented in any AI agent environment (e.g. OpenAI Codex, Claude Code, Cursor, or Antigravity).
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
| **Baseline 1: Pure Control Plane Scope** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) & [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) | Rule & Skill Primitives | `rules/init-grill.md` (Baseline 1) & `skills/init-scaffolder/SKILL.md` |
| **Baseline 2: Clean Root Mandate** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) Section 1 | Rule & Workflow Primitives | `rules/init-grill.md` (Baseline 2) & `workflows/init.md` (Node S1/S2) |
| **Baseline 3: Mutations Behind Acceptance Gate** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) Section 1 | Workflow & Skill Primitives | `workflows/init.md` (Node S4/S5) & `skills/init-scaffolder/SKILL.md` |
| **Baseline 4: Remote Divergence Halts** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) Section 1 | Rule & Workflow Primitives | `rules/init-grill.md` (Baseline 4) & `workflows/init.md` (Node S2) |
| **Flat Sequential Q1–Q9 Interview Schema** | [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) Sections 2–3 | Rule & Workflow Primitives | `rules/init-grill.md` & `workflows/init.md` (Node S2) |
| **Permanent Q&A Audit Log (`GRILL_STATUS.md`)** | [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/grill_engine.md) & `/grill-me` Q3 | Rule & Template Primitives | `rules/init-grill.md` & `agent-workspace/plans/<scope_name>/GRILL_STATUS.md` |
| **Branch Governance & Matrix (`PROCESS_STATUS.md`)** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/init.md` |
| **Primary Remote Origin Sync & Branch Checkout Guarantee** | [init_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) Section 3 | Workflow Primitive | `workflows/init.md` (Node S6 & S7) |
| **Decoupled Brownfield Flow (No Restructuring)** | [init_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) Section 1 | Workflow & Skill Primitives | `workflows/init.md` & `skills/init-scaffolder/SKILL.md` |
| **Pre-Commit Safety Interceptor** | [init_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) & `/grill-me` Q2 | Hook Primitive | `hooks/pre-commit-plan-validator.sh` |
| **Workflow Context Notification Law** | [user_guide.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/user_guide.md) | Rule, Workflow & Template Primitives | `rules/init-grill.md`, `workflows/init.md` & `templates/PROCESS_STATUS.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Clean & Delete Existing Guard Assets

*   **List of Actions**:
    1.  Inspect directory `actions/init/antigravity/guards/`.
    2.  If `actions/init/antigravity/guards/` exists and contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`, `hooks/`), remove all existing sources inside `actions/init/antigravity/guards/`.
*   **Reasons & Design Decision Links**:
    *   *Clean Slate & Idempotency Guarantee*: Ensures that prior, partial, or outdated guard files are completely purged before scaffolding new master guard assets, guaranteeing a clean, repeatable, and idempotent implementation run.

---

### Step 2: Scaffold Antigravity Guard Master Directory Tree

*   **List of Actions**:
    1.  Create Antigravity tier-3 guard root directory: `actions/init/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `actions/init/antigravity/guards/workflows/`
        *   `actions/init/antigravity/guards/rules/`
        *   `actions/init/antigravity/guards/templates/`
        *   `actions/init/antigravity/guards/skills/init-scaffolder/`
        *   `actions/init/antigravity/guards/hooks/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Implements the decision from `/grill-me` Question 1 alignment and `summary.md` 3-Tier scaffold rationale to maintain master Antigravity guard primitives under `actions/init/antigravity/guards/` for central management before deploying into target project `.agents/` directories during `/init`.
    *   *Folder Taxonomy*: Strictly mirrors the agentic control directory structure documented in [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md).

---

### Step 3: Implement Stateful Workflow Playbook (`workflows/init.md`)

*   **List of Actions**:
    1.  Create `actions/init/antigravity/guards/workflows/init.md`.
    2.  Define YAML frontmatter (`name: init`, `description: Bootstrapping workflow for Guards framework in Antigravity`).
    3.  Implement the linear, single-path state machine execution nodes (S1–S7) using Antigravity workflow syntax:
        *   **Node S1 (Check Environment)**: Verifies filesystem write permissions and Git binary availability before asking interview questions.
        *   **Node S2 (Interview — Q1–Q9)**: Runs the flat, sequential interview defined in `init_questions.md` across 4 sections:
            *   *Section A (Design Goal & Environment)*: Q1 (Local Workspace Parent Directory & Clean Root check), Q2 (Scope, Purpose & Root/Scope Names), Q3 (Git Set-up & Primary Remote Origin: Adopt/Clone/Initialize).
            *   *Section B (Supporting Documentation)*: Q4/Q4b (Local Documentation), Q5/Q5b (Remote/Cloud Documentation), Q6 (Further Documentation & Issue References).
            *   *Section C (Agentic Environment)*: Q7 (Agent Guidance, Rules, Skills, MCPs & Hooks).
            *   *Section D (Verification & Confirmation)*: Q8 (Constraints & Pre-Planning Decisions), Q9 (Q&A Summary Verification & Reflection).
        *   **Node S3 (Lightweight Scan & Path Verification)**: Verifies target workspace paths, checks for `agent-workspace/tests/TEST_STRATEGY.md` existence (records gap if absent without halting), and auto-detects version control configs without code restructuring.
        *   **Node S4 (Execution Acceptance Gate)**: Synthesizes gathered info, displays understanding summary and planned scaffolding steps, and requests user approval (or bypasses prompt in `--auto` mode).
        *   **Node S5 (Scaffolding Workspace & `PROCESS_STATUS.md`)**: Invokes `skills/init-scaffolder/SKILL.md` to deploy `agent-workspace/` control structures (`.agents/`, `plans/<scope_name>/`, `docs/`, `src/`), provisions `.gitkeep` files in every directory node, deploys starter templates, and executes the Q3 Git resolution (clone / init / adopt) per Baseline 3.
        *   **Node S6 (Git Hook Registration & Remote Setup)**: Registers primary remote origin URL from Q3 and installs `hooks/pre-commit-plan-validator.sh`.
        *   **Node S7 (Initialization Done, Branch Checkout & Initial Push)**: Asserts target branch is checked out (`initial` for greenfield; `feature/<name>` or `bugfix/<name>` for feature scopes), marks `/init` as `Completed` in `PROCESS_STATUS.md`, stages and commits initial control assets, pushes initial commit to remote origin (`git push -u origin <branch_name>`), and reports next steps (`/process` or `/plan`).
    4.  Implement CLI parameter handling:
        *   `/init`: Default interactive execution (creates `initial` branch on greenfield; creates `feature/<feature_name>` branch on re-runs).
        *   `/init --auto`: Automatic execution mode. Bypasses interactive Node S4 acceptance prompt and executes all planned scaffolding tasks.
        *   `/init --feature <feature_name>`: Explicitly creates Git branch `feature/<feature_name>` and deploys feature-bound `PROCESS_STATUS.md`.
        *   `/init --release <vX.Y.Z>`: Initializes a release branch (`release/vX.Y.Z`) and prepares release-scoped tracking.
        *   `/init --dry-run`: Previews proposed files, agentic structures, and status sheets without writing to disk.
        *   `/init --force`: Overwrites default `.agents/` rules/workflows while preserving custom phase blueprints.
*   **Reasons & Design Decision Links**:
    *   *Step-by-Step Lifecycle*: Realizes the single-path 7-node execution design documented in [init_action.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md).
    *   *Parameter Behaviors*: Implements parameter rules documented in [init_action.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) and `/grill-me` alignment.
    *   *Decoupled Brownfield Rule*: Enforces the no-restructuring constraint during `/init`, referencing [init_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md).

---

### Step 4: Implement Neutral Q&A Grill Rule Guard (`rules/init-grill.md`)

*   **List of Actions**:
    1.  Create `actions/init/antigravity/guards/rules/init-grill.md`.
    2.  Encode **Unchangeable Baselines Enforcement**:
        *   *Baseline 1 (Pure Control Plane Scope)*: Scope is strictly `agent-workspace/` (zero questions asked about `codebase-*` sub-repos).
        *   *Baseline 2 (Clean Root Mandate)*: Local Workspace Root must not sit inside foreign git worktree; halts at Q1 on violation.
        *   *Baseline 3 (Mutations Behind Acceptance Gate)*: No filesystem writes or git clone/init during Q1–Q9 interview; all mutations occur at Node S5.
        *   *Baseline 4 (Remote Divergence Halts)*: On adopt, divergent local history against registered remote halts execution.
    3.  Encode **Prompting Laws**:
        *   Forbid all `[Recommended]` labels.
        *   Enforce neutral choice lists with a mandatory final free-text input option (`Other / Free-text (...)`).
    4.  Encode **Sequential Q1–Q9 Questionnaire Schema**:
        *   *Section A*: Q1 (Parent Directory), Q2 (Scope, Purpose & Names), Q3 (Git Set-up & Primary Remote Origin).
        *   *Section B*: Q4/Q4b (Local Docs), Q5/Q5b (Remote Docs), Q6 (Issue/Ticket References).
        *   *Section C*: Q7 (Agent Guiders & MCPs).
        *   *Section D*: Q8 (Constraints & Pre-Planning Decisions), Q9 (Summary Verification & Reflection).
    5.  Encode **Audit Log Persistence**:
        *   Maintain `agent-workspace/plans/<scope_name>/GRILL_STATUS.md` permanently alongside `PROCESS_STATUS.md` as an audit log of all Q&A questions and answers.
    6.  Record **Playbook Layer Narrowing Reference**:
        *   Document that per-use-case interview narrowing (e.g. bugfix vs. greenfield) is resolved by the active playbook (`playbook: <name>` header), not by in-interview branching.
*   **Reasons & Design Decision Links**:
    *   *Baselines*: Implements unchangeable baselines documented in [init_questions.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md).
    *   *Flat Q1–Q9 Interview*: Implements the unified 9-question interview schema documented in [init_questions.md Sections 2–3](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md).
    *   *Audit Persistence*: Realizes the permanent audit log decision from `/grill-me` Question 3 alignment and [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/grill_engine.md).

---

### Step 5: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)

*   **List of Actions**:
    1.  Create `actions/init/antigravity/guards/templates/PROCESS_STATUS.md`:
        *   Header with Target Release/Feature, Git Branch, Date, and Active Workflow.
        *   **Block 1 (Workflow Execution Matrix)**: Status table tracking `/init`, `/process`, `/plan` (with sub-rows 3.1–3.6 for Phase 1 to Phase 6), `/implement`, `/qualify`, and `/release`.
        *   **Block 2 (Datestamped Daily Execution History)**: Immutable daily log format timestamped by `### [YYYY-MM-DD]`.
    2.  Create `actions/init/antigravity/guards/templates/phase-1-summary.md`:
        *   Sections for Aim & Purpose, Issue Reference, Pre-Planning Decisions & Constraints, Remote Repositories & Knowledge Links, and Workspace Folder Map.
*   **Reasons & Design Decision Links**:
    *   *Process Guard*: Implements the 2-block release and feature lifecycle document documented in [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md).
    *   *Plan Status Consolidation*: Realizes the decision to consolidate 6-phase planning status into `PROCESS_STATUS.md` Block 1, removing `PLAN_STATUS.md`.
    *   *Phase 1 Blueprint*: Provides the initial architectural summary file scaffolded during Step 4 as specified in [init_action.md Node C1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md).

---

### Step 6: Implement Control Plane Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)

*   **List of Actions**:
    1.  Create `actions/init/antigravity/guards/skills/init-scaffolder/SKILL.md` with YAML frontmatter (`name: init-scaffolder`, `description: Antigravity skill for pure control plane workspace scaffolding and gitkeep provisioning`).
    2.  Define **Directory Scaffolding & `.gitkeep` Preservation Procedures**:
        *   Create `agent-workspace/` (`.agents/` with `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`; `plans/<scope_name>/`; `docs/`; `src/`).
        *   Provision a `.gitkeep` file inside **every scaffolded directory node** to guarantee that empty placeholder folders (e.g. `skills/`, `hooks/`, `sidecars/`, `src/`) are fully tracked, preserved, and synchronized on remote Git origins immediately after `/init` runs.
    3.  Define **Brownfield Folder Linking Procedures**:
        *   Link existing source/doc folders into `phase-1-summary.md` without running any codebase restructuring.
*   **Reasons & Design Decision Links**:
    *   *Pure Control Plane Scaffolding*: Implements directory layout established in [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md).
    *   *Brownfield Decoupling*: Ensures `/init` links folders without refactoring, linking to [init_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md).

---

### Step 7: Implement Pre-Commit Validator Safety Hook (`hooks/pre-commit-plan-validator.sh`)

*   **List of Actions**:
    1.  Create `actions/init/antigravity/guards/hooks/pre-commit-plan-validator.sh`.
    2.  Write bash validation logic:
        *   Check active Git branch and resolve corresponding plan path `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`.
        *   Verify that `PROCESS_STATUS.md` contains Block 1 and Block 2 formatting.
        *   Check that required phase blueprints exist for active in-progress workflows.
        *   Exit with code `0` if valid; exit with code `1` and print error trace if validation fails.
    3.  Add installation instructions for Step 5 (S5) (`cp` to `.git/hooks/pre-commit` and `chmod +x`).
*   **Reasons & Design Decision Links**:
    *   *Safety Interceptor*: Implements the pre-commit validation hook specified in [init_action.md Node S6](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) and `/grill-me` Question 2 alignment.

---

### Step 8: Verification & Testing

*   **List of Actions**:
    1.  Validate execution permissions on shell scripts (`chmod +x actions/init/antigravity/guards/hooks/pre-commit-plan-validator.sh`).
    2.  Verify YAML frontmatter in `workflows/init.md`, `rules/init-grill.md`, and `skills/init-scaffolder/SKILL.md`.
    3.  Verify all markdown links across created guard files to ensure no broken references exist.
    4.  Verify full structural alignment with [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/summary.md).
*   **Reasons & Design Decision Links**:
    *   *Quality Assurance*: Ensures all master guard artifacts are syntax-valid, executable, and fully ready for deployment during `/init`.

---

### Step 9: Workflow E2E Testing

*   **List of Actions**:
    1.  Execute the end-to-end test scenarios collected and designed in [init_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/antigravity/init_tests.md) inside an isolated test sandbox (`/tmp/test-init-workspace`).
    2.  Simulate `/init` command execution and prompt responses across the flat sequential Q1–Q9 interview schema (Scenario A: Greenfield initialization with fresh git setup; Scenario B: Feature initialization in existing workspace with adopted git setup).
    3.  Run and evaluate all automated validation assertions:
        *   Verify branch creation and checkout guarantee (`git branch --show-current`).
        *   Assert permanent audit log creation (`agent-workspace/plans/<scope_name>/GRILL_STATUS.md`) containing full Q1–Q9 transcript.
        *   Assert Node S4 Execution Acceptance Gate prompt summary presentation and acceptance record in `GRILL_STATUS.md` (and `--auto` bypass mode execution).
        *   Assert `agent-workspace/` control directory scaffold (`.agents/rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/<scope_name>/`, `docs/`, `src/`).
        *   Assert `agent-workspace/plans/<scope_name>/PROCESS_STATUS.md` matrix and daily history log entries.
        *   Assert `agent-workspace/plans/<scope_name>/phase-1-summary.md` blueprint metadata (aim, issue references, constraints, remotes, folder map).
        *   Assert `.gitkeep` files present in all scaffolded folders.
        *   Assert pre-commit safety hook installation (`.git/hooks/pre-commit` executable check).
        *   Assert primary remote origin registration and remote push attempt.
    4.  Evaluate test pass/fail metrics and record validation results.
*   **Reasons & Design Decision Links**:
    *   *Final Validation Round*: Serves as the final validation round to evaluate the operational behavior and complete integration of all master guard primitives against the test scenarios in [init_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/antigravity/init_tests.md).

---

## 4. Verification & Readiness Checklist

- `[x]` Step 1: Clean & Delete Existing Guard Assets (`actions/init/antigravity/guards/`)
- `[x]` Step 2: Scaffold Antigravity Guard Master Directory Tree (`actions/init/antigravity/guards/`)
- `[x]` Step 3: Implement Stateful Workflow Playbook (`workflows/init.md`)
- `[x]` Step 4: Implement Neutral Q&A Grill Rule (`rules/init-grill.md`)
- `[x]` Step 5: Implement Document Templates (`templates/PROCESS_STATUS.md` & `templates/phase-1-summary.md`)
- `[x]` Step 6: Implement Control Plane Scaffolding Skill (`skills/init-scaffolder/SKILL.md`)
- `[x]` Step 7: Implement Pre-Commit Validator Hook (`hooks/pre-commit-plan-validator.sh`)
- `[x]` Step 8: Perform Syntax, Link, and Execution Verification
- `[x]` Step 9: Execute Workflow E2E Testing (`init_tests.md` final validation round)
