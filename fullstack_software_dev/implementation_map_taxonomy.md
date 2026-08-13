# Guard Specification: Implementation Map Taxonomy & Structure (`implementation_map.md`)

This document defines the standardized, high-level structure, schema, and taxonomy for **Implementation Maps** (`implementation_map.md`) across the **Guards Framework**. It is a Tier 1 General Specification linked from [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md).

---

## 1. Overview & Core Philosophy

An **Implementation Map** is the agent's authoritative, step-by-step execution roadmap during the `/implement` workflow. It is the most critical asset in `/implement`, translating theoretical 6-Phase Blueprints designed during `/plan` into structured, executable scaffolding tasks.

### Version-Based Naming Strategy
Implementation map files are stored under `.agents/plans/<feature-name>/implementation_maps/` and are **named based on the software version** created from that map:
- **Full Version Release Map**: `implementation_map_v1.0.0.md`
- **Partial Scope Version Map**: `implementation_map_v1.1.0_layout.md` or `implementation_map_v1.1.0_engine.md`

By naming implementation maps after the target software version, the planning roadmap is naturally and explicitly linked to the software release produced in `/implement` and `/release`.

---

## 2. High-Level Document Schema

Every implementation map MUST adhere to the following standardized schema:

```markdown
# Implementation Map: [Feature Name] - Target Version: [vX.Y.Z]

- **Target Feature**: `[e.g., user-auth or layout-engine]`
- **Target Software Version**: `[e.g., v1.0.0 or v1.1.0-alpha]`
- **Implementation Scope**: `[Full Feature | Partial: Layout-Only (v1.1.0) | Partial: Engine-Only (v1.1.0)]`
- **Source Blueprints**: `[e.g., phase-1-summary.md, phase-3-data.md, phase-4-engine.md]`
- **Status**: `[Drafted | Approved | In Progress | Completed]`

---

## Block 1: Target Files & Scaffolding Checklist
Lists all files to be created (`[NEW]`), modified (`[MODIFY]`), or refactored (`[REFACTOR]`).

- [ ] `[NEW]` [codebase-data/src/models/user.py](file:///path/to/file) - User entity model schema.
- [ ] `[NEW]` [codebase-engine/src/services/auth.py](file:///path/to/file) - Authentication domain service logic.
- [ ] `[MODIFY]` [codebase-engine/src/routes/api.py](file:///path/to/file) - Add login/logout API routes.

---

## Block 2: Execution Flow Categorization (Sequential vs. Parallel Steps)

### Sequential Execution Stream (Strict Order)
1. **Step 1: Data Models & Persistence Schemas** (Prerequisite for Step 2)
2. **Step 2: Core Domain Service Logic** (Prerequisite for Step 4)
3. **Step 4: API Controllers & Routing Integration** (Final Integration)

### Parallel Execution Stream (Decoupled / Independent Tasks)
- **Step 3.A: Web UI View Presentation Components** (Can run concurrently with Step 3.B after Step 2)
- **Step 3.B: Mobile App Presenter Views** (Can run concurrently with Step 3.A after Step 2)

---

## Block 3: Step-by-Step Task Sequence

Every step defined in Block 3 MUST adhere to the mandatory 4-part step schema:

### Step 1: Data Models & Persistence Schemas
1. **Requirement Fulfilled**:
   - `phase-3-data.md Section 2.1` (User persistence schema & database model requirements).
2. **Prerequisites**:
   - Database connection pool configured and base ORM model class established in `codebase-data`.
3. **Actions Taken**:
   - `[NEW]` `codebase-data/src/models/user.py`: Define `UserModel` entity schema and database migration script.
4. **Verification Fulfilled**:
   - `pytest tests/unit/test_user_model.py`: Database model creation and validation assertions pass.

### Step 2: Core Domain Service & DTO Mapping
1. **Requirement Fulfilled**:
   - `phase-4-engine.md Section 3.2` (Authentication domain service & DTO contract requirements).
2. **Prerequisites**:
   - Step 1 `UserModel` schema completed and verified.
3. **Actions Taken**:
   - `[NEW]` `codebase-engine/src/services/auth.py`: Implement `AuthService` class and login coroutines.
   - `[NEW]` `codebase-engine/src/dtos/auth_dto.py`: Implement `LoginRequestDTO` and `AuthTokenDTO`.
4. **Verification Fulfilled**:
   - `pytest tests/unit/test_auth_service.py`: Authentication unit tests pass.

### Step 3.A: Web UI View Presentation Components (Parallel Stream)
1. **Requirement Fulfilled**:
   - `phase-2-layout.md Section 4.1` (Login presentation view & design tokens).
2. **Prerequisites**:
   - Step 2 DTO contracts finalized.
3. **Actions Taken**:
   - `[NEW]` `codebase-ui/src/views/LoginView.tsx`: Build login presentation component.
4. **Verification Fulfilled**:
   - `npm run test -- LoginView.test.tsx`: UI component rendering tests pass.

---

## Block 4: Verification & Test Execution Commands
Automated test suite execution commands and assertion matrices to validate code correctness for this version.

```bash
# Run unit & integration test suites
pytest tests/unit/ test/integration/
npm run test
```

---

## Block 5: Acceptance Criteria & Developer Consent Gate
Explicit criteria required for completing the version implementation step.
```

---

## 3. Workflow Lifecycle Integration

- **`/plan` Phase**: Drafts `implementation_map_v<version>.md` inside `.agents/plans/<feature-name>/implementation_maps/` when design blueprints are finalized. No source code editing is permitted during `/plan`.
- **`/implement` Phase**: Consumes the version-named `implementation_map_v<version>.md` as its primary execution guide to scaffold code and run critical system and new feature solution tests. **By-request only**: `code_graph` generation (`--code-graph`) and system documentation updates (`--docs`) are strictly optional add-on operations, executed only when explicitly requested to preserve token efficiency.
- **`/process` Phase**: Optionally generates `agent-workspace/src/<layer>/code_graph/` subfolders and updates `docs/` for legacy/brownfield codebases. **By-request only**: Both operations are invoked via `--code-graph` and `--docs` flags respectively, following the same Token Economy Guard as `/implement`.
