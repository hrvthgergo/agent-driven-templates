# Directory Handling Roles & Folder Authority Map

This document defines the strict physical boundaries for each action in the **Guards Framework**. Under **Law IV (WHERE) of the Global Governor**, this matrix is not a suggestion—it is a mandatory access control list. An active action is mathematically locked to the directory jurisdictions defined below.

### Legend
* **[C] (Create)**: Bootstraps the folder, establishes the skeleton, or provisions the initial tracking sheets.
* **[W] (Write)**: Authors content, edits code/blueprints, syncs artifacts, or outputs reports.
* **[R] (Read)**: Ingests the folder's contents as context, verifies contracts, or executes its files.
* **[L] (LOCKED)**: The action is physically forbidden from touching this directory. Any attempt to modify files here violates Law IV and must be blocked.

---

### Folder Authority & Action Role Matrix

| Directory Scope / Core Folder | `/init`<br>*(Admin)* | `/process`<br>*(Analyst)* | `/plan`<br>*(Architect)* | `/implement`<br>*(Developer)* | `/qualify`<br>*(QA Engine)* | `/operate`<br>*(DevOps)* |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **`.agents/`**<br>*(Agent Rules, Workflows, Skills)* | **[C] / [W]** | **[R]** | **[R]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/plans/<feature>/`**<br>*(Feature Blueprints & Status Sheets)* | **[C] / [W]** | **[W]** | **[W]** | **[W]** | **[W]** | **[W]** |
| **`.../plans/<feature>/implementation_maps/`**<br>*(Versioned Execution Roadmaps)* | **[L]** | **[L]** | **[C] / [W]** | **[R] / [W]** | **[R]** | **[R]** |
| **`.../plans/<feature>/resource/`**<br>*(Staged Legacy Documentation)* | **[L]** | **[C] / [W]** | **[R]** | **[R]** | **[L]** | **[L]** |
| **`agent-workspace/tests/`**<br>*(TEST_STRATEGY.md & scenarios/)* | **[L]** | **[L]** | **[C] / [W]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/tests/regression/`**<br>*(Promoted Regression Catalog)* | **[L]** | **[L]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** |
| **`agent-workspace/docs/`**<br>*(General System Documentation)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[R]** |
| **`agent-workspace/src/<layer>/`**<br>*(Symlink Maps & AST Code Graphs)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[L]** |
| **Deployment Targets / Environments**<br>*(`ENV-*` declared in `phase-6-operation.md`)* | **[L]** | **[L]** | **[W]** | **[L]** | **[L]** | **[R] / [W]** |
| **`codebase-<layer>/`**<br>*(Production Source Code)* | **[L]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[R]** |
| **`codebase-<layer>/tests/`**<br>*(Layer-Specific Unit Tests)* | **[L]** | **[R]** | **[L]** | **[C] / [W]** | **[R]** | **[L]** |
| **`codebase-qualify/`**<br>*(Integration & E2E Executable Suites)* | **[L]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[L]** |
| **`codebase-devops/`**<br>*(Docker, CI/CD, Deployment Configs)* | **[L]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[R]** |

> [!NOTE]
> **Why `/init` holds `[LOCKED]`, not `[C]`, on the `codebase-*` rows.**
> A directory whose existence is a design output cannot be created by an action that runs before design. `/init` runs before `/plan`, so it cannot know which layers a project needs. `/init` owns the **skeleton contract** (`folder_structure.md`) without creating those repositories itself. `/implement` is the sole provisioner based on the formal plans.

---

### Enforced Constraints by Action Profile

1. **`/init` (The Control Plane Scaffolder)**: Holds absolute creation authority (**[C]**) over the agentic control plane (`.agents/`, `plans/`, `docs/`, `tests/`, `src/`). It is **LOCKED** from writing production code, testing logic, or implementation maps.
2. **`/process` (The Ingester)**: Safely stages brownfield code. It is **LOCKED** from modifying the actual source code or test strategies.
3. **`/plan` (The Blueprint Author)**: Holds write authority over `plans/` and `agent-workspace/tests/`. Its governing principle: **`/plan` is physically locked out of touching any executional element.** It treats production `codebase-*/` strictly as Read-Only.
4. **`/implement` (The Code Builder)**: The *only* action with write authority over production logic in `codebase-*/`. It must read the blueprints and tests, write the code, and sync its artifacts back to `plans/`.
5. **`/qualify` (The Auditor)**: Strictly an execution engine. It reads from the codebase, runs the suites, and writes its verdict (`QUALIFICATION_REPORT.md`) to `plans/`. It is **LOCKED** from authoring test execution logic in `codebase-qualify/`.
6. **`/operate` (The Operations Engineer)**: Utilizes `codebase-devops/` to build production images. It is **LOCKED** from modifying UI logic, Engine logic, or test suites. Authors no operations design, only executes delivery.
