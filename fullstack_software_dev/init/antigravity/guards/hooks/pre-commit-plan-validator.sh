#!/usr/bin/env bash
# Pre-Commit Plan Validator Safety Hook

set -e

BRANCH=$(git branch --show-current 2>/dev/null || echo "initial")
STATUS_FILE="agent-workspace/plans/${BRANCH}/PROCESS_STATUS.md"

if [ ! -f "$STATUS_FILE" ]; then
    # Fallback to root or initial if branch folder not found
    STATUS_FILE=$(find agent-workspace/plans/ -name "PROCESS_STATUS.md" | head -n 1)
fi

if [ -z "$STATUS_FILE" ] || [ ! -f "$STATUS_FILE" ]; then
    echo "ERROR: Pre-commit check failed. PROCESS_STATUS.md does not exist."
    exit 1
fi

if ! grep -q "Block 1: Workflow Execution Matrix" "$STATUS_FILE"; then
    echo "ERROR: Pre-commit check failed. PROCESS_STATUS.md missing Block 1 matrix."
    exit 1
fi

echo "Pre-commit check passed: Valid PROCESS_STATUS.md found."
exit 0
