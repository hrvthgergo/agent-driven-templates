#!/usr/bin/env bash
set -e

echo "=== STARTING DUAL-MODE E2E TEST SUITE FOR /init WORKFLOW (init_tests.md) ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RM_PATH="${SCRIPT_DIR}/test_sandbox"
REMOTE_REPO_PATH="${SCRIPT_DIR}/mock_remote.git"

rm -rf "$RM_PATH" "$REMOTE_REPO_PATH"
mkdir -p "$RM_PATH"

# Create a bare remote Git repository to test push
git init --bare "$REMOTE_REPO_PATH" >/dev/null

cd "$RM_PATH"
git init >/dev/null

echo "--> Sandbox prepared at $RM_PATH"
echo "--> Mock remote repository at $REMOTE_REPO_PATH"
ERRORS=0

# ==============================================================================
# SCENARIO A: Greenfield / Major Feature Setup (Full Deep-Dive)
# ==============================================================================
echo ""
echo "========================================================================"
echo ">>> SCENARIO A: Greenfield Control Plane Setup (Major Feature Mode)"
echo "========================================================================"

# S1: Check environment & branch initialization
git checkout -b initial >/dev/null 2>&1

# S5: Scaffolding Pure Control Plane Directory Tree
mkdir -p agent-workspace/.agents/rules \
         agent-workspace/.agents/workflows \
         agent-workspace/.agents/skills \
         agent-workspace/.agents/hooks \
         agent-workspace/.agents/sidecars \
         agent-workspace/plans/initial \
         agent-workspace/docs \
         agent-workspace/src

# Provision .gitkeep Files in every directory node
touch agent-workspace/.agents/rules/.gitkeep \
      agent-workspace/.agents/workflows/.gitkeep \
      agent-workspace/.agents/skills/.gitkeep \
      agent-workspace/.agents/hooks/.gitkeep \
      agent-workspace/.agents/sidecars/.gitkeep \
      agent-workspace/plans/initial/.gitkeep \
      agent-workspace/docs/.gitkeep \
      agent-workspace/src/.gitkeep

# Copy master guard primitives
cp "${SCRIPT_DIR}/../guards/workflows/init.md" agent-workspace/.agents/workflows/
cp "${SCRIPT_DIR}/../guards/rules/init-grill.md" agent-workspace/.agents/rules/
mkdir -p agent-workspace/.agents/skills/init-scaffolder
cp "${SCRIPT_DIR}/../guards/skills/init-scaffolder/SKILL.md" agent-workspace/.agents/skills/init-scaffolder/

# Deploy Status & Audit Documents (Q1–Q7)
cat << 'LOG' > agent-workspace/plans/initial/GRILL_STATUS.md
# GRILL_STATUS Audit Log
mode: major_feature
Q1 Purpose & Scope: Fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release
Q2 Local System Folders: Current working directory
Q3 Cloud Docs: None
Q4 Additional Remotes: None
Q5 Primary Remote Origin: file://MOCK_REMOTE (Provider: Other)
Q6 Agent Guiders: Standard Guards framework defaults
Q7 Summary Verification: Accepted
Node S4 Execution Acceptance: Accepted
LOG

cat << 'STATUS' > agent-workspace/plans/initial/PROCESS_STATUS.md
# Process Status Matrix
**Target Release/Feature**: Initial Setup
**Git Branch**: initial
**Date**: 2026-08-19
**Active Workflow**: /init

## Block 1: Workflow Execution Matrix
| Step | Workflow Stage | Status | Assigned Plan / Artifact | Next Action |
| :--- | :--- | :--- | :--- | :--- |
| **1** | `/init` | Completed | `agent-workspace/plans/initial/GRILL_STATUS.md` | Proceed to `/plan` |
| **2** | `/process` | Skipped | N/A (Greenfield setup) | N/A |
| **3** | `/plan` | In Progress | `agent-workspace/plans/initial/phase-1-summary.md` | Execute Phase 1 |
| 3.1 | -- Phase 1: Summary | In Progress | `phase-1-summary.md` | Draft Scope & Goals |
| 3.2 | -- Phase 2: Layout | Pending | `phase-2-layout.md` | Pending |
| 3.3 | -- Phase 3: Data | Pending | `phase-3-data.md` | Pending |
| 3.4 | -- Phase 4: Engine | Pending | `phase-4-engine.md` | Pending |
| 3.5 | -- Phase 5: Test | Pending | `phase-5-test.md` | Pending |
| 3.6 | -- Phase 6: Operation | Pending | `phase-6-operation.md` | Pending |
| **4** | `/implement` | Pending | Codebase Implementation | Pending |
| **5** | `/qualify` | Pending | Release Qualification | Pending |
| **6** | `/release` | Pending | Release Tag & Merge | Pending |

## Block 2: Daily Execution History
### [2026-08-19]
- **Action**: Executed `/init` workflow.
- **Result**: Scaffolded agent-workspace/ control structures, configured origin, and pushed initial documentation.
STATUS

cat << 'SUMMARY' > agent-workspace/plans/initial/phase-1-summary.md
# Phase 1 Summary Blueprint: Project & Feature Overview
**Project / Feature Name**: Initial E-Commerce Platform
**Branch**: initial
**Date**: 2026-08-19
**Mode**: major_feature

## 1. Executive Summary & Change Scope
### Aim & Purpose
Fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release.

### Issue & Ticket Reference
N/A (Greenfield Setup)

### Pre-Planning Decisions & Constraints
None

## 2. Remote Repositories & Knowledge Links
*   **Primary Remote Git Origin**: file://MOCK_REMOTE
*   **Documentation Repository**: None
*   **Additional Remote Repositories**: None

## 3. Workspace Folder Map
*   **Control Plane Root**: `agent-workspace/`
*   **Rules & Governance**: `agent-workspace/.agents/rules/`
*   **Workflows & Playbooks**: `agent-workspace/.agents/workflows/`
*   **Active Plan Directory**: `agent-workspace/plans/initial/`
*   **Staging Directories**: `agent-workspace/docs/`, `agent-workspace/src/`
SUMMARY

# S6: Remote Setup & Hook Installation
git remote add origin "$REMOTE_REPO_PATH"
cp "${SCRIPT_DIR}/../guards/hooks/pre-commit-plan-validator.sh" .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# S7: Initial Commit & Push
git add agent-workspace/
git commit -m "chore(init): bootstrap agent control plane and documentation" >/dev/null 2>&1
git push -u origin initial >/dev/null 2>&1

echo "--> Scenario A Scaffolding complete. Running Assertions..."

# Assertion A1: Branch Check
BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "initial" ]; then
    echo "[PASS A1] Git Branch is 'initial'"
else
    echo "[FAIL A1] Git Branch is '$BRANCH' (expected 'initial')"
    ERRORS=$((ERRORS+1))
fi

# Assertion A2: Audit Log & Mode Check
if grep -q "mode: major_feature" agent-workspace/plans/initial/GRILL_STATUS.md && grep -q "Q5 Primary Remote Origin" agent-workspace/plans/initial/GRILL_STATUS.md; then
    echo "[PASS A2] GRILL_STATUS.md has mode: major_feature and Q5 remote origin"
else
    echo "[FAIL A2] GRILL_STATUS.md missing mode or Q5 entry"
    ERRORS=$((ERRORS+1))
fi

# Assertion A3: Process Status Matrix Check
if [ -f agent-workspace/plans/initial/PROCESS_STATUS.md ]; then
    echo "[PASS A3] PROCESS_STATUS.md present in initial/"
else
    echo "[FAIL A3] PROCESS_STATUS.md missing in initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A4: Phase 1 Summary Check
if [ -f agent-workspace/plans/initial/phase-1-summary.md ]; then
    echo "[PASS A4] phase-1-summary.md present in initial/"
else
    echo "[FAIL A4] phase-1-summary.md missing in initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A5: .gitkeep in all control and staging directories
GITKEEP_OK=1
for dir in rules workflows skills hooks sidecars; do
    if [ ! -f "agent-workspace/.agents/$dir/.gitkeep" ]; then
        echo "[FAIL A5] .gitkeep missing in agent-workspace/.agents/$dir/"
        GITKEEP_OK=0
    fi
done
if [ ! -f "agent-workspace/docs/.gitkeep" ] || [ ! -f "agent-workspace/src/.gitkeep" ]; then
    echo "[FAIL A5] .gitkeep missing in agent-workspace/docs/ or src/"
    GITKEEP_OK=0
fi

if [ $GITKEEP_OK -eq 1 ]; then
    echo "[PASS A5] .gitkeep present in all control and staging directories"
else
    ERRORS=$((ERRORS+1))
fi

# Assertion A6: No codebase-* sub-repositories created during /init
if [ ! -d codebase-devops ] && [ ! -d codebase-layout ] && [ ! -d codebase-engine ]; then
    echo "[PASS A6] Pure control plane asserted: No codebase-* sub-repositories created during /init"
else
    echo "[FAIL A6] codebase-* directories were created during /init!"
    ERRORS=$((ERRORS+1))
fi

# Assertion A7: Remote Origin Configuration & Push
REMOTE_URL=$(git remote get-url origin 2>/dev/null || true)
if [ "$REMOTE_URL" = "$REMOTE_REPO_PATH" ]; then
    echo "[PASS A7] Remote origin configured correctly ($REMOTE_URL)"
else
    echo "[FAIL A7] Remote origin URL mismatch: '$REMOTE_URL'"
    ERRORS=$((ERRORS+1))
fi

# Verify remote repository received the push
if git ls-remote --heads origin initial | grep -q "refs/heads/initial"; then
    echo "[PASS A8] Initial commit successfully pushed to remote origin"
else
    echo "[FAIL A8] Remote origin does not contain branch 'initial'"
    ERRORS=$((ERRORS+1))
fi

# Assertion A9: Pre-commit Hook Execution
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "[PASS A9] Pre-commit hook passed validation on initial branch"
else
    echo "[FAIL A9] Pre-commit hook failed validation on initial branch"
    ERRORS=$((ERRORS+1))
fi


# ==============================================================================
# SCENARIO B: Quick & Simple / Bugfix Setup (3-Question Fast Track)
# ==============================================================================
echo ""
echo "========================================================================"
echo ">>> SCENARIO B: Quick & Simple Mode (Bugfix / Minor Change)"
echo "========================================================================"

# S1 & S2: Mode Gate -> Quick & Simple selected
# Branch origination: branch creates from initial
git checkout -b bugfix/fix-checkout-button >/dev/null 2>&1

# S5: Scaffolding feature plan directory
mkdir -p agent-workspace/plans/fix-checkout-button

# Write QS1-QS3 transcript
cat << 'LOG' > agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md
# GRILL_STATUS Audit Log
mode: quick_simple
feature_name: fix-checkout-button
branch: bugfix/fix-checkout-button
QS1 Aim & Reason: Fix checkout button alignment on mobile view — button overflows container on screens < 375px
QS2 Issue Reference: GitHub Issue #142 — Checkout button overflow on mobile
QS3 Pre-Planning Decisions: None (Proceed with initialization)
Node S4 Execution Acceptance: Accepted
LOG

cat << 'STATUS' > agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md
# Process Status Matrix
**Target Release/Feature**: fix-checkout-button
**Git Branch**: bugfix/fix-checkout-button
**Date**: 2026-08-19
**Active Workflow**: /init

## Block 1: Workflow Execution Matrix
| Step | Workflow Stage | Status | Assigned Plan / Artifact | Next Action |
| :--- | :--- | :--- | :--- | :--- |
| **1** | `/init` | Completed | `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` | Proceed to `/plan` |
| **2** | `/process` | Skipped | N/A (Quick & Simple bugfix) | N/A |
| **3** | `/plan` | In Progress | `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` | Execute Phase 1 |
| 3.1 | -- Phase 1: Summary | In Progress | `phase-1-summary.md` | Draft Scope & Goals |
| 3.2 | -- Phase 2: Layout | Pending | `phase-2-layout.md` | Pending |
| 3.3 | -- Phase 3: Data | Pending | `phase-3-data.md` | Pending |
| 3.4 | -- Phase 4: Engine | Pending | `phase-4-engine.md` | Pending |
| 3.5 | -- Phase 5: Test | Pending | `phase-5-test.md` | Pending |
| 3.6 | -- Phase 6: Operation | Pending | `phase-6-operation.md` | Pending |
| **4** | `/implement` | Pending | Codebase Implementation | Pending |
| **5** | `/qualify` | Pending | Release Qualification | Pending |
| **6** | `/release` | Pending | Release Tag & Merge | Pending |

## Block 2: Daily Execution History
### [2026-08-19]
- **Action**: Executed `/init` workflow in Quick & Simple mode.
- **Result**: Scaffolded agent-workspace/plans/fix-checkout-button/ and prepared for planning.
STATUS

cat << 'SUMMARY' > agent-workspace/plans/fix-checkout-button/phase-1-summary.md
# Phase 1 Summary Blueprint: Project & Feature Overview
**Project / Feature Name**: fix-checkout-button
**Branch**: bugfix/fix-checkout-button
**Date**: 2026-08-19
**Mode**: quick_simple

## 1. Executive Summary & Change Scope
### Aim & Purpose
Fix checkout button alignment on mobile view — button overflows container on screens < 375px.

### Issue & Ticket Reference
GitHub Issue #142 — Checkout button overflow on mobile

### Pre-Planning Decisions & Constraints
None

## 2. Remote Repositories & Knowledge Links
*   **Primary Remote Git Origin**: file://MOCK_REMOTE
*   **Documentation Repository**: None
*   **Additional Remote Repositories**: None

## 3. Workspace Folder Map
*   **Control Plane Root**: `agent-workspace/`
*   **Rules & Governance**: `agent-workspace/.agents/rules/`
*   **Workflows & Playbooks**: `agent-workspace/.agents/workflows/`
*   **Active Plan Directory**: `agent-workspace/plans/fix-checkout-button/`
*   **Staging Directories**: `agent-workspace/docs/`, `agent-workspace/src/`
SUMMARY

echo "--> Scenario B Scaffolding complete. Running Assertions..."

# Assertion B1: Branch Check
BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "bugfix/fix-checkout-button" ]; then
    echo "[PASS B1] Git Branch is 'bugfix/fix-checkout-button'"
else
    echo "[FAIL B1] Git Branch is '$BRANCH' (expected 'bugfix/fix-checkout-button')"
    ERRORS=$((ERRORS+1))
fi

# Assertion B2: Audit Log & Mode Check
if grep -q "mode: quick_simple" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md; then
    echo "[PASS B2] Feature GRILL_STATUS.md has mode: quick_simple"
else
    echo "[FAIL B2] Feature GRILL_STATUS.md missing mode: quick_simple"
    ERRORS=$((ERRORS+1))
fi

# Assertion B3: Issue Reference in phase-1-summary.md
if grep -q "#142" agent-workspace/plans/fix-checkout-button/phase-1-summary.md; then
    echo "[PASS B3] Issue reference (#142) present in feature phase-1-summary.md"
else
    echo "[FAIL B3] Issue reference missing in feature phase-1-summary.md"
    ERRORS=$((ERRORS+1))
fi

# Assertion B4: No Redundant Sub-Repositories Created
if [ ! -d codebase-fix-checkout-button ] && [ ! -d codebase-bugfix ]; then
    echo "[PASS B4] No redundant sub-repositories created for Quick & Simple mode"
else
    echo "[FAIL B4] Redundant sub-repositories were created!"
    ERRORS=$((ERRORS+1))
fi

# Assertion B5: Pre-commit Hook Check on Bugfix Branch
git add agent-workspace/plans/fix-checkout-button/
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "[PASS B5] Pre-commit hook passed validation on bugfix branch"
else
    echo "[FAIL B5] Pre-commit hook failed validation on bugfix branch"
    ERRORS=$((ERRORS+1))
fi

echo ""
echo "--------------------------------------------------------"
if [ $ERRORS -eq 0 ]; then
    echo "=== ALL E2E TEST ASSERTIONS (SCENARIOS A & B) PASSED SUCCESSFULLY! ==="
    # Clean up test sandbox
    rm -rf "$RM_PATH" "$REMOTE_REPO_PATH"
    exit 0
else
    echo "=== E2E TEST SUITE FAILED WITH $ERRORS ERROR(S) ==="
    exit 1
fi
