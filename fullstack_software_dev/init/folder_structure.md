# Desired Project Folder Structure

This document defines the generic directory layout scaffolded, mapped, and enforced by the `/init` workflow across project repositories. The initial number and scope of `codebase-*` layers (e.g., single-layer UI/Engine only, or multi-layer fullstack) are dynamically configured during the `/init` Grill-me session, and can later be expanded at any point during the project lifecycle.

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
│   │       ├── PROCESS_STATUS.md # Release-governed process & daily execution log (includes 5-phase plan status)
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
│   ├── docker/                  # Local multi-service orchestrator & dev sandbox
│   │   ├── dev.Dockerfile       # Agent sandbox environment
│   │   └── docker-compose.yml   # Local multi-service orchestrator (links sub-repos)
│   │
│   ├── docs/                    # Global human-facing documentation
│   │
│   └── src/                     # Source Code Entry Points (Examples of symlink targets)
│       ├── layout/              # [SYMLINK] Points to ../codebase-layout/src/ (Example UI layer)
│       ├── engine/              # [SYMLINK] Points to ../codebase-engine/src/ (Example Engine layer)
│       └── config/              # Central configuration (Secrets & environment envs)
│
├── codebase-<layer_a>/          # Generic Layer Skeleton A (e.g. codebase-layout for UI-only/fullstack)
│   ├── .github/ (or .gitlab/)   # Layer micro-pipelines (linting, unit tests)
│   ├── config/                  # Layer autonomous routing, themes, or DB settings
│   ├── Dockerfile               # Standalone production build spec for Layer A
│   ├── src/                     # Raw layer source code (views, services, APIs)
│   └── tests/                   # Layer-specific unit and isolation tests
│
└── codebase-<layer_b>/          # Generic Layer Skeleton B (e.g. codebase-engine for fullstack/multi-layer)
    ├── .github/ (or .gitlab/)   # Layer micro-pipelines (unit tests, build checks)
    ├── config/                  # Layer autonomous background & service settings
    ├── Dockerfile               # Standalone production build spec for Layer B
    ├── src/                     # Core layer services (API routing, computational logic)
    └── tests/                   # Layer-specific unit and integration tests
```

*Note: Projects can initially be single-layer (e.g., developing only `codebase-layout` or `codebase-engine`), dual-layer (fullstack), or multi-layer. The `codebase-*` sub-repository layout is uniform across all layers, and the initial layer scope is confirmed in the `/init` Grill-me Q&A.*

*Lifecycle Layer Expansion: If a project begins as single-layer (e.g., `codebase-engine`) and later requires an additional layer (e.g., adding `codebase-layout` or `codebase-worker`), the framework introduces the new layer skeleton under the same `codebase-<new_layer>` pattern, registers a new symlink under `src/<new_layer>`, updates `docker-compose.yml`, and preserves complete structural consistency across the repository lifecycle.*
