---
name: plan
description: Interactive planning workflow for 6-phase blueprints, research reports, and versioned implementation maps
---

# `/plan` Workflow Execution Playbook

This stateful execution playbook defines the 7-node state machine governing feature planning, 6-Phase Blueprint Architecture generation, and software versioned implementation map drafting within Google Antigravity.

---

## 1. Parameters & Operational Rules of Thumb

### CLI Parameter Handling
*   `/plan`: Default interactive execution mode. Automatically detects active Git feature branch (or prompts for feature name) and targets `agent-workspace/plans/<feature-name>/`.
*   `/plan --feature <feature_name>`: Explicitly specifies the target feature name and targets plan subfolder `agent-workspace/plans/<feature_name>/`.
*   `/plan --auto`: Non-interactive execution mode. Automatically presents initial summary, auto-selects default blueprint set, bypasses Node S5 interactive prompts, and scaffolds blueprints automatically.
*   `/plan --dry-run`: Simulates the planning sequence, previewing proposed 6-phase blueprint documents, `phase_details/` subfolders, research reports, and versioned implementation maps without writing changes to disk.
*   `/plan --force`: Overwrites existing phase blueprints while preserving `GRILL_STATUS.md` and historical logs.

---

## 2. Execution State Machine Nodes (S1 – S7)

### Node S1: Check Preconditions & Feature Branch
1.  **Workspace Verification**: Assert that `agent-workspace/` control structures exist and workspace is initialized.
2.  **Git Context Verification**: Verify Git context and determine active feature branch (`feature/<feature-name>`).
3.  **Docker Healthcheck**: Execute `docker info` to verify Docker daemon accessibility.

### Node S2: Initial Feature Understanding Summary
1.  Synthesize initial feature understanding from `/init` baseline, `/process` outputs, and user prompt context.
2.  **Summary Presentation**: Present an Initial Feature Understanding Summary to the developer *before* starting any Q&A interview prompts.
3.  Initialize feature directory `agent-workspace/plans/<feature-name>/`.

### Node S3: Interactive Q&A Session (System Impact & Blueprint Selection)
1.  Invoke the neutral interview engine enforcing `rules/plan-grill.md`.
2.  Execute sequential prompts Q1 to Q11 neutrally without `[Recommended]` bias labels.
3.  Identify affected system layers (UI Presentation, Data Handling, Core Engine/API, Verification Specs, Docker Ops).
4.  Select active 6-Phase Blueprint subset (`phase-1-summary.md` through `phase-6-operation.md`, including `phase-3-data.md`).
5.  Evaluate whether a multi-layer subfolder structure (`phase_details/<element_name>/`) is required for complex features.
6.  Process topic research requests under `knowledge/research_report_<topic>.md` and link them directly in blueprints.
7.  Document all architectural choices, ADR trade-off rationale, and design decisions **directly inside active `phase-*.md` documents** (with zero separate decisions folder).
8.  Persist all questions, options, and user choices permanently into `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

### Node S4: Dynamic Blueprint Scaffolding & Embedded Decision Drafting
1.  Invoke `skills/plan-generator/SKILL.md`.
2.  Scaffold active phase blueprint documents (`phase-1-summary.md` through `phase-6-operation.md`) under `agent-workspace/plans/<feature-name>/`.
3.  If multi-layer subfolder option selected in Q4, scaffold `phase_details/<element_name>/` subfolders.
4.  Write requested research reports under `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md`.
5.  Strictly respect the Workspace Boundary Guard (writing ONLY to `agent-workspace/plans/<feature-name>/`).

### Node S5: Execution Acceptance Gate & Versioned Implementation Map Option
1.  Synthesize generated blueprint status into an Execution Acceptance Summary for developer review.
2.  **Implementation Map Option Prompt**: Offer an option to draft a software version-linked implementation map (`implementation_maps/implementation_map_v<version>.md`) adhering to `implementation_map_taxonomy.md`.
3.  **STRICT PROHIBITION**: Draft document files only. **Zero code scaffolding or source file editing in `src/` or `codebase-*/` is permitted during `/plan`**.
4.  Log acceptance decision into `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

### Node S6: `PROCESS_STATUS.md` Sync & Log Update
1.  Synchronize `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md` Block 1 matrix sub-rows (3.1 to 3.6 for 6 planning phases).
2.  Record datestamped entry in Block 2 daily history log.

### Node S7: Planning Completed
1.  Output planning completion summary report.
2.  Display generated blueprint paths and recommend next workflow command (`/implement`).
