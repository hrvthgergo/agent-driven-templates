#!/usr/bin/env bash
set -e

FEATURE_NAME=$(git branch --show-current 2>/dev/null | sed 's/feature\///' || true)
if [ -z "$FEATURE_NAME" ] || [ "$FEATURE_NAME" = "main" ] || [ "$FEATURE_NAME" = "master" ]; then
    # Fallback to scanning active feature directory in agent-workspace/plans/
    PLAN_DIR=$(find agent-workspace/plans/ -mindepth 1 -maxdepth 1 -type d ! -name "initial" 2>/dev/null | head -n 1 || true)
else
    PLAN_DIR="agent-workspace/plans/${FEATURE_NAME}"
fi

if [ -z "$PLAN_DIR" ] || [ ! -d "$PLAN_DIR" ]; then
    # If no feature planning directory is active, pass
    exit 0
fi

# 1. Verify PROCESS_STATUS.md exists
if [ ! -f "${PLAN_DIR}/PROCESS_STATUS.md" ]; then
    echo "ERROR: PROCESS_STATUS.md not found in ${PLAN_DIR}"
    exit 1
fi

# 2. Verify phase-1-summary.md exists
if [ ! -f "${PLAN_DIR}/phase-1-summary.md" ]; then
    echo "ERROR: phase-1-summary.md not found in ${PLAN_DIR}"
    exit 1
fi

# 3. If phase-5-test.md exists, verify all cited SC-* scenario files exist
if [ -f "${PLAN_DIR}/phase-5-test.md" ]; then
    SCENARIO_IDS=$(grep -oE 'SC-[A-Za-z0-9_-]+-[0-9]+' "${PLAN_DIR}/phase-5-test.md" | sort -u || true)
    for SC_ID in $SCENARIO_IDS; do
        SC_FILE="agent-workspace/tests/scenarios/${SC_ID}.md"
        if [ ! -f "$SC_FILE" ]; then
            echo "ERROR: Scenario file ${SC_FILE} cited in phase-5-test.md does not exist"
            exit 1
        fi
    done
fi

# 4. Check if any source code or test harness files were modified during /plan
MODIFIED_CODE=$(git diff --cached --name-only 2>/dev/null | grep -E '^(src/|codebase-)' || true)
if [ -n "$MODIFIED_CODE" ]; then
    echo "ERROR: Source code or test harness modifications are strictly forbidden during /plan:"
    echo "$MODIFIED_CODE"
    exit 1
fi

echo "Plan validation passed successfully."
exit 0
