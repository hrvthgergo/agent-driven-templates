---
name: plan-grill
description: Neutral Q&A Interview Rule Guard for interactive feature planning
---

# `plan-grill` Rule Guard

This rule guard governs the `/plan` Grill-me Q&A interview engine, enforcing unchangeable architecture baselines, 6-Phase Blueprint Architecture rules, neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines

1.  **Baseline 1: Initial Feature Understanding Summary Mandate (Node S2)**: Every `/plan` session MUST open with the agent synthesizing its initial understanding of the feature (from `/init` outputs, `/process` outputs, and user prompt context) and presenting an **Initial Feature Understanding Summary** to the developer before any questions are asked.
2.  **Baseline 2: Strict Feature Plan Sandbox (`agent-workspace/plans/<feature-name>/`)**: All files created or modified during `/plan`—including active phase blueprints, `knowledge/` research reports, `phase_details/` subfolders, and versioned `implementation_maps/`—MUST reside strictly within `agent-workspace/plans/<feature-name>/`.
3.  **Baseline 3: Decisions Embedded Directly in `phase-*.md` (No Decisions Subfolder)**: Architectural decisions, ADR trade-off rationale, and design choices MUST be documented **directly inside active `phase-*.md` documents** (and their sub-element blueprints inside `phase_details/`). There is no separate decisions folder.
4.  **Baseline 4: Implementation Map Sandbox Guard (No Code Execution in `/plan`)**: Creating or drafting a versioned `implementation_map_v<version>.md` inside `agent-workspace/plans/<feature-name>/` is allowed, but **ZERO code scaffolding, file creation, or source code modification in `src/` or `codebase-*/` is permitted during `/plan`**. Source code implementation remains strictly reserved for `/implement`.
5.  **Baseline 5: Version-Based Implementation Map Naming & Schema**: Implementation map documents MUST be named after the target software version created from that map (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_layout.md`) and MUST adhere to the Tier 1 schema defined in `implementation_map_taxonomy.md`.

---

## 2. Prompting Laws

*   **Zero Bias**: Do NOT prefix any option with `[Recommended]`.
*   **Mandatory Free-Text**: Always include `Other / Free-text (...)` as the final choice in every prompt.
*   **Audit Persistence**: Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

---

## 3. Sequential Q1 – Q11 Prompts

*   **Q1: Feature Name & Initial Understanding Verification**: Confirm feature slug name (`<feature-name>`) and verify initial summary.
*   **Q2: System Layer Impact & Affected Components**: Select affected layers (UI Presentation, Data Handling & Storing, Core Engine/API, Verification Specs, Docker Ops, Full System).
*   **Q3: Dynamic Phase Blueprint Subset Selection (`phase-*.md`)**: Select blueprint set (`Phase 1` mandatory baseline; `Phase 2` UI; `Phase 3` Data; `Phase 4` Engine; `Phase 5` Verification; `Phase 6` Ops).
*   **Q4: Multi-Layer Sub-Element Architecture & Phase Details (`phase_details/`)**: Evaluate if multi-layer subfolders are needed under `phase_details/<element_name>/`.
*   **Q5: Topic Research Reports & Idea Explorations (`knowledge/`)**: Request deep-dive research reports written to `knowledge/research_report_<topic>.md` and linked inside `phase-*.md`.
*   **Q6: Phase 2 - UI Layout & View Design**: Define UI presentation views, design tokens, and layout decisions.
*   **Q7: Phase 3 - Data Handling, Storing & Store Lifecycle**: Define data management, capturing mechanisms, storage schemas, persistence policies, and data store lifecycle events.
*   **Q8: Phase 4 - Core Engine, API Contracts & Data Flow**: Define domain services, REST/gRPC endpoints, DTO mappers, and engine routing decisions.
*   **Q9: Phase 5 - Verification Specifications & Test Suites**: Define unit, integration, E2E test suites, and assertion criteria.
*   **Q10: Phase 6 - Docker & Operations Deployment Impact**: Define container profiles, Compose orchestration, and infrastructure deployment decisions.
*   **Q11: Versioned Implementation Map Drafting Gate (Node S5)**: Select target software release version and draft `implementation_maps/implementation_map_v<version>.md` without code execution.
