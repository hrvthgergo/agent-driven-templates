# Verification & Test Specification: `/plan` Workflow (Feature Planning Scenario)

This document defines the test scenario, mock execution sequence, user input simulation, and verification assertions for testing the `/plan` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/plan` (Interactive Planning workflow for 6-Phase Blueprints, Test Strategies, Scenarios, Operations Design, and Versioned Implementation Maps)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenario**: Feature Planning & Blueprint Generation Scenario (Fullstack Web App with Data Handling + Core Engine + Operations Design + Verification Strategy & Scenarios)
*   **Primary Objective**: Validate end-to-end execution of the `/plan` workflow state machine (Nodes S1 $\rightarrow$ S7), asserting that:
    1. Node S2 presents an Initial Feature Understanding Summary prior to starting Q&A.
    2. Q1–Q11 prompts generate neutral choices, persistent `GRILL_STATUS.md` audit logs, and Node S5 Execution Acceptance Gate prompts.
    3. Scaffolding generates the active subset of 6-Phase Blueprints (`phase-1-summary.md` through `phase-6-operation.md`, including `phase-3-data.md` and `phase-5-test.md`) inside `agent-workspace/plans/<feature-name>/`.
    4. Complex multi-layer features scaffold `phase_details/<element_name>/` subfolders on-demand.
    5. Research requests produce `knowledge/research_report_<topic>.md` reports linked directly in `phase-*.md` blueprints.
    6. Architectural decisions are embedded directly inside `phase-*.md` blueprints (with NO separate decisions folder).
    7. Test Strategy (`agent-workspace/tests/TEST_STRATEGY.md`) is authored/asserted project-wide (Q8b) with declared tiers, thresholds, and mocking policy.
    8. Scenarios are authored under `agent-workspace/tests/scenarios/SC-<feature-slug>-<nnn>.md` with immutable identifiers, `origin: plan`, `status: ratified`, and Given/When/Then behaviour criteria (Q9).
    9. `phase-5-test.md` serves as Verification Scope Delta, referencing `TEST_STRATEGY.md` and listing the binding scenario IDs in scope.
    10. `phase-6-operation.md` adheres to the 8-section content contract (§0 Environment Topology matrix with entry gates, §1 Containerization, §2 Service Orchestration, §3 Config/Secrets declarations [names only], §4 CI/CD Pipeline Topology, §5 Delivery & Promotion Policy, §6 Observability Contracts [6a/6b/6c], §7 ADRs), populated via Q10.1–Q10.5.
    11. Node S5 offers an option to draft a software versioned implementation map (`implementation_map_v1.0.0.md`) adhering to `implementation_map_taxonomy.md` without executing source code modifications.
    12. Write actions are strictly restricted to `agent-workspace/plans/<feature-name>/` (and project-durable verification artifacts in `agent-workspace/tests/`).
    13. `PROCESS_STATUS.md` matrix (sub-rows 3.1–3.6) is synchronized cleanly, and row 6 points to `/operate`.

---

## 2. Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST meet the following pre-conditions prior to command execution:

1.  **Initialized Workspace**: An existing project workspace initialized via `/init` containing Agentic Environment and Folder-Based Control Plane structures, and `codebase-*` sub-repositories.
2.  **Git Branch Context**: An active feature branch checked out (e.g. `feature/user-auth`).
3.  **Docker Daemon Status**: Docker daemon active and accessible (`docker info` returns exit code `0`).

---

## 3. Simulated Execution Sequence & Mock Q&A

### Command Invocation
```bash
/plan --feature user-auth
```

### Mock User Input Sequence (Nodes S1–S7 and Q1–Q11 Prompts)

The test harness simulates an interactive user session responding to the sequential interview prompts enforced by `rules/plan-grill.md` and confirming Node S5 Execution Acceptance:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Precondition & Branch Check** | System verifies Agentic Environment and Folder-Based Control Plane baselines and checks out `feature/user-auth`. | Environments verified. Branch confirmed (`feature/user-auth`). |
| **S2** | **Initial Feature Understanding Summary** | Agent synthesizes initial understanding of user authentication feature and displays summary. | Initial Feature Summary printed to console *before* Q&A begins. |
| **Q1** | **Feature Name & Initial Summary Verification** | Selected Option 1 (*Yes, summary and feature name are accurate*). | Feature name `user-auth` confirmed. Directory `agent-workspace/plans/user-auth/` initialized. |
| **Q2** | **System Layer Impact & Affected Components** | Selected Option 6 (*Full System - All layers affected: UI, Data, Engine, Verification, Ops*). | System impact recorded in `phase-1-summary.md`. All 6 phase blueprints flagged for scaffolding. |
| **Q3** | **Dynamic Phase Blueprint Subset Selection** | Selected Option 2 (*Complete 6-Phase Blueprint Set: Phase 1 through Phase 6*). | Scaffolds `phase-1-summary.md` through `phase-6-operation.md` (including `phase-3-data.md` and `phase-5-test.md`). |
| **Q4** | **Multi-Layer Sub-Element Architecture** | Selected Option 2 (*Yes - Create subfolders under phase_details/<element_name>/ for web_ui and auth_api*). | Subfolders `phase_details/web_ui/` and `phase_details/auth_api/` scaffolded. |
| **Q5** | **Topic Research Reports** | Selected Option 2 (*Yes*) $\rightarrow$ Input: *"OAuth2 vs JWT token authentication security comparison"*. | Research report written to `agent-workspace/plans/user-auth/knowledge/research_report_oauth2_vs_jwt.md` and linked in `phase-1-summary.md`. |
| **Q6** | **Phase 2 - UI Layout & View Design** | Selected Option 1 (*Vanilla CSS / Custom Design Tokens*). | Populates `agent-workspace/plans/user-auth/phase-2-layout.md` with UI view specs & decisions. |
| **Q7** | **Phase 3 - Data Handling & Store Lifecycle** | Selected Option 1 (*Relational data model with SQL migrations and automated backup lifecycle*). | Populates `agent-workspace/plans/user-auth/phase-3-data.md` with user DB schemas & data store lifecycle decisions. |
| **Q8** | **Phase 4 - Core Engine & API Contracts** | Selected Option 1 (*RESTful API contracts with JSON DTO mappers*). | Populates `agent-workspace/plans/user-auth/phase-4-engine.md` with auth endpoints, DTOs & engine decisions. |
| **Q8b** | **Test Strategy Assertion & Amendment** | Selected Option 3 (*Author the strategy for the first time: unit, integration, e2e, regression tiers, 80% threshold, mock policy*). | Authors project-durable `agent-workspace/tests/TEST_STRATEGY.md`. |
| **Q8c** | **Carry-Over Ratification** | Selected Option 1 (*No carry-over proposals present / adopt into active scope*). | Confirms unratified carry-over queue state in `agent-workspace/tests/scenarios/`. |
| **Q9** | **Phase 5 - Verification Scope Delta & Scenario Authoring** | Selected Option 1 (*Enumerate behaviours: SC-user-auth-001 for credential login, SC-user-auth-002 for JWT refresh token rotation*). | Populates `phase-5-test.md` citing `SC-user-auth-001` and `SC-user-auth-002`; authors scenario files in `agent-workspace/tests/scenarios/`. |
| **Q10.1** | **Environment Topology** | Selected Option 2 (*New environment: ENV-staging, purpose: integration validation, services: auth_api, web_ui, postgres, entry gate: certification: full*). | Populates `phase-6-operation.md` §0 (Environment Topology). |
| **Q10.2** | **Containerization & Image Impact** | Selected Option 1 (*Multi-container Compose orchestration with environment variable isolation*). | Populates `phase-6-operation.md` §1–§2 (Containerization & Service Orchestration). |
| **Q10.3** | **Configuration & Secret Declarations** | Selected Option 2 (*New secret keys: JWT_SECRET_KEY, DB_PASSWORD; scope: engine, auth; envs: staging, prod; source: vault. Names only.*). | Populates `phase-6-operation.md` §3 (Configuration & Secret Declarations). |
| **Q10.4** | **CI/CD Pipeline Impact & Promotion Policy** | Selected Option 2 (*Layer micro-pipeline updates + standard promotion edges*). | Populates `phase-6-operation.md` §4–§5 (CI/CD Pipeline Topology & Promotion Policy). |
| **Q10.5** | **Observability & Monitoring Design** | Selected Option 2 (*Signals: auth_login_total, auth_latency_ms; Tool: Prometheus at /metrics; Health checks: /healthz 200 OK, alert on error rate > 1% over 5m*). | Populates `phase-6-operation.md` §6 (blocks 6a, 6b, 6c). |
| **S5** | **Execution Acceptance Gate & Map Option** | Displays understanding recap. Selected Option 2 (*Draft Full Feature Release Map v1.0.0*). | User acceptance logged; drafts `agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md` without code execution. |
| **S6** | **PROCESS_STATUS.md Sync** | System synchronizes process status matrix sub-rows 3.1–3.6. | `PROCESS_STATUS.md` matrix updated to `Completed` for planning phase. |

---

## 4. Verification Assertions & Validation Matrix

Upon completion of Node S7, the test harness executes automated verification checks asserting that all physical and logical resources were scaffolded exactly as designed:

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Precondition & Branch Verification | Git Context & `agent-workspace/` | Verified environments exist. Active branch confirmed as `feature/user-auth`. |
| **S2** | Initial Feature Summary Mandate | Subprocess Stdout / Audit Log | Console output contains Initial Feature Understanding Summary prior to Q1 prompt. |
| **S3** | Audit Log & Transcript | `agent-workspace/plans/user-auth/GRILL_STATUS.md` | File exists. Contains full Q1–Q11 (and Q10.1–Q10.5) transcript, question texts, selected options, and user inputs. |
| **S4** | Master Governor Blueprint | `agent-workspace/plans/user-auth/phase-1-summary.md` | File exists. Contains vision, System Impact Analysis, and links to research reports. |
| **S4** | 6-Phase Blueprints Set | `agent-workspace/plans/user-auth/` | All 6 files present: `phase-1-summary.md`, `phase-2-layout.md`, `phase-3-data.md`, `phase-4-engine.md`, `phase-5-test.md`, `phase-6-operation.md`. |
| **S4** | Phase Details Subfolders | `agent-workspace/plans/user-auth/phase_details/` | Subfolders present: `phase_details/web_ui/` and `phase_details/auth_api/`. Each contains sub-element phase specs. |
| **S4** | Research Report Document | `agent-workspace/plans/user-auth/knowledge/` | File `knowledge/research_report_oauth2_vs_jwt.md` exists and is linked inside `phase-1-summary.md`. |
| **S4** | Test Strategy Specification | `agent-workspace/tests/TEST_STRATEGY.md` | File exists. Contains declared testing tiers, tooling, thresholds, mocking policy, and definition of certified. |
| **S4** | Ratified Scenario Files | `agent-workspace/tests/scenarios/` | Files `SC-user-auth-001.md` and `SC-user-auth-002.md` exist with `origin: plan`, `status: ratified`, and Given/When/Then criteria. |
| **S4** | Verification Scope Delta | `agent-workspace/plans/user-auth/phase-5-test.md` | File exists. References `TEST_STRATEGY.md` and explicitly cites `SC-user-auth-001` and `SC-user-auth-002`. Zero restated tooling/thresholds. |
| **S4** | Operations & Environment Design | `agent-workspace/plans/user-auth/phase-6-operation.md` | File exists. Contains full 8-section content contract (§0 Environment Topology matrix with entry gates, §1 Containerization, §2 Compose, §3 Secret declarations [names only], §4 CI/CD Topology, §5 Promotion & post-delivery hooks, §6 Observability blocks [6a/6b/6c], §7 ADRs). |
| **S4** | Embedded Decision Verification | `agent-workspace/plans/user-auth/phase-*.md` | Decisions documented directly inside `phase-*.md` blueprints. **Zero `decisions/` subfolder created**. |
| **S5** | Versioned Implementation Map | `agent-workspace/plans/user-auth/implementation_maps/` | File `implementation_maps/implementation_map_v1.0.0.md` exists, adhering to `implementation_map_taxonomy.md`. **Zero source code modified in `src/` or `codebase-*/`**. |
| **S5** | Filesystem Sandbox Boundary | Workspace Root | All created/edited feature files are strictly confined to `agent-workspace/plans/user-auth/` (plus project-durable `agent-workspace/tests/`). **Zero edits in `docs/` or `src/*/code_graph/`**. |
| **S6** | Guard Process Status | `agent-workspace/plans/user-auth/PROCESS_STATUS.md` | Block 1 matrix contains planning sub-rows 3.1–3.6 marked `[x] Done`. Row 6 designates `/operate`. Block 2 daily history updated. |
| **S7** | Execution Completion Output | Subprocess Stdout | Terminal prints planning summary report and recommended next workflow command (`/implement`). |

---

## 5. Automated Execution Test Script

To execute this test scenario automatically in an Antigravity sandbox:

```bash
# 1. Prepare workspace and check out feature branch
git checkout -b feature/user-auth

# 2. Run /plan workflow in dry-run mode first to verify output
/plan --feature user-auth --dry-run

# 3. Run full /plan workflow execution in interactive mode
/plan --feature user-auth

# 4. Run automated assertions
test -f agent-workspace/plans/user-auth/GRILL_STATUS.md && echo "ASSERT PASS: GRILL_STATUS.md present in agent-workspace/plans/user-auth/"
test -f agent-workspace/plans/user-auth/PROCESS_STATUS.md && echo "ASSERT PASS: PROCESS_STATUS.md present in agent-workspace/plans/user-auth/"
test -f agent-workspace/plans/user-auth/phase-1-summary.md && echo "ASSERT PASS: phase-1-summary.md present"
test -f agent-workspace/plans/user-auth/phase-3-data.md && echo "ASSERT PASS: phase-3-data.md present"
test -f agent-workspace/plans/user-auth/phase-4-engine.md && echo "ASSERT PASS: phase-4-engine.md present"
test -f agent-workspace/plans/user-auth/phase-5-test.md && echo "ASSERT PASS: phase-5-test.md present"
test -f agent-workspace/plans/user-auth/phase-6-operation.md && echo "ASSERT PASS: phase-6-operation.md present"
test -d agent-workspace/plans/user-auth/phase_details/web_ui && echo "ASSERT PASS: phase_details/web_ui present"
test -f agent-workspace/plans/user-auth/knowledge/research_report_oauth2_vs_jwt.md && echo "ASSERT PASS: research report present in knowledge/"
test -f agent-workspace/tests/TEST_STRATEGY.md && echo "ASSERT PASS: TEST_STRATEGY.md present in agent-workspace/tests/"
test -f agent-workspace/tests/scenarios/SC-user-auth-001.md && echo "ASSERT PASS: SC-user-auth-001.md present in agent-workspace/tests/scenarios/"
test -f agent-workspace/tests/scenarios/SC-user-auth-002.md && echo "ASSERT PASS: SC-user-auth-002.md present in agent-workspace/tests/scenarios/"
grep -q "SC-user-auth-001" agent-workspace/plans/user-auth/phase-5-test.md && echo "ASSERT PASS: scenario cited in phase-5-test.md"
grep -q "Environment Topology" agent-workspace/plans/user-auth/phase-6-operation.md && echo "ASSERT PASS: Environment Topology present in phase-6-operation.md"
grep -q "Observability" agent-workspace/plans/user-auth/phase-6-operation.md && echo "ASSERT PASS: Observability present in phase-6-operation.md"
test -f agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md && echo "ASSERT PASS: versioned implementation_map_v1.0.0.md present"
test ! -d agent-workspace/plans/user-auth/decisions && echo "ASSERT PASS: no separate decisions folder created"
```
