---
name: process-migrator
description: Antigravity skill instructing the agent on brownfield legacy source analysis, in-place layer symlink creation under agent-workspace/src/, non-code doc resource staging, test coverage cataloguing, workspace-scoped Code Graph subfolder creation, selective phase blueprint population, and remote origin synchronization.
---

# Action Skill: Legacy Migration & Code Graph Generation (`process-migrator`)

This skill package defines the exact procedural instructions for analyzing brownfield legacy codebases, creating in-place symbolic links inside `agent-workspace/src/<layer>` (or optional sub-repository scaffolding), staging non-code legacy documentation and test coverage catalogs in `agent-workspace/plans/<branch_name>/resource/`, building modular workspace Code Graph subfolders (`agent-workspace/src/<layer>/code_graph/`), selectively synthesizing phase blueprints, and executing remote origin synchronization during the `/process` action in Google Antigravity.

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

3. **Feature Plan Subfolders & Test Coverage Staging**:
   - Copy non-code legacy documentation, supplementary assets, schemas, and diagrams into **`agent-workspace/plans/<branch_name>/resource/`**, research reports into `knowledge/`, version-named implementation maps into `implementation_maps/`, multi-layer sub-element blueprints into `phase_details/`, and stage discovered test suites, runners, fixtures, and configs into **`agent-workspace/plans/<branch_name>/resource/existing_coverage.md`** as feature reference knowledge. (Global `docs/` is reserved for already implemented system capabilities; relevant docs will be linked/promoted into `docs/` later during `/implement`).
   - **Strict Non-Rewriting Rule**: Do NOT modify, refactor, or rewrite source code logic, variable names, or syntax. Legacy test suites are catalogued only and never edited or refactored.

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

## Procedure 4: Remote Synchronization (`--sync`)

When the `--sync` command flag is passed, the agent MUST synchronize the workspace according to ownership-classed fetch rules:

1. **Target Discovery & Ownership Classification**:
   - Live-scan workspace root children and legacy symlink targets under `agent-workspace/src/<layer>`.
   - Classify discovered repositories:
     * **Framework-Owned (`agent-workspace`)**: The active control plane repository.
     * **Project-Owned (`codebase-*`)**: Active project layer sub-repositories.
     * **Foreign / Read-Only**: Linked external legacy folders.

2. **Ownership-Classed Fetch Execution**:
   - **Framework-Owned (`agent-workspace`)**:
     * Check working tree cleanliness (`git status --porcelain`). If dirty, halt immediately.
     * Attempt `git merge --ff-only origin/<branch>`.
     * If divergence is detected, **halt immediately** (no override permitted; requires manual resolution).
   - **Project-Owned (`codebase-*`) & Foreign / Legacy Repositories**:
     * Execute `git fetch` only against remote origins.
     * Compute and report alignment state (`aligned` | `ahead` | `behind` | `diverged` | `no-remote`) and working-tree cleanliness.
     * **Strict No-Mutation Policy**: NEVER execute `git pull`, `git merge`, or modify project source code during `--sync`.

3. **Derived-Artifact Staleness Reporting (No Regeneration)**:
   - Compare Version Stamp Headers in existing `agent-workspace/src/<layer>/code_graph/*.md` and `phase-*.md` documents against the newly fetched commit hashes.
   - Output a list of stale derived artifacts in the sync summary report and update `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`.
   - **Strict Token Economy Policy**: Do **NOT** automatically regenerate Code Graphs or phase blueprints during `--sync`. Full regeneration is deferred to explicit maintenance commands (e.g. `/process --code-graph`).

