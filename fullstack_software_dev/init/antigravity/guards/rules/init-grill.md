---
name: init-grill
description: Neutral Q&A Interview Rule Guard for project initialization
---

# `init-grill` Rule Guard

This rule guard governs the `/init` Grill-me Q&A interview engine, enforcing unchangeable architecture baselines, neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines

1.  **Baseline 1: Hybrid Docker Handling Strategy**: Zero questions asked. Production `Dockerfile`s reside in layer roots; central orchestrator `docker-compose.yml` and `dev.Dockerfile` reside in `codebase-devops/docker/`.
2.  **Baseline 2: Pure Control Plane (`agent-workspace/`) & Sub-Repository Layout**: Zero questions asked. `agent-workspace/` acts strictly as Control Plane & Knowledge Hub (`.agents/`, `plans/`, `docs/`, `src/`). Infrastructure code resides in `codebase-devops/`. Entry points in `agent-workspace/src/` are strictly relative symlinks (`devops`, `layout`, `engine` $\rightarrow$ `../../codebase-X/src`).

---

## 2. Prompting Laws

*   **Zero Bias**: Do NOT prefix any option with `[Recommended]`.
*   **Mandatory Free-Text**: Always include `Other / Free-text (...)` as the final choice in every prompt.
*   **Audit Persistence**: Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<branch_name>/GRILL_STATUS.md`.

---

## 3. Sequential Q1 – Q10 Prompts

*   **Q1: Project Scope, Purpose, & Milestones**: Ask high-level business goals and target release milestones.
*   **Q2: Local System Folders**:
    *   Q2.a: List local folder paths. Auto-detect remotes from `.git/config`.
    *   Q2.b: Select folder creation strategy.
*   **Q3: Cloud Documentation Repository**: Ask for external documentation links. If scan fails, state explicitly that scan failed before asking.
*   **Q4: Additional Remote Code Repos**: Ask for additional remote repository URLs.
*   **Q5: Cloud Git Provider**: Select Git host (GitHub, GitLab, Bitbucket) and repository creation option.
*   **Q6: Architecture Design Pattern**: Select system architecture (Modular Monolith, Microservices, Event-Driven).
*   **Q7: Layer Scope & Sub-repos**: Select layer breakdown (Fullstack UI + Engine, UI-only, Engine-only).
*   **Q8: Software Stack & Frameworks**: Select language and framework stack for each layer.
*   **Q9: Agent Guidance Rules & Tooling**: Select agentic control defaults.
*   **Q10: Summary Reflection & Verification**: Present recap matrix of Q1–Q9 choices for user verification.
