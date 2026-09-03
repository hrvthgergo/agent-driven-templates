#!/usr/bin/env bash
# Deterministic Process Status Synchronization Tool
# Enforces Law III (WHEN) & Law V (WHY) of the Global Governor

set -e

WORKFLOW=""
SUB_PROCESS=""
STATUS=""
LOG_MSG=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --workflow)
            WORKFLOW="$2"
            shift 2
            ;;
        --sub-process)
            SUB_PROCESS="$2"
            shift 2
            ;;
        --status)
            STATUS="$2"
            shift 2
            ;;
        --log)
            LOG_MSG="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1"
            echo "Usage: $0 --workflow <init|process|plan|implement|qualify|operate> [--sub-process <3.1..3.6>] --status <not_started|in_progress|done|not_in_scope> --log \"<message>\""
            exit 1
            ;;
    esac
done

if [ -z "$WORKFLOW" ] || [ -z "$STATUS" ] || [ -z "$LOG_MSG" ]; then
    echo "ERROR: Missing required arguments."
    echo "Usage: $0 --workflow <init|process|plan|implement|qualify|operate> [--sub-process <3.1..3.6>] --status <not_started|in_progress|done|not_in_scope> --log \"<message>\""
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
    echo "ERROR: PROCESS_STATUS.md not found in agent-workspace/plans/."
    exit 1
fi

# Execute python updater for deterministic table and history manipulation
python3 - "$STATUS_FILE" "$WORKFLOW" "$SUB_PROCESS" "$STATUS" "$LOG_MSG" << 'EOF'
import re
import sys
from datetime import datetime

status_file = sys.argv[1]
workflow = sys.argv[2].lower()
sub_process = sys.argv[3].strip()
status_arg = sys.argv[4].lower()
log_msg = sys.argv[5].strip()

status_map = {
    "not_started": "`[ ] Not Started`",
    "in_progress": "`[>] In Progress`",
    "done": "`[x] Done`",
    "not_in_scope": "`[-] Not In Scope`"
}

if status_arg not in status_map:
    print(f"ERROR: Invalid status '{status_arg}'. Valid options: {list(status_map.keys())}")
    sys.exit(1)

new_token = status_map[status_arg]
today_str = datetime.now().strftime("%Y-%m-%d")
time_str = datetime.now().strftime("%H:%M")

with open(status_file, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Update Active Workflow header if status is in_progress
if status_arg == "in_progress" and not sub_process:
    content = re.sub(r"(\-\s*\*\*Active Workflow\*\*:\s*).*$", rf"\1/{workflow}", content, flags=re.MULTILINE)

# 2. Determine line to update in Block 1
lines = content.splitlines()
target_idx = -1

for i, line in enumerate(lines):
    if sub_process:
        if f"3.{sub_process}" in line or f"{sub_process} Phase" in line or f"**{sub_process}" in line:
            target_idx = i
            break
    else:
        # Match top-level workflow row e.g. **1. /init** or **/plan**
        if re.search(rf"\|\s*\*\*\d+\.\s*/{workflow}\*\*", line, re.IGNORECASE):
            target_idx = i
            break

if target_idx != -1:
    line = lines[target_idx]
    # Format is | Workflow / Sub-Process | Status | Focus / Artifact | Last Updated |
    cols = [c.strip() for c in line.split("|")]
    # cols[0] is empty, cols[1] is Name, cols[2] is Status, cols[3] is Focus, cols[4] is Date, cols[5] is empty
    if len(cols) >= 5:
        cols[2] = new_token
        cols[4] = today_str
        lines[target_idx] = " | ".join(cols)
    else:
        # Fallback regex substitution
        line = re.sub(r"\`\[.*?\] (Not Started|In Progress|Done|Not In Scope)\`", new_token, line)
        lines[target_idx] = line
else:
    print(f"WARNING: Target row for workflow='{workflow}', sub_process='{sub_process}' not found in matrix.")

# 3. Append to Block 2 Datestamped Daily Execution History
content_updated = "\n".join(lines)
date_header = f"### [{today_str}]"
event_target = f"/{workflow}" + (f" (Phase {sub_process})" if sub_process else "")
event_entry = f"- **[{time_str}] Status Update**: `{event_target}` -> {new_token}\n  - {log_msg}"

if "## Block 2: Datestamped Daily Execution History" in content_updated:
    parts = content_updated.split("## Block 2: Datestamped Daily Execution History")
    header_part = parts[0] + "## Block 2: Datestamped Daily Execution History"
    history_part = parts[1]
    
    if date_header in history_part:
        # Insert event under today's header
        subparts = history_part.split(date_header, 1)
        history_part = subparts[0] + date_header + "\n" + event_entry + subparts[1]
    else:
        # Add new date header at the top of Block 2
        history_part = "\n\n" + date_header + "\n" + event_entry + history_part
        
    content_updated = header_part + history_part
else:
    content_updated += f"\n\n## Block 2: Datestamped Daily Execution History\n\n{date_header}\n{event_entry}\n"

with open(status_file, "w", encoding="utf-8") as f:
    f.write(content_updated)

print(f"SUCCESS: {status_file} updated -> {event_target} = {new_token}")
EOF

# Automatically stage updated PROCESS_STATUS.md
git add "$STATUS_FILE"
echo "Staged $STATUS_FILE for upcoming commit."
exit 0
