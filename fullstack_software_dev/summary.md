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
- **[Multi-Repository Architecture Spec](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md)**: Specifications mapping out directory separation, symbolic link mapping, config dependency policies (Rule of Dependency), and the Option 3 Hybrid Docker handling strategy to isolate UI and Engine components.
- **[Guard Process Handling Spec (Process Guard)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md)**: Specifications for release-governed process handling documents (`PROCESS_STATUS.md`), featuring a concise 2-block structure (Workflow Execution Matrix & Datestamped Daily History) and branch-based release initialization options.

---

## 3. Planned Development Workflows

The framework is organized into six development workflows, each with its dedicated subdirectory under `fullstack_software_dev/`. The following workflow diagram details the complete operational lifecycle from initialization to post-release evolution:

```mermaid
graph TD
    Start([User Request / Bootstrapping]) --> Init["/init (Initialization Workflow)<br/>• Docker & Environment Checks<br/>• Discover codebase-* Layers & Symlinks<br/>• Create Git Branch & PROCESS_STATUS.md"]
    
    Init --> CheckType{Project Type?}
    
    CheckType -->|Brownfield / Legacy Code| ProcHist["/process-history (Legacy Processing)<br/>• Deep Historical Code/Docs Scan<br/>• Draft restructure-proposal.md<br/>• Refactor & Fix Relative Imports"]
    CheckType -->|Greenfield / New Feature| Plan["/plan (Interactive Planning)<br/>• Q&A Grill Gate (Max 2 questions/turn)<br/>• Generate Phase 1-5 Blueprints<br/>• Update PROCESS_STATUS.md"]
    
    ProcHist --> Plan
    
    Plan --> Implement["/implement (Action Implementation)<br/>• Draft implementation-map.md<br/>• Developer Consent Gate<br/>• Incremental Code Scaffolding"]
    
    Implement --> Verify["/verify (Automated Verification)<br/>• Execute Unit, Integration & E2E Tests<br/>• Run System Assertions & Regression Checks"]
    
    Verify --> TestCheck{All Tests Pass?}
    
    TestCheck -->|No| Fix["Log Failures in verification_log.json<br/>Lock /release Command"] --> Implement
    TestCheck -->|Yes| Release["/release (Release & Operations)<br/>• Build Production Docker Images<br/>• Deploy & Create Pull Request<br/>• Generate Walkthrough Summary"]
    
    Release --> Evolve{Post-Release Evolution?}
    Evolve -->|New Release Scope| InitRel["/init --release vX.Y.Z"] --> Plan
    Evolve -->|New Feature| InitFeat["/init --feature feature-name"] --> Plan
```

### Detailed Workflow Descriptions

1.  **[Initialization (/init)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md)**
    *   *Path*: `fullstack_software_dev/init/`
    *   *Purpose*: Bootstraps Docker setups, performs lightweight layer scanning to establish `codebase-*` sub-repository skeletons, links existing source folders into initial documentation, and configures Git origin.
    *   *Key Files*:
        *   [init_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md) (Detailed specifications)
        *   [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md) (Scans and Q&A schema)
        *   [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/folder_structure.md) (Desired repository directory layout)
2.  **[Legacy Code & Docs Processing (/process-history)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md)**
    *   *Path*: `fullstack_software_dev/process_history/`
    *   *Purpose*: Handles deep historical code analysis, legacy documentation processing, refactoring proposals, and codebase restructuring for brownfield projects.
    *   *Key Files*:
        *   [process_history_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md) (Detailed specifications)
3.  **Interactive Planning (/plan)**
    *   *Path*: `fullstack_software_dev/plan/`
    *   *Purpose*: Leads the user through the creation of the 5-phase blueprint plans tracking status in `PROCESS_STATUS.md`.
4.  **Action Implementation (/implement)**
    *   *Path*: `fullstack_software_dev/implement/`
    *   *Purpose*: Scaffolds layout and logic components in increments after approval of a specific `implementation-map.md`.
5.  **Verification (/verify)**
    *   *Path*: `fullstack_software_dev/verify/`
    *   *Purpose*: Executes automated assertions, unit/integration/E2E test suites, and regression checks.
6.  **Release & Operations (/release)**
    *   *Path*: `fullstack_software_dev/release/`
    *   *Purpose*: Manages Docker builds, operations deployment, walkthrough summaries, and pull requests.
