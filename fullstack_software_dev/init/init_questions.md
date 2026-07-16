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

### Q2: Project Description & Core Goals
*   **Goal**: Define the scope, purpose, and milestones for planning phase documentation.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `README.md` (extract lines under `# Project Name` or first paragraph).
    *   Inspect `package.json` (`description` key) or `pyproject.toml`/`setup.py`.
*   **Reframed Grill Prompt** (If not detected or needs elaboration):
    > **Could you provide a brief description (1-2 sentences) of the project's goal?**
    > *Example: "A web app to manage shared household chores with automated email notifications."*
*   **Resulting Action**: Writes this information to `.agents/plans/phase-1-summary.md` and initializes the vision document.

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
*   **Resulting Action**: Generates standard package skeletons (e.g. `requirements.txt` or `package.json`) and scaffolds the initial development `docker/dev.Dockerfile` with correct base images.
