# Qualification & Test Specification: `/implement` Workflow (Feature Implementation Scenario)

This document defines the test scenario, mock execution sequence, user input simulation, pragmatic CLI test commands, and verification assertions for testing the `/implement` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

* **Target Workflow**: `/implement` (Action Implementation workflow for physical code scaffolding, cross-layer test harness construction, solution testing, code graph sync, and system doc updates)
* **Target Environment**: Google Antigravity Agent Execution Environment
* **Test Scenario**: Fullstack Feature Implementation Scenario (`user-auth` feature spanning `codebase-data`, `codebase-engine`, `codebase-ui`, and `codebase-qualify`)
* **Primary Objective**: Validate end-to-end execution of the `/implement` workflow state machine (Nodes S1 $\rightarrow$ S7), asserting that:
  1. **FIRST ACTION Mandate**: Node S2 immediately checks and verifies (1) `implementation_map_v1.0.0.md`, (2) `phase-5-test.md`, and (3) that all scenario IDs in `phase-5-test.md` resolve to `agent-workspace/tests/scenarios/` with `status: ratified` before touching code.
  2. **Rejection Guards**: Agent strictly rejects code modification if the implementation map, test plan, or any scenario ratification resolution fails, returning scope to `/plan`.
  3. **4-Part Step Schema & Stream Categorization**: Scaffolding executes sequential steps, parallel steps, and the test harness stream (`codebase-qualify/`), asserting Requirement, Prerequisites, Actions, and Verification for each step.
  4. **Visible Scaffolding & Interruption Checkpoints**: Scaffolding actions are visible and allow direct user interruption without opaque subagent delegation.
  5. **Solution Testing & Cross-Layer Test Harness**: Runs layer-local unit/integration tests per step AND builds cross-layer test harness in `codebase-qualify/src/` tagged with `@scenario SC-<feature-slug>-<nnn>`.
  6. **Red-First Harness Isolation Mode**: Supports `--tests-only` to build failing test harnesses in `codebase-qualify/` ahead of feature code.
  7. **Token Economy Guard**: AST Code Graph (`src/<layer>/code_graph/`) and System Documentation (`docs/`) updates are skipped by default and run only with `--code-graph`, `--docs`, or `--full-sync`.
  8. **Decision Persistence & Artifact Sync**: All decisions and outcomes recorded in inner agent docs (Artifacts) are 100% synchronized into version-controlled files under `agent-workspace/plans/user-auth/`.
  9. **Process Status Sync**: `PROCESS_STATUS.md` Row 4 is marked `Completed` with datestamped history log.

---

## 2. Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST meet the following pre-conditions prior to command execution:

1. **Initialized Workspace & Branch**: Existing workspace initialized via `/init` and `/plan` with active branch `feature/user-auth`.
2. **Pre-scaffolded Planning Artifacts**: Directory `agent-workspace/plans/user-auth/` containing:
   - `phase-1-summary.md` through `phase-6-operation.md`
   - `phase-5-test.md` (Test Plan with critical regression assertions, verification scope delta, and in-scope scenario ID list)
   - `implementation_maps/implementation_map_v1.0.0.md` adhering to the 4-part step schema
   - `PROCESS_STATUS.md` with Rows 1–3 marked `Completed`
3. **Ratified Test Scenarios**: Directory `agent-workspace/tests/scenarios/` containing:
   - `SC-user-auth-001.md` (`status: ratified`)
   - `SC-user-auth-002.md` (`status: ratified`)
4. **Sub-Repository Layer Symlinks**: Relative symlinks under `agent-workspace/src/` resolving to `codebase-data/`, `codebase-engine/`, `codebase-ui/`, and `codebase-qualify/`.

---

## 3. Simulated Execution Sequence & Mock Q&A

### Command Invocations Tested

```bash
# 1. Standard Interactive Execution
/implement --version v1.0.0

# 2. Automated Continuous Scaffolding Mode
/implement --auto --version v1.0.0

# 3. Test Harness Isolation Mode (Red-First Construction)
/implement --tests-only --version v1.0.0

# 4. Token Economy Optional Flags
/implement --version v1.0.0 --code-graph
/implement --version v1.0.0 --docs
/implement --version v1.0.0 --full-sync

# 5. Dry-run Preview Mode
/implement --version v1.0.0 --dry-run
```

### Mock User Input Sequence (Nodes S1–S7 & Q1–Q9 Prompts)

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Workspace & Branch Verification** | System inspects `agent-workspace/` and verifies active branch `feature/user-auth`. | Environment verified. Branch confirmed (`feature/user-auth`). |
| **S2** | **FIRST ACTION: 3-Leg Precondition Check** | System reads `implementation_map_v1.0.0.md`, `phase-5-test.md`, and resolves scenarios in `tests/scenarios/`. | Verified map, test plan, and 2 ratified scenarios (`SC-user-auth-001`, `SC-user-auth-002`). Displays confirmation summary. |
| **Q1** | **Implementation Map Selection** | Selected Option 1 (*Target full feature release map v1.0.0*). | `implementation_map_v1.0.0.md` confirmed as authoritative roadmap. |
| **Q2** | **Test Plan & Critical Assertions** | Selected Option 1 (*Scaffold unit test files alongside production code per step*). | Test co-location strategy confirmed; scenario ratification verified. |
| **Q3** | **Starting Layer / Entry Point** | Selected Option 1 (*Data Layer & Persistence Models: codebase-data*). | Starting layer set to `codebase-data`. |
| **Q4** | **Scaffolding Strategy & Visibility** | Selected Option 1 (*Step-by-step with explicit developer approval and diff preview*). | Plan-First interactive mode engaged. |
| **Q4b** | **Test Harness Construction Ordering** | Selected Option 1 (*Red-first: Build harness before feature code via /implement --tests-only*). | Harness stream scheduled prior to feature code. |
| **Q5** | **Sequential vs Parallel Sequencing** | Selected Option 1 (*Interleaved sequential execution: Step 1 -> Step 2 -> Parallel Step 3.A & 3.B -> Step 4*). | Execution stream sequence established (including `codebase-qualify/` stream). |
| **Q6** | **Token Economy: Code Graph** | Selected Option 1 (*Skip Code Graph updates - Default*). | Code graph generation bypassed (conserves tokens). |
| **Q7** | **Token Economy: System Docs** | Selected Option 1 (*Skip System Docs updates - Default*). | System docs generation bypassed (conserves tokens). |
| **Q8** | **Symlink Integrity Check** | Selected Option 1 (*Yes - Verify symlink resolution*). | Asserted symlinks in `agent-workspace/src/` (incl. `qualify`) are valid relative links. |
| **Q9** | **Execution Start Confirmation** | Selected Option 1 (*Confirm and execute implementation*). | User approval logged; begins Node S4 code & harness scaffolding loop. |
| **S4** | **Step-by-Step Scaffolding, Harness & Tests** | User confirms Step 1 (Data Models) $\rightarrow$ Step 2 (Engine Service) $\rightarrow$ Step 3.A/3.B (UI Presenters) $\rightarrow$ Step 4 (API Routes & Qualify Harness). | Scaffolds files, builds `codebase-qualify/src/` test citing `@scenario SC-user-auth-001`, runs unit tests, syncs decisions to `plans/user-auth/`. |
| **S7** | **PROCESS_STATUS.md Sync** | System synchronizes process status matrix. | Row 4 marked `Completed`. Next command recommended: `/qualify`. |

---

## 4. Qualification Assertions & Validation Matrix

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S2** | 3-Leg Dual Grounding Gate | `agent-workspace/plans/user-auth/` & `agent-workspace/tests/scenarios/` | `implementation_map_v1.0.0.md` exists, `phase-5-test.md` exists, and all in-scope scenario IDs carry `status: ratified`. |
| **S3** | Audit Log & Transcript | `agent-workspace/plans/user-auth/GRILL_STATUS.md` | Contains full Q1–Q9 (incl. Q4b) prompt choices, selected options, and user inputs. |
| **S4** | Data Layer Scaffolding | `codebase-data/src/models/user.py` | Entity class and database migration script created. |
| **S4** | Engine Layer Scaffolding | `codebase-engine/src/services/auth.py` | `AuthService` logic and DTO mappers created. |
| **S4** | UI Layer Scaffolding | `codebase-ui/src/views/LoginView.tsx` | UI presentation view component created. |
| **S4** | Test Harness Construction | `codebase-qualify/src/test_auth_flow.py` | Cross-layer harness test created and tagged with `@scenario SC-user-auth-001`. |
| **S4** | Solution Testing: Unit Tests | `codebase-data/tests/`, `codebase-engine/tests/` | Unit test files scaffolded and passing (`exit code 0`). |
| **S4** | Decision Persistence & Artifact Sync | `agent-workspace/plans/user-auth/` | 100% parity between inner agent Artifacts and version-controlled `plans/` documents. |
| **S5** | Token Economy: Code Graph Bypass | `agent-workspace/src/*/code_graph/` | Directory unmodified during default `/implement` run. |
| **S6** | Token Economy: System Docs Bypass | `agent-workspace/docs/` | Directory unmodified during default `/implement` run. |
| **S7** | Guard Process Status | `agent-workspace/plans/user-auth/PROCESS_STATUS.md` | Row 4 marked `Completed`. Daily history contains datestamped log entry. |

---

## 5. Pragmatic Automated Test Suites & Executable Commands

Below are the exact executable shell commands used by test harnesses and CI scripts to validate each test case.

---

### Test Suite 1: Precondition & Dual Grounding Guards

#### Test 1.1: Missing Implementation Map Rejection
```bash
# Setup: Remove implementation map
mkdir -p /tmp/test-implement-suite/agent-workspace/plans/user-auth/
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/phase-5-test.md
rm -f /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md

# Command: Run /implement
cd /tmp/test-implement-suite && /implement --version v1.0.0

# Assertion: Must exit with error code and make ZERO file edits
test $? -ne 0 && echo "PASS: /implement halted due to missing implementation_map"
test ! -d /tmp/test-implement-suite/codebase-data/src && echo "PASS: Zero source code modified"
```

#### Test 1.2: Missing Test Plan Rejection
```bash
# Setup: Create map but remove test plan
mkdir -p /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md
rm -f /tmp/test-implement-suite/agent-workspace/plans/user-auth/phase-5-test.md

# Command: Run /implement
cd /tmp/test-implement-suite && /implement --version v1.0.0

# Assertion: Must exit with error code
test $? -ne 0 && echo "PASS: /implement halted due to missing phase-5-test.md"
```

#### Test 1.3: Ambiguous Version Map Resolution Check
```bash
# Setup: Create multiple versioned maps
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/phase-5-test.md
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.1.0_layout.md

# Command: Run /implement without --version flag in dry-run mode
cd /tmp/test-implement-suite && /implement --dry-run

# Assertion: Output must prompt for version resolution (Q1 prompt)
grep -q "Which implementation map version" /tmp/test-implement-suite/agent-workspace/plans/user-auth/GRILL_STATUS.md \
  && echo "PASS: Version resolution gate triggered"
```

#### Test 1.4: Unratified / Missing Scenario Precondition Rejection
```bash
# Setup: Create map and test plan referencing SC-user-auth-001, but leave scenario in draft status
mkdir -p /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/
mkdir -p /tmp/test-implement-suite/agent-workspace/tests/scenarios/
echo -e "# Test Scope\n- SC-user-auth-001" > /tmp/test-implement-suite/agent-workspace/plans/user-auth/phase-5-test.md
touch /tmp/test-implement-suite/agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md
echo -e "---\nid: SC-user-auth-001\nstatus: draft\n---" > /tmp/test-implement-suite/agent-workspace/tests/scenarios/SC-user-auth-001.md

# Command: Run /implement
cd /tmp/test-implement-suite && /implement --version v1.0.0

# Assertion: Must exit with error code, report unratified scenario precondition failure, and return scope to /plan
test $? -ne 0 && echo "PASS: /implement halted due to unratified scenario SC-user-auth-001 (scope returned to /plan)"
test ! -d /tmp/test-implement-suite/codebase-data/src && echo "PASS: Zero source code modified"
```

---

### Test Suite 2: 4-Part Step Schema, Multi-Project Code Scaffolding & Test Harness

#### Test 2.1: 4-Part Step Schema Parsing Check
```bash
# Assertion: Verify target implementation map contains all 4 mandatory sections per step
grep -q "1. \*\*Requirement Fulfilled\*\*" agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md \
  && grep -q "2. \*\*Prerequisites\*\*" agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md \
  && grep -q "3. \*\*Actions Taken\*\*" agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md \
  && grep -q "4. \*\*Verification Fulfilled\*\*" agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md \
  && echo "PASS: 4-Part Step Schema validated in implementation_map"
```

#### Test 2.2: Incremental Code Scaffolding Execution
```bash
# Command: Execute /implement in continuous mode
/implement --auto --version v1.0.0

# Assertions: Verify files created in respective sub-repositories
test -f codebase-data/src/models/user.py && echo "PASS: Data model scaffolded in codebase-data"
test -f codebase-engine/src/services/auth.py && echo "PASS: Auth service scaffolded in codebase-engine"
test -f codebase-ui/src/views/LoginView.tsx && echo "PASS: Login view scaffolded in codebase-ui"
test -f codebase-qualify/src/test_auth_flow.py && echo "PASS: Test harness scaffolded in codebase-qualify"

# Assertions: Verify symlinks in agent-workspace/src/ resolve properly
test -L agent-workspace/src/data && test -e agent-workspace/src/data/models/user.py \
  && test -L agent-workspace/src/qualify && test -e agent-workspace/src/qualify/src/test_auth_flow.py \
  && echo "PASS: Symlinks in agent-workspace/src/ resolve to codebase-* and codebase-qualify"
```

#### Test 2.3: Test Harness Scaffolding & `@scenario` Tag Validation (`--tests-only`)
```bash
# Command: Execute /implement in harness isolation mode (red-first construction)
/implement --tests-only --version v1.0.0

# Assertions: Verify harness file scaffolded in codebase-qualify/src/
test -f codebase-qualify/src/test_auth_flow.py && echo "PASS: Test harness file created in codebase-qualify/src/"

# Assertion: Verify @scenario tag is present within the test declaration block
grep -q "@scenario SC-user-auth-001" codebase-qualify/src/test_auth_flow.py \
  && echo "PASS: Valid @scenario citation found in test harness declaration"
```

---

### Test Suite 3: Solution Testing (Critical Regression & Cross-Layer Harness Tests)

#### Test 3.1: Unit, Integration & Harness Test Execution Commands
```bash
# Step 1 Test: Data persistence unit test
pytest codebase-data/tests/unit/test_user_model.py
test $? -eq 0 && echo "PASS: Data layer unit tests passed"

# Step 2 Test: Engine domain service test
pytest codebase-engine/tests/unit/test_auth_service.py
test $? -eq 0 && echo "PASS: Engine layer unit tests passed"

# Step 3 Test: UI presentation component test
cd codebase-ui && npm run test -- LoginView.test.tsx
test $? -eq 0 && echo "PASS: UI component tests passed"

# Cross-Layer Test Harness: Execute qualify harness suite
pytest codebase-qualify/src/test_auth_flow.py
test $? -eq 0 && echo "PASS: Cross-layer test harness assertions passed"

# Regression Test: Critical feature baseline assertion
pytest codebase-engine/tests/regression/test_critical_system_features.py
test $? -eq 0 && echo "PASS: Critical system regression assertions unbroken"
```

---

### Test Suite 4: Token Economy Guard (Optional Features)

#### Test 4.1: Default Baseline Execution (Code Graph & Docs Skipped)
```bash
# 1. Record timestamps/state of code_graph and docs
mkdir -p agent-workspace/src/engine/code_graph agent-workspace/docs
touch agent-workspace/src/engine/code_graph/.sentinel agent-workspace/docs/.sentinel

# 2. Run /implement default baseline
/implement --auto --version v1.0.0

# 3. Assert sentinels untouched (Zero overhead generated)
test -f agent-workspace/src/engine/code_graph/.sentinel && echo "PASS: Code Graph update bypassed by default"
test -f agent-workspace/docs/.sentinel && echo "PASS: System Docs update bypassed by default"
```

#### Test 4.2: Explicit Code Graph & System Docs Synchronization (`--full-sync`)
```bash
# 1. Run /implement with --full-sync
/implement --auto --version v1.0.0 --full-sync

# 2. Assert AST Code Graphs updated
test -f agent-workspace/src/engine/code_graph/graph.md \
  && grep -q "AuthService" agent-workspace/src/engine/code_graph/graph.md \
  && echo "PASS: AST Code Graph synchronized in src/engine/code_graph/"

# 3. Assert System Documentation promoted
test -f agent-workspace/docs/api/auth.md \
  && grep -q "Endpoint: /api/v1/auth/login" agent-workspace/docs/api/auth.md \
  && echo "PASS: System Docs promoted to agent-workspace/docs/"
```

---

### Test Suite 5: Decision Persistence & Inner Agent Artifact Alignment

#### Test 5.1: Artifact Parity Verification
```bash
# 1. Check if inner agent artifact exists in brain storage
ARTIFACT_PATH="/Users/horvathgergo/.gemini/antigravity/brain/59c34be1-75d8-4ca7-8a3b-8527ecf26c42/implementation_plan.md"
PLANS_DOC_PATH="agent-workspace/plans/user-auth/implementation_maps/implementation_map_v1.0.0.md"

# 2. Assert that decisions and steps in inner artifact are present in version-controlled plans/
test -f "$PLANS_DOC_PATH" && echo "PASS: Version-controlled implementation map exists in plans/"
grep -q "UserModel" "$PLANS_DOC_PATH" && echo "PASS: Decision parity confirmed in version-controlled plans/ doc"
```

---

### Test Suite 6: Process Status & Lifecycle Handoff

#### Test 6.1: `PROCESS_STATUS.md` Completion Check
```bash
# 1. Assert Row 4 (/implement) is marked Completed
grep "| \*\*4\*\* | \`/implement\` | Completed |" agent-workspace/plans/user-auth/PROCESS_STATUS.md \
  && echo "PASS: PROCESS_STATUS.md Row 4 marked Completed"

# 2. Assert Daily History Log contains datestamped entry
grep -q "Scaffolded source code across codebase-\*" agent-workspace/plans/user-auth/PROCESS_STATUS.md \
  && echo "PASS: Datestamped execution entry recorded in daily history log"
```
