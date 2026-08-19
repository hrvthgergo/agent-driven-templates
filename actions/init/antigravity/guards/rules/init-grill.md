---
name: init-grill
description: Dual-mode neutral Q&A interview rule guard for project initialization
---

# `init-grill` Rule Guard

This rule guard governs the `/init` Grill-Me Q&A interview engine, enforcing unchangeable architecture baselines, dual-mode selection (Quick & Simple vs. Major Feature), neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines (No Questions Asked)

Zero questions are asked about this baseline during the `/init` interview regardless of selected mode:

1.  **Baseline 1: Pure Agent Control Plane (`agent-workspace/`) Layout**:
    *   `agent-workspace/` acts strictly as Control Plane & Knowledge Hub (`.agents/`, `plans/`, `docs/`, `src/`).
    *   Software layer skeletons (`codebase-*`) and container configurations are decoupled from `/init` and planned in `/plan` or linked in `/process`.

---

## 2. Prompting Laws

*   **Zero Bias**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally.
*   **Mandatory Free-Text**: Every multiple-choice question MUST include a final free-text input option (`Other / Free-text (...)`).
*   **Audit Persistence**: Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<branch_name>/GRILL_STATUS.md`.
*   **Workflow Context Notification**: Output turn banner quote `> 📍 **Active Workflow**: /init | **Scope**: <branch> | **Node**: <Node_ID>` on every interaction.

---

## 3. Mode Selection Gate (Q0)

*   **Greenfield First-Time Run**: If `agent-workspace/plans/initial/` does NOT exist, auto-select **Major Feature / Greenfield Mode** (skip Q0).
*   **Initialized Workspace**: Present Q0 mode selection prompt:
    *   *Prompt*: "What type of change are you initializing?"
    *   *Option 1*: Quick & Simple (Bugfix / Minor Change) — 3 focused questions (QS1–QS3).
    *   *Option 2*: Major Feature / Greenfield Setup — 7 interview questions (Q1–Q7).
    *   *Option 3*: Other / Free-text (Describe scope).
*   **Branch Auto-Detection**: If Git branch starts with `bugfix/`, `fix/`, `hotfix/`, or `patch/`, pre-select Quick & Simple Mode.

---

## 4. Quick & Simple Mode Questions (QS1 – QS3)

*   **QS1: Aim & Reason of the Change**:
    *   Capture summary of purpose, expected outcome, affected area, and feature/branch name (`fix-<name>` or `<feature-name>`).
*   **QS2: Issue & Bug Reference**:
    *   Option 1: Link issue (URL or ticket ID, e.g. `#142`, `JIRA-1055`).
    *   Option 2: No formal ticket — describe bug/issue in own words.
    *   Option 3: Other / Free-text (reproduction steps, error logs).
*   **QS3: Pre-Planning Decisions & Constraints**:
    *   Option 1: No — Proceed with initialization (no blockers).
    *   Option 2: Yes — Document constraints, breaking changes, or dependencies.
    *   Option 3: Other / Free-text (additional planning context).

---

## 5. Major Feature / Greenfield Mode Questions (Q1 – Q7)

*   **Q1: Project Scope, Purpose, & Milestones**: Ask high-level business goals and target release milestones. Auto-detect from `README.md` if available.
*   **Q2: Local System Folders & Existing Locations**:
    *   Q2.a (If folder exists): List local folder paths. Auto-detect remotes from `.git/config`.
    *   Q2.b (If no folder exists): Select folder creation strategy (current working directory or custom path).
*   **Q3: Remote / Cloud Documentation Repository**: Ask for external documentation links (Confluence, Notion, Wiki). If auto-scan fails, state scan failure before asking.
*   **Q4: Additional Remote Code Repositories**: Ask for secondary/additional remote repository URLs (Q4.a URL list).
*   **Q5: Primary Remote Git Origin & Provider**:
    *   Capture primary remote Git repository URL (e.g. `https://github.com/org/repo.git`) and provider type (GitHub, GitLab, Bitbucket, Other).
    *   This remote origin is configured in Node S6 and used in Node S7 to push the initial documentation and control plane commit.
*   **Q6: Agent Guidance, Rules, Skills, MCPs, & Hooks**: Select agentic control defaults (`.agents/` standards, custom skills, hooks, or MCP servers).
*   **Q7: Summary Verification & Reflection**: Present clean recap table of Q1–Q6 gathered choices for user verification, adjustment, or final approval.
