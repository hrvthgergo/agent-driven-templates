---
name: plan-generator
description: Antigravity skill for 6-phase blueprint generation, research report drafting, and versioned implementation map scaffolding
---

# `plan-generator` Skill Procedure

This skill provides step-by-step procedures for scaffolding 6-Phase Blueprints, `phase_details/` subfolders, research reports, and software versioned implementation maps within `agent-workspace/plans/<feature-name>/`.

---

## 1. 6-Phase Blueprint Scaffolding & Embedded Decision Drafting

1.  Create feature plan directory: `agent-workspace/plans/<feature-name>/`.
2.  Deploy active subset of 6-Phase Blueprint documents:
    *   `phase-1-summary.md`: Master Architecture & Vision Governor (vision, scope, master decisions, System Impact Analysis, research links).
    *   `phase-2-layout.md`: Phase 2 UI Layout Governor (design tokens, view hierarchy, responsive layout decisions).
    *   `phase-3-data.md`: Phase 3 Data Handling Governor (data capturing, storage engine schemas, persistence policies, data store lifecycle events).
    *   `phase-4-engine.md`: Phase 4 Core Engine Governor (domain logic, REST/gRPC API contracts, DTO mappers, backend routing decisions).
    *   `phase-5-verification.md`: Phase 5 Verification Governor (unit, integration, E2E test suites, test assertion matrices).
    *   `phase-6-operation.md`: Phase 6 Operations Governor (Docker container profiles, Compose orchestration, deployment impact).
3.  **Embedded Decisions Rule**: Ensure all architectural choices, ADR trade-off rationale, and design choices are documented **directly inside the active `phase-*.md` documents**. Do NOT create a separate `decisions/` subfolder.

---

## 2. On-Demand Multi-Layer Subfolder Scaffolding (`phase_details/`)

1.  If Q4 identified multi-layer sub-elements (e.g., web UI + mobile app UI, multiple APIs/DBs):
    *   Create directory: `agent-workspace/plans/<feature-name>/phase_details/`.
    *   Create sub-element directories: `phase_details/<element_name>/` (e.g., `phase_details/web_ui/`, `phase_details/mobile_app/`, `phase_details/auth_api/`).
2.  Scaffold sub-element phase blueprints inside respective subfolders (e.g., `phase_details/web_ui/phase-2-layout.md`).

---

## 3. Topic Research Report Drafting (`knowledge/`)

1.  Create research directory: `agent-workspace/plans/<feature-name>/knowledge/`.
2.  If topic research was requested in Q5:
    *   Draft research report file: `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md`.
    *   Include executive summary, evaluated options, comparative trade-offs, and technical recommendations.
3.  **Markdown Linkage**: Insert direct markdown file links pointing to the research report inside `phase-1-summary.md` and active phase blueprints.

---

## 4. Version-Named Implementation Map Drafting (`implementation_maps/`)

1.  Create implementation maps directory: `agent-workspace/plans/<feature-name>/implementation_maps/`.
2.  If option selected in Node S5 / Q11:
    *   Draft implementation map file named after target software release version: `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_layout.md`).
    *   Enforce 5-block schema defined in `implementation_map_taxonomy.md` (Block 1: Target Files & Scaffolding Checklist, Block 2: Step-by-Step Task Sequence, Block 3: Verification Commands, Block 4: Acceptance Criteria).
3.  **Implementation Map Sandbox Guard**: Ensure NO source code scaffolding or file editing is performed in `src/` or `codebase-*/` during `/plan`.
