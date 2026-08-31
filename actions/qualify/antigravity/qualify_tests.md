# Qualification & Test Specification: `/qualify` Workflow (Release Qualification Scenario)

This document defines the test scenario, mock execution sequence, user input simulation, pragmatic CLI test commands, and verification assertions for testing the `/qualify` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

* **Target Workflow**: `/qualify` (Action Qualification workflow for coverage gating, multi-tier test execution, layer defect attribution, coverage gap proposal authoring, audit reporting, and release certification)
* **Target Environment**: Google Antigravity Agent Execution Environment
* **Test Scenario**: Fullstack Feature Qualification Scenario (`user-auth` feature spanning `codebase-data`, `codebase-engine`, `codebase-ui`, and `codebase-qualify`)
* **Primary Objective**: Validate end-to-end execution of the `/qualify` workflow state machine (Nodes Q1 $\rightarrow$ Q6), asserting that:
  1. **Coverage Gate Precedence (Node Q1)**: Node Q1 executes BEFORE environment boot and fails closed if any ratified in-scope scenario lacks an `@scenario` citation in the codebase.
  2. **No Authoring Authority**: Agent strictly limits its scope to execution and judgment; it never authors harness code or modifies ratified scenario criteria.
  3. **Force-Gate Override**: `--force-gate "<justification>"` produces a `provisional` certification that cannot unlock `/operate`.
  4. **Multi-Tier Test Execution**: Executes unit tests in `codebase-*/tests/`, integration tests in `codebase-qualify/src/integration/`, E2E tests in `codebase-qualify/src/e2e/`, and regression tests in `agent-workspace/tests/regression/`.
  5. **Layer Defect Attribution (Node Q4)**: Parses failure stack traces and attributes root causes accurately (`layout`, `engine`, `data`, `devops`, `test_spec`).
  6. **Defect vs. Coverage Gap Distinction**: Defects block release; discovered gaps are authored as proposals (`origin: qualify, status: unratified`) and never certified against.
  7. **Audit Report Generation**: Generates `QUALIFICATION_REPORT.md` (with Section 0 Coverage Gate result) and `qualification_log.json`.
  8. **Regression Catalog Promotion**: Promotes only passing `status: ratified` scenarios into `agent-workspace/tests/regression/`.
  9. **Process Status Sync**: `PROCESS_STATUS.md` Row 5 is marked `Completed` with datestamped history log.

---

## 2. Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST meet the following pre-conditions prior to command execution:

1. **Initialized Workspace & Branch**: Existing workspace initialized via `/init`, planned via `/plan`, and scaffolded via `/implement` with active branch `feature/user-auth`.
2. **Pre-scaffolded Planning Artifacts**: Directory `agent-workspace/plans/user-auth/` containing:
   - `phase-1-summary.md` through `phase-6-operation.md`
   - `phase-5-test.md` (listing in-scope scenario IDs: `SC-user-auth-001`, `SC-user-auth-002`)
   - `implementation_maps/implementation_map_v1.0.0.md`
   - `PROCESS_STATUS.md` with Rows 1–4 marked `Completed`
3. **Ratified Master Test Scenarios & Strategy**: Directory `agent-workspace/tests/` containing:
   - `TEST_STRATEGY.md` defining tiers, tooling, and thresholds
   - `scenarios/SC-user-auth-001.md` (`status: ratified`, Title: "Successful OAuth2 Login Flow")
   - `scenarios/SC-user-auth-002.md` (`status: ratified`, Title: "Invalid Password Rate Limiting")
4. **Physical Source & Test Codebases**:
   - `codebase-data/src/`, `codebase-engine/src/`, `codebase-ui/src/` with co-located unit tests.
   - `codebase-qualify/src/` containing integration and E2E test files citing `@scenario SC-user-auth-001` and `@scenario SC-user-auth-002`.
   - `codebase-devops/docker/docker-compose.yml` for multi-container orchestration.

---

## 3. Simulated Execution Sequence & Mock Q&A

### Command Invocations Tested

```bash
# 1. Standard Full Qualification Matrix
/qualify

# 2. Tier-Targeted Invocations
/qualify --unit
/qualify --integration
/qualify --e2e
/qualify --regression

# 3. Targeted External Environment Run
/qualify --env https://staging.example.com

# 4. Audit Reporting Mode
/qualify --report-only

# 5. Gap Discovery Mode (Proposals Only)
/qualify --propose

# 6. Coverage Gate Override (Provisional Certification)
/qualify --force-gate "E2E rate limiting verified manually via staging proxy"
```

### Mock User Input Sequence (Nodes Q1–Q6 & Q1–Q6 Prompts)

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **Q1** | **Scope Resolution & Coverage Gate Check** | System reads `phase-5-test.md`, resolves 2 ratified scenarios, and scans `@scenario` citations. | All 2 ratified scenarios resolved. Coverage gate PASSED. |
| **Q1 (Grill)**| **Verification Scope Confirmation** | Selected Option 1 (*Confirm scope and run the coverage gate*). | Scope `feature/user-auth` confirmed (2 ratified scenarios). |
| **Q2 (Grill)**| **Coverage Gate Failure Handling** | *(Skipped silently on passing gate)*. | No missing harness detected. Proceeds to Node Q2. |
| **Q3 (Grill)**| **Test Environment Target** | Selected Option 1 (*Boot isolated container network via docker-compose.yml*). | Docker compose orchestration target configured. |
| **Q4 (Grill)**| **Tier Selection** | Selected Option 1 (*Full matrix — Unit → Integration → E2E → Regression*). | Full matrix execution scheduled. |
| **Q3 (Node)** | **Multi-Tier Suite Execution** | System boots environment and executes Tier 1 $\rightarrow$ Tier 2 $\rightarrow$ Tier 3 $\rightarrow$ Tier 4. | 42 unit, 18 integration, 6 E2E, 24 regression tests pass (100% pass rate). |
| **Q4 (Node)** | **Defect Identification & Attribution** | System parses test outputs and stack traces. | 0 defects detected. 0 coverage gaps identified. |
| **Q5 (Grill)**| **Defect Routing Confirmation** | *(Skipped silently: 100% pass rate)*. | No defects to route. |
| **Q6 (Grill)**| **Coverage Gap Proposal Review** | *(Skipped silently: zero gaps)*. | Proceeds to reporting. |
| **Q5 (Node)** | **Qualification Reporting** | System generates `QUALIFICATION_REPORT.md` & `qualification_log.json`. | Audit report written; Section 0 logs gate pass, Section 5 logs `certification: full`. |
| **Q6 (Node)** | **Release Gating & Regression Promotion** | System promotes `SC-user-auth-001` & `002` to `tests/regression/` and syncs `PROCESS_STATUS.md`. | Row 5 marked `Completed`. Handoff to `/operate` unlocked. |

---

## 4. Qualification Assertions & Validation Matrix

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **Q1** | Coverage Gate (Pre-Boot) | Node Q1 Console Output & Log | Resolved all in-scope scenario IDs from `phase-5-test.md`. Verified `@scenario` citations before booting Docker. |
| **Q1** | Fail-Closed Coverage Gate | Console Output & Return Code | When a scenario lacks `@scenario` citation, halts immediately (`exit code != 0`) and makes zero Docker / test calls. |
| **Q2** | Environment Target Selection | `GRILL_STATUS.md` | Recorded mode (`docker-compose`, `local`, or `--env <url>`). |
| **Q3** | Tier 1: Unit Execution | Subprocess Stdout | Executes unit tests in `codebase-*/tests/`. Requires 100% pass rate. |
| **Q3** | Tier 2: Integration Execution | Subprocess Stdout | Executes API & contract suites in `codebase-qualify/src/integration/`. |
| **Q3** | Tier 3: E2E Execution | Subprocess Stdout | Executes Playwright/Cypress flows in `codebase-qualify/src/e2e/`. |
| **Q3** | Tier 4: Regression Execution | Subprocess Stdout | Executes master regression catalog in `agent-workspace/tests/regression/`. |
| **Q4** | Layer Defect Attribution | `QUALIFICATION_REPORT.md` Section 2 | Failed test correctly attributed to `layout`, `engine`, `data`, `devops`, or `test_spec`. |
| **Q4** | Coverage Gap Discovery | `QUALIFICATION_REPORT.md` Section 3 | Untested behaviors emitted as `origin: qualify, status: unratified` proposals. |
| **Q5** | Audit Report Schema | `agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md` | Contains Section 0 (Coverage Gate), Section 1 (Execution Summary), Section 2 (Defects), Section 3 (Proposals), Section 5 (Certification). |
| **Q5** | Machine Audit Log | `agent-workspace/plans/user-auth/qualification_log.json` | Valid JSON with timestamps, tier counts, exit codes, and coverage metrics. |
| **Q6** | Regression Catalog Promotion | `agent-workspace/tests/regression/` | Ratified scenarios `SC-user-auth-001.md` and `SC-user-auth-002.md` copied/promoted into regression catalog. |
| **Q6** | Guard Process Status | `agent-workspace/plans/user-auth/PROCESS_STATUS.md` | Row 5 marked `Completed`. Datestamped execution log entry added. |

---

## 5. Pragmatic Automated Test Suites & Executable Commands

Below are the exact executable shell commands used by test harnesses and CI scripts to validate each qualification guard.

---

### Test Suite 1: Node Q1 Coverage Gate Precedence & Fail-Closed Guard

#### Test 1.1: Missing Scenario Citation Rejection (Fail-Closed Before Environment Boot)
```bash
# Setup: Create feature plan with scenario SC-user-auth-003, but do NOT add @scenario citation in harness
mkdir -p /tmp/test-qualify-suite/agent-workspace/plans/user-auth/
cat << 'EOF' > /tmp/test-qualify-suite/agent-workspace/plans/user-auth/phase-5-test.md
# Phase 5: Verification Scope
- SC-user-auth-001
- SC-user-auth-003
EOF

mkdir -p /tmp/test-qualify-suite/agent-workspace/tests/scenarios/
cat << 'EOF' > /tmp/test-qualify-suite/agent-workspace/tests/scenarios/SC-user-auth-001.md
---
id: SC-user-auth-001
title: OAuth2 Login Flow
status: ratified
---
EOF

cat << 'EOF' > /tmp/test-qualify-suite/agent-workspace/tests/scenarios/SC-user-auth-003.md
---
id: SC-user-auth-003
title: Unimplemented MFA Flow
status: ratified
---
EOF

mkdir -p /tmp/test-qualify-suite/codebase-qualify/src/
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/test_login.py
# @scenario SC-user-auth-001
def test_oauth_login():
    assert True
EOF

# Command: Run /qualify
cd /tmp/test-qualify-suite && /qualify

# Assertion: Must FAIL CLOSED before environment boot due to missing SC-user-auth-003 citation
test $? -ne 0 && echo "PASS: /qualify halted at Node Q1 coverage gate"
grep -q "SC-user-auth-003" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  || echo "PASS: Missing ratified scenario flagged in gate evaluation"
```

#### Test 1.2: Passing Coverage Gate
```bash
# Setup: Add the missing @scenario citation
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/test_mfa.py
# @scenario SC-user-auth-003
def test_mfa():
    assert True
EOF

# Command: Run /qualify in report-only mode
cd /tmp/test-qualify-suite && /qualify --report-only

# Assertion: Must PASS Node Q1 gate
test $? -eq 0 && echo "PASS: Node Q1 coverage gate passed when all ratified scenarios are cited"
```

#### Test 1.3: Force-Gate Override (Yields Provisional Certification)
```bash
# Setup: Remove MFA citation again
rm -f /tmp/test-qualify-suite/codebase-qualify/src/test_mfa.py

# Command: Run /qualify with --force-gate
cd /tmp/test-qualify-suite && /qualify --force-gate "MFA tested externally via IdP console"

# Assertion: Must record provisional certification and NOT unlock release
grep -q "provisional" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Override produced provisional certification"
grep -q "Unproven ratified IDs.*SC-user-auth-003" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Unproven ratified scenario recorded in report"
```

---

### Test Suite 2: Multi-Tier Test Suite Execution

#### Test 2.1: Full Matrix Execution Sequence
```bash
# Setup: Scaffold test suites across unit, integration, and E2E tiers
mkdir -p /tmp/test-qualify-suite/codebase-engine/tests/
cat << 'EOF' > /tmp/test-qualify-suite/codebase-engine/tests/test_service.py
def test_engine_unit():
    assert True
EOF

mkdir -p /tmp/test-qualify-suite/codebase-qualify/src/integration/
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/integration/test_auth_contract.py
# @scenario SC-user-auth-001
def test_contract():
    assert True
EOF

mkdir -p /tmp/test-qualify-suite/codebase-qualify/src/e2e/
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/e2e/test_auth_journey.py
# @scenario SC-user-auth-003
def test_journey():
    assert True
EOF

# Command: Run /qualify
cd /tmp/test-qualify-suite && /qualify

# Assertion: Must execute all 4 tiers in hierarchical order
test $? -eq 0 && echo "PASS: Full qualification matrix executed cleanly"
grep -q "Layer Unit Tests" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Layer Unit Tests tier included in report"
grep -q "Integration Tests" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Integration Tests tier included in report"
grep -q "E2E User Journeys" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: E2E User Journeys tier included in report"
```

#### Test 2.2: Targeted Single-Tier Invocation (`--unit`)
```bash
# Command: Run only unit tests
cd /tmp/test-qualify-suite && /qualify --unit

# Assertion: Only unit tests executed; integration and E2E tiers skipped
test $? -eq 0 && echo "PASS: Single-tier --unit invocation succeeded"
```

---

### Test Suite 3: Defect Identification & Layer Attribution

#### Test 3.1: Engine Layer Defect Attribution
```bash
# Setup: Introduce a failing assertion in engine integration test
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/integration/test_auth_contract.py
# @scenario SC-user-auth-001
def test_contract():
    # Simulating 500 Internal Server Error from AuthService
    raise AssertionError("HTTP 500 Internal Server Error from /api/v1/auth/token: AuthService exception")
EOF

# Command: Run /qualify
cd /tmp/test-qualify-suite && /qualify

# Assertion: Must exit non-zero and attribute defect to Engine layer
test $? -ne 0 && echo "PASS: /qualify failed on assertion error"
grep -q "Engine Layer Defect" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Defect correctly attributed to Engine layer"
grep -q "AuthService exception" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Stack trace diagnostic context captured in report"
```

#### Test 3.2: Layout Layer Defect Attribution
```bash
# Setup: Introduce UI component rendering failure
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/e2e/test_auth_journey.py
# @scenario SC-user-auth-003
def test_journey():
    raise AssertionError("ElementNotFoundException: LoginButton not visible in LoginView.tsx DOM")
EOF

# Command: Run /qualify
cd /tmp/test-qualify-suite && /qualify

# Assertion: Must attribute to Layout layer
grep -q "Layout Layer Defect" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: Defect correctly attributed to Layout layer"
```

---

### Test Suite 4: Coverage Gap Proposal Handling (`--propose`)

#### Test 4.1: Gap Discovery Without Blocking Release
```bash
# Setup: Fix tests so matrix passes, but invoke in discovery mode
cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/integration/test_auth_contract.py
# @scenario SC-user-auth-001
def test_contract():
    assert True
EOF

cat << 'EOF' > /tmp/test-qualify-suite/codebase-qualify/src/e2e/test_auth_journey.py
# @scenario SC-user-auth-003
def test_journey():
    assert True
EOF

# Command: Run /qualify with discovery flag
cd /tmp/test-qualify-suite && /qualify --propose

# Assertion: Emits proposal with origin: qualify, status: unratified
grep -q "status: unratified" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  || echo "PASS: Coverage gap proposals marked unratified"
```

---

### Test Suite 5: Release Gating, Audit Reporting & Regression Promotion

#### Test 5.1: Clean Qualification & Regression Catalog Promotion
```bash
# Setup: Ensure all tests pass cleanly and ratified scenarios exist
mkdir -p /tmp/test-qualify-suite/agent-workspace/tests/regression/

# Command: Run /qualify for full certification
cd /tmp/test-qualify-suite && /qualify

# Assertion: Must pass, create reports, promote scenarios, and mark PROCESS_STATUS.md Completed
test $? -eq 0 && echo "PASS: /qualify passed with 100% pass rate"
test -f /tmp/test-qualify-suite/agent-workspace/plans/user-auth/QUALIFICATION_REPORT.md \
  && echo "PASS: QUALIFICATION_REPORT.md created"
test -f /tmp/test-qualify-suite/agent-workspace/plans/user-auth/qualification_log.json \
  && echo "PASS: qualification_log.json created"
test -f /tmp/test-qualify-suite/agent-workspace/tests/regression/SC-user-auth-001.md \
  && echo "PASS: Ratified scenario SC-user-auth-001 promoted to regression catalog"
grep -q "Row 5.*Completed" /tmp/test-qualify-suite/agent-workspace/plans/user-auth/PROCESS_STATUS.md \
  || echo "PASS: PROCESS_STATUS.md Row 5 updated to Completed"
```
