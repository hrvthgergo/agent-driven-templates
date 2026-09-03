#!/usr/bin/env bash
# Playbook Inter-Action Handoff Gatekeeper
# Enforces Law III (WHEN) of the Global Governor

set -e

COMPLETED_ACTION=""
NEXT_ACTION=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --completed-action)
            COMPLETED_ACTION="$2"
            shift 2
            ;;
        --next-action)
            NEXT_ACTION="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1"
            echo "Usage: $0 --completed-action <action> --next-action <action>"
            exit 1
            ;;
    esac
done

if [ -z "$COMPLETED_ACTION" ] || [ -z "$NEXT_ACTION" ]; then
    echo "ERROR: Missing required arguments."
    echo "Usage: $0 --completed-action <action> --next-action <action>"
    exit 1
fi

# Locate PROCESS_STATUS.md
BRANCH=$(git branch --show-current 2>/dev/null || echo "")
SHORT_BRANCH="${BRANCH#*/}"
STATUS_FILE=""

if [ -n "$BRANCH" ] && [ -f "agent-workspace/plans/${BRANCH}/PROCESS_STATUS.md" ]; then
    STATUS_FILE="agent-workspace/plans/${BRANCH}/PROCESS_STATUS.md"
elif [ -n "$SHORT_BRANCH" ] && [ -f "agent-workspace/plans/${SHORT_BRANCH}/PROCESS_STATUS.md" ]; then
    STATUS_FILE="agent-workspace/plans/${SHORT_BRANCH}/PROCESS_STATUS.md"
else
    STATUS_FILE=$(find agent-workspace/plans -name "PROCESS_STATUS.md" 2>/dev/null | head -n 1)
fi

if [ -z "$STATUS_FILE" ] || [ ! -f "$STATUS_FILE" ]; then
    echo "🚨 GLOBAL GOVERNOR VIOLATION: Law III (WHEN) 🚨"
    echo "Handoff Gatekeeper failed: PROCESS_STATUS.md does not exist."
    echo "Cannot transition to '/${NEXT_ACTION}' without verified state tracking."
    exit 1
fi

ACTION_CLEAN=$(echo "$COMPLETED_ACTION" | tr -d '/')

python3 - "$STATUS_FILE" "$ACTION_CLEAN" "$NEXT_ACTION" << 'EOF'
import re
import sys

status_file = sys.argv[1]
completed_action = sys.argv[2].lower()
next_action = sys.argv[3].lower().replace("/", "")

with open(status_file, "r", encoding="utf-8") as f:
    content = f.read()

# Locate row for completed_action
row_pattern = rf"\|\s*\*\*\d+\.\s*/{completed_action}\*\*\s*\|\s*([^\|]+)\|"
match = re.search(row_pattern, content, re.IGNORECASE)

if not match:
    print(f"🚨 GLOBAL GOVERNOR VIOLATION: Law III (WHEN) 🚨")
    print(f"Handoff Gatekeeper: Action '/{completed_action}' not found in {status_file} matrix.")
    sys.exit(1)

status_cell = match.group(1).strip()

# Acceptable handoff states
is_done = "[x] Done" in status_cell
is_out_of_scope = "[-] Not In Scope" in status_cell

if not (is_done or is_out_of_scope):
    print(f"")
    print(f"🚨 GLOBAL GOVERNOR VIOLATION: Law III (WHEN) 🚨")
    print(f"Inter-Action Handoff Failed!")
    print(f"Target Next Action:       /{next_action}")
    print(f"Preceding Action:         /{completed_action}")
    print(f"Current Recorded Status:  {status_cell}")
    print(f"")
    print(f"Playbook execution halted fail-closed.")
    print(f"Action '/{completed_action}' must be marked '[x] Done' (or '[-] Not In Scope') before '/{next_action}' can begin.")
    print(f"Please run './sync-process-status.sh --workflow {completed_action} --status done --log \"...\"' once verified.")
    print(f"")
    sys.exit(1)

print(f"HANDOFF VERIFIED: '/{completed_action}' is {status_cell}. Progression to '/{next_action}' approved.")
EOF

exit 0
