# Architectural Summary: Hybrid Multi-Repo Code & Config Strategy

This document summarizes our transition to a hybrid multi-repo workspace structure. It outlines how we isolate our frontend and backend repositories to maintain clean development boundaries while preserving a unified orchestration workspace for our Antigravity agents.

---

## 1. Directory & Codebase Separation (The Symlink Model)

To prevent the master project workspace from becoming a heavy, congested monorepo, the raw codebase is split into **three completely separate Git repositories**:

*   **Main Orchestrator Repo (`antigravity-workspace`):** Handles agent control (`.agents/`), documentation (`docs/`), deployment pipelines (`docker/`, `.github/`), and orchestration profiles.
*   **Layout Repo (`codebase-layout`):** A standalone repository dedicated entirely to frontend code, UI views, and styling layers.
*   **Engine Repo (`codebase-engine`):** A standalone repository dedicated entirely to backend service logic, database integrations, and core computation.

### Local Development Integration (Symlinks)
On local development environments (both macOS and Windows), symbolic links are placed inside the main workspace to map the separate repositories seamlessly into a single visual workspace. This allows agents to read and modify codebase files natively:

*   `src/layout` ---> Symbolic link pointing to external `codebase-layout` directory.
*   `src/engine` ---> Symbolic link pointing to external `codebase-engine` directory.

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
