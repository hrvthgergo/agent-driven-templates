#!/usr/bin/env bash
# AGY Gatekeeper: OS-Level Enforcement of Law IV (WHERE)
# Wraps system commands to prevent the agent from writing out-of-bounds.

set -e

COMMAND=$1
TARGET_PATH=$2

if [ -z "$COMMAND" ] || [ -z "$TARGET_PATH" ]; then
    echo "Usage: ./agy-gatekeeper.sh <command> <target_path>"
    exit 1
fi

# Locate the active PROCESS_STATUS.md to determine the active workflow
STATUS_FILE=$(find agent-workspace/plans/ -name "PROCESS_STATUS.md" 2>/dev/null | head -n 1)

if [ -z "$STATUS_FILE" ]; then
    # No status file means we are in absolute infancy; allow /init commands to pass.
    ACTIVE_WORKFLOW="/init"
else
    # Extract the active workflow from the header (e.g., "- **Active Workflow**: /plan")
    ACTIVE_WORKFLOW=$(grep -E '^\-\s\*\*Active Workflow\*\*:' "$STATUS_FILE" | awk '{print $NF}' || echo "")
fi

# Function to block access and throw a Law IV error
block_access() {
    local folder=$1
    echo ""
    echo "🚨 GLOBAL GOVERNOR VIOLATION: Law IV (WHERE) 🚨"
    echo "The active workflow is '$ACTIVE_WORKFLOW'."
    echo "Under the Directory Authority Matrix, this workflow is physically [LOCKED] out of '$folder'."
    echo "Attempted command: $COMMAND $TARGET_PATH"
    echo "Access Denied."
    echo ""
    exit 1
}

# Determine the restricted scopes based on the active workflow
case "$ACTIVE_WORKFLOW" in
    "/init")
        # /init is LOCKED out of codebase-* repositories entirely.
        if [[ "$TARGET_PATH" == *"codebase-"* ]]; then
            block_access "codebase-*/"
        fi
        ;;
    "/plan")
        # /plan is LOCKED out of codebase-* production code and devops.
        if [[ "$TARGET_PATH" == *"codebase-"* ]]; then
            block_access "codebase-*/"
        fi
        ;;
    "/implement")
        # /implement is the sole provisioner for codebase-*.
        # However, it is LOCKED out of agent-workspace/tests/ (it builds harness in codebase-qualify, not the tests strategy directory)
        # Note: /implement creates implementation maps in agent-workspace/plans/
        if [[ "$TARGET_PATH" == *"agent-workspace/tests/"* ]]; then
            block_access "agent-workspace/tests/"
        fi
        ;;
    "/qualify")
        # /qualify is an auditor. It is LOCKED out of writing production logic.
        # Can read codebase-*, but if the command is a write command (mkdir, touch, echo >), block it.
        if [[ "$COMMAND" == "mkdir" ]] || [[ "$COMMAND" == "touch" ]] || [[ "$COMMAND" == "rm" ]]; then
            if [[ "$TARGET_PATH" == *"codebase-"* ]]; then
                # Specifically, qualify shouldn't write source code.
                if [[ "$TARGET_PATH" != *"QUALIFICATION_REPORT"* ]]; then
                    block_access "codebase-*/ (Write operation)"
                fi
            fi
        fi
        ;;
    "/operate")
        # /operate is LOCKED from touching agent-workspace/src and codebase-*/src (except devops/deploy configs)
        if [[ "$TARGET_PATH" == *"agent-workspace/src/"* ]] || [[ "$TARGET_PATH" == *"codebase-"*"/src/"* ]]; then
            block_access "source execution logic"
        fi
        ;;
esac

# If we get here, the action is permitted within the territorial matrix.
# Execute the original command
$COMMAND "$TARGET_PATH"
