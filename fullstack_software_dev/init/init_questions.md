# Grill Schema: Initialization Questions (/init)

This file defines the questions, auto-detection rules, and Q&A prompts used by the `/init` workflow's Grill Engine to bootstrap the project environments.

---

## 1. Questions & Scanning Blueprint

```
                      ┌─────────────────────────────────┐
                      │    Start /init Scan & Check     │
                      └────────────────┬────────────────┘
                                       │
                        For each question in schema:
                                       │
                      Does Scan detect files/configs?
                      /                             \
                   (Yes)                            (No)
                   /                                   \
        [Auto-answer Question]                 [Run Q&A Interview]
```

### Q1: Cloud-Based Code Repository
*   **Goal**: Establish the remote git provider to configure synchronization.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `.git/config` for `[remote "origin"]` URLs.
    *   *Signatures*:
        *   Contains `github.com` $\rightarrow$ Auto-answer: **GitHub**
        *   Contains `gitlab.com` $\rightarrow$ Auto-answer: **GitLab**
        *   Contains `bitbucket.org` $\rightarrow$ Auto-answer: **Bitbucket**
*   **Reframed Grill Prompt** (If not detected):
    > **Which cloud-based repository provider are you using for this project?**
    > 1. [Recommended] GitHub
    > 2. GitLab
    > 3. Bitbucket
    > 4. Other (Specify URL)
*   **Resulting Action**: Installs platform-specific actions (e.g., `.github/workflows/ci.yml` or `.gitlab-ci.yml`) and configures local git origin.

---

### Q2: Project Description, Goals, & Existing Assets Discovery
*   **Goal**: Define the project scope, purpose, and discover whether existing legacy codebases or documentation folders are present.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `README.md` (extract lines under `# Project Name` or first paragraph).
    *   Inspect `package.json` (`description` key) or `pyproject.toml`/`setup.py`.
    *   Inspect workspace root for legacy folders (`docs/`, `legacy/`, `old_src/`, `v1/`, etc.).
*   **Reframed Grill Prompt** (If not detected or needs elaboration):
    > **Could you provide a brief description of the project goal, and specify if there are existing source code or legacy documentation folders to link?**
    > 1. Greenfield project (New codebase & fresh documentation)
    > 2. Brownfield project with existing source code (Specify folder paths, e.g. `src/`, `backend/`)
    > 3. Brownfield project with legacy documentation only (Specify doc paths, e.g. `docs/`)
*   **Resulting Action**: Writes this information to `.agents/plans/phase-1-summary.md`, links existing legacy folders into the workspace's 'Folders' map for `/process-history`, and initializes the vision document.

---

### Q3: Languages, Stack, & Developer Tools
*   **Goal**: Setup the software environment, framework files, and Docker sandbox.
*   **Auto-Detection Scanning Rule**:
    *   *File Presence*:
        *   `package.json` $\rightarrow$ Auto-answer: **Node.js** (Detect React, Next.js, Express, etc.)
        *   `requirements.txt` / `pyproject.toml` $\rightarrow$ Auto-answer: **Python** (Detect Django, FastAPI, Flask, etc.)
        *   `go.mod` $\rightarrow$ Auto-answer: **Go**
        *   `cargo.toml` $\rightarrow$ Auto-answer: **Rust**
*   **Reframed Grill Prompt** (If not detected or needs refinement):
    > **What primary programming language and framework will this project use?**
    > *(We did not detect any language package files in the root.)*
    > 1. [Recommended] Python (FastAPI / pure CSS)
    > 2. Node.js (Express / HTML / JS)
    > 3. Go
    > 4. Static HTML / Vanilla JS / Pure CSS
*   **Resulting Action**: Generates standard package skeletons (e.g. `requirements.txt` or `package.json`), scaffolds the development `docker/dev.Dockerfile` and `docker/docker-compose.yml` in the orchestrator, and creates standalone `Dockerfile` specs in defined `codebase-*` layer skeletons.

---

### Q4: Project Layer Scope & Sub-Repositories
*   **Goal**: Determine the initial software layer scope (e.g. UI-only `codebase-layout`, Engine API-only `codebase-engine`, or fullstack) and establish the starting `codebase-<layer_name>` sub-repository skeletons, noting that additional layers can be introduced later during project evolution.
*   **Auto-Detection Scanning Rule**:
    *   Inspect parent workspace for existing directories or sibling checkouts (`codebase-layout`, `codebase-engine`, `codebase-frontend`, `codebase-backend`, etc.).
    *   Inspect `src/` symlinks under `antigravity-workspace/src/`.
*   **Reframed Grill Prompt** (If not detected or needs confirmation):
    > **Which architecture layers are you developing in this project?**
    > 1. [Recommended] Fullstack (UI Layout + Backend Engine) $\rightarrow$ Skeletons: `codebase-layout` & `codebase-engine`
    > 2. UI / Presentation only $\rightarrow$ Skeleton: `codebase-layout`
    > 3. Engine / Backend API only $\rightarrow$ Skeleton: `codebase-engine`
    > 4. Custom Multi-layer (Specify layer skeleton names, e.g. `codebase-api`, `codebase-worker`)
*   **Resulting Action**: Maps `src/<layer_name>` symlinks under `antigravity-workspace/src/` to the defined `codebase-<layer_name>` repositories or existing brownfield source folders, provisions standalone `Dockerfile` specs in each defined layer, updates `docker-compose.yml` orchestration links, and links existing source folders into `phase-1-summary.md` (reserving historical code analysis and restructuring for `/process-history`).
