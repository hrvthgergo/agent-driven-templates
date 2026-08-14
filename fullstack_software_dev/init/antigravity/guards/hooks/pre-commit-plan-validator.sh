#!/usr/bin/env bash
# Pre-Commit Plan Validator Safety Hook

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
    echo "ERROR: Pre-commit check failed. PROCESS_STATUS.md does not exist."
    exit 1
fi

if ! grep -q "Block 1: Workflow Execution Matrix" "$STATUS_FILE"; then
    echo "ERROR: Pre-commit check failed. PROCESS_STATUS.md missing Block 1 matrix."
    exit 1
fi

echo "Pre-commit check passed: Valid PROCESS_STATUS.md found at $STATUS_FILE."
exit 0
