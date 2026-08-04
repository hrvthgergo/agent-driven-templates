# Legacy Restructuring & Migration Proposal: `/process-history`

**Execution Mode**: [Plan-First (--plan) | Immediate Execution (--auto)]  
**Date**: YYYY-MM-DD  
**Status**: [Pending Review | Approved | Executed]

---

## 1. Overview & Safety Policy

This restructuring proposal maps source files and documentation from linked brownfield legacy directories into the workspace's target sub-repository layout (`codebase-*`).

> [!IMPORTANT]
> **Read-Only Legacy Source Policy**: The original legacy repositories and source directories MUST remain 100% untouched and read-only. Files are copied intact into the target sub-repositories without modifying source logic.

---

## 2. Source-to-Layer Migration Mapping

The table below outlines the proposed intact file copy operations:

| Legacy Source Directory | Classification | Target Sub-Repository Destination |
| :--- | :--- | :--- |
| `[legacy_path/ui/...]` | UI / Presentation | `codebase-layout/src/` |
| `[legacy_path/server/...]` | Domain Engine Logic | `codebase-engine/src/` |
| `[legacy_path/docs/...]` | Documentation | `.agents/plans/` & `codebase-docs/` |

---

## 3. Workspace Code Graph Generation Plan

The following layer-scoped Code Graph subfolders will be generated inside **`antigravity-workspace/src/<layer>/code_graph/`** (keeping production `codebase-*` sub-repositories clean of documentation overhead):

*   **`antigravity-workspace/src/layout/code_graph/`**:
    *   `graph.md` (Unordered structural dependency graph & element registry)
    *   `process_flow.md` (UI process entry points & rendering flow)
    *   `data_flow.md` (Frontend data sources: user inputs, state, APIs)
    *   `risk_analysis.md` (Component coupling & test maps)
*   **`antigravity-workspace/src/engine/code_graph/`**:
    *   `graph.md` (Unordered structural dependency graph & element registry)
    *   `process_flow.md` (Backend API entry points & controller initiation)
    *   `data_flow.md` (Backend data sources: DB, configs, external APIs)
    *   `risk_analysis.md` (Service coupling, critical nodes, & test maps)

---

## 4. 5-Phase Blueprints Synthesis Plan

The following planning phase documents in `.agents/plans/` will be populated with domain knowledge extracted from the legacy codebase:
- `.agents/plans/phase-1-summary.md` (Project vision, boundaries, remotes, linked folders)
- `.agents/plans/phase-2-layout.md` (UI layouts, view layers, component trees)
- `.agents/plans/phase-3-engine.md` (Domain logic, API contracts, DB models, schemas)
- `.agents/plans/phase-4-verification.md` (Test suites, mocks, verification specs)
- `.agents/plans/phase-5-operation.md` (Docker specs, deployment pipelines, ops notes)
