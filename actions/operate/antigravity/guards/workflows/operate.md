---
name: operate
description: Delivery and Operations workflow for Guards framework in Antigravity
---

# Workflow: `/operate`

This is the stateful execution playbook for the Operations & Delivery phase of the Guards framework.

## Node O1 (Target & Environment Resolution)
- Parse `--env <name>` and `--version <vX.Y.Z>` flags.
- Load `agent-workspace/plans/<feature-name>/phase-6-operation.md` Section 0 to establish the target environment, its purpose, and its required entry gate.

## Node O2 (Entry Gate & Provenance Gate)
- **Entry Gate**: If the target environment requires `certification: full`, evaluate `QUALIFICATION_REPORT.md`. If provisional or absent, **halt fail-closed** and route to Grill Q3.
- **Provenance Gate**: If entry gate passes and certification is full, evaluate the current source state digest against the certified digest in `QUALIFICATION_REPORT.md`. If they mismatch, **halt fail-closed** and route to Grill Q4.

## Node O3 (Image Build & Immutable Tagging)
- Identity is keyed on source state. Check `WALKTHROUGH.md` history.
- If a match is found: Reuse the previously recorded digest and re-tag it to the new `<vX.Y.Z>`.
- If no match is found: Build fresh from the `/implement` Dockerfiles. Record the new digest.

## Node O4 (Delivery / Promotion)
- Promote the recorded, immutable digest to the target environment.
- If `phase-6-operation.md` §5 declares a post-delivery hook for this environment, execute it automatically. (No `--deploy` flag).

## Node O5 (Post-Deploy Observability & Health Assertion)
- Execute `skills/operate-deliver/SKILL.md` to:
  1. Assert signal presence.
  2. Ping health/readiness endpoints for their specified soak durations.
  3. Verify alert rule registrations.
- **Halt fail-closed** if any health assertion fails, and surface the unratified ops finding.

## Node O6 (Walkthrough Record & Ops Finding Capture)
- Write `agent-workspace/plans/<feature-name>/WALKTHROUGH.md` recording:
  - Gate results (Entry & Provenance).
  - Target environment, version, source state, and image digest.
  - Health assertion results.
  - Delivery actions and hooks fired.
  - Unratified ops findings (e.g., timeouts, missing signals) with `origin: operate`.

## Node O7 (PROCESS_STATUS.md Sync & Handoff)
- Update `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`: mark Row 6 (`/operate`) as `Completed`.
- Add a datestamped entry in Block 2.
- Recommend running `/init --feature <name>` or `/init --release <version>` to begin the Evolution Dialogue.

## Execution Modes
- `/operate`: Interactive default.
- `/operate --env <name>`: Target specific environment.
- `/operate --version <vX.Y.Z>`: Target specific version tag.
- `/operate --auto`: Automated execution without confirmation prompts (bypasses Q5).
- `/operate --dry-run`: Evaluate gates and output the delivery plan without pushing images or modifying Git tags.
