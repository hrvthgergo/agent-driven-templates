# Desired Project Folder Structure

This document defines the unified directory layout scaffolded, mapped, and enforced by the `/init` workflow across the three separate repositories.

```
[Local Workspace Root]
│
├── antigravity-workspace/       # Repo 1: Main Orchestrator Workspace
│   ├── .agents/                 # Agentic Control Directory (Guards)
│   │   ├── rules/               # Permanent rules & constraints
│   │   │   └── implementation-plan.md # 5-phase blueprint rules
│   │   ├── workflows/           # Stateful development playbooks
│   │   │   └── init.md          # Bootstrapping playbook
│   │   ├── skills/              # Domain capability instructions (empty by default)
│   │   ├── hooks/               # Safety script interceptors (empty by default)
│   │   ├── sidecars/            # Co-pilot validation subagents (empty by default)
│   │   └── plans/               # Blueprint planning blueprints & status tracking
│   │       ├── PLAN_STATUS.md   # Checkbox tracker of planning phase
│   │       ├── phase-1-summary.md # Phase 1: High-level summary & folder map
│   │       ├── phase-2-layout.md # Phase 2: Design system & styling laws
│   │       ├── phase-3-engine.md # Phase 3: Engine logic & mappers (DTOs)
│   │       ├── phase-4-verification.md # Phase 4: Test specs & assertions
│   │       └── phase-5-operation.md # Phase 5: Dockerfiles, compose, CI/CD
│   │
│   ├── .github/ (or .gitlab/)   # Platform CI/CD (Integration/E2E pipelines)
│   │   └── workflows/
│   │       └── ci.yml           # Automated E2E verification
│   │
│   ├── docker/                  # Docker Compose runtime configurations
│   │   ├── dev.Dockerfile       # Agent container sandbox
│   │   └── prod.Dockerfile      # Release container base
│   │
│   ├── docs/                    # Global human-facing documentation
│   │
│   └── src/                     # Source Code Entry Points
│       ├── layout/              # [SYMLINK] Points to ../codebase-layout/src/
│       ├── engine/              # [SYMLINK] Points to ../codebase-engine/src/
│       └── config/              # Central configuration (Secrets & environment envs)
│
├── codebase-layout/             # Repo 2: Standalone Layout UI Workspace
│   ├── .github/ (or .gitlab/)   # UI-specific micro-pipelines (linting, tests)
│   ├── config/                  # UI autonomous layout routing & themes
│   ├── src/                     # Raw frontend code (HTML, views, layout assets)
│   └── tests/                   # UI unit and visual styling tests
│
└── codebase-engine/             # Repo 3: Standalone Engine Backend Workspace
    ├── .github/ (or .gitlab/)   # Engine-specific micro-pipelines (unit tests)
    ├── config/                  # DB mappers & autonomous background settings
    ├── src/                     # Core engine services (API routing, mappers)
    └── tests/                   # Engine unit and data verification tests
```
