# Architectural Summary: Hybrid Multi-Repo Code & Config Strategy

This document summarizes our transition to a hybrid multi-repo workspace structure. It outlines how we isolate our frontend and backend repositories to maintain clean development boundaries while preserving a unified orchestration workspace for our Antigravity agents.

---

## 1. Directory & Codebase Separation (The Symlink Model)

To prevent the master project workspace from becoming a heavy, congested monorepo, the raw codebase is split into **three completely separate Git repositories**:

*   **Main Orchestrator Repo (`antigravity-workspace`):** Handles agent control (`.agents/`), documentation (`docs/`), deployment pipelines (`docker/`, `.github/`), and orchestration profiles.
*   **Layer Skeletons (`codebase-<layer_name>`):** Standalone repositories dedicated entirely to specific architectural layers (e.g., `codebase-layout` for UI/Views, `codebase-engine` for backend logic/APIs).

### Local Development Integration (Symlinks)
On local development environments (both macOS and Windows), symbolic links are placed inside the main workspace `src/` directory to map the active layer repositories into a single visual workspace (e.g., `src/layout` $\rightarrow$ `codebase-layout`, `src/engine` $\rightarrow$ `codebase-engine`). 

*Note: Projects can initially focus on a single layer (e.g. UI-only or Engine API-only), fullstack, or multi-layer. The initial layer scope and `codebase-*` skeleton count are defined during the `/init` Grill-me session, and can be expanded later via the dynamic layer expansion workflow.*

---

### Git & GitHub Remote Origin Setup (`/init` Behavior)

During the `/init` workflow, Git and GitHub remotes are initialized for all three folders (`antigravity-workspace`, `codebase-layout`, and `codebase-engine`) based on the choices made during the Grill Q&A session (Questions Q4 and Q5):

1. **Option A: True Multi-Repository Setup (3 Independent GitHub Repositories)**:
   - **`antigravity-workspace/`**: Initialized with its own `.git` repository and linked to the orchestrator/docs GitHub remote origin (e.g. `https://github.com/org/my-project-workspace.git`). Tracks `.agents/`, `docs/`, `docker/`, and the **relative symlinks** under `src/`.
   - **`codebase-layout/`**: Initialized with its own `.git` repository and linked to the UI layer GitHub remote origin (e.g. `https://github.com/org/my-project-layout.git`). Tracks `src/`, `config/`, `tests/`, and standalone `Dockerfile`.
   - **`codebase-engine/`**: Initialized with its own `.git` repository and linked to the Engine layer GitHub remote origin (e.g. `https://github.com/org/my-project-engine.git`). Tracks `src/`, `config/`, `tests/`, and standalone `Dockerfile`.
   - *Symlink Portability*: Because symlinks under `antigravity-workspace/src/` use relative paths (`../../codebase-layout/src`), `antigravity-workspace` can be committed and pushed to its own GitHub repository without embedding or duplicating sub-repo source code.

2. **Option B: Umbrella Workspace Setup (Single GitHub Repository)**:
   - If a single repository is selected in Q5, `/init` initializes one root `.git` repository at `[Local Workspace Root]` encompassing all three subfolders (`antigravity-workspace/`, `codebase-layout/`, `codebase-engine/`) under a single GitHub remote origin URL.

---

## 2. Configuration Handling (The Hybrid Autonomy Model)

To maintain absolute development autonomy without exposing runtime secrets, configurations are divided according to the **"Rule of Dependency"**:

```
                                  ┌── [codebase-layout/config] ──> Local UI Routing & Themes
                                  │
[src/config] (Central Env/Secrets) ┼── (Injected dynamically into local code at runtime)
                                  │
                                  └── [codebase-engine/config] ──> Local DB Mappers & Build Settings
```

### Local Configurations (Autonomous)
*   **Location:** Reside directly inside `codebase-layout/config/` and `codebase-engine/config/`.
*   **Scope:** Framework-specific variables and build-time properties (e.g., UI routing tables, database mappings, application-level variables).
*   **Advantage:** Both repositories remain **100% self-contained**, meaning they can compile, build, and run unit tests independently of the orchestration workspace.

### Central Configurations (Orchestrated)
*   **Location:** Reside inside `antigravity-workspace/src/config/` (or root `.env` files).
*   **Scope:** Run-time variables, secrets, database passwords, third-party API tokens, and target IP mappings.
*   **Advantage:** Keeps sensitive secrets and deployment environment paths out of the core application source code. These keys are dynamically injected when booting up the complete system (e.g., via Docker Compose).

---

## 3. CI/CD Pipeline Benefits

This structural segregation establishes an incredibly fast, dual-tier continuous integration workflow:

*   **Isolated Verification (Micro-pipelines):** Commits to the standalone `layout` or `engine` repositories trigger isolated, fast-running workflows (linting, styling checks, and language-specific unit tests). Frontend updates do not run backend unit tests, saving execution time.
*   **Integration Verification (Macro-pipelines):** Commits to the main `antigravity-workspace` repository run the heavier integration pipelines (e.g., pulling latest code, initializing database containers, and spinning up full system End-to-End (E2E) integration tests).

---

## 4. Docker Handling Strategy (The Hybrid Docker Strategy)

Docker configurations follow **The Hybrid Docker Handling Strategy** to balance standalone container production deployment with centralized local multi-service orchestration.

### Target Docker Layout & Ownership

```text
antigravity-workspace/
└── docker/
    ├── dev.Dockerfile       # Agent sandbox environment
    └── docker-compose.yml   # Local multi-service orchestrator (links sub-repos)

codebase-layout/
└── Dockerfile               # Standalone production build spec for UI/Frontend

codebase-engine/
└── Dockerfile               # Standalone production build spec for Engine/Backend
```

### Container Orchestration Rules
*   **Production Autonomy:** `codebase-layout` and `codebase-engine` maintain standalone `Dockerfile` specs in their respective repository roots. This allows UI and backend services to be built, tagged, and deployed to production independently.
*   **Local Multi-Service Orchestration:** `antigravity-workspace/docker/docker-compose.yml` acts as the orchestrator for local development and E2E testing. It links the sub-repos, injects central runtime secrets from `antigravity-workspace/src/config/`, and provisions shared networking and database containers.
*   **Agent Execution Sandbox:** `antigravity-workspace/docker/dev.Dockerfile` provisions the sandboxed container environment for agent-driven execution and verification.

---

## 5. Dynamic Layer Expansion & Lifecycle Consistency

A project may start as single-layer (e.g. backend API engine only under `codebase-engine`) and later evolve to require an additional software layer (e.g. adding a UI under `codebase-layout` or a background worker under `codebase-worker`). 

The multi-repo and folder structure rules are enforced **consistently across the entire project lifecycle**:

### Layer Expansion Workflow (`/plan --evolve` / `/init --add-layer <layer_name>`)
1. **Target Sub-Repository Provisioning**:
   - Creates the new standalone sub-repository `codebase-<new_layer>` following the exact generic skeleton (`src/`, `config/`, `tests/`, `.github/workflows/`, `Dockerfile`).
2. **Orchestrator Symlink Registration**:
   - Adds a symbolic link under `antigravity-workspace/src/<new_layer>` pointing to `../codebase-<new_layer>/src/`.
3. **Configuration & Docker Injection**:
   - Scaffolds local autonomous configurations in `codebase-<new_layer>/config/`.
   - Injects runtime environment parameters into central `antigravity-workspace/src/config/`.
   - Updates `antigravity-workspace/docker/docker-compose.yml` to include the new container service.
4. **Blueprint Synchronization**:
   - Updates `PROCESS_STATUS.md` and generates a delta blueprint (`.agents/plans/feature-add-<new_layer>.md`) defining the integration boundaries, preserving system consistency.
