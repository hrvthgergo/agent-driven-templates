#!/usr/bin/env bash
set -e

FEATURE_NAME=$(git branch --show-current | sed 's/feature\///')
PLAN_DIR="agent-workspace/plans/${FEATURE_NAME}"

# VerifyPROCESS_STATUS.md exists
if [ ! -f "${PLAN_DIR}/PROCESS_STATUS.md" ]; then
    echo "ERROR: PROCESS_STATUS.md not found in ${PLAN_DIR}"
    exit 1
fi

# Verify phase-1-summary.md exists
if [ ! -f "${PLAN_DIR}/phase-1-summary.md" ]; then
    echo "ERROR: phase-1-summary.md not found in ${PLAN_DIR}"
    exit 1
fi

# Check if any files in src/ or codebase-*/ were modified during /plan
MODIFIED_CODE=$(git diff --cached --name-only | grep -E '^(src|codebase-)' || true)
if [ ! -z "$MODIFIED_CODE" ]; then
    echo "ERROR: Source code modifications are not allowed during /plan"
    exit 1
fi

echo "Plan validation passed."
exit 0
