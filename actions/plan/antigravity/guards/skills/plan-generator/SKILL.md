---
name: plan-generator
description: Skill for generating 6-phase blueprints, test strategies, scenarios, and versioned implementation maps
---

# Plan Generator Skill

This skill provides step-by-step procedures for scaffolding 6-Phase Blueprints, multi-layer `phase_details/` subfolders, research reports, project-durable test strategies, Given/When/Then scenarios, and software versioned implementation maps.

---

## 1. Procedure: 6-Phase Blueprints Scaffolding

1. Ensure the feature plan directory exists: `agent-workspace/plans/<feature-name>/`.
2. Deploy starter templates from `actions/plan/antigravity/guards/templates/` based on the selected blueprint subset:
   * Mandatory: `phase-1-summary.md` (Master Governor, Vision, Decisions & System Impact Analysis).
   * Selected: `phase-2-layout.md` (UI view & component hierarchy specifications).
   * Selected: `phase-3-data.md` (Data models, schemas, capture/storing mechanisms & store lifecycle).
   * Selected: `phase-4-engine.md` (Core engine, API contracts, mappers & service routing).
   * Selected: `phase-5-test.md` (Verification Scope Delta referencing `TEST_STRATEGY.md` and listing `SC-*` scenario IDs).
   * Selected: `phase-6-operation.md` (Docker compose, environment variables & CI/CD deployment impact).
3. Populate each active phase document with user specifications, embedded decisions, and markdown links to research reports.

---

## 2. Procedure: Multi-Layer Sub-Element Architecture (`phase_details/`)

1. For complex features requiring distinct sub-element specifications (e.g. web UI vs. mobile app, or multiple microservices):
   * Create directory: `agent-workspace/plans/<feature-name>/phase_details/<element_name>/`.
   * Scaffold the relevant sub-element phase document (e.g. `phase_details/web_ui/phase-2-layout.md` or `phase_details/auth_api/phase-4-engine.md`).
2. Maintain top-level `phase-*.md` documents as master governors and link sub-element files directly within them.

---

## 3. Procedure: Topic Research Reports (`knowledge/`)

1. When research reports or idea explorations are requested:
   * Create directory: `agent-workspace/plans/<feature-name>/knowledge/`.
   * Draft research report: `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md`.
2. Add explicit markdown link inside `phase-1-summary.md` and relevant active phase blueprints:
   ```markdown
   - [Research Report: <Topic>](file:///path/to/agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md)
   ```

---

## 4. Procedure: Test Strategy Authoring & Amendment (`TEST_STRATEGY.md`)

1. Ensure directory exists: `agent-workspace/tests/`.
2. Inspect `agent-workspace/tests/TEST_STRATEGY.md`. If absent or when run via `/plan --test-strategy`:
   * Deploy `actions/plan/antigravity/guards/templates/TEST_STRATEGY.md`.
   * Define declared testing tiers (Unit, Integration, E2E, Regression).
   * Declare tooling per layer (e.g. pytest, vitest, cypress).
   * Declare coverage thresholds (e.g. 80% line coverage), mocking policies, defect severities, and definition of certified.
3. Note: Test Strategy is project-durable. Per-feature deviation in `phase-5-test.md` is forbidden.

---

## 5. Procedure: Scenario Authoring (`tests/scenarios/SC-<feature-slug>-<nnn>.md`)

1. Ensure directory exists: `agent-workspace/tests/scenarios/`.
2. For each behaviour identified in Q9:
   * Determine next free ordinal in sequence: `SC-<feature-slug>-<nnn>`.
   * Create scenario file: `agent-workspace/tests/scenarios/SC-<feature-slug>-<nnn>.md`.
   * Populate YAML frontmatter:
     ```yaml
     ---
     id: SC-<feature-slug>-<nnn>
     title: <Descriptive Behaviour Title>
     feature: <feature-slug>
     tier: <unit | integration | e2e | regression>
     origin: plan
     status: ratified
     ---
     ```
   * Populate Given/When/Then behaviour criteria (declaring WHAT must be true, never implementation harness code).
3. In `agent-workspace/plans/<feature-name>/phase-5-test.md`, list all scenario IDs in scope.

---

## 6. Procedure: Scenario Ratification (`/plan --ratify`)

1. Inspect `agent-workspace/tests/scenarios/` for any scenarios with `status: unratified` (typically carrying `origin: qualify`).
2. For each unratified proposal:
   * If accepted into active feature scope: update frontmatter to `status: ratified`.
   * If rejected: update frontmatter to `status: retired` and append `rejection_reason: "<Reason>"`.

---

## 7. Procedure: Versioned Implementation Map Drafting (`implementation_maps/`)

1. When option is selected in Node S5 or via `/plan --map`:
   * Create directory: `agent-workspace/plans/<feature-name>/implementation_maps/`.
   * Draft map file named after release version: `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md`.
   * Structure content following the 5-block taxonomy schema in `implementation_map_taxonomy.md`:
     - Block 1: Release Version & Plan Context
     - Block 2: Micro-Architecture Summary & Scope Boundary
     - Block 3: Pre-Implementation Checklist (Dependencies & Environment)
     - Block 4: Step-by-Step Implementation Roadmap (Requirement, Prerequisites, Actions, Verification)
     - Block 5: Post-Implementation Verification & Qualification Handoff
2. Strictly prohibit code scaffolding or file modification in `src/` or `codebase-*/` during map generation.
