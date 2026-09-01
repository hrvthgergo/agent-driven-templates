---
name: implement-scaffolder
description: Antigravity skill for incremental code scaffolding, solution testing, AST code graph generation, decision persistence, and system documentation updates
---

# `implement-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding source code in `codebase-*`, running solution tests, synchronizing inner agent artifacts with version-controlled `plans/` documents, and optionally building AST code graphs and updating global system documentation.

---

## 1. Execution Repository Provisioning & Incremental Code Scaffolding

1. Read target `implementation_map_v<version>.md`, `phase-5-test.md`, and `phase-6-operation.md` from `agent-workspace/plans/<feature-name>/`, and extract in-scope scenario IDs.
2. Verify all in-scope scenarios carry `status: ratified` in `agent-workspace/tests/scenarios/`.
3. **Repository & Execution Directory Provisioning (First Act)**:
   * For each repository named in the blueprint (`codebase-<layer>/`, `codebase-qualify/`, `codebase-devops/`) that does not yet exist:
     - Provision the repository root and initialize `.git`.
     - Apply the standard skeleton contract (`src/`, `config/`, `tests/`, `.github/workflows/`, `Dockerfile`, and universal `.gitkeep` files).
     - Register the relative symlink under `agent-workspace/src/<layer>/`.
   * (In brownfield mode, write directly into repositories linked by `/process`).
4. Parse planned tasks adhering to the mandatory 4-part step schema:
   * 1. **Requirement Fulfilled**: Map to corresponding `phase-*.md` section.
   * 2. **Prerequisites**: Verify preceding dependencies are satisfied.
   * 3. **Actions Taken**: Detail target sub-repositories (`codebase-<layer>/`, `codebase-qualify/`, `codebase-devops/`, or `src/<layer>/`) and files (`[NEW]`, `[MODIFY]`, `[REFACTOR]`).
   * 4. **Verification Fulfilled**: Execute unit, regression, and harness test commands.
5. **Test Harness Construction (`codebase-qualify/src/`)**:
   * For each in-scope ratified scenario, scaffold a cross-layer test in `codebase-qualify/src/`.
   * Inject the mandatory language-invariant citation token within the test declaration block:
     ```
     @scenario SC-<feature-slug>-<nnn>
     ```
   * When `--tests-only` is invoked, execute only this stream (red-first harness construction).
6. **Feature Code & Layer-Local Tests (`codebase-*`)**:
   * Create new source files or edit existing code in target `codebase-*` sub-repositories.
   * Create layer-local unit and integration test files in `codebase-<layer>/tests/` alongside production code.
   * Scaffold runtime observability instrumentation (metrics, health endpoints) in `codebase-<layer>/`.
   * Enforce architectural boundaries and clean layer separation.
7. **DevOps & Monitoring Infrastructure (`codebase-devops/`)**:
   * Scaffold monitoring infrastructure (collector configs, alert rules, dashboards-as-code) and CI/CD pipelines in `codebase-devops/` per `phase-6-operation.md` §6.
   * Verify workspace symlinks in `agent-workspace/src/<layer>/`, `agent-workspace/src/qualify/`, and `agent-workspace/src/devops/`.

---

## 2. Decision Persistence & Inner Agent Artifact Synchronization

1. For every decision, design adjustment, trade-off rationale, or step outcome recorded in an inner agent artifact (e.g. `implementation_plan.md` or `walkthrough.md`):
   * Write and synchronize the exact content into the corresponding version-controlled files under `agent-workspace/plans/<feature-name>/` (`phase-*.md`, `GRILL_STATUS.md`, `PROCESS_STATUS.md`, or `implementation_maps/`).
2. Ensure that version-controlled Git history retains 100% parity with agent reasoning.

---

## 3. OPTIONAL: AST-Level Code Graph Generation & Synchronization (`src/<layer>/code_graph/`)

1. **Check Flag**: Proceed ONLY if `--code-graph` or `--full-sync` flag is active. (Skipped by default).
2. Parse modified source files for structural code symbols based on selected language taxonomy:
   * **Python**: `Module`, `Class`, `Dataclass`, `Protocol`, `Function`, `Decorator`, `Exception`.
   * **Go**: `Package`, `Struct`, `Interface`, `Function`, `Goroutine`, `Channel`.
   * **JavaScript / TypeScript**: `Module`, `Class`, `Function`, `Export`, `Middleware`.
3. Create/update directory `agent-workspace/src/<layer>/code_graph/`.
4. Update the 4 core code graph files:
   * `graph.md`: Structural element registry and connection graph (`IMPORTS`, `IMPLEMENTS`, `CALLS`, `EXTENDS`).
   * `process_flow.md`: Control flow entry points and execution sequence.
   * `data_flow.md`: Data input sources, DTO transformations, and persistence flows.
   * `risk_analysis.md`: Coupling metrics (fan-in/fan-out), critical nodes, and test coverage maps.

---

## 4. OPTIONAL: Global System Documentation Updates (`agent-workspace/docs/`)

1. **Check Flag**: Proceed ONLY if `--docs` or `--full-sync` flag is active. (Skipped by default).
2. Inspect `agent-workspace/plans/<feature-name>/resource/` for non-code specs, API diagrams, and schemas staged during `/process` or `/plan`.
3. Update/create global documentation files under `agent-workspace/docs/`:
   * `agent-workspace/docs/architecture/`: System-wide component topology and data layer designs.
   * `agent-workspace/docs/api/`: REST/gRPC endpoint specifications, DTO schemas, and authentication flows.
   * `agent-workspace/docs/components/`: Reusable UI presentation components and service contracts.
4. Synthesize implemented feature capabilities into human-readable markdown documents reflecting live codebase reality.

---

## 5. `PROCESS_STATUS.md` Synchronization

1. Open `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`.
2. Update Block 1 Row 4 (`/implement`) status to `Completed`.
3. Append datestamped execution log entry to Block 2 daily history table.
