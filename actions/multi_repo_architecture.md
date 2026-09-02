# Architectural Summary: Hybrid Multi-Repo Code & Config Strategy

This document summarizes our transition to a hybrid multi-repo workspace structure. It outlines how we isolate our frontend and backend repositories to maintain clean development boundaries while preserving a unified orchestration workspace for our Antigravity agents. See [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) for the definition of the `[Local Workspace Root]` container this document builds on — it is a plain directory, never a Git repository itself.

---

## 1. Directory & Codebase Separation (The Symlink Model)

To prevent the master project workspace from becoming a heavy, congested monorepo, the raw codebase is split into **standalone Git repositories**:

*   **Main Control Plane & Knowledge Hub (`agent-workspace`):** Handles agent control (`.agents/`), planning status & blueprints (`plans/`), and human-facing documentation (`docs/`). Serves as a 100% pure knowledge hub.
*   **Infrastructure & Operations Sub-Repo (`codebase-devops`):** Standalone repository dedicated entirely to DevOps, container orchestrations (`docker/` with `dev.Dockerfile` and `docker-compose.yml`), and global CI/CD pipelines (`.github/`).
*   **Layer Skeletons (`codebase-<layer_name>`):** Standalone repositories dedicated entirely to specific architectural layers (e.g., `codebase-layout` for UI/Views, `codebase-engine` for backend logic/APIs).
*   **Test Implementation Repository (`codebase-qualify`):** Standalone repository dedicated to executable cross-layer test scripts, e2e scenarios, and fixtures. Tests are orchestrated by `devops` but implemented here.

### Local Development Integration (Symlinks)
On local development environments (both macOS and Windows), symbolic links are placed inside the main workspace `src/` directory to map the active layer repositories into a single visual workspace (e.g., `src/devops` $\rightarrow$ `codebase-devops/src`, `src/qualify` $\rightarrow$ `codebase-qualify/src`, `src/layout` $\rightarrow$ `codebase-layout/src` or legacy UI folder, `src/engine` $\rightarrow$ `codebase-engine/src` or legacy backend folder). 

*Note: The `/init` action scaffolds the pure control plane (`agent-workspace/`) and creates `src/` as an empty staging folder with a `.gitkeep`. Software layers (`codebase-*`) are designed in `/plan` Phase 1 and provisioned — repository, skeleton, and relative symlink registration — during `/implement` (for greenfield projects), or linked in-place during `/process` (for brownfield projects).*

---

### Git & GitHub Remote Origin Setup (`/init` & `/process` Behavior)

During the `/init` action, Git is initialized for `agent-workspace/` and linked to the primary remote Git origin based on Q3 (e.g. `https://github.com/org/my-project-workspace.git`), and the initial documentation is immediately pushed.

When software layers are subsequently planned in `/plan` or discovered in `/process`, repositories follow:

1. **Option A: Greenfield Multi-Repository Setup (Independent Repositories)**:
   - **`agent-workspace/`**: Initialized with its own `.git` repository and linked to the workspace/docs GitHub remote origin. Tracks `.agents/`, `plans/`, `docs/`, and the **relative symlinks** under `src/`.
   - **`codebase-devops/`**: Specified in `/plan` Phase 6; created and written by `/implement` with its own `.git` repository. Tracks `.github/`, `docker/`, `src/`, `config/`, `tests/`, and standalone `Dockerfile`.
   - **`codebase-<layer>/`**: Specified in `/plan` Phase 1; created and written by `/implement` with its own `.git` repository. Tracks `src/`, `config/`, `tests/`, and standalone `Dockerfile`.
   - **`codebase-qualify/`**: Specified in `/plan` Phase 5; created and written by `/implement` with its own `.git` repository. Tracks test scripts, fixtures, and qualification `Dockerfile`.
   - *Symlink Portability*: Because symlinks under `agent-workspace/src/` use relative paths (`../../codebase-<layer>/src`), `agent-workspace` can be committed and pushed to its own GitHub repository without embedding or duplicating sub-repo source code.

2. **Option B: Brownfield In-Place Integration (Existing Codebase Linking)**:
   - Existing legacy repositories remain in their current location and retain their original Git origins and histories.
   - The `/process` action registers relative symbolic links under `agent-workspace/src/<layer>` pointing directly to the existing codebase directories (e.g. `agent-workspace/src/engine` $\rightarrow$ `../../legacy-engine/src/`).
   - `agent-workspace/` tracks the symlinks, enabling unified agent governance, code graphs, and planning across pre-existing repositories without code copying.

*Note: An earlier revision of this document described a third "Umbrella Workspace Setup" option, where a single root `.git` repository at `[Local Workspace Root]` would encompass every subfolder. That option is retired — the Local Workspace Root is never itself a Git repository (see [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) Clean Root Mandate). Only Options A and B are valid topologies.*

---

## 2. Configuration Handling (The Two-Tier Autonomy & Infra Model)

To maintain absolute development autonomy for individual software layers while providing central DevOps governance, configurations are divided according to the **"Two-Tier Configuration Hierarchy"**:

```text
                                  ┌── [codebase-devops/config] ────> Global Infra, Shared Envs & CI/CD
                                  │
[Central Secrets / Env Mappers] ──┼── [codebase-layout/config] ────> UI Routing, Themes & Local Props
                                  │
                                  └── [codebase-engine/config] ────> DB Mappers, Service DTOs & API Props
```

### Layer-Specific Application Configurations (Autonomous & Application-Bound)
*   **Location:** Reside directly inside each `codebase-<layer>/config/` (e.g. `codebase-layout/config/`, `codebase-engine/config/`).
*   **Scope:** Application-specific properties, framework settings, layer UI themes, database mappings, and service DTO routing tables.
*   **Advantage:** Every application layer remains **100% self-contained**, allowing it to compile, build, and run standalone unit tests independently of external infrastructure or other layers.

### Global DevOps & Infrastructure Configurations (Orchestrated)
*   **Location:** Reside inside `codebase-devops/config/`.
*   **Scope:** Infrastructure variables, platform deployment manifests, runtime secret mappers, database connection strings, and multi-service docker-compose profiles.
*   **Advantage:** Keeps sensitive secrets and deployment environment paths out of application layer repositories while providing central DevOps control over multi-container environments.

---

## 3. CI/CD Pipeline Hierarchy (The 3-Tier Model)

This structural segregation establishes an incredibly fast, three-tier continuous integration workflow:

*   **Layer-Specific Micro-pipelines (Autonomous):** Commits to individual `codebase-<layer>` repositories trigger layer-specific workflows defined in `codebase-<layer>/.github/workflows/` (linting, code formatting checks, unit tests). Frontend commits do not trigger backend unit tests, saving execution time.
*   **Qualification Pipelines (Cross-Layer Testing):** Housed in `codebase-qualify/.github/workflows/`. These run the integration, E2E, and business logic tests. They can be triggered manually, by cross-layer commits, or by the macro-pipeline.
*   **Global Macro-pipelines (Orchestrated):** Commits to `codebase-devops` (or cross-layer releases) run global integration pipelines defined in `codebase-devops/.github/workflows/` (pulling latest layer images, spinning up multi-container docker-compose environments, and triggering the `codebase-qualify` pipelines).

---

## 4. Docker Handling Strategy (The Hybrid Docker Strategy)

*Note: The Hybrid Docker Strategy defines the target architecture for local multi-service orchestration and containerized deployment. Docker configurations (`dev.Dockerfile`, `docker-compose.yml`, and layer `Dockerfile` specs) are **planned during `/plan` Phase 6: Operations** (for greenfield projects) and **written by `/implement`**, or **discovered and catalogued during `/process`** (for brownfield projects). The `/init` action does not create Docker files.*

Docker configurations follow **The Hybrid Docker Handling Strategy** to balance standalone container production deployment with centralized local multi-service orchestration.

### Target Docker Layout & Ownership

```text
codebase-devops/
└── docker/
    ├── dev.Dockerfile       # Agent sandbox environment
    └── docker-compose.yml   # Local multi-service orchestrator (links sub-repos)

codebase-layout/
└── Dockerfile               # Standalone production build spec for UI/Frontend

codebase-engine/
└── Dockerfile               # Standalone production build spec for Engine/Backend

codebase-qualify/
└── Dockerfile               # Standalone qualification runner container
```

### Container Orchestration Rules
*   **Layer Production Autonomy:** Each application sub-repository (`codebase-layout`, `codebase-engine`) maintains a standalone `Dockerfile` in its root. This enables each layer service to be built, tagged, and deployed to production environments independently.
*   **Test Environment Autonomy:** `codebase-qualify` maintains its own `Dockerfile` to package the test runner (e.g., Playwright dependencies, testing SDKs) separately from production artifacts.
*   **Local Multi-Service Orchestration:** `codebase-devops/docker/docker-compose.yml` acts as the central orchestrator for local multi-service development and E2E testing. It links layer containers, injects runtime configurations, provisions databases, and triggers the `qualify-runner`.
*   **Agent Execution Sandbox:** `codebase-devops/docker/dev.Dockerfile` provisions the sandboxed container environment for agent-driven execution and verification.

---

## 5. Dynamic Layer Expansion & Lifecycle Consistency

A project may start as single-layer (e.g. backend API engine only under `codebase-engine`) and later evolve to require an additional software layer (e.g. adding a UI under `codebase-layout` or a background worker under `codebase-worker`). 

The multi-repo and folder structure rules are enforced **consistently across the entire project lifecycle**:

### Layer Expansion Workflow (`/plan --evolve` specifies; `/implement` provisions)
1. **Blueprint Delta First**: `/plan --evolve` specifies the new layer in a delta blueprint
   (`plans/<feature_name>/phase-1-summary.md`) defining the integration boundaries. This is a design
   act — no repository, file, or symlink is created during `/plan`.
2. **Target Sub-Repository Provisioning** *(by `/implement`)*:
   - Creates the new standalone sub-repository `codebase-<new_layer>` following the exact generic skeleton (`src/`, `config/`, `tests/`, `.github/workflows/`, `Dockerfile`).
3. **Orchestrator Symlink Registration** *(by `/implement`)*:
   - Adds a symbolic link under `agent-workspace/src/<new_layer>` pointing to `../../codebase-<new_layer>/src/`.
4. **Configuration & Docker Injection** *(by `/implement`)*:
   - Scaffolds layer-specific autonomous configurations in `codebase-<new_layer>/config/`.
   - Updates `codebase-devops/docker/docker-compose.yml` to include the new container service.
5. **Blueprint Synchronization** *(by `/implement`)*:
   - Updates `PROCESS_STATUS.md` to reflect the provisioned layer, preserving system consistency.
