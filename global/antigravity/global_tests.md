# Qualification & Test Specification: Global Governance Utilities

This document defines the test scenarios, mock execution sequences, and automated test assertions for validating the global Antigravity guard utilities (`sync-process-status.sh` and `verify-action-handoff.sh`).

---

## 1. Test Overview & Objectives

* **Target Modules**:
  * `global/antigravity/guards/scripts/sync-process-status.sh`
  * `global/antigravity/guards/scripts/verify-action-handoff.sh`
* **Target Environment**: Google Antigravity Agent Execution Environment / Bash
* **Primary Objectives**:
  1. Validate that `sync-process-status.sh` accurately updates Block 1 status tokens, sets the `Last Updated` date, appends datestamped event entries to Block 2, and stages `PROCESS_STATUS.md`.
  2. Validate that `verify-action-handoff.sh` correctly passes when an action is `[x] Done` (or `[-] Not In Scope`) and halts fail-closed with exit code `1` when the action is incomplete or unstarted.

---

## 2. Test Setup & Sandbox Preparation

```bash
# Prepare an isolated test sandbox
SANDBOX_DIR="/tmp/test-global-guards"
rm -rf "$SANDBOX_DIR"
mkdir -p "$SANDBOX_DIR/agent-workspace/plans/test-feature"
cd "$SANDBOX_DIR"
git init -q

# Scaffold a mock PROCESS_STATUS.md
cat << 'EOF' > agent-workspace/plans/test-feature/PROCESS_STATUS.md
# Guard Process Status: test-feature

- **Target Release / Feature**: `feature/test-feature`
- **Git Branch**: `feature/test-feature`
- **Initialization Date**: `2026-09-03`
- **Active Workflow**: `/init`

---

## Block 1: Workflow Execution Matrix

| Workflow / Sub-Process | Status | Focus / Artifact | Last Updated |
| :--- | :--- | :--- | :--- |
| **1. /init** | `[x] Done` | Control plane scaffolding | 2026-09-03 |
| **2. /process** | `[-] Not In Scope` | Legacy code & docs analysis | 2026-09-03 |
| **3. /plan** | `[ ] Not Started` | 6-Phase Blueprinting Framework | 2026-09-03 |
| ├── **3.1 Phase 1: Summary** | `[ ] Not Started` | High-level summary & folder map | 2026-09-03 |
| ├── **3.2 Phase 2: Layout** | `[ ] Not Started` | Design system & styling laws | 2026-09-03 |
| ├── **3.3 Phase 3: Data** | `[ ] Not Started` | Data capturing & storing mechanisms | 2026-09-03 |
| ├── **3.4 Phase 4: Engine** | `[ ] Not Started` | Core engine logic & API services | 2026-09-03 |
| ├── **3.5 Phase 5: Test** | `[ ] Not Started` | Verification Scope & Test Delta | 2026-09-03 |
| └── **3.6 Phase 6: Operations** | `[ ] Not Started` | Environments & CI/CD topology | 2026-09-03 |
| **4. /implement** | `[ ] Not Started` | Code scaffolding & layout | 2026-09-03 |
| **5. /qualify** | `[ ] Not Started` | Full-spectrum qualification | 2026-09-03 |
| **6. /operate** | `[ ] Not Started` | Image build & deployment | 2026-09-03 |

---

## Block 2: Datestamped Daily Execution History

### [2026-09-03]
- **[09:00] Workflow Initiated**: `/init`
  - Scaffolded control plane.
EOF

git add . && git commit -q -m "Initial mock status"
```

---

## 3. Test Suites & Pragmatic Assertions

### Suite 1: Status Synchronization Tool (`sync-process-status.sh`)

#### Test 1.1: Top-Level Workflow Status Transition (`[ ]` $\rightarrow$ `[>]`)
```bash
# Command: Transition /plan to in_progress
./sync-process-status.sh --workflow plan --status in_progress --log "Started 6-Phase Planning"

# Assertions
grep -E '\|\s*\*\*3\.\s*/plan\*\*\s*\|\s*`\[>\] In Progress`' agent-workspace/plans/test-feature/PROCESS_STATUS.md \
  && echo "ASSERT PASS: /plan transitioned to in_progress in Block 1"
grep -q "Started 6-Phase Planning" agent-workspace/plans/test-feature/PROCESS_STATUS.md \
  && echo "ASSERT PASS: Block 2 execution history appended"
git status --porcelain | grep -q "PROCESS_STATUS.md" \
  && echo "ASSERT PASS: PROCESS_STATUS.md automatically staged"
```

#### Test 1.2: Sub-Process / Phase Status Transition (`[ ]` $\rightarrow$ `[x]`)
```bash
# Command: Mark Phase 1 Summary as done
./sync-process-status.sh --workflow plan --sub-process 3.1 --status done --log "Finalized phase-1-summary.md"

# Assertions
grep -E '\|\s*├──\s*\*\*3\.1 Phase 1: Summary\*\*\s*\|\s*`\[x\] Done`' agent-workspace/plans/test-feature/PROCESS_STATUS.md \
  && echo "ASSERT PASS: Sub-process 3.1 transitioned to done in Block 1"
grep -q "Finalized phase-1-summary.md" agent-workspace/plans/test-feature/PROCESS_STATUS.md \
  && echo "ASSERT PASS: Block 2 history appended for sub-process 3.1"
```

---

### Suite 2: Playbook Inter-Action Handoff Gate (`verify-action-handoff.sh`)

#### Test 2.1: Successful Handoff for Completed Action (`/init` $\rightarrow$ `/plan`)
```bash
# /init is marked [x] Done in mock status
./verify-action-handoff.sh --completed-action init --next-action plan
test $? -eq 0 && echo "ASSERT PASS: Handoff from /init to /plan approved"
```

#### Test 2.2: Fail-Closed Rejection for Incomplete Action (`/plan` $\rightarrow$ `/implement`)
```bash
# /plan is [>] In Progress (not [x] Done)
./verify-action-handoff.sh --completed-action plan --next-action implement 2>/dev/null
test $? -ne 0 && echo "ASSERT PASS: Handoff halted fail-closed because /plan is not Done"
```

#### Test 2.3: Successful Handoff for Out-of-Scope Action (`/process` $\rightarrow$ `/plan`)
```bash
# /process is [-] Not In Scope
./verify-action-handoff.sh --completed-action process --next-action plan
test $? -eq 0 && echo "ASSERT PASS: Handoff approved for out-of-scope action"
```
