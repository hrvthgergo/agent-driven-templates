---
name: process-migrator
description: Antigravity skill instructing the agent on brownfield legacy source analysis, in-place layer symlink creation under agent-workspace/src/, non-code doc resource staging, workspace-scoped Code Graph subfolder creation, and selective phase blueprint population.
---

# Action Skill: Legacy Migration & Code Graph Generation (`process-migrator`)

This skill package defines the exact procedural instructions for analyzing brownfield legacy codebases, creating in-place symbolic links inside `agent-workspace/src/<layer>` (or optional sub-repository scaffolding), staging non-code legacy documentation in `agent-workspace/plans/<branch_name>/resource/`, building modular workspace Code Graph subfolders (`agent-workspace/src/<layer>/code_graph/`), and selectively synthesizing phase blueprints during the `/process` action in Google Antigravity.

---

## Procedure 1: Untouched Legacy Source Integrity & In-Place Symlink Integration

When executing legacy codebase integration, the agent MUST adhere to the following steps:

1. **Read-Only Integrity Assertion**:
   - Original legacy source directories and repositories MUST remain 100% untouched and read-only.
   - Record MD5 checksums of legacy source files prior to integration operations.
   - Zero file deletions, moves, overwrites, or logic refactoring are permitted within original legacy directories.

2. **In-Place Layer Symlink Creation**:
   - For each classified legacy codebase folder (e.g. UI $\rightarrow$ `layout`, Server/API $\rightarrow$ `engine`), register a relative symbolic link inside `agent-workspace/src/<layer>` pointing directly to the corresponding legacy path (e.g., `ln -s ../../legacy-app/src agent-workspace/src/layout`).
   - If isolated scaffolding is requested instead, scaffold the `codebase-*` sub-repository structure and copy files intact without code modifications.

3. **Feature Plan Subfolders Staging**:
   - Copy non-code legacy documentation, supplementary assets, schemas, and diagrams into **`agent-workspace/plans/<branch_name>/resource/`**, research reports into `knowledge/`, version-named implementation maps into `implementation_maps/`, and multi-layer sub-element blueprints into `phase_details/` as feature reference knowledge. (Global `docs/` is reserved for already implemented system capabilities; relevant docs will be linked/promoted into `docs/` later during `/implement`).
   - **Strict Non-Rewriting Rule**: Do NOT modify, refactor, or rewrite source code logic, variable names, or syntax.

---

## Procedure 2: Workspace Code Graph Subfolder Generation

When the `--code-graph` command flag is passed, Code Graphs are generated exclusively inside **`agent-workspace/src/<layer>/code_graph/`**:

1. **Scaffold Code Graph Subfolder**:
   - For each active layer (e.g. `layout`, `engine`), create `agent-workspace/src/<layer>/code_graph/`.

2. **Generate Modular Analysis Files**:
   - Parse legacy source code adhering to [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/code_graph_taxonomy.md) (Python, Go, or JS node types) and create 4 files per layer with Version Stamp Headers:
     * **`graph.md` (Block 1)**: Unordered structural dependency graph & element registry listing interfaces, classes, functions, entities, and services.
     * **`process_flow.md` (Block 2A)**: Process entry points, execution triggers, and control flow initiation paths.
     * **`data_flow.md` (Block 2B)**: Inventory of data sources (user provided, configs, external APIs, databases, hardcoded constants) and datastream transformations.
     * **`risk_analysis.md` (Block 2C)**: Coupling metrics (fan-in / fan-out connection counts), critical code nodes, and test coverage maps.

---

## Procedure 3: Selective Blueprints Population & Status Update

1. **Synthesize Identified Domain Knowledge into `agent-workspace/plans/<branch_name>/`**:
   - Selectively populate relevant phase blueprint documents in `agent-workspace/plans/<branch_name>/` (`phase-1-summary.md` through `phase-6-operation.md`).
   - *Selective Rule*: Populate ONLY those phase blueprint documents where relevant information was identified in the legacy sources. Filling out all 6 phase documents is optional and not mandatory.

2. **Update Process Status**:
   - Update `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`. Update Block 1 matrix marking Row 2.0 (`/process`) as `Completed` and record a datestamped summary entry in Block 2.

---

## Procedure 4: Remote Synchronization (`--sync` / `--pull`)

When the `--sync` flag is passed, the agent MUST synchronize the workspace with remote coworker commits:

1. **Remote Fetch & Pull**:
   - Execute `git fetch` and `git pull` on the active workspace and linked legacy repository origins.
   - If merge conflicts occur, halt and present the conflicts to the user or resolve them if trivial.

2. **Structural Diff Analysis**:
   - Analyze the `git diff` against the previous local HEAD to identify precisely which files, modules, or directories were modified by remote coworkers.

3. **Incremental Knowledge Alignment**:
   - For layers affected by the diffs, selectively re-execute **Procedure 2 (Code Graph Generation)** to update `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md`.
   - Selectively update relevant phase blueprint documents in **Procedure 3** (e.g., if a new data model was pulled, update `phase-3-data.md`).
