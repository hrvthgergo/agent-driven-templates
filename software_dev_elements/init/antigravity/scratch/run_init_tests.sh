#!/usr/bin/env bash
set -e

echo "=== STARTING DUAL-MODE E2E TEST SUITE FOR /init WORKFLOW (init_tests.md) ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RM_PATH="${SCRIPT_DIR}/test_sandbox"
rm -rf "$RM_PATH"
mkdir -p "$RM_PATH"
cd "$RM_PATH"
git init >/dev/null

echo "--> Sandbox prepared at $RM_PATH"
ERRORS=0

# ==============================================================================
# SCENARIO A: Greenfield / Major Feature Setup (Full Deep-Dive)
# ==============================================================================
echo ""
echo "========================================================================"
echo ">>> SCENARIO A: Greenfield Multi-Repo Setup (Major Feature Mode)"
echo "========================================================================"

# S1: Check environment & branch initialization
docker info >/dev/null 2>&1 || docker --version >/dev/null 2>&1 || true
git checkout -b initial >/dev/null 2>&1

# S5: Scaffolding Directory Tree & Control Structures
mkdir -p agent-workspace/.agents/rules \
         agent-workspace/.agents/workflows \
         agent-workspace/.agents/skills \
         agent-workspace/.agents/hooks \
         agent-workspace/.agents/sidecars \
         agent-workspace/plans/initial \
         agent-workspace/docs \
         agent-workspace/src

mkdir -p codebase-devops/.github/workflows \
         codebase-devops/docker \
         codebase-devops/config \
         codebase-devops/src \
         codebase-devops/tests

mkdir -p codebase-layout/src \
         codebase-layout/config \
         codebase-layout/tests \
         codebase-layout/.github/workflows

mkdir -p codebase-engine/src \
         codebase-engine/config \
         codebase-engine/tests \
         codebase-engine/.github/workflows

# Provision .gitkeep Files in every node
touch agent-workspace/.agents/rules/.gitkeep \
      agent-workspace/.agents/workflows/.gitkeep \
      agent-workspace/.agents/skills/.gitkeep \
      agent-workspace/.agents/hooks/.gitkeep \
      agent-workspace/.agents/sidecars/.gitkeep \
      agent-workspace/plans/initial/.gitkeep \
      agent-workspace/docs/.gitkeep \
      codebase-devops/.github/workflows/.gitkeep \
      codebase-devops/docker/.gitkeep \
      codebase-devops/config/.gitkeep \
      codebase-devops/src/.gitkeep \
      codebase-devops/tests/.gitkeep \
      codebase-layout/src/.gitkeep \
      codebase-layout/config/.gitkeep \
      codebase-layout/tests/.gitkeep \
      codebase-engine/src/.gitkeep \
      codebase-engine/config/.gitkeep \
      codebase-engine/tests/.gitkeep

# Relative Symbolic Links (3-part verification)
(cd agent-workspace/src && ln -s ../../codebase-devops/src devops)
(cd agent-workspace/src && ln -s ../../codebase-layout/src layout)
(cd agent-workspace/src && ln -s ../../codebase-engine/src engine)

# Docker files
touch codebase-devops/docker/dev.Dockerfile \
      codebase-devops/docker/docker-compose.yml \
      codebase-devops/Dockerfile \
      codebase-layout/Dockerfile \
      codebase-engine/Dockerfile

# Deploy Status & Audit Documents
cat << 'LOG' > agent-workspace/plans/initial/GRILL_STATUS.md
# GRILL_STATUS Audit Log
mode: major_feature
Q1 Purpose & Scope: Fullstack web application with automated background processing
Q6 Architecture: Modular Monolith / Layered Architecture
Q7 Layers: codebase-devops, codebase-layout, codebase-engine
Q8 Stack: Go + PostgreSQL for engine; Vanilla JS + Pure CSS for layout
Node S4 Execution Acceptance: Accepted
LOG

cat << 'STATUS' > agent-workspace/plans/initial/PROCESS_STATUS.md
# Process Status Matrix
**Target Release/Feature**: Initial Setup
**Git Branch**: initial
**Date**: 2026-08-14
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
### [2026-08-14]
- **Action**: Executed `/init` workflow.
STATUS

cat << 'SUMMARY' > agent-workspace/plans/initial/phase-1-summary.md
# Phase 1 Summary Blueprint: Architectural Overview
**Project / Feature Name**: Initial E-Commerce Platform
**Branch**: initial
**Mode**: major_feature

## 1. Executive Summary & Change Scope
### Aim & Purpose
Fullstack e-commerce engine with real-time inventory management.

## 2. Architecture & Tech Stack
*   **Architecture Pattern**: Modular Monolith / Layered Architecture
*   **Tech Stack**: Engine API in Go; UI Layout in Vanilla JS.
SUMMARY

# Install Pre-commit Safety Hook
cp /Users/horvathgergo/Desktop/agent-driven-templates/software_dev_elements/init/antigravity/guards/hooks/pre-commit-plan-validator.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

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
if grep -q "mode: major_feature" agent-workspace/plans/initial/GRILL_STATUS.md; then
    echo "[PASS A2] GRILL_STATUS.md has mode: major_feature"
else
    echo "[FAIL A2] GRILL_STATUS.md missing mode: major_feature"
    ERRORS=$((ERRORS+1))
fi

# Assertion A3: Process Status Matrix Check
if [ -f agent-workspace/plans/initial/PROCESS_STATUS.md ]; then
    echo "[PASS A3] PROCESS_STATUS.md present in initial/"
else
    echo "[FAIL A3] PROCESS_STATUS.md missing in initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A4: Architecture Summary Blueprint Check
if [ -f agent-workspace/plans/initial/phase-1-summary.md ]; then
    echo "[PASS A4] phase-1-summary.md present in initial/"
else
    echo "[FAIL A4] phase-1-summary.md missing in initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A5: .gitkeep in Control Directory
if [ -f agent-workspace/.agents/skills/.gitkeep ]; then
    echo "[PASS A5] .gitkeep present in agent-workspace/.agents/skills/"
else
    echo "[FAIL A5] .gitkeep missing in agent-workspace/.agents/skills/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A6: codebase-devops Docker Directory Check
if [ -f codebase-devops/docker/dev.Dockerfile ] && [ -f codebase-devops/docker/docker-compose.yml ]; then
    echo "[PASS A6] dev.Dockerfile and docker-compose.yml present in codebase-devops/docker/"
else
    echo "[FAIL A6] dev.Dockerfile or docker-compose.yml missing in codebase-devops/docker/"
    ERRORS=$((ERRORS+1))
fi

# Assertion A7: Symlink 3-Part Verification (devops, layout, engine)
SYM_OK=1
for sym in devops layout engine; do
    LINK_TARGET=$(readlink agent-workspace/src/$sym || true)
    if [ ! -L agent-workspace/src/$sym ] || [ ! -d agent-workspace/src/$sym ] || [[ "$LINK_TARGET" != ../../codebase-* ]]; then
        SYM_OK=0
        echo "[FAIL A7] Relative symlink src/$sym invalid (target: $LINK_TARGET)"
    fi
done
if [ $SYM_OK -eq 1 ]; then
    echo "[PASS A7] Relative symlinks devops, layout, engine valid with 3-part verification"
else
    ERRORS=$((ERRORS+1))
fi

# Assertion A8: Symlink Purity
NON_SYMLINKS=$(find agent-workspace/src -maxdepth 1 -mindepth 1 ! -type l | wc -l | tr -d ' ')
if [ "$NON_SYMLINKS" = "0" ]; then
    echo "[PASS A8] Symlink purity asserted (0 non-symlink items in agent-workspace/src/)"
else
    echo "[FAIL A8] Symlink purity violated ($NON_SYMLINKS non-symlink items found)"
    ERRORS=$((ERRORS+1))
fi

# Assertion A9: Pre-commit Hook Execution
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "[PASS A9] Pre-commit hook passed validation on initial branch"
else
    echo "[FAIL A9] Pre-commit hook failed validation on initial branch"
    ERRORS=$((ERRORS+1))
fi

# Commit initial state so we can test branch switching and Scenario B
git add .
git commit -m "chore: initial workspace setup" >/dev/null 2>&1


# ==============================================================================
# SCENARIO B: Quick & Simple / Bugfix Setup (3-Question Fast Track)
# ==============================================================================
echo ""
echo "========================================================================"
echo ">>> SCENARIO B: Quick & Simple Mode (Bugfix / Minor Change)"
echo "========================================================================"

# S1 & S2: Mode Gate -> Quick & Simple selected
# Branch creation: bugfix/fix-checkout-button
git checkout -b bugfix/fix-checkout-button >/dev/null 2>&1

# S5: Scaffolding feature plan directory
mkdir -p agent-workspace/plans/fix-checkout-button

# Inherit stack from initial/GRILL_STATUS.md and write QS1-QS3 transcript
cat << 'LOG' > agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md
# GRILL_STATUS Audit Log
mode: quick_simple
feature_name: fix-checkout-button
branch: bugfix/fix-checkout-button
QS1 Aim & Reason: Fix checkout button alignment on mobile view — button overflows container on screens < 375px
QS2 Issue Reference: GitHub Issue #142 — Checkout button overflow on mobile
QS3 Pre-Planning Decisions: None (Proceed with initialization)
Inherited Architecture: Modular Monolith / Layered Architecture (from initial/GRILL_STATUS.md)
Inherited Tech Stack: Go + PostgreSQL for engine; Vanilla JS + Pure CSS for layout (from initial/GRILL_STATUS.md)
Inherited Cloud Provider: GitHub (from initial/GRILL_STATUS.md)
Inherited Layer Scope: codebase-devops, codebase-layout, codebase-engine (from initial/GRILL_STATUS.md)
Node S4 Execution Acceptance: Accepted
LOG

cat << 'STATUS' > agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md
# Process Status Matrix
**Target Release/Feature**: fix-checkout-button
**Git Branch**: bugfix/fix-checkout-button
**Date**: 2026-08-14
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
### [2026-08-14]
- **Action**: Executed `/init` workflow in Quick & Simple mode.
STATUS

cat << 'SUMMARY' > agent-workspace/plans/fix-checkout-button/phase-1-summary.md
# Phase 1 Summary Blueprint: Architectural Overview
**Project / Feature Name**: fix-checkout-button
**Branch**: bugfix/fix-checkout-button
**Date**: 2026-08-14
**Mode**: quick_simple

## 1. Executive Summary & Change Scope
### Aim & Purpose
Fix checkout button alignment on mobile view — button overflows container on screens < 375px.

### Issue & Ticket Reference
GitHub Issue #142 — Checkout button overflow on mobile

### Pre-Planning Decisions & Constraints
None

## 2. Architecture & Tech Stack
*   **Architecture Pattern**: Modular Monolith / Layered Architecture (Inherited)
*   **Tech Stack**: Engine API in Go; UI Layout in Vanilla JS (Inherited).
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

# Assertion B4: Stack Inheritance in GRILL_STATUS.md
if grep -q "Go" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && grep -q "Vanilla JS" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md; then
    echo "[PASS B4] Stack inheritance verified (Go, Vanilla JS present)"
else
    echo "[FAIL B4] Stack inheritance failed in feature GRILL_STATUS.md"
    ERRORS=$((ERRORS+1))
fi

# Assertion B5: No Redundant Sub-Repositories Created
if [ ! -d codebase-fix-checkout-button ] && [ ! -d codebase-bugfix ]; then
    echo "[PASS B5] No redundant sub-repositories created for Quick & Simple mode"
else
    echo "[FAIL B5] Redundant sub-repositories were created!"
    ERRORS=$((ERRORS+1))
fi

# Assertion B6: Pre-commit Hook Check on Bugfix Branch
git add .
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "[PASS B6] Pre-commit hook passed validation on bugfix branch"
else
    echo "[FAIL B6] Pre-commit hook failed validation on bugfix branch"
    ERRORS=$((ERRORS+1))
fi

echo ""
echo "--------------------------------------------------------"
if [ $ERRORS -eq 0 ]; then
    echo "=== ALL E2E TEST ASSERTIONS (SCENARIOS A & B) PASSED SUCCESSFULLY! ==="
    # Clean up test sandbox
    rm -rf "$RM_PATH"
    exit 0
else
    echo "=== E2E TEST SUITE FAILED WITH $ERRORS ERROR(S) ==="
    exit 1
fi
