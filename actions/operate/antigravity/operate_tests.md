# Verification & Test Specification: `/operate` Workflow

This document defines the test scenarios, mock execution sequences, user input simulations, and verification assertions for testing the `/operate` workflow within **Google Antigravity**. It covers execution of entry and provenance gates, build vs. reuse logic, health assertions, and ops finding generation.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/operate` (Operations & Delivery)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenarios**:
    1.  **Scenario A (Certified Promotion - Success)**: Delivery to a `certification: full` environment with a matching source digest and passing health checks.
    2.  **Scenario B (Entry Gate Failure - Halt)**: Delivery to a `certification: full` environment when `QUALIFICATION_REPORT.md` is `provisional` or absent.
    3.  **Scenario C (Provenance Gate Mismatch - Halt)**: Delivery to a `certification: full` environment where the current source state digest diverges from the certified digest.
    4.  **Scenario D (Un-Gated Delivery & Ops Findings)**: Delivery to a `gate: none` environment where Node O5 health assertions surface an unratified ops finding.
*   **Primary Objective**: Validate the strict execution of the 7-node state machine (O1 → O7), ensuring gates fail-closed, build identity accurately relies on source state matching, and no unauthorized authoring or restructuring occurs.

---

## 2. Test Setup & Pre-conditions

### Shared Pre-conditions
1.  **Workspace Directory**: `agent-workspace/plans/<feature-name>/` exists.
2.  **Design Artifact**: `phase-6-operation.md` is populated with valid environments, topologies, and health contracts.
3.  **Implement Artifacts**: `codebase-devops/` and valid Dockerfiles exist.

### Scenario-Specific Overrides
*   **Scenario A**: `QUALIFICATION_REPORT.md` exists with `certification: full`. The certified digest matches the current mock source state.
*   **Scenario B**: `QUALIFICATION_REPORT.md` exists but marks `certification: provisional`.
*   **Scenario C**: `QUALIFICATION_REPORT.md` marks `certification: full` but the current source state digest simulates a post-certification code change.
*   **Scenario D**: `phase-6-operation.md` defines the target environment with `gate: none`. Node O5 mocks a health check timeout (failure).

---

## 3. Mock Execution Sequences

### Scenario A: Certified Promotion (Success)
*   **Command Invocation**: `/operate --env prod --version v1.0.0`
*   **Mock Execution Sequence**:
    1.  **O1**: Resolves `prod` environment and `v1.0.0` tag.
    2.  **O2**: Evaluates Entry Gate (Passed -> requires full) and Provenance Gate (Passed -> digests match).
    3.  **O3**: Evaluates history. Mock simulates a prior build match -> Reuses digest, re-tags.
    4.  **O4**: Promotes digest to `prod`. Executes mock post-delivery hook.
    5.  **O5**: Health assertions all pass.
    6.  **O6**: `WALKTHROUGH.md` generated with success statuses. No ops findings.
    7.  **O7**: `PROCESS_STATUS.md` Row 6 synced to `Completed`.

### Scenario B: Entry Gate Failure (Halt)
*   **Command Invocation**: `/operate --env prod --version v1.0.0`
*   **Mock Execution Sequence**:
    1.  **O1**: Resolves `prod` environment.
    2.  **O2**: Evaluates Entry Gate -> Fails (`provisional` != `full`). Grill Q3 presents routing options.
    3.  **Grill Q3**: User selects "Halt and return to /qualify".
    4.  **Action**: Halts delivery. Does not proceed to Node O3. Walkthrough logs failure.

### Scenario C: Provenance Gate Mismatch (Halt)
*   **Command Invocation**: `/operate --env prod --version v1.0.1`
*   **Mock Execution Sequence**:
    1.  **O1**: Resolves `prod` environment.
    2.  **O2**: Evaluates Entry Gate (Passed). Evaluates Provenance Gate -> Fails (Source digest mismatch). Grill Q4 presents routing options.
    3.  **Grill Q4**: User selects "Halt and return to /qualify".
    4.  **Action**: Halts delivery. Does not proceed to Node O3. Walkthrough logs failure.

### Scenario D: Un-Gated Delivery & Ops Findings
*   **Command Invocation**: `/operate --env staging --version v1.0.0`
*   **Mock Execution Sequence**:
    1.  **O1**: Resolves `staging` (gate: none).
    2.  **O2**: Evaluates Entry Gate (Passed -> `none`). Skips Provenance Gate.
    3.  **O3**: Builds fresh (Mock: No prior build history). Records new digest.
    4.  **O4**: Promotes digest to `staging`.
    5.  **O5**: Health assertion fails (e.g., Check timeout). Generates unratified ops finding. Delivery halts (fail-closed) before marking complete.
    6.  **O6**: `WALKTHROUGH.md` generated with ops finding.
    7.  **O7**: `PROCESS_STATUS.md` does NOT sync to `Completed`.

---

## 4. Verification Assertions & Validation Matrix

| Scenario | Node | Verification Target | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **All** | **O2** | Pure Execution | No modifications made to Dockerfiles, compose YAML, or `phase-6-operation.md` anywhere in the process. |
| **A** | **O6** | Walkthrough Record | `WALKTHROUGH.md` shows `Entry Gate: PASSED`, `Provenance Gate: PASSED`. |
| **A** | **O7** | Process Sync | `PROCESS_STATUS.md` Row 6 is `Completed`. |
| **B** | **O2** | Entry Gate Halt | Execution stops before O3. `WALKTHROUGH.md` records `Entry Gate: FAILED`. No image pushed or built. |
| **C** | **O2** | Provenance Halt | Execution stops before O3. `WALKTHROUGH.md` records `Provenance Gate: FAILED`. No image pushed or built. |
| **D** | **O6** | Ops Finding | `WALKTHROUGH.md` contains Ops Finding with `origin: operate, status: unratified` capturing the O5 assertion timeout. |
| **D** | **O7** | Process Halt | `PROCESS_STATUS.md` Row 6 remains unchanged (not Completed). |

---

## 5. Automated Execution Scripts

### 5.1 Scenario A Test (Success)

```bash
# 1. Prepare mock environment with valid certification
mkdir -p /tmp/test-operate && cd /tmp/test-operate
# ... Setup mock QUALIFICATION_REPORT.md and phase-6-operation.md ...

# 2. Run /operate in dry-run mode
/operate --env prod --version v1.0.0 --dry-run

# 3. Assert Walkthrough and Process Status
test -f agent-workspace/plans/feature-x/WALKTHROUGH.md && echo "ASSERT PASS: WALKTHROUGH.md created"
grep -q "Provenance Gate.*PASSED" agent-workspace/plans/feature-x/WALKTHROUGH.md && echo "ASSERT PASS: Provenance Gate Passed"
grep -q "Row 6.*Completed" agent-workspace/plans/feature-x/PROCESS_STATUS.md && echo "ASSERT PASS: Process Status Completed"
test ! -f codebase-devops/Dockerfile.modified && echo "ASSERT PASS: No devops files were tampered with"
```

### 5.2 Scenario B/C Test (Gate Failures)

```bash
# 1. Modify mock environment to invalidate certification or digest
cd /tmp/test-operate
# ... Set certification: provisional ...

# 2. Run /operate
/operate --env prod --version v1.0.0

# 3. Assert Halt & Walkthrough Failure
test ! -f /tmp/mock-registry/v1.0.0 && echo "ASSERT PASS: No image built or pushed"
grep -q "FAILED" agent-workspace/plans/feature-x/WALKTHROUGH.md && echo "ASSERT PASS: Gate Failure recorded in WALKTHROUGH.md"
```

### 5.3 Scenario D Test (Ops Findings)

```bash
# 1. Modify mock environment for staging (gate: none) and failing health assertion
cd /tmp/test-operate
# ... Set gate: none, simulate O5 timeout ...

# 2. Run /operate
/operate --env staging --version v1.0.0

# 3. Assert Ops Finding Generation
grep -q "origin: operate" agent-workspace/plans/feature-x/WALKTHROUGH.md && echo "ASSERT PASS: Ops finding generated"
grep -q "status: unratified" agent-workspace/plans/feature-x/WALKTHROUGH.md && echo "ASSERT PASS: Ops finding is unratified"
```
