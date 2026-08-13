---
name: process-migrator
description: Antigravity skill instructing the agent on brownfield legacy source analysis, intact as-is file copying into codebase-* layers, non-code doc resource staging, workspace-scoped Code Graph subfolder creation, and selective phase blueprint population.
---

# Action Skill: Legacy Migration & Code Graph Generation (`process-migrator`)

This skill package defines the exact procedural instructions for analyzing brownfield legacy codebases, copying files as-is into `codebase-*` sub-repositories without code modification, staging non-code legacy documentation in `agent-workspace/plans/<branch_name>/resource/`, building modular workspace Code Graph subfolders (`agent-workspace/src/<layer>/code_graph/`), and selectively synthesizing phase blueprints during the `/process` workflow in Google Antigravity.

---

## Procedure 1: Untouched Legacy Source Integrity & As-Is File Migration

When executing legacy codebase restructuring, the agent MUST adhere to the following steps:

1. **Read-Only Integrity Assertion**:
   - Original legacy source directories and repositories MUST remain 100% untouched and read-only.
   - Record MD5 checksums of legacy source files prior to migration operations.
   - Zero file deletions, moves, overwrites, or refactoring are permitted within original legacy directories.

2. **As-Is File Copying & Feature Plan Subfolders Staging**:
   - Copy source code intact from linked legacy source directories into target sub-repository destinations (`codebase-layout/src/`, `codebase-engine/src/`).
   - Copy non-code legacy documentation, supplementary assets, schemas, and diagrams into **`agent-workspace/plans/<branch_name>/resource/`**, research reports into `knowledge/`, version-named implementation maps into `implementation_maps/`, and multi-layer sub-element blueprints into `phase_details/` as feature reference knowledge. (Global `docs/` is reserved for already implemented system capabilities; relevant docs will be linked/promoted into `docs/` later during `/implement`).
   - Preserve original directory structures, package layouts, and asset paths during copy operations.
   - **Strict Non-Rewriting Rule**: Do NOT modify, refactor, or rewrite source code logic, variable names, or syntax.

---

## Procedure 2: Workspace Code Graph Subfolder Generation

To keep production `codebase-*` sub-repositories clean of documentation overhead, Code Graphs are generated exclusively inside **`agent-workspace/src/<layer>/code_graph/`** (no symlinks required):

1. **Scaffold Code Graph Subfolder**:
   - For each active layer (e.g. `layout`, `engine`), create `agent-workspace/src/<layer>/code_graph/`.

2. **Generate Modular Analysis Files**:
   - Parse legacy source code adhering to [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/code_graph_taxonomy.md) (Python, Go, or JS node types) and create 4 files per layer:
     * **`graph.md` (Block 1)**: Unordered structural dependency graph & element registry listing interfaces, classes, functions, entities, and services.
     * **`process_flow.md` (Block 2A)**: Process entry points, execution triggers, and control flow initiation paths.
     * **`data_flow.md` (Block 2B)**: Inventory of data sources (user provided, configs, external APIs, databases, hardcoded constants) and datastream transformations.
     * **`risk_analysis.md` (Block 2C)**: Coupling metrics (fan-in / fan-out connection counts), critical code nodes, and test coverage maps.

---

## Procedure 3: Selective Blueprints Population & Status Update

1. **Synthesize Identified Domain Knowledge into `agent-workspace/plans/<branch_name>/`**:
   - Selectively populate relevant phase blueprint documents in `agent-workspace/plans/<branch_name>/` (`phase-1-summary.md` through `phase-5-operation.md`).
   - *Selective Rule*: Populate ONLY those phase blueprint documents where relevant information was identified in the legacy sources. Filling out all 5 phase documents is optional and not mandatory.

2. **Update Process Status**:
   - Deploy/update `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`. Update Block 1 matrix marking Row 2.0 (`/process`) as `Completed` and record a datestamped summary entry in Block 2.
