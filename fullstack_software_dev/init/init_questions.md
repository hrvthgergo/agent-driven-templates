# Grill Schema: Initialization Questions (/init)

This document defines the Q&A interview schema, auto-detection rules, unchangeable baselines, and structured prompts used by the `/init` workflow's Grill Engine.

The primary objective of the `/init` Grill-Me session is to discover and initialize the dependencies of the three core project environments:
1. **Agentic Environment**: Agent guiders (rules, skills, MCPs, hooks, sidecars), cloud Git origin providers, CI/CD pipelines, external documentation repositories, project scope, and vision goals.
2. **Software Environment**: Solid containerization baselines, software architecture design patterns, programming languages, building blocks, and frameworks.
3. **Folder Environment**: Solid directory layout baselines, local system folder locations, layer count/scope, and `codebase-*` sub-repository skeletons.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational consistency and structural stability, the following two baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/init` interview**:

### Baseline 1: Containerization Setup (Software Environment)
*   **Specification**: The **Hybrid Docker Handling Strategy** MUST be used without exception.
*   **Enforced Architecture**:
    *   `antigravity-workspace/docker/dev.Dockerfile`: Isolated agent execution sandbox environment.
    *   `antigravity-workspace/docker/docker-compose.yml`: Local multi-service orchestrator linking layer sub-repositories.
    *   `codebase-<layer_name>/Dockerfile`: Standalone production build specs inside each sub-repository.

### Baseline 2: Folder Environment Layout (Folder Environment)
*   **Specification**: The physical directory structure of the workspace is solid and MUST follow the designed Guards layout.
*   **Enforced Architecture**:
    *   Root multi-repo layout: `antigravity-workspace/`, `codebase-<layer_a>/`, `codebase-<layer_b>/`.
    *   `antigravity-workspace/.agents/`: Control directory (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/PROCESS_STATUS.md`).
    *   `antigravity-workspace/src/`: Symbolic links (`src/layout` $\rightarrow$ `../codebase-layout/src/`, `src/engine` $\rightarrow$ `../codebase-engine/src/`).
    *   *Note*: While the **number and scope** of `codebase-*` layers are questioned (Q7), the internal directory structure follows the designed baseline unconditionally.

---

## 2. Questions & Scanning Blueprint

```
                      ┌─────────────────────────────────┐
                      │    Start /init Scan & Check     │
                      └────────────────┬────────────────┘
                                       │
                    For each question in Schema (Q1 - Q10):
                                       │
                      Does Scan detect files/configs?
                      /                             \
                   (Yes)                            (No)
                   /                                   \
        [Auto-answer Question]                 [Run Q&A Interview]
```

*   **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom thoughts.

---

## 3. Sequential Question List (Execution Order: Q1 to Q11)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

### Q1: Modification Scope & Process Mode Selection
*   **Target Environment**: Agentic & Folder Environment
*   **Goal**: Determine whether the initialization run represents a **Quick & Simple Modification (Bugfix / Minor Enhancement)** or a **Major Feature / Greenfield Setup** to prevent unnecessary Q&A overhead.
*   **Auto-Detection Scanning Rule**:
    *   If current Git branch name starts with `bugfix/`, `fix/`, `hotfix/`, or `minor/`, pre-select **Quick & Simple Mode**.
*   **Reframed Grill Prompt**:
    > **What is the scope and majority of this modification?**
    > 1. **Quick & Simple Mode (Bugfix / Minor Change)**: Fast-track initialization. Inherits existing workspace stack and container profiles, prompts for task summary and feature name, creates `agent-workspace/plans/<feature-name>/`, and skips deep-dive architecture questions.
    > 2. **Major Feature / Greenfield Setup (Full Process)**: Complete architectural initialization. Executes full Q2–Q11 deep-dive interview to define layers, tech stacks, cloud docs, and container specs.
    > 3. Other / Free-text (Describe custom modification scope)
*   **Execution Flow & Resulting Action**:
    *   **If Quick & Simple Mode selected**:
        *   Prompt user for: (A) Brief Task/Bug Summary, (B) Feature/Branch Name.
        *   Create Git branch (`bugfix/<name>` or `feature/<name>`) and scaffold plan folder `agent-workspace/plans/<feature-name>/` with starter governance files (`PROCESS_STATUS.md`, `GRILL_STATUS.md`, `phase-1-summary.md`).
        *   Automatically inherit all stack, cloud provider, and Docker profiles from `agent-workspace/plans/initial/GRILL_STATUS.md`.
        *   Bypass questions Q5–Q10 and jump directly to Node S3/S4 execution acceptance gate for rapid execution.
    *   **If Major Feature / Full Process selected**:
        *   Proceed sequentially through questions Q2 to Q11.

---

### Q2: Project Scope, Purpose, & Milestones
*   **Target Environment**: Agentic Environment
*   **Goal**: Define the project scope, high-level purpose, and key milestones for planning phase documentation.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `README.md` (extract header and initial paragraphs).
    *   Inspect package manifests (`package.json` description, `pyproject.toml`, `setup.py`, `go.mod`).
*   **Reframed Grill Prompt** (If not detected):
    > **Could you define the project scope, high-level purpose, and key milestones for the planning phase documentation?**
    > *Please describe your project goals below (or select from options):*
    > 1. Fullstack web application with automated background processing
    > 2. Standalone API engine / backend microservice
    > 3. User interface / presentation application
    > 4. Other / Free-text (Describe your project goals and milestones in detail)
*   **Resulting Action**: Writes purpose and scope into `agent-workspace/plans/<branch_name>/phase-1-summary.md` and initializes the vision baseline.

---

### Q2: Local System Folders & Existing Workspace Locations
*   **Target Environment**: Folder Environment
*   **Goal**: Discover if there are existing folders on the local system for the project, or establish a new project folder location.
*   **Auto-Detection Scanning Rule**:
    *   Inspect current working directory and parent paths for existing project directories or legacy code/doc folders.
*   **Reframed Grill Prompt**:
    > **Is there any existing folder on the local system for this project?**
    > 1. Yes (Existing local folder present)
    > 2. No (Create a new project folder)
    > 3. Other / Free-text (Describe local directory setup)
*   **Conditional Sub-Questions**:
    *   **Q2.a (If folder exists)**:
        > **Please provide the folder location path(s).**
        > *(Note: If multiple folders exist, iterate through questioning paths or request a complete list of folder locations. Remote origins will be identified automatically by analyzing version control configurations like `.git/config` inside the provided software.)*
        *   *Resulting Action*: Analyzes software version control configs inside provided paths to identify remote origins, and links existing source/doc folders into the workspace's 'Folders' map in `phase-1-summary.md` (reserving deep code analysis and refactoring for `/process`).
    *   **Q2.b (If no folder exists)**:
        > **Where on the system would you like to create the new project folder?**
        > 1. Current working directory
        > 2. Custom path (Specify location)
        > 3. Other / Free-text (Describe folder creation instructions)
        *   *Resulting Action*: Scaffolds the new directory at the specified path and adds it to the workspace configuration.

---

### Q3: Remote / Cloud-Based Documentation Repository
*   **Target Environment**: Agentic Environment
*   **Goal**: Identify external documentation repositories or knowledge bases associated with the project.
*   **Auto-Detection Scanning Rule**:
    *   Scan `README.md` or `.env` files for documentation URLs (e.g. Confluence, Notion, Wiki, Google Docs).
*   **Reframed Grill Prompt** (If auto-detection scan ran and found no linked documentation repositories):
    > **Our automated scan was unable to identify any remote or cloud-based documentation repository linked in your local project files. Is there an external documentation repository for the project (e.g., Confluence, Notion, Wiki, Google Docs)?**
    > 1. Confluence (Specify URL / space key)
    > 2. Notion (Specify workspace URL / page ID)
    > 3. GitHub / GitLab Wiki
    > 4. No external documentation repository
    > 5. Other / Free-text (Specify documentation repository URL and access details)
*   **Resulting Action**: Registers documentation URLs in `.agents/plans/phase-1-summary.md` for agent reference.

---

### Q4: Additional Remote / Cloud-Based Repositories
*   **Target Environment**: Agentic Environment
*   **Goal**: Discover additional or secondary remote code repositories linked to the project.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `.git/config` for extra remotes (`git remote -v`).
*   **Reframed Grill Prompt**:
    > **Is there any other remote origin or cloud-based code repository linked to this project?**
    > 1. Yes (Secondary code repositories exist)
    > 2. No (Single remote repository only)
    > 3. Other / Free-text (Describe repository layout)
*   **Conditional Sub-Question**:
    *   **Q4.a (If additional repos exist)**:
        > **Please provide the repository URL(s).**
        > *(Note: If multiple repositories exist, iterate through questioning URLs or request a complete list of repository URLs.)*
        *   *Resulting Action*: Registers secondary remotes in project configuration and `.git/config`.

---

### Q5: Cloud-Based Repository Provider & Pre-Created Projects
*   **Target Environment**: Agentic Environment
*   **Goal**: Identify the cloud Git provider to configure remote synchronization and platform CI/CD pipelines.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `.git/config` for `origin` host signature (`github.com`, `gitlab.com`, `bitbucket.org`).
*   **Reframed Grill Prompt** (If not detected):
    > **Which cloud-based repository provider are you using for this project?**
    > 1. GitHub
    > 2. GitLab
    > 3. Bitbucket
    > 4. Other / Free-text (Specify provider URL / platform)
*   **Conditional Sub-Question**:
    *   **Q5.a (Pre-created project setup)**:
        > **Is there any pre-created project, organization, or board within this tool (e.g., GitHub Project, GitLab Group) pre-settled for this project?**
        > 1. Yes (Specify project / board name or ID)
        > 2. No pre-created project
        > 3. Other / Free-text (Describe provider project setup)
*   **Resulting Action**: Installs platform CI actions (e.g., `.github/workflows/ci.yml` or `.gitlab-ci.yml`) and configures Git origin.

---

### Q6: Software Architecture Design Pattern
*   **Target Environment**: Software Environment
*   **Goal**: Determine the overarching software architecture design pattern to guide component boundaries.
*   **Auto-Detection Scanning Rule**:
    *   Inspect project manifests or directory names for architectural signatures (e.g., `services/`, `domain/`, `microservices/`).
*   **Reframed Grill Prompt** (If not detected):
    > **Is there any software architecture design pattern in place you would like to follow?**
    > 1. Modular Monolith / Layered Architecture
    > 2. Microservices Architecture
    > 3. Domain-Driven Design (DDD)
    > 4. Event-Driven Architecture
    > 5. Other / Free-text (Describe architectural pattern and rules)
*   **Resulting Action**: Records architectural laws in `.agents/plans/phase-1-summary.md` and enforces matching component boundary rules during planning.

---

### Q7: Layer Scope & Sub-Repositories
*   **Target Environment**: Folder Environment
*   **Goal**: Question the number and scope of `codebase-*` layers to design and implement for the project.
*   **Auto-Detection Scanning Rule**:
    *   Inspect parent directory for existing layer sub-repos (`codebase-layout`, `codebase-engine`, `codebase-api`, etc.).
*   **Reframed Grill Prompt**:
    > **Which architecture layers would you like to design and implement for this project?**
    > 1. Fullstack (UI Layout + Backend Engine) $\rightarrow$ Skeletons: `codebase-layout` & `codebase-engine`
    > 2. Pure Backend / Engine API project $\rightarrow$ Skeleton: `codebase-engine`
    > 3. Lightweight UI / Presentation project $\rightarrow$ Skeleton: `codebase-layout`
    > 4. Other / Free-text (Specify layer names, e.g. `codebase-api`, `codebase-worker`, `codebase-ui`)
*   **Resulting Action**: Provisions defined `codebase-<layer_name>` layer skeletons, registers `src/<layer_name>` symbolic links under `antigravity-workspace/src/`, and provisions standalone `Dockerfile` specs per layer.

---

### Q8: Software Stack, Building Blocks, & Frameworks
*   **Target Environment**: Software Environment
*   **Goal**: Establish programming languages, core building blocks, and frameworks for backend/frontend layers.
*   **Auto-Detection Scanning Rule**:
    *   Inspect file presence (`package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `Cargo.toml`).
*   **Reframed Grill Prompt** (If not detected):
    > **Which software stack, building blocks, or frameworks would you like to use during the project?**
    > 1. Python (FastAPI / HTML / Vanilla CSS)
    > 2. Go (Engine API) + Node.js (UI)
    > 3. Node.js (Express / HTML / Vanilla JS)
    > 4. Other / Free-text (Specify language & framework per layer)
*   **Resulting Action**: Generates standard package manifests (`requirements.txt`, `package.json`, `go.mod`) inside respective `codebase-*` sub-repositories.

---

### Q9: Agent Guidance, Rules, Skills, MCPs, & Hooks
*   **Target Environment**: Agentic Environment
*   **Goal**: Identify existing rules, skills, MCP servers, hooks, sidecars, or custom agent guiders, and specify their source locations.
*   **Auto-Detection Scanning Rule**:
    *   Inspect local `.agents/` or global `~/.agents/` for rules, skills, hooks, sidecars, and `mcp.json` configs.
*   **Reframed Grill Prompt**:
    > **Are there any existing rules, skills, MCP tools, hooks, or sidecars you would like the agent to use during the project, and where are these sources located?**
    > 1. Standard Guards framework defaults (`.agents/` directory)
    > 2. Custom local/remote agent guiders
    > 3. Other / Free-text (Specify paths/URLs for MCPs, rules, skills, hooks, sidecars)
*   **Resulting Action**: Copies or links specified agent guider sources into `.agents/` (`rules/`, `skills/`, `hooks/`, `sidecars/`) and configures MCP server integrations.

---

### Q10: Q&A Summary Verification & Open Reflection
*   **Target Environment**: Cross-Environment Verification (Agentic, Software, & Folder Environments)
*   **Goal**: Summarize the gathered answers from Q1 through Q9 and allow the user to review, edit, or add any open-ended thoughts before finalizing initialization.
*   **Execution Rule**:
    1. The Grill Engine MUST format and display a clean summary table of all answers gathered across Q1–Q9.
    2. The Grill Engine MUST prompt the user for open-ended reflections or additional instructions.
*   **Reframed Grill Prompt**:
    > **Summary of Answers Gathered During /init Session:**
    > 
    > | Environment | Question | Gathered Specification / Answer |
    > | :--- | :--- | :--- |
    > | **Agentic** | Q1 Purpose & Scope | *[Q1 Answer / Vision summary]* |
    > | **Folder** | Q2 Local Folders | *[Q2 Answer / Paths linked]* |
    > | **Agentic** | Q3 Cloud Documentation | *[Q3 Answer / Doc URLs]* |
    > | **Agentic** | Q4 Remote Repositories | *[Q4 Answer / Additional URLs]* |
    > | **Agentic** | Q5 Cloud Provider & Setup | *[Q5 Answer / Git Provider & Board]* |
    > | **Software** | Q6 Architecture Pattern | *[Q6 Answer / Design Pattern]* |
    > | **Folder** | Q7 Layer Scope | *[Q7 Answer / Codebase Skeletons]* |
    > | **Software** | Q8 Tech Stack & Frameworks | *[Q8 Answer / Languages & Stack]* |
    > | **Agentic** | Q9 Agent Guiders & MCPs | *[Q9 Answer / Rules, Skills, Hooks]* |
    > 
    > **Reflecting on this summary, is there anything else you would like to add, adjust, or clarify for the project initialization?**
    > 1. Everything is accurate $\rightarrow$ Proceed to finalize `/init`
    > 2. Edit a specific answer (Specify question number to re-run)
    > 3. Other / Free-text (Add further instructions, notes, or constraints for the agent)
*   **Resulting Action**: Writes permanent audit log into `.agents/plans/GRILL_STATUS.md` and transitions to **Node S4 (Execution Acceptance Gate)** to present the understanding summary and planned scaffolding steps for user approval (or proceeds automatically if `/init --auto` is passed).
