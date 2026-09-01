# Grill Schema: Initialization Questions (/init)

This document defines the Q&A interview schema, auto-detection rules, unchangeable baselines, and structured prompts used by the `/init` workflow's Grill Engine.

The `/init` Grill-Me session operates in **two distinct modes**, selected by the user at the very start of the interview:

1. **Quick & Simple Mode**: A fast-track 3-question interview for bug fixes, minor changes, and small enhancements within an already initialized workspace.
2. **Major Feature / Greenfield Mode**: The complete deep-dive interview (Q1–Q7) for major architectural features or first-time greenfield workspace setup.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational consistency and structural stability, the following baseline is solid and non-negotiable. **Zero questions are asked about this baseline during the `/init` interview** (regardless of mode):

### Baseline 1: Pure Agent Control Plane & Folder Layout (Folder Environment)
*   **Specification**: The `/init` action strictly scaffolds the **Control Plane & Knowledge Hub** under `agent-workspace/`. It does NOT create empty `codebase-*/` sub-repositories or Dockerfiles.
*   **Enforced Architecture**:
    *   `agent-workspace/.agents/`: Control directory (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`).
    *   `agent-workspace/plans/`: Feature-bound planning blueprints organized by branch (`plans/initial/`, `plans/<feature_name>/`).
    *   `agent-workspace/docs/`: Human-facing system documentation.
    *   `agent-workspace/src/`: Empty entry point directory (with `.gitkeep`) ready to receive relative symlinks when software layers are provisioned during `/implement` (greenfield, following scope designed in `/plan`) or linked during `/process` (brownfield).
*   *Note*: Software layer scope (`codebase-*`), programming languages, and containerization strategy (Hybrid Docker) are planned during `/plan` (or discovered by `/process` for brownfield projects), not during `/init`.

---

## 2. Process Mode Gate & Question Flow Diagram

```
                      ┌─────────────────────────────────┐
                      │    Start /init Scan & Check      │
                      └────────────────┬─────────────────┘
                                       │
                               ┌────────┴────────┐
                               │  Q0: Mode Gate   │
                               │  Quick or Major? │
                               └───┬─────────┬────┘
                                   │         │
                         [Quick & Simple]  [Major Feature / Greenfield]
                                   │         │
                       ┌───────────┘         └───────────┐
                       │                                 │
               QS1 → QS2 → QS3                  Q1 → Q2 → ... → Q7
               (3 Questions)                    (7 Questions with
                       │                         Auto-Detection Scan)
                       │                                 │
                       └──────────┬──────────────────────┘
                                  │
                           [Node S3 → S7]
                       (Shared Execution Path)
```

*   **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom thoughts.

---

## 3. Process Mode Gate (Q0)

### Q0: Initialization Mode Selection
*   **Target Environment**: Cross-Environment (Mode Decision)
*   **Goal**: Determine the scope and magnitude of the work to select the appropriate interview depth.
*   **Precondition**: This question is ONLY presented when `/init` is executed in an **already initialized workspace** (i.e., `agent-workspace/plans/initial/` exists). For **greenfield first-time runs**, the system automatically selects **Major Feature / Greenfield Mode** and skips Q0.
*   **Auto-Detection Scanning Rule**:
    *   If current Git branch name starts with `bugfix/`, `fix/`, `hotfix/`, or `patch/`, pre-select **Quick & Simple Mode**.
*   **Reframed Grill Prompt**:
    > **What type of change are you initializing?**
    > 1. **Quick & Simple (Bugfix / Minor Change)**: Fast-track setup for a bug fix, small UI tweak, or minor enhancement. Inherits existing workspace configuration. Only 3 focused questions.
    > 2. **Major Feature / Full Architecture Setup**: Complete deep-dive interview for a significant new feature or greenfield setup. 7-question session.
    > 3. Other / Free-text (Describe the scope of your change)
*   **Resulting Action**:
    *   **Quick & Simple selected**: Proceeds to Section 4 (QS1–QS3).
    *   **Major Feature selected**: Proceeds to Section 5 (Q1–Q7).

---

## 4. Quick & Simple Mode Questions (QS1 – QS3)

Quick & Simple Mode is designed for bug fixes, minor UI tweaks, and small enhancements. It inherits the existing workspace stack, architecture, cloud provider, and Docker profiles from `agent-workspace/plans/initial/GRILL_STATUS.md` and asks only 3 focused questions.

### QS1: Aim & Reason of the Change
*   **Target Environment**: Agentic Environment
*   **Goal**: Capture the purpose and intended outcome of the bug fix or minor change.
*   **Reframed Grill Prompt**:
    > **What is the aim and reason for this change?**
    > *Please provide a short summary describing the purpose, expected outcome, and affected area of the system (e.g., "Fix checkout button alignment on mobile view" or "Add loading spinner to dashboard API calls").*
    >
    > Additionally, provide the **feature/branch name** for this change:
    > *Example: `fix-checkout-button`, `add-loading-spinner`, `update-inventory-validation`*
*   **Resulting Action**: Records the aim/reason summary into `agent-workspace/plans/<feature_name>/phase-1-summary.md`. Creates Git branch (`bugfix/<name>` or `feature/<name>`).

---

### QS2: Issue & Bug Reference
*   **Target Environment**: Agentic Environment
*   **Goal**: Link or describe the specific issue, bug report, or ticket driving this change.
*   **Reframed Grill Prompt**:
    > **Is there a specific issue, bug report, or ticket linked to this change?**
    > 1. Yes — Link issue (Provide URL or ticket ID, e.g. `#142`, `JIRA-1055`, or a GitHub Issues URL)
    > 2. No formal ticket — Describe the bug or issue in your own words
    > 3. Other / Free-text (Provide issue context, reproduction steps, or error logs)
*   **Resulting Action**: Records issue reference or bug description into `agent-workspace/plans/<feature_name>/phase-1-summary.md` under the "Issue Reference" section.

---

### QS3: Pre-Planning Decisions & Constraints
*   **Target Environment**: Cross-Environment (Final Gate)
*   **Goal**: Capture any critical decisions, constraints, or dependencies that must be resolved before starting the planning and implementation phases.
*   **Reframed Grill Prompt**:
    > **Are there any major decisions, constraints, or dependencies to consider before we initialize this feature?**
    > 1. No — Proceed with initialization (no blockers)
    > 2. Yes — There are decisions to document (Describe constraints, breaking changes, affected dependencies, or team coordination needs)
    > 3. Other / Free-text (Provide any additional context or notes for the planning phase)
*   **Resulting Action**: Records decisions and constraints into `agent-workspace/plans/<feature_name>/phase-1-summary.md`. Writes permanent audit log into `agent-workspace/plans/<feature_name>/GRILL_STATUS.md` containing QS1–QS3 transcript. Transitions to **Node S4 (Execution Acceptance Gate)**.

---

## 5. Major Feature / Greenfield Mode Questions (Q1 – Q7)

Major Feature Mode executes the complete interview to configure the agentic environment and workspace control plane. This mode is used for greenfield setups or significant new initiatives.

### Q1: Project Scope, Purpose, & Milestones
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
*   **Resulting Action**: Registers documentation URLs in `agent-workspace/plans/<branch_name>/phase-1-summary.md` for agent reference.

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

### Q5: Primary Remote Git Origin & Provider
*   **Target Environment**: Agentic Environment / Remote Synchronization
*   **Goal**: Identify the target remote Git repository origin URL for `agent-workspace/` to ensure all scaffolded documentation and control files are synchronized to the remote origin upon completion.
*   **Auto-Detection Scanning Rule**:
    *   Inspect `.git/config` for existing `origin` remote (`github.com`, `gitlab.com`, `bitbucket.org`).
*   **Reframed Grill Prompt** (If not detected or during greenfield setup):
    > **Where is the remote Git repository origin for this project?**
    > 1. GitHub (Provide repository URL, e.g. `https://github.com/org/repo.git`)
    > 2. GitLab (Provide repository URL)
    > 3. Bitbucket (Provide repository URL)
    > 4. Other / Custom Git Server (Provide Git remote URL)
    > 5. No remote origin (Local-only workspace)
*   **Conditional Sub-Question**:
    *   **Q5.a (Pre-created project setup)**:
        > **Is there any pre-created project, organization, or board within this tool (e.g., GitHub Project, GitLab Group) pre-settled for this project?**
        > 1. Yes (Specify project / board name or ID)
        > 2. No pre-created project
        > 3. Other / Free-text (Describe provider project setup)
*   **Resulting Action**: Configures `git remote add origin <url>` (or updates existing origin) in the workspace Git context, enabling automatic commit and push during Step S7.

---

### Q6: Agent Guidance, Rules, Skills, MCPs, & Hooks
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

### Q7: Q&A Summary Verification & Open Reflection
*   **Target Environment**: Cross-Environment Verification (Agentic & Folder Environments)
*   **Goal**: Summarize the gathered answers from Q1 through Q6 and allow the user to review, edit, or add any open-ended thoughts before finalizing initialization.
*   **Execution Rule**:
    1. The Grill Engine MUST format and display a clean summary table of all answers gathered across Q1–Q6.
    2. The Grill Engine MUST prompt the user for open-ended reflections or additional instructions.
*   **Reframed Grill Prompt**:
    > **Summary of Answers Gathered During /init Session:**
    >
    > | Environment | Question | Gathered Specification / Answer |
    > | :--- | :--- | :--- |
    > | **Agentic** | Q1 Purpose & Scope | *[Q1 Answer / Vision summary]* |
    > | **Folder** | Q2 Local Folders | *[Q2 Answer / Paths linked]* |
    > | **Agentic** | Q3 Cloud Documentation | *[Q3 Answer / Doc URLs]* |
    > | **Agentic** | Q4 Additional Remotes | *[Q4 Answer / Additional URLs]* |
    > | **Agentic** | Q5 Remote Git Origin | *[Q5 Answer / Primary Remote Origin URL]* |
    > | **Agentic** | Q6 Agent Guiders & MCPs | *[Q6 Answer / Rules, Skills, Hooks, MCPs]* |
    >
    > **Reflecting on this summary, is there anything else you would like to add, adjust, or clarify for the project initialization?**
    > 1. Everything is accurate $\rightarrow$ Proceed to finalize `/init`
    > 2. Edit a specific answer (Specify question number to re-run)
    > 3. Other / Free-text (Add further instructions, notes, or constraints for the agent)
*   **Resulting Action**: Writes permanent audit log into `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` and transitions to **Node S4 (Execution Acceptance Gate)**.
