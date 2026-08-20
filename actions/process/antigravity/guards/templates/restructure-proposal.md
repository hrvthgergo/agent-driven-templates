# Legacy Integration & Proposal: `/process --proposal`

**Execution Mode**: [Standard Interactive | Proposal Mode (--proposal) | Immediate Execution (--auto)]  
**Date**: YYYY-MM-DD  
**Status**: [Pending Review | Approved | Executed]

---

## 1. Overview & Safety Policy

This integration proposal maps source files and documentation from linked brownfield legacy directories into the workspace's target layer layout (`agent-workspace/src/<layer>`) and control plane (`agent-workspace/`).

> [!IMPORTANT]
> **Read-Only Legacy Source Policy**: The original legacy repositories and source directories MUST remain 100% untouched and read-only with respect to code logic. In-place symbolic links are registered under `agent-workspace/src/<layer>` without modifying source logic or duplicating files.

---

## 2. Source-to-Layer Integration & Staging Mapping

The table below outlines the proposed in-place layer symlink creation and documentation staging operations:

| Legacy Source Directory | Classification | Target Workspace Destination | Integration Type |
| :--- | :--- | :--- | :--- |
| `[legacy_path/ui/...]` | UI / Presentation | `agent-workspace/src/layout/` | Symbolic Link (In-Place) |
| `[legacy_path/server/...]` | Domain Engine Logic | `agent-workspace/src/engine/` | Symbolic Link (In-Place) |
| `[legacy_path/docs/...]` | Non-Code Docs & Assets | `agent-workspace/plans/<branch_name>/resource/` | Staged Copy |
| `[legacy_path/research/...]` | Topic Research & Summaries | `agent-workspace/plans/<branch_name>/knowledge/` | Staged Copy |
| `[legacy_path/plans/...]` | Implementation Roadmaps | `agent-workspace/plans/<branch_name>/implementation_maps/` | Staged Copy |
| `[legacy_path/details/...]` | Sub-Element Blueprints | `agent-workspace/plans/<branch_name>/phase_details/` | Staged Copy |

---

## 3. Workspace Code Graph Generation Plan (Optional --code-graph)

When `--code-graph` is provided, the following layer-scoped Code Graph subfolders will be generated inside **`agent-workspace/src/<layer>/code_graph/`**:

*   **`agent-workspace/src/layout/code_graph/`**:
    *   `graph.md` (Unordered structural dependency graph & element registry based on JS taxonomy)
    *   `process_flow.md` (UI process entry points & rendering flow)
    *   `data_flow.md` (Frontend data sources: user inputs, state, APIs)
    *   `risk_analysis.md` (Component coupling & test maps)
*   **`agent-workspace/src/engine/code_graph/`**:
    *   `graph.md` (Unordered structural dependency graph & element registry based on Python/Go taxonomy)
    *   `process_flow.md` (Backend API entry points & controller initiation)
    *   `data_flow.md` (Backend data sources: DB, configs, external APIs)
    *   `risk_analysis.md` (Service coupling, critical nodes, & test maps)

---

## 4. Selective Blueprints Synthesis Plan

The following planning phase documents in `agent-workspace/plans/<branch_name>/` will be selectively populated with domain knowledge extracted from the legacy codebase (*filling out blueprints is optional and strictly based on relevance*):
- `agent-workspace/plans/<branch_name>/phase-1-summary.md` (Project vision, boundaries, remotes, linked folders)
- `agent-workspace/plans/<branch_name>/phase-2-layout.md` (Presentation views, component hierarchy, styling system)
- `agent-workspace/plans/<branch_name>/phase-3-data.md` (Data handling, capturing, models & storage mechanisms)
- `agent-workspace/plans/<branch_name>/phase-4-engine.md` (Domain logic, API contracts, DTO schemas, core services)
- `agent-workspace/plans/<branch_name>/phase-5-test.md` (Test specifications, test runner configs, assertion matrices)
- `agent-workspace/plans/<branch_name>/phase-6-operation.md` (Docker specs, deployment pipelines, ops notes)

