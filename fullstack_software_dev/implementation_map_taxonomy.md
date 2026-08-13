# Guard Specification: Implementation Map Taxonomy & Structure (`implementation_map.md`)

This document defines the standardized, high-level structure, schema, and taxonomy for **Implementation Maps** (`implementation_map.md`) across the **Guards Framework**. It is a Tier 1 General Specification linked from [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md).

---

## 1. Overview & Core Philosophy

An **Implementation Map** is the agent's authoritative, step-by-step execution roadmap during the `/implement` workflow. It translates theoretical 6-Phase Blueprints designed during `/plan` into structured, executable scaffolding tasks.

### Version-Based Naming Strategy
Implementation map files are stored under `.agents/plans/<feature-name>/implementation_maps/` and are **named based on the software version** created from that map:
- **Full Version Release Map**: `implementation_map_v1.0.0.md`
- **Partial Scope Version Map**: `implementation_map_v1.1.0_layout.md` or `implementation_map_v1.1.0_engine.md`

By naming implementation maps after the target software version, the planning roadmap is naturally and explicitly linked to the software release produced in `/implement` and `/release`.

---

## 2. High-Level Document Schema

Every implementation map MUST adhere to the following 5-block standardized schema:

```markdown
# Implementation Map: [Feature Name] - Target Version: [vX.Y.Z]

- **Target Feature**: `[e.g., user-auth or layout-engine]`
- **Target Software Version**: `[e.g., v1.0.0 or v1.1.0-alpha]`
- **Implementation Scope**: `[Full Feature | Partial: Layout-Only (v1.1.0) | Partial: Engine-Only (v1.1.0)]`
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
Automated test suite execution commands and assertion matrices to validate code correctness for this version.

```bash
pytest tests/auth/
```

---

## Block 4: Acceptance Criteria & Developer Consent Gate
Explicit criteria required for completing the version implementation step.
```

---

## 3. Workflow Lifecycle Integration

- **`/plan` Phase**: Drafts `implementation_map_v<version>.md` inside `.agents/plans/<feature-name>/implementation_maps/` when design blueprints are finalized. No source code editing is permitted during `/plan`.
- **`/implement` Phase**: Consumes the version-named `implementation_map_v<version>.md` as its primary execution guide to scaffold code, update general `docs/`, and generate `src/*/code_graph/` taxonomy maps.
