#!/usr/bin/env bash
# ==============================================================================
# Guards Framework Pre-Commit Validator Hook
# Location: .git/hooks/pre-commit
# Installed during: /init Step 6 (Node S6)
# ==============================================================================

set -e

echo "[GUARDS FRAMEWORK] Running Pre-Commit Plan Validator..."

PROCESS_STATUS_FILE=".agents/plans/PROCESS_STATUS.md"

# 1. Check if PROCESS_STATUS.md exists
if [ ! -f "$PROCESS_STATUS_FILE" ]; then
    echo "[ERROR] Pre-Commit Validation Failed: Missing required process status sheet: $PROCESS_STATUS_FILE"
    echo "Please run /init to bootstrap the Guards framework."
    exit 1
fi

# 2. Check if PROCESS_STATUS.md contains Block 1 and Block 2 headers
if ! grep -q "Block 1: Workflow Execution & Planning Matrix" "$PROCESS_STATUS_FILE"; then
    echo "[ERROR] Pre-Commit Validation Failed: $PROCESS_STATUS_FILE is missing Block 1 Matrix header."
    exit 1
fi

if ! grep -q "Block 2: Datestamped Daily Execution History" "$PROCESS_STATUS_FILE"; then
    echo "[ERROR] Pre-Commit Validation Failed: $PROCESS_STATUS_FILE is missing Block 2 History header."
    exit 1
fi

# 3. Check for Phase 1 Summary blueprint if /init or /plan is active
PHASE_1_SUMMARY=".agents/plans/phase-1-summary.md"
if [ ! -f "$PHASE_1_SUMMARY" ]; then
    echo "[ERROR] Pre-Commit Validation Failed: Missing required architecture summary: $PHASE_1_SUMMARY"
    exit 1
fi

echo "[GUARDS FRAMEWORK] Pre-Commit Plan Validation Passed Successfully!"
exit 0
