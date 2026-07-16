# Desired Project Folder Structure

This document defines the standard folder layout scaffolded and enforced by the `/init` workflow to maintain separation of concerns.

```
[Project Root]
├── .agents/                    # Agentic Control Directory (Guards)
│   ├── rules/                  # Permanent rules & constraints
│   │   └── implementation-plan.md # 5-phase blueprint layout rules
│   ├── workflows/              # Stateful playbooks for development lifecycle
│   │   └── init.md            # Bootstrapping script (/init)
│   ├── skills/                 # Domain capabilities (SKILL.md)
│   ├── hooks/                  # Safety interceptors running outside agent
│   ├── sidecars/               # Co-pilot validation & audit subagents
│   └── plans/                  # Stateful blueprints & progress tracking
│       ├── PLAN_STATUS.md     # Checkbox tracker of the 5-phase plan status
│       ├── phase-1-summary.md # Phase 1: High-level summary & folder map
│       ├── phase-2-layout.md  # Phase 2: Design system & styling laws
│       ├── phase-3-engine.md  # Phase 3: Engine logic & mappers (DTOs)
│       ├── phase-4-verification.md # Phase 4: Test specs & assertions
│       └── phase-5-operation.md # Phase 5: Dockerfiles, compose, CI/CD
│
├── .github/ (or .gitlab/)      # Platform CI/CD and pull request templates
│   └── workflows/
│       └── ci.yml             # Automated tests, linting, and build verification
│
├── docker/                     # Docker-based runtime configurations
│   ├── dev.Dockerfile         # Development environment (agent sandbox)
│   └── prod.Dockerfile        # Minimal production release image
│
├── src/ (or app/)              # Source Code (The Software Environment)
│   ├── layout/                 # [SYMLINK] Points to codebase-layout (UI code & local config)
│   ├── engine/                 # [SYMLINK] Points to codebase-engine (Backend logic & local config)
│   └── config/                 # Central environment & secrets config (orchestration layer)
│
├── tests/                      # Automated Verification Layer
│   ├── unit/                  # Isolated module tests
│   ├── integration/           # Flow & API contract assertion tests
│   └── end-to-end/            # System-wide end-to-end tests (E2E)
│
└── docs/                       # Human-facing project documentation
```
