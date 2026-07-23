# Grill Schema: Initialization Questions (/init)

This file defines the questions, auto-detection rules, and Q&A prompts used by the `/init` workflow's Grill Engine to bootstrap the project environments.

The questions are organized into three distinct blocks corresponding to the core environments of the Guards Framework:
1. **Block A: Agentic Environment Questions** (Git remotes, CI/CD integrations, project vision & goals).
2. **Block B: Software Environment Questions** (Programming languages, tech stack, Docker containerization & MCP tools).
3. **Block C: Folder Environment Questions** (Layer sub-repositories, symlinks, & existing asset discovery).

---

## 1. Questions & Scanning Blueprint

```
                      ┌─────────────────────────────────┐
                      │    Start /init Scan & Check     │
                      └────────────────┬────────────────┘
                                       │
                    For each question in Environment Blocks:
                                       │
                      Does Scan detect files/configs?
                      /                             \
                   (Yes)                            (No)
                   /                                   \
        [Auto-answer Question]                 [Run Q&A Interview]
```

---

## Block A: Agentic Environment Questions

### Q1: Cloud-Based Code Repository & Remote Origin
*   **Goal**: Establish the remote git provider to configure synchronization and CI/CD pipelines.
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

### Q2: Project Description, Scope, & Vision Goals
*   **Goal**: Define the project scope, high-level purpose, and milestones for planning phase documentation.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `README.md` (extract lines under `# Project Name` or first paragraph).
    *   Inspect `package.json` (`description` key) or `pyproject.toml`/`setup.py`.
*   **Reframed Grill Prompt** (If not detected or needs elaboration):
    > **Could you provide a brief description (1-2 sentences) of the project's goal?**
    > *Example: "A web app to manage shared household chores with automated email notifications."*
*   **Resulting Action**: Writes this information to `.agents/plans/phase-1-summary.md` and initializes the vision document.

---

## Block B: Software Environment Questions

### Q3: Programming Languages, Frameworks, & Stack
*   **Goal**: Establish the primary software stack, runtime engines, and developer dependencies.
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
*   **Resulting Action**: Generates standard package skeletons (e.g. `requirements.txt` or `package.json`) in sub-repositories.

---

### Q4: Containerization, Sandbox, & Tooling Setup
*   **Goal**: Setup the container execution sandbox, local multi-service orchestrator, and tool integration parameters.
*   **Auto-Detection Scanning Rule**:
    *   Run `docker info` to verify Docker engine availability and privileges.
    *   Inspect workspace root for `docker-compose.yml` or `dev.Dockerfile`.
*   **Reframed Grill Prompt** (If containerization settings are missing or customized):
    > **How should local multi-service testing and agent execution sandboxes be configured?**
    > 1. [Recommended] Option 3 Hybrid Docker (Central orchestrator compose + standalone layer Dockerfiles)
    > 2. Single container sandbox only
    > 3. Direct host execution (No Docker containerization)
*   **Resulting Action**: Scaffolds `docker/dev.Dockerfile` (agent sandbox) and `docker/docker-compose.yml` (orchestrator) in `antigravity-workspace/`, and provisions standalone `Dockerfile` specs in defined `codebase-*` layer skeletons.

---

## Block C: Folder Environment Questions

### Q5: Project Layer Scope & Sub-Repositories
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
*   **Resulting Action**: Maps `src/<layer_name>` symlinks under `antigravity-workspace/src/` to the defined `codebase-<layer_name>` repositories.

---

### Q6: Existing Assets & Legacy Folder Discovery
*   **Goal**: Discover whether the project is Greenfield (new codebase) or Brownfield with existing source code or legacy documentation folders to link.
*   **Auto-Detection Scanning Rule**:
    *   Inspect workspace root for legacy folders (`docs/`, `legacy/`, `old_src/`, `v1/`, etc.).
*   **Reframed Grill Prompt** (If not detected or needs elaboration):
    > **Does this project contain existing source code or legacy documentation folders to link?**
    > 1. Greenfield project (New codebase & fresh documentation)
    > 2. Brownfield project with existing source code (Specify folder paths, e.g. `src/`, `backend/`)
    > 3. Brownfield project with legacy documentation only (Specify doc paths, e.g. `docs/`)
*   **Resulting Action**: Links existing source/doc folders into the workspace's 'Folders' map in `phase-1-summary.md` for later processing via `/process-history` (reserving historical code analysis and restructuring for `/process-history` without running refactoring during `/init`).
