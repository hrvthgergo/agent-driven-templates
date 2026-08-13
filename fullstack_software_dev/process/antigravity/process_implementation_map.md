# Implementation Map: `/process` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/process` workflow within **Google Antigravity**. It details the planned actions and technical rationale, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `fullstack_software_dev/process/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [process_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md), [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md), and [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, state machine rules, and scanning laws so they can be implemented in any AI agent environment.
*   **Antigravity Implementation Map**: This document (`process_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining multi-step state machine nodes (e.g. `process-history.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing prerequisite checks, read-only legacy sources, as-is code migration, and prompting laws (e.g. `process-history-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures for scanning legacy code, building modular workspace Code Graph subfolders, staging non-code docs in `agent-workspace/plans/<branch_name>/resource/`, and copying files as-is (e.g. `process-history-migrator/SKILL.md`).
    *   **Templates (`templates/`)**: Standardized document formats deployed into `agent-workspace/plans/<branch_name>/` and `agent-workspace/src/<layer>/code_graph/` (e.g. `restructure-proposal.md`, `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Prerequisite `/init` Check Gate** | [process_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md#L90-L95) | Workflow & Rule Primitives | `workflows/process-history.md` (Node S0) & `rules/process-history-grill.md` |
| **Read-Only Legacy Source & As-Is Migration Policy** | [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_questions.md#L18-L21) | Rule & Skill Primitives | `rules/process-history-grill.md` (Baseline 1) & `skills/process-history-migrator/SKILL.md` |
| **Pure Control Plane (`agent-workspace/`) & Sub-Repo Layout** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md) | Rule & Skill Primitives | `rules/process-history-grill.md` (Baseline 2) & `skills/process-history-migrator/SKILL.md` |
| **Non-Code Docs Staging (`agent-workspace/plans/<branch_name>/resource/`)** | [process_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md#L27) | Skill & Template Primitives | `skills/process-history-migrator/SKILL.md` & `templates/restructure-proposal.md` |
| **Three Knowledge Inputs Synthesis** | [process_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md#L18-L23) | Workflow & Skill Primitives | `workflows/process-history.md` & `skills/process-history-migrator/SKILL.md` |
| **Dual Execution Modes (`--plan` vs `--auto`)** | [process_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_questions.md#L149-L159) | Workflow & Rule Primitives | `workflows/process-history.md` (Nodes S4–S5) & `rules/process-history-grill.md` (Q5) |
| **Modular Workspace Code Graph Subfolders** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md#L34-L45) | Skill & Template Primitives | `skills/process-history-migrator/SKILL.md` & `templates/code_graph/` |
| **Selective Blueprints & Governance Synthesis** | [process_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md#L101-L109) | Template & Workflow Primitives | `templates/restructure-proposal.md`, `agent-workspace/plans/<branch_name>/phase-*.md`, & `PROCESS_STATUS.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Clean & Delete Existing Guard Assets

*   **List of Actions**:
    1.  Inspect directory `fullstack_software_dev/process/antigravity/guards/`.
    2.  If `fullstack_software_dev/process/antigravity/guards/` exists and contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`), remove all existing sources inside `fullstack_software_dev/process/antigravity/guards/`.
*   **Reasons & Design Decision Links**:
    *   *Clean Slate & Idempotency Guarantee*: Ensures that prior, partial, or outdated guard files are completely purged before scaffolding new master guard assets, guaranteeing a clean, repeatable, and idempotent implementation run.

---

### Step 2: Scaffold Antigravity Guard Master Directory Tree for `/process`

*   **List of Actions**:
    1.  Create Antigravity guard root directory: `fullstack_software_dev/process/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `fullstack_software_dev/process/antigravity/guards/workflows/`
        *   `fullstack_software_dev/process/antigravity/guards/rules/`
        *   `fullstack_software_dev/process/antigravity/guards/templates/code_graph/`
        *   `fullstack_software_dev/process/antigravity/guards/skills/process-history-migrator/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Maintains master Antigravity guard primitives under `fullstack_software_dev/process/antigravity/guards/` for central governance prior to deployment during workflow execution.

---

### Step 3: Implement Stateful Workflow Playbook (`workflows/process-history.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process/antigravity/guards/workflows/process-history.md`.
    2.  Define YAML frontmatter (`name: process`, `description: Brownfield legacy code processing and codebase migration playbook for Antigravity`).
    3.  Implement the 8-node state machine execution flow:
        *   **Node S0 (Prerequisite Check)**: Inspects `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`. If missing or `/init` marked `Not Started`, halts immediately and instructs user to run `/init` first.
        *   **Node S1 (Inspect `/init` Metadata)**: Reads linked legacy folders, tech stack, and workspace layer scope from `agent-workspace/plans/<branch_name>/phase-1-summary.md`.
        *   **Node S2 (Audit Omitted Remotes & Submodules)**: Scans `.git/config`, `.gitmodules`, and documentation links across legacy folders.
        *   **Node S3 (Q&A Grill Gate)**: Invokes interactive interview adhering to `rules/process-history-grill.md`.
        *   **Node S4 (Draft Restructuring Plan)**: Generates `agent-workspace/plans/<branch_name>/restructure-proposal.md`.
        *   **Node S5 (Consent Gate / Mode Check)**: Pauses for developer approval in Plan-First Mode (`--plan`); proceeds immediately in Immediate Execution Mode (`--auto`).
        *   **Node S6 (Execute As-Is File Copies & Non-Code Docs Staging)**: Invokes `skills/process-history-migrator/SKILL.md` to copy legacy code intact to target `codebase-*` layers without code modifications, and stage non-code legacy documentation in `agent-workspace/plans/<branch_name>/resource/`.
        *   **Node S7 (Generate Workspace Code Graphs & Selective Blueprint Population)**: Generates `agent-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), selectively populates relevant phase blueprints in `agent-workspace/plans/<branch_name>/`, and updates `PROCESS_STATUS.md` Row 2.0 to `Completed`.
    4.  Implement CLI parameter handling:
        *   `/process` (or `--plan`): Plan-First Mode (default, pauses for developer approval).
        *   `/process --auto` (or `--apply`): Immediate Execution Mode (acts immediately and records plan artifact).
        *   `/process --dry-run`: Previews migration mapping without writing files to disk.
        *   `/process --docs-only`: Extracts documentation and populates blueprints without moving source files.

---

### Step 4: Implement Q&A Grill Rule Guard (`rules/process-history-grill.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process/antigravity/guards/rules/process-history-grill.md`.
    2.  Encode **Unchangeable Baselines**:
        *   *Baseline 1*: Read-Only Legacy Source & As-Is Migration Policy (zero in-place edits in original legacy folders).
        *   *Baseline 2*: Target Layout Alignment (`codebase-*` sub-repositories & `agent-workspace/` control plane).
    3.  Encode **Prompting Law**: Neutral choice lists with mandatory `Other / Free-text (...)` option; forbid `[Recommended]` labels.
    4.  Encode **Sequential Q1 to Q7 Prompts**:
        *   Q1 (Baseline Review), Q2 (Omitted Remotes Audit), Q3 (Legacy Source & Non-Code Docs Mapping), Q4 (Workspace Code Graphs & Blueprint Extraction Scope), Q5 (Execution Mode), Q6 (Path & Link Strategy), and Q7 (Summary Verification).

---

### Step 5: Implement Code Graph & Plan Templates (`templates/`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process/antigravity/guards/templates/restructure-proposal.md`.
    2.  Create Modular Code Graph templates inside `templates/code_graph/`:
        *   `graph.md`: Unordered Mermaid dependency graph & structural element registry (interfaces, classes, functions, entities, services based on Python, Go, JS taxonomy).
        *   `process_flow.md`: Process entry points & control flow initiation paths.
        *   `data_flow.md`: Data sources (user provided, configs, external APIs, DB persistence, hardcoded constants) & datastream transformations.
        *   `risk_analysis.md`: Coupling metrics (fan-in/fan-out connection counts), critical code nodes, & test coverage maps.

---

### Step 6: Implement Migration & Code Graph Skill (`skills/process-history-migrator/SKILL.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process/antigravity/guards/skills/process-history-migrator/SKILL.md`.
    2.  Define **As-Is File Copying Procedures**: Copy source files intact from legacy folders to target `codebase-*` sub-repositories without modifying source logic.
    3.  Define **Non-Code Docs Staging Procedures**: Copy non-code legacy documentation, supplementary assets, schemas, and diagrams into `agent-workspace/plans/<branch_name>/resource/`.
    4.  Define **Workspace Code Graph Generation Procedures**: Parse code structures and write `agent-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`) with zero symlinks.
    5.  Define **Selective Blueprint Population Procedures**: Synthesize extracted legacy metadata selectively into `agent-workspace/plans/<branch_name>/phase-*.md` based on relevance.

---

### Step 7: Verification & Test Execution (`process_tests.md`)

*   **List of Actions**:
    1.  Verify file references and links across created guard files.
    2.  Execute the end-to-end brownfield validation scenario detailed in [process_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/antigravity/process_tests.md).

---

## 4. Verification & Readiness Checklist

- `[ ]` Step 1: Clean & Delete Existing Guard Assets (`fullstack_software_dev/process/antigravity/guards/`)
- `[ ]` Step 2: Scaffold Antigravity Guard Master Directory Tree (`guards/`)
- `[ ]` Step 3: Implement Stateful Workflow Playbook (`workflows/process-history.md`)
- `[ ]` Step 4: Implement Q&A Grill Rule Guard (`rules/process-history-grill.md`)
- `[ ]` Step 5: Implement Restructure & Code Graph Templates (`templates/`)
- `[ ]` Step 6: Implement Migration & Code Graph Skill (`skills/process-history-migrator/SKILL.md`)
- `[ ]` Step 7: Perform Verification & Execute E2E Tests (`process_tests.md`)
