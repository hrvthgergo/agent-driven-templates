# Grill Schema: Action Implementation Questions (/implement)

This document defines the Q&A interview questionnaire schema, auto-detection scanning rules, unchangeable baselines, and structured prompts used by the `/implement` workflow's Grill Engine session.

The primary objective of the `/implement` Grill-Me session is to align the developer and AI agent on micro-architectural implementation choices, starting layers, scaffolding boundaries, sequential vs. parallel execution streams, token economy options, and decision persistence before source code changes begin.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure system stability, code quality, and process governance, six unchangeable baselines are strictly enforced. **Zero questions are asked about these baselines during the `/implement` interview**:

### Baseline 1: Mandatory Dual Grounding Mandate
* **Specification**: Code implementation MUST stand firmly on THREE resolved foundations: (1) a valid `implementation_map_v<version>.md` under `agent-workspace/plans/<feature-name>/implementation_maps/`, (2) a Verification Scope (`phase-5-test.md`), and (3) a fully resolved, **ratified** scenario set — every scenario ID listed in `phase-5-test.md` resolving to a file in `agent-workspace/tests/scenarios/` with `status: ratified`, per [verification_taxonomy.md](../verification_taxonomy.md) §6. Source code modification without all three is strictly prohibited. `/implement` never resolves a failed precondition by authoring the missing artifact itself; it returns the scope to `/plan`.

### Baseline 2: Strict Directory Separation & Production Cleanliness
* **Specification**: Source code edits and unit test additions MUST take place inside `codebase-*` sub-repositories (or `src/`). Production source repositories must remain 100% clean of documentation maps; AST code graphs MUST be placed exclusively in `agent-workspace/src/<layer>/code_graph/`, and system documentation MUST be written to `agent-workspace/docs/`.

### Baseline 3: Mandatory 4-Part Step Schema Enforcement
* **Specification**: Every implementation task in the target implementation map MUST document:
  1. Requirement Fulfilled (from `phase-*.md`)
  2. Prerequisites
  3. Actions Taken (`[NEW]`, `[MODIFY]`, `[REFACTOR]`)
  4. Verification Fulfilled (test command/assertion)
  Sequential steps MUST run in strict linear order; parallel steps MAY run concurrently.

### Baseline 4: Mandatory Decision Persistence & Inner Agent Artifact Alignment
* **Specification**: Every decision, design choice, and conversation outcome recorded in inner agent docs (e.g. Antigravity Artifacts) MUST be immediately synchronized and written into version-controlled files under `agent-workspace/plans/<feature-name>/`.

### Baseline 5: Token Economy Guard (Optional Maintenance of Code Graphs & Docs)
* **Specification**: Updating AST Code Graphs (`src/<layer>/code_graph/`) and System Documentation (`docs/`) is strictly OPTIONAL and bypassed by default during `/implement` to prevent token bloat and excessive computational overhead.

### Baseline 6: Visible Step-by-Step Execution & Direct User Control
* **Specification**: Code scaffolding MUST run in a visible, followable step-by-step loop where the user can interrupt, ask questions, or request micro-architectural clarification at any time. Opaque background delegations to subagents are forbidden.

---

## 2. Questions & Scanning Blueprint

```
                     ┌───────────────────────────────────┐
                     │   Start /implement Scan & Check   │
                     └─────────────────┬─────────────────┘
                                       │
                Verify Dual Grounding (Map + Test Plan)
                                       │
                    For each question in Schema (Q1 - Q9):
                                       │
                      Does Scan/Context auto-answer?
                      /                             \
                   (Yes)                            (No)
                   /                                   \
        [Auto-answer Question]                 [Run Q&A Interview]
```

* **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom thoughts.

---

## 3. Sequential Question List (Execution Order: Q1 to Q9, incl. Q4b)

### Q1: Implementation Map & Target Version Selection
* **Goal**: Confirm which version-named implementation map inside `agent-workspace/plans/<feature-name>/implementation_maps/` governs this execution.
* **Auto-Detection Scanning Rule**:
  * Scan `agent-workspace/plans/<feature-name>/implementation_maps/` for active files (`implementation_map_v1.0.0.md`, `implementation_map_v1.1.0_layout.md`).
  * If exactly one map exists, auto-select and confirm. If multiple exist and no `--version` flag is provided, prompt the user.
* **Reframed Grill Prompt**:
  > **Which implementation map version should govern this implementation run?**
  > 1. Target full feature release map (e.g., `implementation_map_v1.0.0.md`)
  > 2. Target partial scope implementation map (e.g., `implementation_map_v1.1.0_layout.md` or `implementation_map_v1.1.0_engine.md`)
  > 3. Draft a new versioned implementation map before proceeding
  > 4. Other / Free-text (Specify custom implementation map path)

---

### Q2: Verification Test Plan & Critical Feature Assertions Alignment
* **Goal**: Confirm alignment with test specifications in `phase-5-test.md` and global test scenarios before code scaffolding.
* **Auto-Detection Scanning Rule**:
  * Read `agent-workspace/plans/<feature-name>/phase-5-test.md`. Extract the scenario ID list in scope.
  * Resolve every extracted ID against `agent-workspace/tests/scenarios/<id>.md`. Confirm each exists and carries `status: ratified`. Report any missing, unratified, or retired ID as a **precondition failure**, not as a question.
* **Reframed Grill Prompt**:
  > **How should unit and integration test specs from the Test Plan be scaffolded during implementation?**
  > 1. Scaffold unit test files alongside production code files per step
  > 2. Scaffold production code first, then scaffold corresponding test suites in step finalization
  > 3. Focus strictly on production code scaffolding (Defer test execution to `/qualify`)
  > 4. Other / Free-text (Describe custom test scaffolding strategy)

---

### Q3: Starting Layer / Component Entry Point
* **Goal**: Identify which architectural layer or component module to implement first.
* **Auto-Detection Scanning Rule**:
  * Read execution steps block in target `implementation_map_v<version>.md`. Auto-detect Step 1 target layer.
* **Reframed Grill Prompt**:
  > **Which architectural layer or module would you like to implement first?**
  > 1. Data Layer & Persistence Models (`codebase-data` / database models / DTOs)
  > 2. Core Engine & API Services Layer (`codebase-engine` / backend logic)
  > 3. UI Presentation & Component Layer (`codebase-ui` / frontend components)
  > 4. Infrastructure & Operations Layer (`codebase-ops` / container orchestration)
  > 5. Sequential order defined in `implementation_map_v<version>.md`
  > 6. Other / Free-text (Specify starting layer or file path)

---

### Q4: Code Modification Strategy & Visible Step Boundary
* **Goal**: Determine the scaffolding step boundary, visibility level, and confirmation frequency.
* **Auto-Detection Scanning Rule**:
  * Check CLI flags (`--auto`, `--plan`, `--dry-run`).
* **Reframed Grill Prompt**:
  > **What scaffolding execution strategy should be applied?**
  > 1. Step-by-step with explicit developer approval and diff preview after each file group (Plan-First Mode)
  > 2. Continuous scaffolding across all steps defined in the implementation map with live progress output (Continuous Mode)
  > 3. Dry-run preview (Simulate code scaffolding and diff generation without altering files)
  > 4. Other / Free-text (Describe custom scaffolding strategy)

---

### Q4b: Test Harness Construction Ordering (Red-First vs. Feature-First)
* **Goal**: Determine when the Test Harness stream (`codebase-qualify/`) is executed relative to feature code.
* **Auto-Detection Scanning Rule**:
  * Inspect Block 2 of the target `implementation_map_v<version>.md` for a Test Harness stream and count the ratified scenarios it must cover.
  * Check whether `codebase-qualify/src/` already contains tests citing any in-scope `SC-*` identifier.
* **Reframed Grill Prompt**:
  > **When should the cross-layer test harness for this feature be built?**
  > 1. **Red-first (Recommended)** — Build the harness before feature code (`/implement --tests-only`), producing a failing suite that feature scaffolding turns green. Available because scenarios already exist from `/plan`.
  > 2. Feature-first — Scaffold feature code first, then build the harness to match
  > 3. Interleaved — Build each scenario's harness immediately after the step that satisfies it
  > 4. Other / Free-text (Describe custom harness ordering)

---

### Q5: Sequential vs. Parallel Stream Execution Order
* **Goal**: Confirm how parallel execution streams defined in Block 2 of the implementation map should be handled.
* **Auto-Detection Scanning Rule**:
  * Inspect Block 2 of target `implementation_map_v<version>.md` for parallel tasks, including the Test Harness stream targeting `codebase-qualify/`.
* **Reframed Grill Prompt**:
  > **How should decoupled parallel execution tasks be sequenced?**
  > 1. Interleaved sequential execution (Execute Parallel Stream A, then Parallel Stream B)
  > 2. Complete backend/data parallel tasks before starting presentation/UI parallel tasks
  > 3. Let user select order interactively at the parallel branching point
  > 4. Other / Free-text (Describe custom parallel execution sequence)

---

### Q6: Token Economy & AST Code Graph Update Options (`--code-graph`)
* **Goal**: Confirm whether AST Code Graph generation should be activated for this implementation run.
* **Auto-Detection Scanning Rule**:
  * Check CLI flags (`--code-graph`, `--full-sync`).
* **Reframed Grill Prompt**:
  > **Should AST Code Graphs in `src/<layer>/code_graph/` be generated/updated during this run?**
  > 1. Skip Code Graph updates (Default - Conserves token usage and eliminates parsing overhead)
  > 2. Update Code Graphs in `agent-workspace/src/<layer>/code_graph/` upon completing all steps
  > 3. Update Code Graphs incrementally per layer step
  > 4. Other / Free-text (Specify custom code graph policy)

---

### Q7: Token Economy & System Documentation Promotion Options (`--docs`)
* **Goal**: Confirm whether general system documentation under `agent-workspace/docs/` should be updated.
* **Auto-Detection Scanning Rule**:
  * Check CLI flags (`--docs`, `--full-sync`).
* **Reframed Grill Prompt**:
  > **Should general system documentation under `agent-workspace/docs/` be updated from staged feature resources?**
  > 1. Skip System Docs updates (Default - Conserves token usage during active code development)
  > 2. Synthesize API endpoints, component specs, and data models into `docs/` upon completion
  > 3. Update existing global `docs/` files with newly implemented feature capabilities
  > 4. Other / Free-text (Describe custom documentation update requirements)

---

### Q8: Sub-Repository / Multi-Repo Symlink Integrity Verification
* **Goal**: Verify that workspace symbolic links (`agent-workspace/src/<layer>`) resolve correctly to target `codebase-*` sub-repositories.
* **Auto-Detection Scanning Rule**:
  * Check symlinks under `agent-workspace/src/` using `test -L` and `readlink`.
* **Reframed Grill Prompt**:
  > **Would you like to perform a symbolic link integrity check on `agent-workspace/src/` before scaffolding code?**
  > 1. Yes, verify symlink resolution and directory write permissions
  > 2. Skip symlink check (Single-repository / direct `src/` layout)
  > 3. Re-link broken workspace symlinks automatically
  > 4. Other / Free-text (Describe custom workspace link setup)

---

### Q9: Final Implementation Confirmation & Execution Start
* **Goal**: Re-cap chosen options and obtain final developer consent to start code implementation.
* **Reframed Grill Prompt**:
  > **Review implementation configuration:**
  > * Target Map: `implementation_map_v<version>.md`
  > * Verification Scope: `phase-5-test.md`
  > * Ratified Scenarios in Scope: `<n>` (all resolved)
  > * Harness Ordering: `[Red-First | Feature-First | Interleaved]`
  > * Execution Mode: `[Plan-First | Continuous | Dry-Run]`
  > * Code Graph Updates: `[Enabled | Skipped (Default)]`
  > * System Docs Updates: `[Enabled | Skipped (Default)]`
  > 
  > **Would you like to begin code scaffolding now?**
  > 1. Confirm and execute implementation
  > 2. Revise implementation settings or starting layer
  > 3. Abort implementation execution
  > 4. Other / Free-text (Describe custom execution startup)
