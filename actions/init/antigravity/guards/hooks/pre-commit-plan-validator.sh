#!/usr/bin/env bash
# Pre-Commit Plan Validator Safety Hook
# Enforces Law III (WHEN): No code modifications in codebase-* if /plan is not Done.

set -e

BRANCH=$(git branch --show-current 2>/dev/null || echo "initial")
SHORT_BRANCH="${BRANCH#*/}" # Strips 'feature/', 'bugfix/', etc.

STATUS_FILE="agent-workspace/plans/${BRANCH}/PROCESS_STATUS.md"

if [ ! -f "$STATUS_FILE" ]; then
    STATUS_FILE="agent-workspace/plans/${SHORT_BRANCH}/PROCESS_STATUS.md"
fi

if [ ! -f "$STATUS_FILE" ]; then
    # Fallback search inside agent-workspace/plans/
    STATUS_FILE=$(find agent-workspace/plans/ -name "PROCESS_STATUS.md" 2>/dev/null | head -n 1)
fi

if [ -z "$STATUS_FILE" ] || [ ! -f "$STATUS_FILE" ]; then
    echo "ERROR (Law III): Pre-commit check failed. PROCESS_STATUS.md does not exist."
    exit 1
fi

if ! grep -q "Block 1: Workflow Execution Matrix" "$STATUS_FILE"; then
    echo "ERROR (Law III): Pre-commit check failed. PROCESS_STATUS.md missing Block 1 matrix."
    exit 1
fi

# ENFORCING LAW III: Process Sequencing Check
# If any codebase-* file is staged for commit, /plan MUST be [x] Done or [-] Not In Scope.
STAGED_CODEBASE_FILES=$(git diff --cached --name-only | grep -E '^codebase-' || true)

if [ -n "$STAGED_CODEBASE_FILES" ]; then
    # Check the status of /plan in PROCESS_STATUS.md
    PLAN_LINE=$(grep -E '^\s*\|\s*\*\*3\.\s*/plan\*\*' "$STATUS_FILE" || true)
    
    if [[ ! "$PLAN_LINE" == *"[x] Done"* ]] && [[ ! "$PLAN_LINE" == *"[-] Not In Scope"* ]]; then
        echo ""
        echo "🚨 GLOBAL GOVERNOR VIOLATION: Law III (WHEN) 🚨"
        echo "You are attempting to commit code to 'codebase-*', but '/plan' is not marked as '[x] Done'!"
        echo "Process Sequencing forbids implementation scaffolding without a completed architectural blueprint."
        echo "File violating rule:"
        echo "$STAGED_CODEBASE_FILES"
        echo ""
        echo "Please complete the /plan workflow or explicitly override via the God-Mode Protocol."
        exit 1
    fi
fi

echo "Pre-commit check passed: Law III verified. Valid PROCESS_STATUS.md found at $STATUS_FILE."
exit 0
