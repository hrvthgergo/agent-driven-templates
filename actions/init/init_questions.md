# Grill Schema: Initialization Questions (/init)

This document defines the Q&A interview schema, auto-detection rules, unchangeable baselines, and structured prompts used by the `/init` workflow's Grill Engine.

`/init` runs a single, flat, sequential interview (Q1–Q9). There is no mode gate and no forked question set: every `/init` invocation — greenfield, existing-workspace feature, or urgent fix — walks the same nine questions. What varies between use cases is which questions auto-resolve by detection and which require an answer; that narrowing is the responsibility of the **playbook** layer (`playbooks/`), not of `/init` itself. `/init` always exposes the complete, general question set.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational consistency and structural stability, the following baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/init` interview.**

### Baseline 1: Pure Control Plane Scope
* **Specification**: `/init`'s scope is strictly `agent-workspace/` — the **Control Plane & Knowledge Hub**. It does NOT create, clone, or link `codebase-*/` sub-repositories, and it asks no questions about them. Discovering, linking, or scaffolding `codebase-*` layers is the responsibility of `/process` (brownfield) or `/plan` + `/implement` (greenfield). See [The Local Workspace Root](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md) for the container/repository distinction this baseline depends on.
* **Enforced Architecture**:
    *   `agent-workspace/.agents/`: Control directory (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`).
    *   `agent-workspace/plans/`: Feature-bound planning blueprints organized by branch (`plans/initial/`, `plans/<feature_name>/`).
    *   `agent-workspace/docs/`: Human-facing system documentation.
    *   `agent-workspace/src/`: Empty entry point directory (with `.gitkeep`) ready to receive relative symlinks when software layers are provisioned during `/implement` (greenfield, following scope designed in `/plan`) or linked during `/process` (brownfield).

### Baseline 2: Clean Root Mandate
* **Specification**: A new Local Workspace Root MUST NOT be created or cloned inside an existing Git working tree (verified with `git rev-parse --show-toplevel` on the resolved parent directory). On violation, `/init` halts at Q1 and requires the user to supply a clean parent directory. This binds the **create** and **clone** resolutions only — **adopting** an already-conformant Local Workspace Root is exempt, since its `agent-workspace/` is legitimately a Git repository.

### Baseline 3: Mutations Behind the Acceptance Gate
* **Specification**: No directory is created, no repository is cloned, and no file is written during the Q1–Q9 interview itself. All filesystem and Git mutations resolved by the interview (new directories, `git clone`, `git init`, symlink staging) execute only at Node S5, after the Node S4 Execution Acceptance Gate is passed. The interview resolves *what* will happen; S4–S5 is where it happens.

### Baseline 4: Remote Divergence Halts
* **Specification**: If Q3 resolves to **adopt** and the local `agent-workspace/` history has diverged from its registered remote (neither a fast-forward ancestor nor descendant), `/init` halts and reports the divergence rather than merging, rebasing, or force-pushing. This is a conservative stub: reconciliation policy for project-durable shared state is designed separately (see [Deferred Design Item](#4-deferred-design-item) below); until that lands, divergence is never resolved silently.

### Prompting Law
The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom thoughts.

---

## 2. Questions & Scanning Blueprint

| # | Question | Auto-Detection Source | Skippable |
| :--- | :--- | :--- | :--- |
| Q1 | Local Workspace Parent Directory | cwd, immediate children, `agent-workspace/` conformance check, `git rev-parse --show-toplevel` | Yes (unambiguous conformant root detected) |
| Q2 | Project/Feature Scope, Purpose & Milestones | `README.md`, package manifests, `PROCESS_STATUS.md` active rows | Partial (root name skipped if Q1 found a conformant root) |
| Q3 | Git Set-up & Primary Remote Origin | `agent-workspace/.git/config` (if Q1 found a root) | Yes (unambiguous origin detected and Baseline 4 does not trigger) |
| Q4 | Local Documentation Repository | Common doc folder names (`docs/`, `documentation/`, `wiki/`) near the resolved root | Yes (none found and user confirms) |
| Q4b | Additional Local Documentation Repositories | *(conditional on Q4)* | Yes (single path only) |
| Q5 | Remote / Cloud-Based Documentation Repository | `README.md`, `.env` for doc URLs (Confluence, Notion, Wiki, Google Docs) | Yes (none found and user confirms) |
| Q5b | Additional Remote Documentation Repositories | *(conditional on Q5)* | Yes (single source only) |
| Q6 | Further Documentation & Issue References | Prompt text for ticket/issue references | Yes (none supplied) |
| Q7 | Agent Guidance, Rules, Skills, MCPs & Hooks | Local `.agents/` or global `~/.agents/` | No |
| Q8 | Constraints & Pre-Planning Decisions | Prompt text for breaking-change or dependency signals | No |
| Q9 | Q&A Summary Verification & Open Reflection | Q1–Q8 answers | No |

---

## 3. Sequential Question List (Execution Order: Q1 to Q9)

### Section A — Design Goal & Environment

#### Q1: Local Workspace Parent Directory
* **Target Environment**: Folder Environment
* **Goal**: Resolve the parent directory that will contain the Local Workspace Root, and determine — before anything else — whether a conformant root already exists there. This runs first because conformance is name-independent (see [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md)): the workspace can be located before the project is named.
* **Auto-Detection Scanning Rule**:
    *   Inspect the current working directory and its immediate children for a directory containing `agent-workspace/` with `.agents/`, `plans/`, `docs/`, `tests/`, and `src/` present.
    *   Run `git rev-parse --show-toplevel` against the candidate parent directory to check Baseline 2 (Clean Root Mandate) compliance.
* **Reframed Grill Prompt**:
    > **Where should this project's Local Workspace Root live?**
    > 1. Use the current directory (`<cwd>`) — *[state detected outcome: conformant root found at `<path>` / directory present but non-conformant / empty, ready for a new root]*
    > 2. Specify a different parent directory path
    > 3. Other / Free-text (Describe custom directory resolution)
* **Resulting Action**: Records the resolved `<parent_directory>` and its detected state (`conformant` | `non-conformant` | `absent`) into `phase-1-summary.md`. If the resolved parent directory sits inside a foreign Git working tree and no conformant root is present, `/init` halts immediately per Baseline 2.

---

#### Q2: Project/Feature Scope, Purpose, & Milestones
* **Target Environment**: Agentic Environment
* **Goal**: Define the project or feature's scope, high-level purpose, and key milestones, and collect the two names the workspace depends on: the **Local Workspace Root name** (only if Q1 found no conformant root — greenfield naming, practically the software/system name) and the **working scope name** (`initial` for a first-time greenfield run, or the feature/change name otherwise), which drives `plans/<scope_name>/` and the Git branch created at Q3/S7.
* **Auto-Detection Scanning Rule**:
    *   Inspect `README.md` (header and initial paragraphs).
    *   Inspect package manifests (`package.json` description, `pyproject.toml`, `setup.py`, `go.mod`).
* **Reframed Grill Prompt** (If not detected):
    > **Could you define the project scope, high-level purpose, and key milestones for the planning phase documentation?**
    > *Please describe your project goals below (or select from options):*
    > 1. Fullstack web application with automated background processing
    > 2. Standalone API engine / backend microservice
    > 3. User interface / presentation application
    > 4. Other / Free-text (Describe your project goals and milestones in detail)
    >
    > *[If Q1 found no conformant root]* **What should the Local Workspace Root be named?** *(e.g. the software/system name)*
    >
    > **What is the working scope for this session?**
    > 1. Initial greenfield setup (`initial`)
    > 2. A named feature or change (Specify name, e.g. `checkout-api`, `fix-checkout-button`)
    > 3. Other / Free-text (Describe custom scope naming)
* **Resulting Action**: Writes purpose and scope into `agent-workspace/plans/<scope_name>/phase-1-summary.md`. Finalizes `<local_workspace_root_name>` (if newly created) and `<scope_name>`, which together determine the branch name applied at S7 per the branch-origination rules in [init_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_action.md) §4.

---

#### Q3: Git Set-up & Primary Remote Origin
* **Target Environment**: Agentic Environment / Remote Synchronization
* **Goal**: Resolve how `agent-workspace/` obtains its Git identity — by adopting an existing local repository, cloning a conformant remote, or initializing fresh — and register its primary remote origin.
* **Auto-Detection Scanning Rule**:
    *   If Q1 found a conformant local root, inspect its `agent-workspace/.git/config` for an existing `origin` remote.
    *   Otherwise, scan prompt context and `.env`/config hints for a known remote URL.
* **Reframed Grill Prompt**:
    > **How should `agent-workspace/` be set up?**
    > 1. **Adopt** — Use the existing local `agent-workspace/` in place *(offered only if Q1 found a conformant root)*
    > 2. **Clone** — A remote `agent-workspace/` repository already exists and should be cloned into the resolved Local Workspace Root (GitHub / GitLab / Bitbucket / Other — provide URL)
    > 3. **Initialize** — No local or remote `agent-workspace/` exists yet; initialize a fresh repository here (optionally register a remote origin now)
    > 4. Other / Free-text (Describe custom Git set-up)
* **Resulting Action**: Records the resolved mode (`adopt` | `clone` | `initialize`) and origin URL in `phase-1-summary.md`. Execution (the actual `git clone` or `git init` and `git remote add origin`) is deferred to Node S5 per Baseline 3. If **adopt** is selected and the local history has diverged from the registered remote, `/init` halts per Baseline 4.

---

### Section B — Supporting & Existing Documentation

#### Q4: Local Documentation Repository
* **Target Environment**: Folder Environment
* **Goal**: Discover existing local folders holding project documentation, specs, or notes relevant to this scope.
* **Auto-Detection Scanning Rule**:
    *   Scan near the resolved Local Workspace Root for common documentation folder names (`docs/`, `documentation/`, `wiki/`, `notes/`).
* **Reframed Grill Prompt**:
    > **Is there a local folder containing existing documentation for this project?**
    > 1. Yes (Provide the folder path)
    > 2. No local documentation folder
    > 3. Other / Free-text (Describe local documentation locations)
* **Conditional Sub-Question**:
    *   **Q4b (If a local documentation folder exists)**:
        > **Are there any additional local documentation repositories or folders?**
        > *(If multiple exist, iterate through questioning paths or request a complete list.)*
        *   *Resulting Action*: Links all identified local documentation paths into the 'Folders' map in `phase-1-summary.md`.
* **Resulting Action**: Registers local documentation folder path(s) into `phase-1-summary.md` for agent reference; no content is read or restructured during `/init`.

---

#### Q5: Remote / Cloud-Based Documentation Repository
* **Target Environment**: Agentic Environment
* **Goal**: Identify external documentation repositories or knowledge bases associated with the project.
* **Auto-Detection Scanning Rule**:
    *   Scan `README.md` or `.env` files for documentation URLs (e.g. Confluence, Notion, Wiki, Google Docs).
* **Reframed Grill Prompt** (If auto-detection scan ran and found no linked documentation repositories):
    > **Our automated scan was unable to identify any remote or cloud-based documentation repository linked in your local project files. Is there an external documentation repository for the project (e.g., Confluence, Notion, Wiki, Google Docs)?**
    > 1. Confluence (Specify URL / space key)
    > 2. Notion (Specify workspace URL / page ID)
    > 3. GitHub / GitLab Wiki
    > 4. No external documentation repository
    > 5. Other / Free-text (Specify documentation repository URL and access details)
* **Conditional Sub-Question**:
    *   **Q5b (If a remote documentation source exists)**:
        > **Are there any additional remote or cloud-based documentation repositories?**
        > *(If multiple exist, iterate through questioning URLs or request a complete list.)*
        *   *Resulting Action*: Registers all identified documentation URLs in `phase-1-summary.md`.
* **Resulting Action**: Registers documentation URL(s) in `agent-workspace/plans/<scope_name>/phase-1-summary.md` for agent reference.

---

#### Q6: Further Documentation & Issue References
* **Target Environment**: Agentic Environment
* **Goal**: Capture any other reference material driving this session — a linked issue, bug report, ticket, or hotfix clarification — that does not fit the local/remote documentation categories above.
* **Auto-Detection Scanning Rule**:
    *   Scan prompt text for issue/ticket identifiers (e.g. `#142`, `JIRA-1055`) or GitHub Issues URLs.
* **Reframed Grill Prompt**:
    > **Is there any further documentation, issue, or ticket reference relevant to this session?**
    > 1. Yes — Link issue or ticket (Provide URL or ID, e.g. `#142`, `JIRA-1055`)
    > 2. No formal reference — Describe the context in your own words
    > 3. No further documentation
    > 4. Other / Free-text (Provide reference context, reproduction steps, or error logs)
* **Resulting Action**: Records the reference or description into `phase-1-summary.md` under an "Issue / Reference" section.

---

### Section C — Agentic Environment Elements

#### Q7: Agent Guidance, Rules, Skills, MCPs, & Hooks
* **Target Environment**: Agentic Environment
* **Goal**: Identify existing rules, skills, MCP servers, hooks, sidecars, or custom agent guiders, and specify their source locations.
* **Auto-Detection Scanning Rule**:
    *   Inspect local `.agents/` or global `~/.agents/` for rules, skills, hooks, sidecars, and `mcp.json` configs.
* **Reframed Grill Prompt**:
    > **Are there any existing rules, skills, MCP tools, hooks, or sidecars you would like the agent to use during the project, and where are these sources located?**
    > 1. Standard Guards framework defaults (`.agents/` directory)
    > 2. Custom local/remote agent guiders
    > 3. Other / Free-text (Specify paths/URLs for MCPs, rules, skills, hooks, sidecars)
* **Resulting Action**: Copies or links specified agent guider sources into `.agents/` (`rules/`, `skills/`, `hooks/`, `sidecars/`) and configures MCP server integrations.

---

### Section D — Verification & Confirmation

#### Q8: Constraints & Pre-Planning Decisions
* **Target Environment**: Cross-Environment
* **Goal**: Capture any critical decisions, constraints, breaking changes, or dependencies that must be resolved or flagged before planning and implementation begin. Asked explicitly — not left to open reflection — so that blast-radius is recorded even when the user would not otherwise volunteer it.
* **Reframed Grill Prompt**:
    > **Are there any major decisions, constraints, or dependencies to consider before we proceed?**
    > 1. No — No blockers or constraints to record
    > 2. Yes — There are decisions to document (Describe constraints, breaking changes, affected dependencies, or team coordination needs)
    > 3. Other / Free-text (Provide any additional context or notes)
* **Resulting Action**: Records decisions and constraints into `agent-workspace/plans/<scope_name>/phase-1-summary.md`.

---

#### Q9: Q&A Summary Verification & Open Reflection
* **Target Environment**: Cross-Environment Verification (Agentic & Folder Environments)
* **Goal**: Summarize the gathered answers from Q1 through Q8 and allow the user to review, edit, or add any open-ended thoughts before finalizing initialization.
* **Execution Rule**:
    1. The Grill Engine MUST format and display a clean summary table of all answers gathered across Q1–Q8.
    2. The Grill Engine MUST prompt the user for open-ended reflections or additional instructions.
* **Reframed Grill Prompt**:
    > **Summary of Answers Gathered During /init Session:**
    >
    > | Environment | Question | Gathered Specification / Answer |
    > | :--- | :--- | :--- |
    > | **Folder** | Q1 Local Workspace Parent Directory | *[Q1 Answer / Resolved parent path & detected state]* |
    > | **Agentic** | Q2 Scope, Purpose & Names | *[Q2 Answer / Root name, scope name, vision summary]* |
    > | **Agentic** | Q3 Git Set-up & Origin | *[Q3 Answer / Adopt, Clone, or Initialize + origin URL]* |
    > | **Folder** | Q4 Local Documentation | *[Q4/Q4b Answer / Local doc paths]* |
    > | **Agentic** | Q5 Remote Documentation | *[Q5/Q5b Answer / Doc URLs]* |
    > | **Agentic** | Q6 Further Documentation | *[Q6 Answer / Issue or ticket reference]* |
    > | **Agentic** | Q7 Agent Guiders & MCPs | *[Q7 Answer / Rules, Skills, Hooks, MCPs]* |
    > | **Cross-Environment** | Q8 Constraints & Decisions | *[Q8 Answer / Constraints, breaking changes, dependencies]* |
    >
    > **Reflecting on this summary, is there anything else you would like to add, adjust, or clarify for the project initialization?**
    > 1. Everything is accurate → Proceed to finalize `/init`
    > 2. Edit a specific answer (Specify question number to re-run)
    > 3. Other / Free-text (Add further instructions, notes, or constraints for the agent)
* **Resulting Action**: Writes permanent audit log into `agent-workspace/plans/<scope_name>/GRILL_STATUS.md` and transitions to **Node S4 (Execution Acceptance Gate)**.

---

## 4. Deferred Design Item

**Remote State Reconciliation** (referenced by Baseline 4): a shared guard spec for reconciling divergent project-durable state (`tests/scenarios/`, `TEST_STRATEGY.md`, `regression/`, `docs/`) across `/init`, `/plan`, `/qualify`, and `/implement`. Not designed here — `/init` Baseline 4 halts unconditionally on divergence until that spec exists.

## 5. Deferred to Playbook Layer

Two mechanisms from the prior dual-mode design are retired from `/init` itself and are expected to resurface as **playbook resolution policy** once `playbooks/` is populated:

*   **Interview depth selection**: previously a `mode: quick_simple | major_feature` header in `GRILL_STATUS.md`, chosen by an in-interview Q0. Under the flat Q1–Q9 schema, interview depth (which questions are asked vs. auto-resolved) is a per-playbook binding over this schema's questions, not a question `/init` asks itself. The expected header is `playbook: <name>`.
*   **Branch-prefix heuristic**: previously used to pre-select Quick & Simple Mode when the current Git branch started with `bugfix/`, `fix/`, `hotfix/`, or `patch/`. This heuristic is expected to move to whatever mechanism resolves which playbook is active for a session.
