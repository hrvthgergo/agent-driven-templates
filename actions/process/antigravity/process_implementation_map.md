# Implementation Map: `/process` Action Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/process` action within **Google Antigravity**. It details the planned actions and technical rationale, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `actions/process/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md), [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md), [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/summary.md), and [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/multi_repo_architecture.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, state machine rules, and scanning laws so they can be implemented in any AI agent environment.
*   **Antigravity Implementation Map**: This document (`process_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining multi-step state machine nodes (e.g. `process.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing prerequisite checks, read-only legacy sources (no code logic rewriting), in-place symlink baselines, and prompting laws (e.g. `process-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures for scanning legacy code, creating workspace layer symlinks, building modular workspace Code Graph subfolders, staging non-code docs in `agent-workspace/plans/<branch_name>/resource/`, and selectively synthesizing blueprints (e.g. `process-migrator/SKILL.md`).
    *   **Templates (`templates/`)**: Standardized document formats deployed into `agent-workspace/plans/<branch_name>/` and `agent-workspace/src/<layer>/code_graph/` (e.g. `restructure-proposal.md`, `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Prerequisite `/init` Check Gate** | [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md) | Workflow & Rule Primitives | `workflows/process.md` (Node S0) & `rules/process-grill.md` |
| **Read-Only Legacy Source & Pure Integration Policy** | [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_questions.md) | Rule & Skill Primitives | `rules/process-grill.md` (Baseline 1) & `skills/process-migrator/SKILL.md` |
| **In-Place Symlink Integration & Control Plane Layout** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) & [multi_repo_architecture.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/multi_repo_architecture.md) | Rule & Skill Primitives | `rules/process-grill.md` (Baseline 2) & `skills/process-migrator/SKILL.md` |
| **Feature Resource Folder (`plans/<branch_name>/resource/`)** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) | Skill & Template Primitives | `skills/process-migrator/SKILL.md` & `templates/restructure-proposal.md` |
| **Three Knowledge Inputs Synthesis** | [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md) | Workflow & Skill Primitives | `workflows/process.md` & `skills/process-migrator/SKILL.md` |
| **On-Demand Proposal Mode (`--proposal`)** | [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md) & [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_questions.md) | Workflow & Template Primitives | `workflows/process.md` (Node S4) & `templates/restructure-proposal.md` |
| **Modular Workspace Code Graph Subfolders (`--code-graph`)** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) & [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/code_graph_taxonomy.md) | Skill & Template Primitives | `skills/process-migrator/SKILL.md` & `templates/code_graph/` |
| **Selective Blueprints & Governance Synthesis** | [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md) | Template & Workflow Primitives | `agent-workspace/plans/<branch_name>/phase-*.md` & `PROCESS_STATUS.md` |
| **Action Context Notification Law** | [user_guide.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/user_guide.md) | Rule, Workflow & Template Primitives | `rules/process-grill.md`, `workflows/process.md` & `templates/PROCESS_STATUS.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Clean & Delete Existing Guard Assets

*   **List of Actions**:
    1.  Inspect directory `actions/process/antigravity/guards/`.
    2.  If `actions/process/antigravity/guards/` exists and contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`), remove all existing sources inside `actions/process/antigravity/guards/`.
*   **Reasons & Design Decision Links**:
    *   *Clean Slate & Idempotency Guarantee*: Ensures that prior, partial, or outdated guard files are completely purged before scaffolding new master guard assets, guaranteeing a clean, repeatable, and idempotent implementation run.

---

### Step 2: Scaffold Antigravity Guard Master Directory Tree for `/process`

*   **List of Actions**:
    1.  Create Antigravity guard root directory: `actions/process/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `actions/process/antigravity/guards/workflows/`
        *   `actions/process/antigravity/guards/rules/`
        *   `actions/process/antigravity/guards/templates/code_graph/`
        *   `actions/process/antigravity/guards/skills/process-migrator/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Maintains master Antigravity guard primitives under `actions/process/antigravity/guards/` for central governance prior to deployment during action execution.

---

### Step 3: Implement Stateful Workflow Playbook (`workflows/process.md`)

*   **List of Actions**:
    1.  Create `actions/process/antigravity/guards/workflows/process.md`.
    2.  Define YAML frontmatter (`name: process`, `description: Brownfield legacy code discovery, in-place symlinking, and knowledge ingestion playbook for Antigravity`).
    3.  Implement the 7-node state machine execution flow (Nodes S0 to S6):
        *   **Node S0 (Prerequisite `/init` Check)**: Inspects `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`. If missing or `/init` marked `Not Started`, halts immediately and instructs user to run `/init` first.
        *   **Node S1 (Inspect `/init` Metadata & Legacy Folders)**: Reads linked legacy folders, tech stack, and project goals from `agent-workspace/plans/<branch_name>/phase-1-summary.md`.
        *   **Node S2 (Audit Omitted Remotes & Submodules)**: Scans `.git/config`, `.gitmodules`, and documentation links across linked legacy folders.
        *   **Node S3 (Q&A Grill Gate)**: Invokes interactive interview adhering to `rules/process-grill.md`.
        *   **Node S4 (Execution Acceptance & Proposal Gate)**:
            *   **Proposal Mode (`--proposal`)**: Generates `agent-workspace/plans/<branch_name>/restructure-proposal.md` and pauses for developer review before applying changes.
            *   **Standard Interactive Mode**: Summarizes planned layer symlink creation and doc staging, prompting for execution confirmation.
            *   **Immediate Mode (`--auto` / `--apply`)**: Bypasses interactive confirmation and transitions immediately to Node S5.
        *   **Node S5 (Execute Layer Symlinks & Resource Staging)**:
            *   **In-Place Symlink Mode (Default)**: Invokes `skills/process-migrator/SKILL.md` to create symbolic links under `agent-workspace/src/<layer>` pointing directly to existing legacy codebase directories.
            *   **Scaffolding & Copy Mode (Optional)**: If requested, scaffolds new `codebase-*` sub-repositories and copies source files intact.
            *   **Resource Staging**: Stages non-code documentation, schemas, and diagrams into `agent-workspace/plans/<feature-name>/resource/`.
        *   **Node S6 (Selective Blueprints & Maintenance Operations)**:
            *   Selectively populates relevant phase blueprints in `agent-workspace/plans/<feature-name>/` based on discovered legacy domain knowledge.
            *   **By-request only (`--code-graph`)**: Generates `agent-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`) with Version Stamp Headers.
            *   **By-request only (`--docs`)**: Promotes non-code docs from `resource/` to `agent-workspace/docs/` with Version Stamp Headers.
            *   Updates `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md` Row 2.0 to `Completed`.
    4.  Implement CLI parameter handling:
        *   `/process`: Default interactive execution (Q&A grill, creates layer symlinks in `agent-workspace/src/<layer>`, stages docs in `resource/`).
        *   `/process --proposal`: On-Demand Proposal Mode (generates `restructure-proposal.md` and pauses for approval).
        *   `/process --auto` (or `--apply`): Immediate Execution Mode (creates symlinks and stages docs without pausing).
        *   `/process --dry-run`: Previews migration mapping without writing files or creating symlinks.
        *   `/process --docs-only`: Extracts documentation and populates blueprints without modifying workspace symlinks.
        *   `/process --code-graph`: By-Request Code Graph Mode (generates `agent-workspace/src/<layer>/code_graph/` subfolders).
        *   `/process --docs`: By-Request Documentation Mode (promotes docs to `agent-workspace/docs/`).
        *   `/process --full-sync`: Full Synchronization Mode (executes integration, Code Graph generation, and documentation promotion in one pass).

---

### Step 4: Implement Q&A Grill Rule Guard (`rules/process-grill.md`)

*   **List of Actions**:
    1.  Create `actions/process/antigravity/guards/rules/process-grill.md`.
    2.  Encode **Unchangeable Baselines**:
        *   *Baseline 1*: Read-Only Legacy Source Rule (no code logic rewriting during `/process`).
        *   *Baseline 2*: Workspace Layer Alignment (`agent-workspace/src/<layer>` target symlinks).
    3.  Encode **Prompting Law**: Neutral choice lists with mandatory `Other / Free-text (...)` option; forbid `[Recommended]` labels.
    4.  Encode **Sequential Q1 to Q7 Prompts**:
        *   Q1 (Baseline Review), Q2 (Omitted Remotes Audit), Q3 (Legacy Source & Non-Code Docs Mapping), Q4 (Workspace Code Graphs & Blueprint Extraction Scope), Q5 (Execution Mode & Proposal Generation), Q6 (Integration Strategy: In-Place Symlink vs Scaffolding), and Q7 (Summary Verification).

---

### Step 5: Implement Restructure Proposal & Code Graph Templates (`templates/`)

*   **List of Actions**:
    1.  Create `actions/process/antigravity/guards/templates/restructure-proposal.md` (activated when `--proposal` flag is used).
    2.  Create Modular Code Graph templates inside `templates/code_graph/`:
        *   `graph.md`: Unordered Mermaid dependency graph & structural element registry (interfaces, classes, functions, entities, services based on Python, Go, JS taxonomy).
        *   `process_flow.md`: Process entry points & control flow initiation paths.
        *   `data_flow.md`: Data sources (user provided, configs, external APIs, DB persistence, hardcoded constants) & datastream transformations.
        *   `risk_analysis.md`: Coupling metrics (fan-in/fan-out connection counts), critical code nodes, & test coverage maps.

---

### Step 6: Implement Migration & Code Graph Skill (`skills/process-migrator/SKILL.md`)

*   **List of Actions**:
    1.  Create `actions/process/antigravity/guards/skills/process-migrator/SKILL.md`.
    2.  Define **In-Place Symlink Procedures**: Create relative symbolic links under `agent-workspace/src/<layer>` pointing to target legacy directories without moving files or duplicating storage.
    3.  Define **Resource Staging Procedures**: Copy non-code legacy documentation, supplementary assets, schemas, and diagrams into `agent-workspace/plans/<feature-name>/resource/`.
    4.  Define **Workspace Code Graph Generation Procedures**: Parse code structures and write `agent-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`) with Version Stamp Headers.
    5.  Define **Selective Blueprint Population Procedures**: Synthesize extracted legacy metadata selectively into `agent-workspace/plans/<feature-name>/phase-*.md` based on relevance.

---

### Step 7: Verification & Test Execution (`process_tests.md`)

*   **List of Actions**:
    1.  Verify file references and links across created guard files.
    2.  Execute the end-to-end brownfield validation scenario detailed in [process_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/antigravity/process_tests.md).

---

## 4. Verification & Readiness Checklist

- `[ ]` Step 1: Clean & Delete Existing Guard Assets (`actions/process/antigravity/guards/`)
- `[ ]` Step 2: Scaffold Antigravity Guard Master Directory Tree (`guards/`)
- `[ ]` Step 3: Implement Stateful Workflow Playbook (`workflows/process.md`)
- `[ ]` Step 4: Implement Q&A Grill Rule Guard (`rules/process-grill.md`)
- `[ ]` Step 5: Implement Restructure & Code Graph Templates (`templates/`)
- `[ ]` Step 6: Implement Migration & Code Graph Skill (`skills/process-migrator/SKILL.md`)
- `[ ]` Step 7: Perform Verification & Execute E2E Tests (`process_tests.md`)

