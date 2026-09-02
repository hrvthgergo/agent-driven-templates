---
name: init-grill
description: Flat sequential neutral Q&A interview rule guard for project initialization
---

# `init-grill` Rule Guard

This rule guard governs the `/init` Grill-Me Q&A interview engine, enforcing unchangeable architecture baselines, neutral choice presentation, sequential Q1–Q9 prompt execution, and permanent audit logging.

---

## 1. Unchangeable Baselines (No Questions Asked)

Zero questions are asked about these baselines during the `/init` interview:

1.  **Baseline 1: Pure Control Plane Scope**:
    *   `/init`'s scope is strictly `agent-workspace/` — the **Control Plane & Knowledge Hub** (`.agents/`, `plans/`, `docs/`, `src/`).
    *   It does NOT create, clone, or link `codebase-*/` sub-repositories, and it asks zero questions about them. Layer discovery and scaffolding belong to `/process` or `/plan`.
2.  **Baseline 2: Clean Root Mandate**:
    *   A new Local Workspace Root MUST NOT be created or cloned inside an existing Git working tree (verified via `git rev-parse --show-toplevel` on the resolved parent directory).
    *   On violation, `/init` halts at Q1 and requires a clean parent directory (adopting an already-conformant root is exempt).
3.  **Baseline 3: Mutations Behind Acceptance Gate**:
    *   No directory is created, no repository is cloned, and no file is written during the Q1–Q9 interview itself. All mutations execute only at Node S5 after passing the Node S4 Execution Acceptance Gate.
4.  **Baseline 4: Remote Divergence Halts**:
    *   If Q3 resolves to **adopt** and the local `agent-workspace/` history has diverged from its registered remote, `/init` halts and reports divergence rather than silently merging or force-pushing.

---

## 2. Prompting Laws

*   **Zero Bias**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally.
*   **Mandatory Free-Text**: Every multiple-choice question MUST include a final free-text input option (`Other / Free-text (...)`).
*   **Audit Persistence**: Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<scope_name>/GRILL_STATUS.md`.
*   **Workflow Context Notification**: Output turn banner quote `> 📍 **Active Workflow**: /init | **Scope**: <branch> | **Node**: <Node_ID>` on every interaction.

---

## 3. Sequential Question Prompts (Execution Order: Q1 to Q9)

### Section A — Design Goal & Environment

*   **Q1: Local Workspace Parent Directory**:
    *   *Prompt*: "Where should this project's Local Workspace Root live?"
    *   *Option 1*: Use current directory (`<cwd>`) — [state detected: conformant root / empty, ready for new root / non-conformant]
    *   *Option 2*: Specify a different parent directory path
    *   *Option 3*: Other / Free-text (Describe custom directory resolution)
    *   *Check*: Enforce Baseline 2 (Clean Root Mandate via `git rev-parse --show-toplevel`).

*   **Q2: Project/Feature Scope, Purpose, & Names**:
    *   *Prompt*: "Could you define the project scope, high-level purpose, and key milestones for the planning phase documentation?"
    *   *Options*: 1. Fullstack web application | 2. Standalone API engine / backend microservice | 3. User interface / presentation application | 4. Other / Free-text (Describe goals and milestones)
    *   *[If Q1 found no conformant root]*: "What should the Local Workspace Root be named?" (e.g. software/system name)
    *   *Working Scope*: "What is the working scope for this session?" (1. Initial greenfield setup [`initial`] | 2. Named feature/change | 3. Other / Free-text)

*   **Q3: Git Set-up & Primary Remote Origin**:
    *   *Prompt*: "How should `agent-workspace/` be set up?"
    *   *Option 1*: **Adopt** — Use existing local `agent-workspace/` in place (offered only if conformant root detected)
    *   *Option 2*: **Clone** — Clone existing remote `agent-workspace/` repository (Provide URL)
    *   *Option 3*: **Initialize** — Initialize a fresh repository here (Optionally register remote origin URL)
    *   *Option 4*: Other / Free-text (Describe custom Git set-up)
    *   *Check*: Enforce Baseline 4 on adopt; defer execution to Node S5 per Baseline 3.

### Section B — Supporting & Existing Documentation

*   **Q4: Local Documentation Repository**:
    *   *Prompt*: "Is there a local folder containing existing documentation for this project?"
    *   *Option 1*: Yes (Provide folder path) | *Option 2*: No local documentation folder | *Option 3*: Other / Free-text
    *   *Q4b (Conditional)*: "Are there any additional local documentation repositories or folders?"

*   **Q5: Remote / Cloud-Based Documentation Repository**:
    *   *Prompt*: "Is there an external documentation repository for the project (e.g., Confluence, Notion, Wiki, Google Docs)?"
    *   *Option 1*: Confluence | *Option 2*: Notion | *Option 3*: GitHub/GitLab Wiki | *Option 4*: No external documentation | *Option 5*: Other / Free-text
    *   *Q5b (Conditional)*: "Are there any additional remote or cloud-based documentation repositories?"

*   **Q6: Further Documentation & Issue References**:
    *   *Prompt*: "Is there any further documentation, issue, or ticket reference relevant to this session?"
    *   *Option 1*: Yes — Link issue or ticket (Provide URL or ID, e.g. `#142`, `JIRA-1055`)
    *   *Option 2*: No formal reference — Describe context in own words
    *   *Option 3*: No further documentation
    *   *Option 4*: Other / Free-text (Reference context, reproduction steps, error logs)

### Section C — Agentic Environment Elements

*   **Q7: Agent Guidance, Rules, Skills, MCPs, & Hooks**:
    *   *Prompt*: "Are there any existing rules, skills, MCP tools, hooks, or sidecars you would like the agent to use during the project, and where are these sources located?"
    *   *Option 1*: Standard Guards framework defaults (`.agents/` directory)
    *   *Option 2*: Custom local/remote agent guiders
    *   *Option 3*: Other / Free-text (Specify paths/URLs for MCPs, rules, skills, hooks, sidecars)

### Section D — Verification & Confirmation

*   **Q8: Constraints & Pre-Planning Decisions**:
    *   *Prompt*: "Are there any major decisions, constraints, or dependencies to consider before we proceed?"
    *   *Option 1*: No — No blockers or constraints to record
    *   *Option 2*: Yes — There are decisions to document (Describe constraints, breaking changes, dependencies)
    *   *Option 3*: Other / Free-text

*   **Q9: Q&A Summary Verification & Open Reflection**:
    *   Display structured summary table of answers gathered across Q1–Q8.
    *   *Prompt*: "Reflecting on this summary, is there anything else you would like to add, adjust, or clarify for the project initialization?"
    *   *Option 1*: Everything is accurate → Proceed to finalize `/init`
    *   *Option 2*: Edit a specific answer (Specify question number to re-run)
    *   *Option 3*: Other / Free-text (Add further instructions or constraints)

---

## 4. Playbook Layer Narrowing Reference

Per-use-case interview narrowing (e.g. bugfix vs. greenfield) is resolved by the active playbook (`playbooks/`), which determines which questions auto-resolve by detection versus require explicit user prompts. The active playbook is recorded via `playbook: <name>` metadata in `GRILL_STATUS.md`.
