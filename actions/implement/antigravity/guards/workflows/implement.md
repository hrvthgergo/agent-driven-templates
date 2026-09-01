---
name: implement
description: Action implementation workflow for incremental code scaffolding, test harness construction, solution testing, AST code graph generation, and system documentation updates
---

# `/implement` Workflow Execution Playbook

This stateful execution playbook defines the 7-node state machine governing source code implementation, cross-layer test harness construction (`codebase-qualify/`), solution testing, decision persistence, and optional AST code graph and documentation promotion within Google Antigravity.

---

## 1. Parameters & Operational Rules of Thumb

### CLI Parameter Handling
* `/implement` (or `/implement --plan`): Default interactive execution mode. Validates map, test plan, and ratified scenarios, runs micro-architecture grill, presents step-by-step code edits with diff previews, and pauses for developer approval before writing to disk. Code graph and docs updates are skipped by default.
* `/implement --auto` (or `/implement --apply`): Continuous execution mode. Automatically scaffolds code step-by-step according to `implementation_map_v<version>.md`, executes solution tests, and syncs decisions to `plans/`, logging to `implementation_log.md`.
* `/implement --tests-only`: Harness Stream Isolation Mode. Executes only the Test Harness stream against `codebase-qualify/`, building one cited test (`@scenario SC-<feature-slug>-<nnn>`) per ratified in-scope scenario. Used for red-first construction ahead of feature code, and to close coverage gaps reported by a failed `/qualify` Node Q1 gate.
* `/implement --code-graph`: Enables optional AST Code Graph updates in `agent-workspace/src/<layer>/code_graph/`.
* `/implement --docs`: Enables optional System Documentation updates in `agent-workspace/docs/`.
* `/implement --full-sync`: Enables both optional Code Graph and System Documentation updates.
* `/implement --version vX.Y.Z`: Explicitly targets a specific implementation map version (e.g. `implementation_map_v1.0.0.md`).
* `/implement --dry-run`: Preview mode. Simulates code scaffolding, displays file diff previews, and verifies code graph updates without writing changes to disk.

---

## 2. Execution State Machine Nodes (S1 – S7)

### Node S1: Check Environment & Preconditions
1. **Workspace Verification**: Assert that `agent-workspace/` control structures exist and active feature directory `agent-workspace/plans/<feature-name>/` is established.
2. **Git Context Verification**: Verify Git context and active feature branch.
3. **Docker Daemon Check**: Execute `docker info` to verify runtime container health.

### Node S2: FIRST ACTION - Map, Test Plan & Scenario Ratification Verification
1. **Prerequisite Check**: As the very first action, inspect `agent-workspace/plans/<feature-name>/implementation_maps/` for `implementation_map_v<version>.md` and `agent-workspace/plans/<feature-name>/phase-5-test.md`.
2. **Scenario Ratification Check**: Extract all scenario IDs from `phase-5-test.md` and resolve each against `agent-workspace/tests/scenarios/<id>.md`. Confirm every scenario exists and carries `status: ratified`.
3. **Fail-Closed Resolution Gate**: If the map, test plan, or any scenario ratification check fails, immediately halt execution, report the missing/unratified items, and **return the scope to `/plan`**. `/implement` NEVER authors missing scenarios or artifacts itself.

### Node S3: Micro-Architecture Q&A Grill Gate
1. Invoke the neutral interview engine enforcing `rules/implement-grill.md`.
2. Execute sequential prompts Q1 to Q9 (including Q4b Test Harness Construction Ordering) neutrally without `[Recommended]` bias labels.
3. Confirm starting layer/module, scaffolding execution strategy, harness ordering (Red-First, Feature-First, Interleaved), sequential vs. parallel stream handling, and optional token economy flags (`--code-graph`, `--docs`).
4. Write interview choices permanently to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

### Node S4: Visible Step-by-Step Code Scaffolding, Test Harness Loop & Solution Testing
1. Invoke `skills/implement-scaffolder/SKILL.md`.
2. **Repository Provisioning (First Act)**: Before any file content is written, provision any `codebase-<layer>/`, `codebase-qualify/`, or `codebase-devops/` repository named in the blueprint that does not yet exist, applying the `/init`-owned skeleton contract (`src/`, `config/`, `tests/`, `.github/workflows/`, `Dockerfile`, `.gitkeep`) and registering relative symlinks under `agent-workspace/src/<layer>/`.
3. **Incremental Code Scaffolding**: Execute code modifications step-by-step in target `codebase-*` sub-repositories following the mandatory 4-part step schema (Requirement, Prerequisites, Actions, Verification).
4. **Test Harness Scaffolding**: For each in-scope ratified scenario, scaffold cross-layer tests in `codebase-qualify/src/` tagged with `@scenario SC-<feature-slug>-<nnn>` inside test declaration blocks (or execute exclusively when `--tests-only` is active).
5. **Observability & DevOps Scaffolding**: Scaffold runtime instrumentation (metrics, health endpoints) in `codebase-<layer>/` and monitoring infrastructure (collector configs, alert rules) in `codebase-devops/` realizing `phase-6-operation.md` §6 contracts.
6. **Layer-Local Tests**: Scaffold unit and integration test files in `codebase-<layer>/tests/` alongside production code.
7. **Solution Testing**: Execute unit, integration, and regression assertions per step.
8. **Inner Agent Artifact Sync**: Immediately write and synchronize all decisions, plan updates, and step outcomes produced in inner agent docs (Artifacts) to the corresponding version-controlled files under `agent-workspace/plans/<feature-name>/`.
9. **User Interruption Checkpoints**: Maintain an active communication window between steps where the user can interrupt, ask questions, or request adjustments (no opaque subagent delegation).

### Node S5: OPTIONAL AST Code Graph Generation & Update
1. **Condition**: Executed ONLY when `--code-graph` or `--full-sync` flag is present (skipped by default).
2. Parse implemented code for structural symbols (Python dataclasses/protocols, Go structs/interfaces, JS ES6 classes/exports).
3. Update modular code graph subfolders under `agent-workspace/src/<layer>/code_graph/` (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`) adhering to `code_graph_taxonomy.md`.

### Node S6: OPTIONAL System Documentation Update & Knowledge Promotion
1. **Condition**: Executed ONLY when `--docs` or `--full-sync` flag is present (skipped by default).
2. Inspect `agent-workspace/plans/<feature-name>/resource/` for staged legacy documents, schemas, and diagrams.
3. Update global system documentation under `agent-workspace/docs/` (e.g. updating API reference, component architecture, data models).

### Node S7: `PROCESS_STATUS.md` Sync & Handoff to `/qualify`
1. Update `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`, marking Row 4 (`/implement`) as `Completed`.
2. Record datestamped entry in Block 2 daily history log.
3. Output completion report and recommend next workflow command (`/qualify`).
