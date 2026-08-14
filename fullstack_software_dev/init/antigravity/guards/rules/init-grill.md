---
name: init-grill
description: Dual-mode neutral Q&A interview rule guard for project initialization
---

# `init-grill` Rule Guard

This rule guard governs the `/init` Grill-Me Q&A interview engine, enforcing unchangeable architecture baselines, dual-mode selection (Quick & Simple vs. Major Feature), neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines (No Questions Asked)

Zero questions are asked about these baselines during the `/init` interview regardless of selected mode:

1.  **Baseline 1: Hybrid Docker Handling Strategy**:
    *   `codebase-devops/docker/dev.Dockerfile`: Isolated agent execution sandbox environment.
    *   `codebase-devops/docker/docker-compose.yml`: Multi-service local orchestrator.
    *   `codebase-<layer_name>/Dockerfile`: Standalone production build specs per layer.
2.  **Baseline 2: Pure Control Plane (`agent-workspace/`) & Sub-Repository Layout**:
    *   `agent-workspace/` acts strictly as Control Plane & Knowledge Hub (`.agents/`, `plans/`, `docs/`, `src/`).
    *   Infrastructure code resides in `codebase-devops/`.
    *   Entry points in `agent-workspace/src/` are strictly pure relative symlinks (`devops`, `layout`, `engine` $\rightarrow$ `../../codebase-X/src`).

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
    *   *Option 1*: Quick & Simple (Bugfix / Minor Change) — 3 focused questions (QS1–QS3), inherits existing stack.
    *   *Option 2*: Major Feature / Full Architecture Setup — 10 deep-dive questions (Q1–Q10).
    *   *Option 3*: Other / Free-text (Describe scope).
*   **Branch Auto-Detection**: If Git branch starts with `bugfix/`, `fix/`, `hotfix/`, or `patch/`, pre-select Quick & Simple Mode.

---

## 4. Quick & Simple Mode Questions (QS1 – QS3)

*Quick & Simple Mode inherits tech stack, architecture, cloud provider, and container profiles from `agent-workspace/plans/initial/GRILL_STATUS.md`.*

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

## 5. Major Feature / Greenfield Mode Questions (Q1 – Q10)

*   **Q1: Project Scope, Purpose, & Milestones**: Ask high-level business goals and target release milestones. Auto-detect from `README.md` and package manifests if available.
*   **Q2: Local System Folders**:
    *   Q2.a (If folder exists): List local folder paths. Auto-detect remotes from `.git/config`.
    *   Q2.b (If no folder exists): Select folder creation strategy (current working directory or custom path).
*   **Q3: Cloud Documentation Repository**: Ask for external documentation links (Confluence, Notion, Wiki). If auto-scan fails, state scan failure before asking.
*   **Q4: Additional Remote Code Repos**: Ask for additional remote repository URLs (Q4.a URL list).
*   **Q5: Cloud Git Provider**: Select Git host (GitHub, GitLab, Bitbucket) and pre-created project/board setup (Q5.a).
*   **Q6: Architecture Design Pattern**: Select system architecture (Modular Monolith, Microservices, DDD, Event-Driven).
*   **Q7: Layer Scope & Sub-repos**: Select layer breakdown (Fullstack UI + Engine, UI-only, Engine-only, or custom).
*   **Q8: Software Stack & Frameworks**: Select language and framework stack for each layer. Auto-detect from manifests if available.
*   **Q9: Agent Guidance Rules & Tooling**: Select agentic control defaults (`.agents/` standards or custom).
*   **Q10: Summary Verification & Reflection**: Present clean recap table of Q1–Q9 gathered choices for user verification, adjustment, or final approval.
