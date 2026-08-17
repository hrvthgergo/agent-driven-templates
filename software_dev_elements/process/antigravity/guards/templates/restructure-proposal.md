# Legacy Restructuring & Migration Proposal: `/process`

**Execution Mode**: [Plan-First (--plan) | Immediate Execution (--auto)]  
**Date**: YYYY-MM-DD  
**Status**: [Pending Review | Approved | Executed]

---

## 1. Overview & Safety Policy

This restructuring proposal maps source files and documentation from linked brownfield legacy directories into the workspace's target sub-repository layout (`codebase-*`) and control plane (`agent-workspace/`).

> [!IMPORTANT]
> **Read-Only Legacy Source Policy**: The original legacy repositories and source directories MUST remain 100% untouched and read-only. Files are copied intact into the target sub-repositories without modifying source logic.

---

## 2. Source-to-Layer Migration & Staging Mapping

The table below outlines the proposed intact file copy and documentation staging operations:

| Legacy Source Directory | Classification | Target Destination |
| :--- | :--- | :--- |
| `[legacy_path/ui/...]` | UI / Presentation | `codebase-layout/src/` |
| `[legacy_path/server/...]` | Domain Engine Logic | `codebase-engine/src/` |
| `[legacy_path/docs/...]` | Non-Code Docs & Assets | `agent-workspace/plans/<branch_name>/resource/` |
| `[legacy_path/research/...]` | Topic Research & Summaries | `agent-workspace/plans/<branch_name>/knowledge/` |
| `[legacy_path/plans/...]` | Implementation Roadmaps | `agent-workspace/plans/<branch_name>/implementation_maps/` |
| `[legacy_path/details/...]` | Sub-Element Blueprints | `agent-workspace/plans/<branch_name>/phase_details/` |

---

## 3. Workspace Code Graph Generation Plan

The following layer-scoped Code Graph subfolders will be generated inside **`agent-workspace/src/<layer>/code_graph/`** (keeping production `codebase-*` sub-repositories clean of documentation overhead):

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
- `agent-workspace/plans/<branch_name>/phase-3-engine.md` (Domain logic, API contracts, DTO schemas, DB models)
- `agent-workspace/plans/<branch_name>/phase-4-verification.md` (Test specifications, test runner configs, assertion matrices)
- `agent-workspace/plans/<branch_name>/phase-5-operation.md` (Docker specs, deployment pipelines, ops notes)
