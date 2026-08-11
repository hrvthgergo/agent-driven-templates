# Desired Project Folder Structure

This document defines the generic directory layout scaffolded, mapped, and enforced by the `/init` workflow across project repositories. The initial number and scope of `codebase-*` layers (e.g., single-layer UI/Engine only, or multi-layer fullstack) are dynamically configured during the `/init` Grill-me session, and can later be expanded at any point during the project lifecycle.

```
[Local Workspace Root]
│
├── agent-workspace/             # Repo 1: Main Control Plane & Knowledge Hub (Pure Agent Governance)
│   ├── .agents/                 # Agentic Control Directory (Guards)
│   │   ├── rules/               # Permanent rules & constraints
│   │   │   └── implementation-plan.md # 5-phase blueprint rules
│   │   ├── workflows/           # Stateful development playbooks
│   │   │   └── init.md          # Bootstrapping playbook
│   │   ├── skills/              # Domain capability instructions (empty by default)
│   │   ├── hooks/               # Safety script interceptors (empty by default)
│   │   └── sidecars/            # Co-pilot validation subagents (empty by default)
│   │
│   ├── plans/                   # Feature-bound planning blueprints & status tracking
│   │   ├── initial/             # Planning scope for initial baseline branch ('initial')
│   │   │   ├── GRILL_STATUS.md  # Q&A audit log for initial setup
│   │   │   ├── PROCESS_STATUS.md # Process matrix & daily execution log for initial setup
│   │   │   ├── phase-1-summary.md # Phase 1: High-level architectural summary
│   │   │   └── resource/        # Staging folder for non-code legacy docs & supplementary assets
│   │   └── <feature_name>/      # Planning scope for feature branch (e.g. 'feature/checkout-api')
│   │       ├── GRILL_STATUS.md  # Q&A audit log for feature branch
│   │       ├── PROCESS_STATUS.md # Feature-bound process & daily execution matrix
│   │       ├── phase-1-summary.md # Phase 1: High-level summary & feature scope (Selective based on relevance)
│   │       ├── phase-2-layout.md # Phase 2: Design system & styling laws (Selective based on relevance)
│   │       ├── phase-3-engine.md # Phase 3: Engine logic & mappers DTOs (Selective based on relevance)
│   │       ├── phase-4-verification.md # Phase 4: Test specs & assertions (Selective based on relevance)
│   │       ├── phase-5-operation.md # Phase 5: Dockerfiles, compose, CI/CD (Selective based on relevance)
│   │       └── resource/        # Staging folder for non-code legacy docs, schemas & assets
│   │
│   ├── docs/                    # Global human-facing documentation (Implemented capabilities)
│   │
│   └── src/                     # Source Code Entry Points & Agentic Layer Graphs
│       ├── devops/              # [SYMLINK] Points to ../codebase-devops/src/ (DevOps/Infra entry point)
│       ├── layout/              # [SYMLINK] Points to ../codebase-layout/src/ (Example UI layer)
│       │   └── code_graph/      # Modular Code Graph Subfolder for Layout Layer (No symlink needed)
│       │       ├── graph.md          # Block 1: Unordered structural dependency graph
│       │       ├── process_flow.md   # Block 2A: Process entry points & control flow
│       │       ├── data_flow.md      # Block 2B: Data sources (user, configs, APIs, DB, hardcoded)
│       │       └── risk_analysis.md  # Block 2C: Coupling metrics & risk maps
│       └── engine/              # [SYMLINK] Points to ../codebase-engine/src/ (Example Engine layer)
│           └── code_graph/      # Modular Code Graph Subfolder for Engine Layer (No symlink needed)
│               ├── graph.md
│               ├── process_flow.md
│               ├── data_flow.md
│               └── risk_analysis.md
│
├── codebase-devops/             # Infrastructure & Operations Sub-Repository (Pure Execution & Containers)
│   ├── .github/ (or .gitlab/)   # Platform CI/CD (Integration/E2E pipelines)
│   │   └── workflows/
│   │       └── ci.yml           # Automated E2E verification
│   ├── docker/                  # Local multi-service orchestrator & dev sandbox
│   │   ├── dev.Dockerfile       # Agent sandbox environment
│   │   └── docker-compose.yml   # Local multi-service orchestrator (links sub-repos)
│   ├── config/                  # Global Infrastructure, Secrets, & CI/CD Envs
│   ├── Dockerfile               # Production build spec for DevOps / Orchestrator tools
│   ├── src/                     # CI/CD deployment scripts, healthchecks, provisioning
│   └── tests/                   # Infrastructure & pipeline integration tests
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

*Note: Production `codebase-*` sub-repositories contain strictly implementation source code, test suites, and build specs required to build/run the service. `agent-workspace` serves strictly as the Control Plane & Knowledge Hub (`.agents/`, `plans/`, `docs/`, `src/`). Every entry point inside `agent-workspace/src/` is strictly a relative symlink pointing to an underlying `codebase-*` sub-repository.*

*Feature Resource Folder & Global Docs Policy: Non-code legacy documentation, supplementary assets, schemas, and diagrams discovered during `/process` are staged inside `plans/<feature_name>/resource/` as reference knowledge for the active feature. Global `docs/` contains knowledge of already implemented system capabilities. Staging legacy docs in `plans/<feature-name>/resource/` keeps active feature planning decoupled; later, during the `/implement` workflow, after the feature is implemented, relevant documentation will be linked/promoted into global `docs/`.*

*Selective Phase Blueprint Rule: Filling out phase blueprint documents (`phase-1-summary.md` through `phase-5-operation.md` in `plans/<feature_name>/`) is optional and strictly based on relevance of identified legacy content.*

*Lifecycle Layer Expansion: If a project begins as single-layer (e.g., `codebase-engine`) and later requires an additional layer (e.g., adding `codebase-layout` or `codebase-worker`), the framework introduces the new layer skeleton under the same `codebase-<new_layer>` pattern, registers a new symlink under `src/<new_layer>`, updates `codebase-devops/docker/docker-compose.yml`, and preserves complete structural consistency across the repository lifecycle.*

---

## Directory Preservation Policy (`.gitkeep` Rule)

Because Git natively tracks files rather than empty directory paths, the `/init` workflow enforces a strict directory preservation policy:
1. **Universal `.gitkeep` Provisioning**: Every scaffolded directory node across `agent-workspace/` (e.g., `.agents/rules/`, `.agents/workflows/`, `.agents/skills/`, `.agents/hooks/`, `.agents/sidecars/`, `plans/`, `docs/`) and inside each `codebase-*` sub-repository (`src/`, `config/`, `tests/`, `.github/workflows/`, `docker/`) MUST include a `.gitkeep` file upon creation.
2. **Remote Synchronization Guarantee**: Provisioning `.gitkeep` across all directory nodes ensures that empty placeholder folders (such as `skills/`, `hooks/`, `sidecars/`) and scaffolded sub-repo layouts are fully tracked, preserved, and synchronized on remote Git origins (GitHub, GitLab, Bitbucket) immediately after `/init` runs.
3. **Ignore-Resilience**: `.gitkeep` files lock directory node paths in Git index, preventing folders from disappearing if sub-files are deleted or ignored by `.gitignore` rules during local development.
