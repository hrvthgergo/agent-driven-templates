#!/usr/bin/env bash
# Pre-Commit Plan Validator Safety Hook

set -e

BRANCH=$(git branch --show-current 2>/dev/null || echo "feature")
FEATURE_NAME="${BRANCH#feature/}"
STATUS_FILE="agent-workspace/plans/${FEATURE_NAME}/PROCESS_STATUS.md"

if [ ! -f "$STATUS_FILE" ]; then
    # Fallback to locate any active feature PROCESS_STATUS.md
    STATUS_FILE=$(find agent-workspace/plans/ -name "PROCESS_STATUS.md" 2>/dev/null | head -n 1)
fi

if [ -z "$STATUS_FILE" ] || [ ! -f "$STATUS_FILE" ]; then
    echo "ERROR: Pre-commit plan validation failed. PROCESS_STATUS.md does not exist."
    exit 1
fi

if ! grep -q "Block 1: Workflow Execution Matrix" "$STATUS_FILE"; then
    echo "ERROR: Pre-commit plan validation failed. PROCESS_STATUS.md missing Block 1 matrix."
    exit 1
fi

# Assert that phase 1 summary blueprint exists for active feature
PLAN_DIR=$(dirname "$STATUS_FILE")
if [ ! -f "${PLAN_DIR}/phase-1-summary.md" ]; then
    echo "ERROR: Pre-commit plan validation failed. Mandatory phase-1-summary.md missing in ${PLAN_DIR}."
    exit 1
fi

echo "Pre-commit plan validation passed: Valid PROCESS_STATUS.md and phase-1-summary.md found in ${PLAN_DIR}."
exit 0
