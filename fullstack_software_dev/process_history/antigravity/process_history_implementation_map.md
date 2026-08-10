# Implementation Map: `/process-history` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/process-history` workflow within **Google Antigravity**. It details the planned actions and technical rationale, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `fullstack_software_dev/process_history/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md), [process_history_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_questions.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md), and [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, state machine rules, and scanning laws so they can be implemented in any AI agent environment.
*   **Antigravity Implementation Map**: This document (`process_history_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining multi-step state machine nodes (e.g. `process-history.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing prerequisite checks, read-only legacy sources, as-is code migration, and prompting laws (e.g. `process-history-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures for scanning legacy code, building modular workspace Code Graph subfolders, and copying files as-is (e.g. `process-history-migrator/SKILL.md`).
    *   **Templates (`templates/`)**: Standardized document formats deployed into `.agents/plans/` and `antigravity-workspace/src/<layer>/code_graph/` (e.g. `restructure-proposal.md`, `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Prerequisite `/init` Check Gate** | [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md#L48-L60) | Workflow & Rule Primitives | `workflows/process-history.md` (Node S0) & `rules/process-history-grill.md` |
| **Read-Only Legacy Source & As-Is Migration Policy** | [process_history_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_questions.md#L17-L20) | Rule & Skill Primitives | `rules/process-history-grill.md` (Baseline 1) & `skills/process-history-migrator/SKILL.md` |
| **Non-Code Docs Staging (`.agents/plans/<feature-name>/resource/`)** | [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md#L26) | Skill & Template Primitives | `skills/process-history-migrator/SKILL.md` & `templates/restructure-proposal.md` |
| **Three Knowledge Inputs Synthesis** | [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md#L14-L23) | Workflow & Skill Primitives | `workflows/process-history.md` & `skills/process-history-migrator/SKILL.md` |
| **Dual Execution Modes (`--plan` vs `--auto`)** | [process_history_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_questions.md#L146-L156) | Workflow & Rule Primitives | `workflows/process-history.md` (Nodes S4–S5) & `rules/process-history-grill.md` (Q5) |
| **Modular Workspace Code Graph Subfolders** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md#L35-L45) | Skill & Template Primitives | `skills/process-history-migrator/SKILL.md` & `templates/code_graph/` |
| **Selective Blueprints & Governance Synthesis** | [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md#L90-L97) | Template & Workflow Primitives | `templates/restructure-proposal.md`, `.agents/plans/phase-*.md`, & `PROCESS_STATUS.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Scaffold Antigravity Guard Directory Tree for `/process-history`

*   **List of Actions**:
    1.  Create Antigravity guard root directory: `fullstack_software_dev/process_history/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `fullstack_software_dev/process_history/antigravity/guards/workflows/`
        *   `fullstack_software_dev/process_history/antigravity/guards/rules/`
        *   `fullstack_software_dev/process_history/antigravity/guards/templates/code_graph/`
        *   `fullstack_software_dev/process_history/antigravity/guards/skills/process-history-migrator/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Maintains master Antigravity guard primitives under `fullstack_software_dev/process_history/antigravity/guards/` for central governance prior to deployment during workflow execution.

---

### Step 2: Implement Stateful Workflow Playbook (`workflows/process-history.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process_history/antigravity/guards/workflows/process-history.md`.
    2.  Define YAML frontmatter (`name: process-history`, `description: Brownfield legacy code processing and codebase migration playbook for Antigravity`).
    3.  Implement the 8-node state machine execution flow:
        *   **Node S0 (Prerequisite Check)**: Inspects `.agents/plans/PROCESS_STATUS.md`. If missing or `/init` marked `Not Started`, halts immediately and instructs user to run `/init` first.
        *   **Node S1 (Inspect `/init` Metadata)**: Reads linked legacy folders, tech stack, and workspace layer scope from `.agents/plans/phase-1-summary.md`.
        *   **Node S2 (Audit Omitted Remotes & Submodules)**: Scans `.git/config`, `.gitmodules`, and documentation links across legacy folders.
        *   **Node S3 (Q&A Grill Gate)**: Invokes interactive interview adhering to `rules/process-history-grill.md`.
        *   **Node S4 (Draft Restructuring Plan)**: Generates `.agents/plans/restructure-proposal.md`.
        *   **Node S5 (Consent Gate / Mode Check)**: Pauses for developer approval in Plan-First Mode (`--plan`); proceeds immediately in Immediate Execution Mode (`--auto`).
        *   **Node S6 (Execute As-Is File Copies)**: Invokes `skills/process-history-migrator/SKILL.md` to copy legacy code intact to `codebase-*` layers without code modifications.
        *   **Node S7 (Generate Workspace Code Graphs & Populate Blueprints)**: Generates `antigravity-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), populates all 5 phase blueprints in `.agents/plans/`, and updates `PROCESS_STATUS.md` Row 2.0 to `Completed`.
    4.  Implement CLI parameter handling:
        *   `/process-history` (or `--plan`): Plan-First Mode (default, pauses for developer approval).
        *   `/process-history --auto` (or `--apply`): Immediate Execution Mode (acts immediately and records plan artifact).
        *   `/process-history --dry-run`: Previews migration mapping without writing files to disk.
        *   `/process-history --docs-only`: Extracts documentation and populates blueprints without moving source files.

---

### Step 3: Implement Q&A Grill Rule Guard (`rules/process-history-grill.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process_history/antigravity/guards/rules/process-history-grill.md`.
    2.  Encode **Unchangeable Baselines**:
        *   *Baseline 1*: Read-Only Legacy Source & As-Is Migration Policy (zero in-place edits in original legacy folders).
        *   *Baseline 2*: Target Layout Alignment (`codebase-*` sub-repositories).
    3.  Encode **Prompting Law**: Neutral choice lists with mandatory `Other / Free-text (...)` option; forbid `[Recommended]` labels.
    4.  Encode **Sequential Q1 to Q7 Prompts**:
        *   Q1 (Baseline Review), Q2 (Omitted Remotes Audit), Q3 (Legacy Source Mapping), Q4 (Workspace Code Graphs & Blueprint Extraction), Q5 (Execution Mode), Q6 (Path & Link Strategy), and Q7 (Summary Verification).

---

### Step 4: Implement Code Graph & Plan Templates (`templates/`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process_history/antigravity/guards/templates/restructure-proposal.md`.
    2.  Create Modular Code Graph templates inside `templates/code_graph/`:
        *   `graph.md`: Unordered Mermaid dependency graph & structural element registry (interfaces, classes, functions, entities, services).
        *   `process_flow.md`: Process entry points & control flow initiation paths.
        *   `data_flow.md`: Data sources (user provided, configs, external APIs, DB persistence, hardcoded constants) & datastream transformations.
        *   `risk_analysis.md`: Coupling metrics (fan-in/fan-out connection counts), critical code nodes, & test coverage maps.

---

### Step 5: Implement Migration & Code Graph Skill (`skills/process-history-migrator/SKILL.md`)

*   **List of Actions**:
    1.  Create `fullstack_software_dev/process_history/antigravity/guards/skills/process-history-migrator/SKILL.md`.
    2.  Define **As-Is File Copying Procedures**: Copy files intact from legacy folders to target `codebase-*` sub-repositories without modifying source logic.
    3.  Define **Workspace Code Graph Generation Procedures**: Parse code structures and write `antigravity-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`) with zero symlinks.
    4.  Define **Blueprint Population Procedures**: Synthesize extracted legacy metadata into `.agents/plans/phase-1-summary.md` through `phase-5-operation.md`.

---

### Step 6: Verification & Test Execution (`process_history_tests.md`)

*   **List of Actions**:
    1.  Verify file references and links across created guard files.
    2.  Execute the end-to-end brownfield validation scenario detailed in [process_history_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/antigravity/process_history_tests.md).

---

## 4. Verification & Readiness Checklist

- `[ ]` Step 1: Scaffold Antigravity Guard Directory Tree (`guards/`)
- `[ ]` Step 2: Implement Stateful Workflow Playbook (`workflows/process-history.md`)
- `[ ]` Step 3: Implement Q&A Grill Rule Guard (`rules/process-history-grill.md`)
- `[ ]` Step 4: Implement Restructure & Code Graph Templates (`templates/`)
- `[ ]` Step 5: Implement Migration & Code Graph Skill (`skills/process-history-migrator/SKILL.md`)
- `[ ]` Step 6: Perform Verification & Execute E2E Tests (`process_history_tests.md`)
