---
name: implement-scaffolder
description: Antigravity skill for incremental code scaffolding, solution testing, AST code graph generation, decision persistence, and system documentation updates
---

# `implement-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding source code in `codebase-*`, running solution tests, synchronizing inner agent artifacts with version-controlled `plans/` documents, and optionally building AST code graphs and updating global system documentation.

---

## 1. Incremental Code Scaffolding in `codebase-*`

1. Read target `implementation_map_v<version>.md` and `phase-5-verification.md` from `agent-workspace/plans/<feature-name>/`.
2. Parse planned tasks adhering to the mandatory 4-part step schema:
   * **1. Requirement Fulfilled**: Map to corresponding `phase-*.md` section.
   * **2. Prerequisites**: Verify preceding dependencies are satisfied.
   * **3. Actions Taken**: Detail target sub-repositories (`codebase-<layer>/` or `src/<layer>/`) and files (`[NEW]`, `[MODIFY]`, `[REFACTOR]`).
   * **4. Verification Fulfilled**: Execute unit and regression test commands.
3. For each step in the implementation map:
   * Create new source files or edit existing code in target `codebase-*` sub-repositories.
   * Create unit and integration test files alongside production code as specified in `phase-5-verification.md`.
   * Enforce architectural boundaries and clean layer separation.
   * Verify workspace symlinks in `agent-workspace/src/<layer>/`.

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
