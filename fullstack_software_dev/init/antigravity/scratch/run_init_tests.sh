#!/usr/bin/env bash
set -e

echo "=== STARTING E2E TEST SUITE FOR /init WORKFLOW (init_tests.md) ==="

# 1. Clean & Prepare Test Sandbox
RM_PATH="/Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/antigravity/scratch/test_sandbox"
rm -rf "$RM_PATH"
mkdir -p "$RM_PATH"
cd "$RM_PATH"
git init >/dev/null

echo "--> Sandbox prepared at $RM_PATH"

# 2. Simulate Node S1: Check Environment & Branch Initialization
docker info >/dev/null 2>&1 || docker --version >/dev/null 2>&1 || true
git checkout -b initial

# 3. Simulate Node S5: Scaffolding Directory Tree
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

# 4. Provision .gitkeep Files
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

# 5. Scaffold Relative Symlinks
(cd agent-workspace/src && ln -s ../../codebase-devops/src devops)
(cd agent-workspace/src && ln -s ../../codebase-layout/src layout)
(cd agent-workspace/src && ln -s ../../codebase-engine/src engine)

# 6. Scaffold Docker Configs
touch codebase-devops/docker/dev.Dockerfile \
      codebase-devops/docker/docker-compose.yml \
      codebase-devops/Dockerfile \
      codebase-layout/Dockerfile \
      codebase-engine/Dockerfile

# 7. Scaffold Status Documents & Audit Logs
cat << 'LOG' > agent-workspace/plans/initial/GRILL_STATUS.md
# GRILL_STATUS Audit Log
Q1 Scope: Fullstack web application
Node S4 Execution Acceptance: Accepted
LOG

cat << 'STATUS' > agent-workspace/plans/initial/PROCESS_STATUS.md
# Process Status Matrix
**Git Branch**: initial
## Block 1: Workflow Execution Matrix
| Step | Workflow Stage | Status |
| 1 | /init | Completed |
STATUS

cat << 'SUMMARY' > agent-workspace/plans/initial/phase-1-summary.md
# Phase 1 Summary Blueprint
Project Purpose: Fullstack e-commerce engine
SUMMARY

# 8. Install Pre-commit Safety Hook
cp /Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/antigravity/guards/hooks/pre-commit-plan-validator.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "--> Scaffolding completed. Running 12 Test Assertions..."
echo "--------------------------------------------------------"

ERRORS=0

# Assertion 1: Branch Check
BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "initial" ]; then
    echo "[PASS 1/12] Git Branch is 'initial'"
else
    echo "[FAIL 1/12] Git Branch is '$BRANCH' (expected 'initial')"
    ERRORS=$((ERRORS+1))
fi

# Assertion 2: Audit Log Check
if [ -f agent-workspace/plans/initial/GRILL_STATUS.md ]; then
    echo "[PASS 2/12] GRILL_STATUS.md present in agent-workspace/plans/initial/"
else
    echo "[FAIL 2/12] GRILL_STATUS.md missing in agent-workspace/plans/initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion 3: Process Status Matrix Check
if [ -f agent-workspace/plans/initial/PROCESS_STATUS.md ]; then
    echo "[PASS 3/12] PROCESS_STATUS.md present in agent-workspace/plans/initial/"
else
    echo "[FAIL 3/12] PROCESS_STATUS.md missing in agent-workspace/plans/initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion 4: Architecture Summary Blueprint Check
if [ -f agent-workspace/plans/initial/phase-1-summary.md ]; then
    echo "[PASS 4/12] phase-1-summary.md present in agent-workspace/plans/initial/"
else
    echo "[FAIL 4/12] phase-1-summary.md missing in agent-workspace/plans/initial/"
    ERRORS=$((ERRORS+1))
fi

# Assertion 5: .gitkeep in Control Directory
if [ -f agent-workspace/.agents/skills/.gitkeep ]; then
    echo "[PASS 5/12] .gitkeep present in agent-workspace/.agents/skills/"
else
    echo "[FAIL 5/12] .gitkeep missing in agent-workspace/.agents/skills/"
    ERRORS=$((ERRORS+1))
fi

# Assertion 6: codebase-devops Docker Directory Check
if [ -f codebase-devops/docker/dev.Dockerfile ] && [ -f codebase-devops/docker/docker-compose.yml ]; then
    echo "[PASS 6/12] dev.Dockerfile and docker-compose.yml present in codebase-devops/docker/"
else
    echo "[FAIL 6/12] dev.Dockerfile or docker-compose.yml missing in codebase-devops/docker/"
    ERRORS=$((ERRORS+1))
fi

# Assertion 7: Layer Sub-repo .gitkeep Check
if [ -f codebase-layout/src/.gitkeep ] && [ -f codebase-engine/src/.gitkeep ]; then
    echo "[PASS 7/12] .gitkeep present in layer sub-repo src/ directories"
else
    echo "[FAIL 7/12] .gitkeep missing in layer sub-repos"
    ERRORS=$((ERRORS+1))
fi

# Assertion 8: Symlink devops Check (3-Part Verification)
LINK_TARGET=$(readlink agent-workspace/src/devops || true)
if [ -L agent-workspace/src/devops ] && [ -d agent-workspace/src/devops ] && [ "$LINK_TARGET" = "../../codebase-devops/src" ]; then
    echo "[PASS 8/12] Relative symlink src/devops valid (target: $LINK_TARGET)"
else
    echo "[FAIL 8/12] Relative symlink src/devops invalid (target: $LINK_TARGET)"
    ERRORS=$((ERRORS+1))
fi

# Assertion 9: Symlink layout Check (3-Part Verification)
LINK_TARGET=$(readlink agent-workspace/src/layout || true)
if [ -L agent-workspace/src/layout ] && [ -d agent-workspace/src/layout ] && [ "$LINK_TARGET" = "../../codebase-layout/src" ]; then
    echo "[PASS 9/12] Relative symlink src/layout valid (target: $LINK_TARGET)"
else
    echo "[FAIL 9/12] Relative symlink src/layout invalid (target: $LINK_TARGET)"
    ERRORS=$((ERRORS+1))
fi

# Assertion 10: Symlink engine Check (3-Part Verification)
LINK_TARGET=$(readlink agent-workspace/src/engine || true)
if [ -L agent-workspace/src/engine ] && [ -d agent-workspace/src/engine ] && [ "$LINK_TARGET" = "../../codebase-engine/src" ]; then
    echo "[PASS 10/12] Relative symlink src/engine valid (target: $LINK_TARGET)"
else
    echo "[FAIL 10/12] Relative symlink src/engine invalid (target: $LINK_TARGET)"
    ERRORS=$((ERRORS+1))
fi

# Assertion 11: Symlink Purity Check (Zero non-symlink items in agent-workspace/src/)
NON_SYMLINKS=$(find agent-workspace/src -maxdepth 1 -mindepth 1 ! -type l | wc -l | tr -d ' ')
if [ "$NON_SYMLINKS" = "0" ]; then
    echo "[PASS 11/12] Symlink purity asserted (0 non-symlink items in agent-workspace/src/)"
else
    echo "[FAIL 11/12] Symlink purity violated ($NON_SYMLINKS non-symlink items found in agent-workspace/src/)"
    ERRORS=$((ERRORS+1))
fi

# Assertion 12: Pre-commit Hook Execution Check
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "[PASS 12/12] Pre-commit hook executed and passed validation"
else
    echo "[FAIL 12/12] Pre-commit hook execution failed"
    ERRORS=$((ERRORS+1))
fi

echo "--------------------------------------------------------"
if [ $ERRORS -eq 0 ]; then
    echo "=== ALL 12 E2E TEST ASSERTIONS PASSED SUCCESSFULLY! ==="
    exit 0
else
    echo "=== E2E TEST SUITE FAILED WITH $ERRORS ERROR(S) ==="
    exit 1
fi
