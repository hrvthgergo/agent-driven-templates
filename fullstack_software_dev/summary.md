# Guards Framework: Full-Stack Software Development Summary

This document acts as the central summary and entry point for the Guards Framework project, coordinating the workflows, guidelines, and control tools for agent-driven software development.

---

## 1. Project Goal

The primary objective is to define a standardized framework of **Guards** (Rules, Workflows, Skills, Hooks, and Sidecars) that guide developers and AI agents through a structured, safe, and token-optimized development lifecycle. It guarantees that agents always plan before implementing, verify before committing, and maintain a decoupled, flexible codebase layout. 

Importantly, this framework is designed to support the entire project lifecycle—from greenfield setup to brownfield restructuring, and the post-release evolutionary iteration of live codebases operating under a hybrid, symbolic-link multi-repository structure.

---

## 2. General-Purpose Components

The framework utilizes shared components and architectural blueprints that operate across all stages of the lifecycle:

- **[Interactive Q&A Engine (Grill Engine)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md)**: A stateful, resume-ready interview module used to gather requirements and resolve architecture ambiguities before generating plans or code.
- **[Multi-Repository Architecture Spec](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md)**: Specifications mapping out directory separation, symbolic link mapping, and config dependency policies (Rule of Dependency) to isolate UI and Engine components.

---

## 3. Planned Development Workflows

The framework is organized into five sequential workflow steps, each with its dedicated subdirectory under `fullstack_software_dev/`:

1.  **[Initialization & Restructuring (/init)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md)**
    *   *Path*: `fullstack_software_dev/init/`
    *   *Purpose*: Bootstraps Docker setups, scans project environments, configuration templates, and initializes Git remote repository connections.
    *   *Key Files*:
        *   [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md) (Detailed specifications)
        *   [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md) (Scans and Q&A schema)
        *   [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md) (Desired repository directory layout)
2.  **Interactive Planning (/plan)**
    *   *Path*: `fullstack_software_dev/plan/`
    *   *Purpose*: Leads the user through the creation of the 5-phase blueprint plans tracking status in `PLAN_STATUS.md`.
3.  **Action Implementation (/implement)**
    *   *Path*: `fullstack_software_dev/implement/`
    *   *Purpose*: Scaffolds layout and logic components in increments after approval of a specific `implementation-map.md`.
4.  **Verification (/verify)**
    *   *Path*: `fullstack_software_dev/verify/`
    *   *Purpose*: Executes automated assertions, unit/integration/E2E test suites, and regression checks.
5.  **Release & Operations (/release)**
    *   *Path*: `fullstack_software_dev/release/`
    *   *Purpose*: Manages Docker builds, operations deployment, walkthrough summaries, and pull requests.
