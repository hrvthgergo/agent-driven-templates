# Guard Specification: Implementation Map Taxonomy & Structure (`implementation_map.md`)

This document defines the standardized, high-level structure, schema, and taxonomy for **Implementation Maps** (`implementation_map.md`) across the **Guards Framework**. It is a Tier 1 General Specification linked from [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md).

---

## 1. Overview & Core Philosophy

An **Implementation Map** (`implementation_map.md` or `implementation_map_<scope>.md`) is the agent's authoritative, step-by-step execution roadmap during the `/implement` workflow. It translates theoretical 5-Phase Blueprints designed during `/plan` into structured, executable scaffolding tasks.

### General Component Nature
Like [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md), [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md), and [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/code_graph_taxonomy.md), the Implementation Map structure is a **general-purpose framework taxonomy**. It governs how step-by-step implementation tasks are structured, sequenced, and verified regardless of the target feature or environment.

---

## 2. High-Level Document Schema

Every `implementation_map.md` MUST adhere to the following 5-block standardized schema:

```markdown
# Implementation Map: [Feature / Component Name]

- **Target Feature**: `[e.g., user-auth or layout-engine]`
- **Implementation Scope**: `[Full Feature | Partial: Layout-Only | Partial: Engine-Only | Specific Module]`
- **Source Blueprints**: `[e.g., phase-1-summary.md, phase-3-engine.md]`
- **Status**: `[Drafted | Approved | In Progress | Completed]`

---

## Block 1: Target Files & Scaffolding Checklist
Lists all files to be created (`[NEW]`), modified (`[MODIFY]`), or refactored (`[REFACTOR]`).

- [ ] `[NEW]` [src/auth/service.py](file:///path/to/file) - Authentication domain service logic.
- [ ] `[MODIFY]` [src/config/routes.py](file:///path/to/file) - Add login/logout API routes.

---

## Block 2: Step-by-Step Task Sequence
Ordered, sequential execution steps detailing exact implementation instructions.

### Step 1: Data Models & DTO Mapping
- Task instructions...

### Step 2: Core Service Logic
- Task instructions...

### Step 3: UI Layout & View Components
- Task instructions...

---

## Block 3: Verification & Test Execution Commands
Automated test suite execution commands and assertion matrices to validate code correctness.

```bash
pytest tests/auth/
```

---

## Block 4: Acceptance Criteria & Developer Consent Gate
Explicit criteria required for completing the implementation step.
```

---

## 3. Workflow Lifecycle Integration

- **`/plan` Phase**: Drafts `implementation_map.md` (or partial `implementation_map_<scope>.md`) inside `.agents/plans/<feature-name>/implementation_maps/` when design blueprints are finalized. No source code editing is permitted during `/plan`.
- **`/implement` Phase**: Consumes the structured `implementation_map.md` as its primary execution guide to scaffold code, update general `docs/`, and generate `src/*/code_graph/` taxonomy maps.
