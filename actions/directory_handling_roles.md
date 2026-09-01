# Directory Handling Roles & Folder Authority Map

This document details the directory handling roles and authority for each action in the **Guards Framework**. It clarifies exactly which action is responsible for creating, writing to, or reading from the core folder structure.

### Legend
* **[C] (Create)**: Bootstraps the folder, establishes the skeleton, or provisions the initial tracking sheets.
* **[W] (Write/Modify)**: Authors content, edits code/blueprints, syncs artifacts, or outputs reports.
* **[R] (Read/Utilize)**: Ingests the folder's contents as context, verifies contracts, or executes its files.
* **[-] (None)**: The action has no business touching this directory.

---

### Folder Authority & Action Role Matrix

| Directory Scope / Core Folder | `/init`<br>*(Admin)* | `/process`<br>*(Analyst)* | `/plan`<br>*(Architect)* | `/implement`<br>*(Developer)* | `/qualify`<br>*(QA Engine)* | `/release`<br>*(DevOps)* |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **`.agents/`**<br>*(Agent Rules, Workflows, Skills)* | **[C] / [W]** | **[R]** | **[R]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/plans/<feature>/`**<br>*(Feature Blueprints & Status Sheets)* | **[C] / [W]** | **[W]** | **[W]** | **[W]** | **[W]** | **[W]** |
| **`.../plans/<feature>/implementation_maps/`**<br>*(Versioned Execution Roadmaps)* | **[-]** | **[-]** | **[C] / [W]** | **[R] / [W]** | **[R]** | **[R]** |
| **`.../plans/<feature>/resource/`**<br>*(Staged Legacy Documentation)* | **[-]** | **[C] / [W]** | **[R]** | **[R]** | **[-]** | **[-]** |
| **`agent-workspace/tests/`**<br>*(Test Strategy & Master Scenarios)* | **[-]** | **[-]** | **[C] / [W]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/docs/`**<br>*(General System Documentation)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[R]** |
| **`agent-workspace/src/<layer>/`**<br>*(Symlink Maps & AST Code Graphs)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[-]** |
| **`codebase-<layer>/`**<br>*(Production Source Code)* | **[C]** | **[R]** | **[R]** | **[W]** | **[R]** | **[R]** |
| **`codebase-<layer>/tests/`**<br>*(Layer-Specific Unit Tests)* | **[-]** | **[R]** | **[-]** | **[C] / [W]** | **[R]** | **[-]** |
| **`codebase-qualify/`**<br>*(Integration & E2E Executable Suites)* | **[C]** | **[R]** | **[R]** | **[W]** | **[R]** | **[-]** |
| **`codebase-devops/`**<br>*(Docker, CI/CD, Deployment Configs)* | **[C]** | **[R]** | **[R]** | **[W]** | **[R]** | **[R]** |

---

### Key Takeaways by Action Profile

1. **`/init` (The Scaffolder)**: Holds absolute creation authority (**[C]**). It builds the empty repository skeletons, the control planes, and the status sheets, but is strictly forbidden from writing production code or test logic.
2. **`/process` (The Ingester)**: Has exclusive write access to `resource/` and `src/` symlink mappings. It safely stages brownfield code and docs without modifying the actual source code.
3. **`/plan` (The Blueprint Author)**: Holds write authority (**[W]**) over the `plans/` directory and `agent-workspace/tests/`. It authors the Phase Blueprints, Test Strategy, and the v1 Implementation Map, treating production `codebase-*/` strictly as Read-Only context.
4. **`/implement` (The Code Builder)**: The *only* action with write authority (**[W]**) over production logic in `codebase-*/`, `codebase-*/tests/`, and `codebase-qualify/`. It reads the blueprints and tests, writes the code, and syncs its artifacts back to `plans/`.
5. **`/qualify` (The Auditor)**: Strictly an execution engine. It reads (**[R]**) from the codebase and test folders, runs the suites, and writes (**[W]**) only its verdict (`QUALIFICATION_REPORT.md`) back into the `plans/` directory.
6. **`/release` (The Packager)**: Reads across the finalized `codebase-*/` layers, utilizes `codebase-devops/` to build production images, and writes the final `WALKTHROUGH.md` to `plans/`.
