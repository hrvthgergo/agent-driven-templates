# Directory Handling Roles & Folder Authority Map

This document details the directory handling roles and authority for each action in the **Guards Framework**. It clarifies exactly which action is responsible for creating, writing to, or reading from the core folder structure.

### Legend
* **[C] (Create)**: Bootstraps the folder, establishes the skeleton, or provisions the initial tracking sheets.
* **[W] (Write/Modify)**: Authors content, edits code/blueprints, syncs artifacts, or outputs reports.
* **[R] (Read/Utilize)**: Ingests the folder's contents as context, verifies contracts, or executes its files.
* **[-] (None)**: The action has no business touching this directory.

---

### Folder Authority & Action Role Matrix

| Directory Scope / Core Folder | `/init`<br>*(Admin)* | `/process`<br>*(Analyst)* | `/plan`<br>*(Architect)* | `/implement`<br>*(Developer)* | `/qualify`<br>*(QA Engine)* | `/operate`<br>*(DevOps)* |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **`.agents/`**<br>*(Agent Rules, Workflows, Skills)* | **[C] / [W]** | **[R]** | **[R]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/plans/<feature>/`**<br>*(Feature Blueprints & Status Sheets)* | **[C] / [W]** | **[W]** | **[W]** | **[W]** | **[W]** | **[W]** |
| **`.../plans/<feature>/implementation_maps/`**<br>*(Versioned Execution Roadmaps)* | **[-]** | **[-]** | **[C] / [W]** | **[R] / [W]** | **[R]** | **[R]** |
| **`.../plans/<feature>/resource/`**<br>*(Staged Legacy Documentation)* | **[-]** | **[C] / [W]** | **[R]** | **[R]** | **[-]** | **[-]** |
| **`agent-workspace/tests/`**<br>*(TEST_STRATEGY.md & scenarios/)* | **[-]** | **[-]** | **[C] / [W]** | **[R]** | **[R]** | **[R]** |
| **`agent-workspace/tests/regression/`**<br>*(Promoted Regression Catalog)* | **[-]** | **[-]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** |
| **`agent-workspace/docs/`**<br>*(General System Documentation)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[R]** |
| **`agent-workspace/src/<layer>/`**<br>*(Symlink Maps & AST Code Graphs)* | **[C]** | **[W]** | **[R]** | **[W]** | **[R]** | **[-]** |
| **Deployment Targets / Environments**<br>*(`ENV-*` declared in `phase-6-operation.md` §0)* | **[-]** | **[-]** | **[W]** | **[-]** | **[-]** | **[R] / [W]** |
| **`codebase-<layer>/`**<br>*(Production Source Code)* | **[-]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[R]** |
| **`codebase-<layer>/tests/`**<br>*(Layer-Specific Unit Tests)* | **[-]** | **[R]** | **[-]** | **[C] / [W]** | **[R]** | **[-]** |
| **`codebase-qualify/`**<br>*(Integration & E2E Executable Suites)* | **[-]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[-]** |
| **`codebase-devops/`**<br>*(Docker, CI/CD, Deployment Configs)* | **[-]** | **[R]** | **[R]** | **[C] / [W]** | **[R]** | **[R]** |

> [!NOTE]
> **Why `/init` holds `[-]`, not `[C]`, on the four `codebase-*` rows.** A directory whose existence
> is a design output cannot be created by an action that runs before design. `/init` runs before
> `/plan`, so it cannot know which layers a project needs. `/init` owns the **skeleton contract** —
> the standard shape every `codebase-*` repository must take, specified in
> [folder_structure.md](./folder_structure.md) — and `/implement` **applies** that contract once
> `/plan` has decided what to provision. `/implement` already holds `[W]` over every one of these
> paths, so creation is the degenerate first case of writing to it: no new authority boundary is
> crossed. Contrast with `agent-workspace/src/<layer>/`, where `/init`'s `[C]` is correct as-is: that
> directory requires no design input to create — it starts empty and is registered into by
> `/implement` only once a layer exists.

---

### Key Takeaways by Action Profile

1. **`/init` (The Control Plane Scaffolder)**: Holds absolute creation authority (**[C]**) over the
   **agentic control plane and knowledge hub** — `.agents/`, `plans/`, `docs/`, `tests/`, and the
   empty `src/` staging directory — none of which requires design input to exist. It owns the
   *skeleton contract* for `codebase-*` repositories (`folder_structure.md`) without creating those
   repositories itself, and is strictly forbidden from writing production code or test logic.
2. **`/process` (The Ingester)**: Has exclusive write access to `resource/` and `src/` symlink mappings. It safely stages brownfield code and docs without modifying the actual source code.
3. **`/plan` (The Blueprint Author)**: Holds write authority (**[W]**) over `plans/` and
   `agent-workspace/tests/`. Its governing principle: **`/plan` may modify any design-relevant
   resource and is forbidden from touching any executional element.** It authors the Phase
   Blueprints, Test Strategy, and the v1 Implementation Map, treats production `codebase-*/` strictly
   as Read-Only context, and never creates a repository.
4. **`/implement` (The Code Builder)**: The *only* action with write authority (**[W]**) over
   production logic in `codebase-*/`, `codebase-*/tests/`, and `codebase-qualify/` — and the **sole
   provisioner** of those repositories (**[C]**), conforming to the `/init`-owned skeleton contract
   and registering their symlinks under `agent-workspace/src/<layer>/`. It reads the blueprints and
   tests, writes the code, and syncs its artifacts back to `plans/`.
5. **`/qualify` (The Auditor)**: Strictly an execution engine. It reads (**[R]**) from the codebase and test folders, runs the suites, writes (**[W]**) its verdict (`QUALIFICATION_REPORT.md`) back into `plans/`, and promotes ratified scenarios into `agent-workspace/tests/regression/` on certification.
6. **`/operate` (The Operations Engineer)**: Reads across the finalized `codebase-*/` layers, utilizes `codebase-devops/` to build production images, promotes an immutable digest into declared environments, and writes the final `WALKTHROUGH.md` to `plans/`. Authors no operations design.
