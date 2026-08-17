# Implementation Map: `/plan` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/plan` workflow within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `software_dev_elements/plan/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md), [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md), [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/implementation_map_taxonomy.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/folder_structure.md), [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/process_handling.md), and [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/summary.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, 6-Phase Blueprint Architecture, and state machine rules so they can be implemented in any AI agent environment (e.g. OpenAI Codex, Claude Code, Cursor, or Antigravity).
*   **Antigravity Implementation Guideline**: This document (`plan_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining the 7-node state machine (e.g. `plan.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing unchangeable baselines and prompting laws (e.g. `plan-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures and scripts for 6-phase blueprint scaffolding, `phase_details/` subfolder creation, research report generation, and versioned implementation map drafting (e.g. `plan-generator/SKILL.md`).
    *   **Hooks (`hooks/`)**: Interceptor shell scripts enforcing plan validity prior to Git commits (e.g. `pre-commit-plan-validator.sh`).
    *   **Templates (`templates/`)**: Standardized starter document formats deployed into `agent-workspace/plans/<feature-name>/` (e.g. `PROCESS_STATUS.md`, `phase-1-summary.md` through `phase-6-operation.md`, `implementation_map_taxonomy.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and `/grill-me` alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Resource Usage & Governance Rule** | [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md#L19-L27) | Rule & Template Primitives | `rules/plan-grill.md` & `templates/PROCESS_STATUS.md` |
| **6-Phase Blueprint Architecture** | [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md#L115-L124) | Template & Skill Primitives | `templates/phase-*.md` (Phase 1–6) & `skills/plan-generator/SKILL.md` |
| **Pure Control Plane Sandbox (`agent-workspace/plans/<feature-name>/`)** | [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/folder_structure.md) & [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md#L16-L18) | Rule & Boundary Primitives | `rules/plan-grill.md` (Baseline 2) |
| **Initial Feature Summary Start Mandate (Node S2)** | [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md#L12-L15) | Workflow & Rule Primitives | `workflows/plan.md` (Node S2) & `rules/plan-grill.md` (Baseline 1) |
| **Decisions Embedded Directly in `phase-*.md` (No Decisions Subfolder)** | [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md#L19-L22) | Rule & Template Primitives | `rules/plan-grill.md` (Baseline 3) & `templates/phase-*.md` |
| **Research Reports in `knowledge/` & Linked** | [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md#L55-L58) | Skill & Template Primitives | `skills/plan-generator/SKILL.md` (`knowledge/research_report_<topic>.md`) |
| **On-Demand Subfolders (`phase_details/`)** | [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md#L59-L70) | Rule & Skill Primitives | `rules/plan-grill.md` & `skills/plan-generator/SKILL.md` |
| **Versioned Implementation Maps (`implementation_maps/`)** | [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/implementation_map_taxonomy.md) | Skill & Template Primitives | `skills/plan-generator/SKILL.md` (`implementation_map_v<version>.md`) |
| **Implementation Map Sandbox Guard (No Code Execution)** | [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md#L23-L26) | Rule Primitive | `rules/plan-grill.md` (Baseline 4) |
| **Sequential Q1–Q11 Grill Schema** | [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md#L51-L175) | Rule & Workflow Primitives | `rules/plan-grill.md` & `workflows/plan.md` |
| **Branch Process Status (`PROCESS_STATUS.md`)** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/plan.md` |

---

## 3. Step-by-Step Implementation Plan

---

### Step 1: Purge Existing Guard Assets inside `plan/antigravity/guards/`

*   **List of Actions**:
    1. Inspect directory `software_dev_elements/plan/antigravity/guards/`.
    2. If `software_dev_elements/plan/antigravity/guards/` contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`, `hooks/`), remove all existing sources inside `software_dev_elements/plan/antigravity/guards/`.
*   **Reasons & Design Decision Links**:
    *   *Idempotency Guarantee*: Purges outdated guard files before scaffolding new master guard assets, guaranteeing a repeatable execution run.

---

### Step 2: Scaffold Antigravity Guard Master Directory Tree

*   **List of Actions**:
    1. Create Antigravity tier-3 guard root directory: `software_dev_elements/plan/antigravity/guards/`.
    2. Create primitive subdirectories:
        *   `software_dev_elements/plan/antigravity/guards/workflows/`
        *   `software_dev_elements/plan/antigravity/guards/rules/`
        *   `software_dev_elements/plan/antigravity/guards/templates/`
        *   `software_dev_elements/plan/antigravity/guards/skills/plan-generator/`
        *   `software_dev_elements/plan/antigravity/guards/hooks/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Maintains master Antigravity guard primitives under `software_dev_elements/plan/antigravity/guards/` for central management before deploying into target project `agent-workspace/.agents/` directories.
    *   *Folder Taxonomy*: Mirrors the agentic control directory structure documented in [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/folder_structure.md).

---

### Step 3: Implement Stateful Workflow Playbook (`workflows/plan.md`)

*   **List of Actions**:
    1. Create `software_dev_elements/plan/antigravity/guards/workflows/plan.md`.
    2. Define YAML frontmatter (`name: plan`, `description: Interactive planning workflow for 6-phase blueprints and versioned implementation maps`).
    3. Implement the 7-step state machine execution nodes using Antigravity workflow syntax:
        *   **Node S1 (Check Preconditions & Feature Branch)**: Verifies `agent-workspace/` initialization and active feature branch.
        *   **Node S2 (Initial Feature Understanding Summary)**: Synthesizes initial feature understanding (from `/init`, `/process`, and user prompt) and presents an Initial Feature Summary to the developer *before* Q&A begins.
        *   **Node S3 (Interactive Q&A Session)**: Invokes the interview engine adhering to `rules/plan-grill.md` (Q1–Q11). Evaluates affected system layers, selects 6-phase blueprint subset, evaluates `phase_details/` subfolder need, processes research requests under `knowledge/`, and embeds decisions directly into blueprints.
        *   **Node S4 (Dynamic Blueprint Scaffolding & Impact Drafting)**: Invokes `skills/plan-generator/SKILL.md` to scaffold active `phase-*.md` documents, `phase_details/` subfolders, and `knowledge/research_report_<topic>.md` files inside `agent-workspace/plans/<feature-name>/`.
        *   **Node S5 (Execution Acceptance Gate & Versioned Implementation Map Option)**: Synthesizes blueprint status for review. Presents an explicit option to draft a software versioned implementation map (`implementation_map_v<version>.md`) adhering to `implementation_map_taxonomy.md` without code execution.
        *   **Node S6 (PROCESS_STATUS.md Sync & Log Update)**: Synchronizes `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md` matrix (sub-rows 3.1–3.6) and appends daily history log.
        *   **Node S7 (Planning Completed)**: Reports planning summary and instructions to proceed to `/implement`.
    4. Implement CLI parameter handling:
        *   `/plan`: Default interactive execution mode.
        *   `/plan --feature <feature_name>`: Specifies target feature folder explicitly.
        *   `/plan --auto`: Bypasses Node S5 acceptance gate and scaffold default blueprints automatically.
        *   `/plan --dry-run`: Previews proposed phase blueprints and implementation maps without writing to disk.
*   **Reasons & Design Decision Links**:
        *   *State Machine Lifecycle*: Realizes the 7-node execution design documented in [plan_workflow.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_workflow.md#L170-L245).

---

### Step 4: Implement Neutral Q&A Grill Rule Guard (`rules/plan-grill.md`)

*   **List of Actions**:
    1. Create `software_dev_elements/plan/antigravity/guards/rules/plan-grill.md`.
    2. Encode **Unchangeable Baseline Enforcement**:
        *   *Baseline 1 (Initial Summary Start)*: Mandates presenting Initial Summary (Node S2) prior to asking Q1.
        *   *Baseline 2 (Feature Sandbox)*: Restricts all write/edit operations strictly to `agent-workspace/plans/<feature-name>/`.
        *   *Baseline 3 (Embedded Decisions)*: Forbids creating a separate `decisions/` subfolder; enforces documenting choices directly inside `phase-*.md` files.
        *   *Baseline 4 (Implementation Map Sandbox Guard)*: Forbids code execution or source file editing in `src/` or `codebase-*/` during `/plan`.
        *   *Baseline 5 (Versioned Implementation Map Naming)*: Mandates naming implementation maps after software release versions (`implementation_map_v<version>.md`).
    3. Encode Prompting Laws (neutral choices, free-text option on every question, no `[Recommended]` tags).
    4. Encode Q1–Q11 questionnaire schema matching [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/plan_questions.md).

---

### Step 5: Implement Blueprint & Map Generator Skill (`skills/plan-generator/SKILL.md`)

*   **List of Actions**:
    1. Create `software_dev_elements/plan/antigravity/guards/skills/plan-generator/SKILL.md`.
    2. Define procedure for deploying 6-Phase Blueprints into `agent-workspace/plans/<feature-name>/`:
        *   `phase-1-summary.md` (Mandatory master governor & System Impact Analysis)
        *   `phase-2-layout.md` (UI presentation & view specs)
        *   `phase-3-data.md` (Data handling, capturing, storing mechanisms & data store lifecycle)
        *   `phase-4-engine.md` (Core engine, API contracts & service routing)
        *   `phase-5-verification.md` (Test suites & assertion matrices)
        *   `phase-6-operation.md` (Docker & operations deployment impact)
    3. Define procedure for scaffolding `phase_details/<element_name>/` subfolders for complex multi-layer features.
    4. Define procedure for drafting `knowledge/research_report_<topic>.md` files and linking them inside `phase-*.md`.
    5. Define procedure for drafting `implementation_maps/implementation_map_v<version>.md` adhering to [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/implementation_map_taxonomy.md).

---

### Step 6: Implement Template Assets (`templates/`)

*   **List of Actions**:
    1. Create `software_dev_elements/plan/antigravity/guards/templates/PROCESS_STATUS.md`: Pre-configured matrix template with sub-rows 3.1–3.6 for 6 planning phases and versioned implementation map rows.
    2. Create `software_dev_elements/plan/antigravity/guards/templates/GRILL_STATUS.md`: Stateful transcript log template for `/plan` interview sessions.
    3. Create `software_dev_elements/plan/antigravity/guards/templates/phase-1-summary.md` through `phase-6-operation.md`: Starter blueprint templates featuring embedded decision sections and research link placeholders.
    4. Create `software_dev_elements/plan/antigravity/guards/templates/implementation_map.md`: Starter implementation map template adhering to 5-block taxonomy schema with version header.

---

### Step 7: Implement Pre-Commit Safety Interceptor Hook (`hooks/pre-commit-plan-validator.sh`)

*   **List of Actions**:
    1. Create `software_dev_elements/plan/antigravity/guards/hooks/pre-commit-plan-validator.sh`.
    2. Add executable shell script logic (`#!/usr/bin/env bash`).
    3. Intercept `git commit` actions during planning to verify:
        *   `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md` exists and is tracked.
        *   `phase-1-summary.md` is present.
        *   No source files in `src/` or `codebase-*/` have been modified during `/plan`.
    4. Exit with code `1` and print error message if boundary rules or process status tracking are violated.

---

## 4. Verification Plan

*   Validate that all generated files in `software_dev_elements/plan/antigravity/` execute cleanly.
*   Run verification test suite defined in [plan_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/plan/antigravity/plan_tests.md).
