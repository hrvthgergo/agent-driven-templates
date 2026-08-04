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
│   └── src/                     # Source Code Entry Points & Agentic Layer Graphs
│       ├── layout/              # [SYMLINK] Points to ../codebase-layout/src/ (Example UI layer)
│       │   └── code_graph/      # Modular Code Graph Subfolder for Layout Layer (No symlink needed)
│       │       ├── graph.md          # Block 1: Unordered structural dependency graph
│       │       ├── process_flow.md   # Block 2A: Process entry points & control flow
│       │       ├── data_flow.md      # Block 2B: Data sources (user, configs, APIs, DB, hardcoded)
│       │       └── risk_analysis.md  # Block 2C: Coupling metrics & risk maps
│       ├── engine/              # [SYMLINK] Points to ../codebase-engine/src/ (Example Engine layer)
│       │   └── code_graph/      # Modular Code Graph Subfolder for Engine Layer (No symlink needed)
│       │       ├── graph.md
│       │       ├── process_flow.md
│       │       ├── data_flow.md
│       │       └── risk_analysis.md
│       └── config/              # Central configuration (Secrets & environment envs)
│
├── codebase-<layer_a>/          # Generic Layer Skeleton A (Production source repo; clean of doc overhead)
│   ├── .github/ (or .gitlab/)   # Layer micro-pipelines (linting, unit tests)
│   ├── config/                  # Layer autonomous routing, themes, or DB settings
│   ├── Dockerfile               # Standalone production build spec for Layer A
│   ├── src/                     # Raw layer source code (views, services, APIs)
│   └── tests/                   # Layer-specific unit and isolation tests
│
└── codebase-<layer_b>/          # Generic Layer Skeleton B (Production source repo; clean of doc overhead)
    ├── .github/ (or .gitlab/)   # Layer micro-pipelines (unit tests, build checks)
    ├── config/                  # Layer autonomous background & service settings
    ├── Dockerfile               # Standalone production build spec for Layer B
    ├── src/                     # Core layer services (API routing, computational logic)
    └── tests/                   # Layer-specific unit and integration tests
```

*Note: Production `codebase-*` sub-repositories contain strictly implementation source code, test suites, and build specs required to build/run the service. Documentation overhead like layer Code Graphs (`code_graph/`) are generated exclusively inside `antigravity-workspace/src/<layer>/code_graph/` (no symlink required).*

*Lifecycle Layer Expansion: If a project begins as single-layer (e.g., `codebase-engine`) and later requires an additional layer (e.g., adding `codebase-layout` or `codebase-worker`), the framework introduces the new layer skeleton under the same `codebase-<new_layer>` pattern, registers a new symlink under `src/<new_layer>`, updates `docker-compose.yml`, and preserves complete structural consistency across the repository lifecycle.*

---

## Directory Preservation Policy (`.gitkeep` Rule)

Because Git natively tracks files rather than empty directory paths, the `/init` workflow enforces a strict directory preservation policy:
1. **Universal `.gitkeep` Provisioning**: Every scaffolded directory node across `antigravity-workspace/` (e.g., `.agents/rules/`, `.agents/workflows/`, `.agents/skills/`, `.agents/hooks/`, `.agents/sidecars/`, `.agents/plans/`, `docs/`, `docker/`, `src/config/`) and inside each `codebase-<layer_name>` sub-repository (`src/`, `config/`, `tests/`, `.github/workflows/`) MUST include a `.gitkeep` file upon creation.
2. **Remote Synchronization Guarantee**: Provisioning `.gitkeep` across all directory nodes ensures that empty placeholder folders (such as `skills/`, `hooks/`, `sidecars/`) and scaffolded sub-repo layouts are fully tracked, preserved, and synchronized on remote Git origins (GitHub, GitLab, Bitbucket) immediately after `/init` runs.
3. **Ignore-Resilience**: `.gitkeep` files lock directory node paths in Git index, preventing folders from disappearing if sub-files are deleted or ignored by `.gitignore` rules during local development.
