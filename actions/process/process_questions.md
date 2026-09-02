# Grill Schema: Legacy Code & Docs Processing Questions (/process)

This document defines the Q&A interview schema, auto-detection rules, unchangeable baselines, and structured prompts used by the `/process` action's Grill Engine.

The primary objective of the `/process` action is to synthesize **three core knowledge sources**:
1. **`/init` Baseline Knowledge**: Metadata, linked folder paths, technology stack, and Git origin settings collected during `/init`.
2. **Interactive Grill-Me Knowledge**: Developer choices gathered during this Q&A interview (layer mappings, symlink vs scaffolding preference, documentation extraction scope).
3. **Existing Codebase & Documentation Knowledge**: Deep code structures, module dependencies, API endpoints, database schemas, and specs extracted from legacy folders.

Based on these sources, `/process` **integrates previous implementations** into the workspace layer layout (`agent-workspace/src/<layer>`) via symlinks or optional sub-repository scaffolding, while **linking all previous remote origins, submodules, and documentation sources** to the workspace.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational safety, non-destructive file processing, and structural consistency, the following baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/process` interview**:

### Baseline 1: Read-Only Legacy Source Rule (No Logic Rewriting)
* **Specification**: Original legacy code repositories and external source folders MUST NOT have their code logic rewritten or modified during `/process`. `/process` is strictly for discovery, symlinking, doc staging, and knowledge extraction.
* **Enforced Action**: All code logic refactoring is deferred to `/plan` and `/implement`. Legacy code is either symlinked directly into `agent-workspace/src/<layer>` or copied intact into new sub-repositories.

### Baseline 2: Workspace Layer Alignment
* **Specification**: Layer integration MUST target the workspace layer layout linked symbolically under `agent-workspace/src/<layer>` (e.g., `agent-workspace/src/layout`, `agent-workspace/src/engine`).

---

## 2. Questions & Scanning Blueprint

```
                      ┌──────────────────────────────────────┐
                      │    Start /process Scan & Audit       │
                      └──────────────────┬───────────────────┘
                                         │
                   Is /init completed in PROCESS_STATUS.md?
                   /                                       \
                (No)                                       (Yes)
                /                                             \
  [Halt & Prompt User to Run /init]          Inspect /init Metadata & Source Folders
                                                              │
                                              For each question in Schema (Q1 - Q7):
                                                              │
                                                Does Scan auto-detect answer?
                                                /                           \
                                             (Yes)                          (No)
                                             /                                 \
                                  [Auto-answer Question]               [Run Q&A Interview]
```

* **Prerequisite Enforcement Gate**: The Grill Engine MUST first check for `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`. If missing or if `/init` is marked `Not Started`, the agent MUST immediately stop execution and instruct the user to run `/init` first.
* **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom instructions.

---

## 3. Sequential Question List (Execution Order: Q1 to Q7)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

---

### Q1: `/init` Knowledge Synthesis & Baseline Review
* **Target Environment**: Agentic & Folder Environment
* **Goal**: Summarize knowledge gathered during `/init` (linked folders, tech stack, workspace layout) and confirm the baseline for legacy code processing.
* **Auto-Detection Scanning Rule**:
  * Inspect `agent-workspace/plans/<branch_name>/phase-1-summary.md` and `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md`.
  * Read mapped local legacy folder paths, identified tech stack, and primary remote Git origin.
* **Reframed Grill Prompt**:
  > **Here is the summary of project knowledge and legacy folders collected during `/init`:**
  >
  > | Category | Identified Baseline |
  > | :--- | :--- |
  > | **Project Vision** | *[Summary of purpose and milestone goals]* |
  > | **Linked Folders** | *[Paths to local legacy code and doc directories]* |
  > | **Software Stack** | *[Languages, frameworks, package managers]* |
  > | **Target Scope** | *[Target layer mappings & workspace structure]* |
  >
  > **Would you like to proceed with this legacy codebase baseline, or add/update linked legacy folder locations before scanning?**
  > 1. Proceed with current baseline
  > 2. Add additional local legacy folder paths
  > 3. Other / Free-text (Specify updates to initial project baseline)

---

### Q2: Audit for Omitted Remote Sources & Submodules
* **Target Environment**: Agentic Environment
* **Goal**: Discover any remote code origins, Git submodules, external documentation URLs, or cloud repositories linked to the legacy codebase. `codebase-*` remotes and submodules are deliberately out of scope for `/init` (Pure Control Plane Scope baseline — see [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/init/init_questions.md) §1) and are discovered here for the first time, not re-checked after being missed.
* **Auto-Detection Scanning Rule**:
  * Inspect `.git/config` and `.gitmodules` inside all linked legacy folder paths (`git remote -v`, `git submodule status`).
  * Scan `README.md` and documentation files across linked folders for external URLs (Confluence, Notion, Wiki, remote Git hosts).
* **Reframed Grill Prompt**:
  > **Our automated audit checked your linked legacy folders for remote Git origins, submodules, and external documentation links.**
  >
  > *Detected Remotes & Links:*
  > * *[List of auto-detected Git remotes, submodules, and documentation URLs, if any]*
  >
  > **Are there any additional remote code repositories, Git submodules, or external documentation sources connected to this project?**
  > 1. No additional remote sources (Use detected links only)
  > 2. Add remote Git code repository URL(s)
  > 3. Add external documentation URL(s) (Notion, Confluence, Wiki, Google Drive)
  > 4. Add Git submodule path(s) / URL(s)
  > 5. Other / Free-text (Specify remote sources and access details)
* **Resulting Action**: Registers newly identified remotes and submodules into `agent-workspace/plans/<branch_name>/phase-1-summary.md` and updates repository tracking.

---

### Q3: Legacy Source-to-Layer Mapping Strategy
* **Target Environment**: Folder & Software Environment
* **Goal**: Determine how existing legacy source files and non-code documentation should be grouped and mapped:
  * **Source Code**: Mapped to workspace layers (`agent-workspace/src/<layer>/`).
  * **Non-Code Documentation & Assets**: Staged in **`agent-workspace/plans/<feature-name>/resource/`** as feature reference knowledge. (Global `docs/` is reserved for already implemented capabilities and will be updated later during `/implement`).
* **Auto-Detection Scanning Rule**:
  * Inspect file trees across linked legacy directories.
  * Auto-classify files by type and pattern:
    * UI / Views / Styles / Templates $\rightarrow$ `layout` layer (`agent-workspace/src/layout/`)
    * Domain Logic / Models / Controllers / APIs / Services $\rightarrow$ `engine` layer (`agent-workspace/src/engine/`)
    * Tests / Mocks / Fixtures $\rightarrow$ `qualify` layer (`agent-workspace/src/qualify/`) or internal layer tests
    * Specs / Architecture Docs / Manuals / Schemas / PDFs $\rightarrow$ `agent-workspace/plans/<feature-name>/resource/`
* **Reframed Grill Prompt**:
  > **Based on file tree analysis, here is the proposed mapping of your legacy source code and documentation:**
  >
  > | Legacy Source Path | Classification | Target Workspace Destination |
  > | :--- | :--- | :--- |
  > | `[legacy_src/ui/...]` | UI / Presentation | `agent-workspace/src/layout/` |
  > | `[legacy_src/core/...]` | Core Business Logic | `agent-workspace/src/engine/` |
  > | `[legacy_docs/...]` | Non-Code Docs & Assets | `agent-workspace/plans/<feature-name>/resource/` |
  >
  > **How would you like to handle the legacy source and documentation mapping?**
  > 1. Accept proposed automatic classification & mapping (code to agent-workspace/src/<layer>, non-code docs to plans/<feature-name>/resource/)
  > 2. Custom layer mapping (Specify custom destination paths for code and docs)
  > 3. Map all source code to a single unified engine layer (`agent-workspace/src/engine`)
  > 4. Other / Free-text (Provide custom file/directory mapping instructions)

---

### Q4: Legacy Documentation, Workspace Code Graphs, & Blueprint Extraction Strategy
* **Target Environment**: Agentic Environment
* **Goal**: Define how legacy documentation, specifications, API schemas, and architecture notes should be extracted to populate relevant phase blueprints (`phase-1-summary.md` through `phase-6-operation.md` in `agent-workspace/plans/<feature-name>/`) and optionally generate **Workspace Code Graph Subfolders** (`agent-workspace/src/<layer>/code_graph/`).
* **Selective Blueprint Rule**: Phase blueprint documents are populated **selectively based on relevance** of identified content. Filling out all 6 phase documents is **not mandatory**.
* **Auto-Detection Scanning Rule**:
  * Scan linked legacy folders for markdown docs (`*.md`), OpenAPI/Swagger specs (`.yaml`, `.json`), database schemas (`.sql`, ORM models), and source code structural elements (interfaces, classes, functions, entities).
* **Reframed Grill Prompt**:
  > **How should legacy documentation and architectural specs be processed into `agent-workspace/plans/<feature-name>/` blueprints and workspace Code Graph subfolders?**
  > 1. Full Extraction & Workspace Code Graphs: Parse legacy docs/code, stage non-code docs in `plans/<feature-name>/resource/`, generate `agent-workspace/src/<layer>/code_graph/` subfolders (with `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), and selectively populate relevant phase blueprints
  > 2. API & Data Schema Focus: Extract DB models/schemas into Phase 3 (`phase-3-data.md`) and API endpoints into Phase 4 (`phase-4-engine.md`), generating Code Graphs for backend services
  > 3. High-Level Summary Only: Extract core goals into Phase 1 (`phase-1-summary.md`) without deep documentation restructuring
  > 4. Other / Free-text (Specify custom documentation extraction guidelines)

---

### Q5: Workflow Execution Mode & Proposal Generation
* **Target Environment**: Software & Workflow Governance
* **Goal**: Select the operational execution mode and determine if an upfront proposal document is requested:
  * **Standard Interactive Mode (`/process`)**: Summarizes planned symlink and staging operations, asking for confirmation before applying changes.
  * **Proposal Mode (`/process --proposal`)**: Generates detailed `agent-workspace/plans/<branch_name>/restructure-proposal.md` and pauses for developer review before making any workspace modifications.
  * **Immediate Execution Mode (`/process --auto` or `/process --apply`)**: Creates layer symlinks and stages files immediately without pausing for interactive confirmation.
* **Reframed Grill Prompt**:
  > **Which execution mode would you like to use for integrating your legacy codebase?**
  > 1. **Standard Interactive Mode (`/process`)**: Summarize planned layer integrations and confirm before creating symlinks.
  > 2. **Proposal Mode (`/process --proposal`)**: Generate detailed `agent-workspace/plans/<branch_name>/restructure-proposal.md` for upfront review before modifying workspace symlinks.
  > 3. **Immediate Execution Mode (`/process --auto`)**: Authorize immediate creation of workspace symlinks and staging without pausing.
  > 4. Other / Free-text (Specify custom execution or dry-run preferences)

---

### Q6: Integration Strategy: In-Place Symlink vs Scaffolding Migration
* **Target Environment**: Software & Folder Environment
* **Goal**: Select whether existing code should be symlinked directly in-place into `agent-workspace/src/<layer>` or copied into newly scaffolded `codebase-*` sub-repositories.
* **Non-Rewriting Rule**: Source code logic and file contents MUST NOT be edited or rewritten during `/process`.
* **Reframed Grill Prompt**:
  > **How should existing legacy source code be integrated into the workspace?**
  > 1. **In-Place Symlink Mode**: Create symbolic links under `agent-workspace/src/<layer>` pointing directly to existing legacy directories (no duplicate storage, maintains single source of truth).
  > 2. **Scaffolding & Copy Mode**: Scaffold new `codebase-*` sub-repositories and copy legacy files intact into them.
  > 3. **Custom Workspace Link / Aliasing**: Configure custom path aliases in workspace configs (e.g. `tsconfig.json` paths, `pyproject.toml` PYTHONPATH).
  > 4. Other / Free-text (Specify custom workspace link or environment configuration)

---

### Q7: Q&A Summary Verification & Execution Confirmation
* **Target Environment**: Cross-Environment Verification
* **Goal**: Format a clean summary table of all answers gathered across Q1–Q6, confirm the execution option, and initiate the `/process` action.
* **Execution Rule**:
  1. The Grill Engine MUST format and display a clean summary table of all answers gathered across Q1–Q6.
  2. The Grill Engine MUST prompt the user to confirm execution or edit answers.
* **Reframed Grill Prompt**:
  > **Summary of Answers Gathered During `/process` Session:**
  >
  > | Environment | Question | Gathered Specification / Answer |
  > | :--- | :--- | :--- |
  > | **Agentic & Folder** | Q1 Baseline Review | *[Q1 Answer / Baseline status]* |
  > | **Agentic** | Q2 Omitted Remotes Audit | *[Q2 Answer / Remotes & submodules]* |
  > | **Folder & Software** | Q3 Legacy Source Mapping | *[Q3 Answer / Layer mapping strategy]* |
  > | **Agentic** | Q4 Code Graph & Docs | *[Q4 Answer / Code Graph subfolder & blueprint extraction scope]* |
  > | **Governance** | Q5 Execution Mode | *[Q5 Answer / Standard vs Proposal vs Immediate]* |
  > | **Software** | Q6 Integration Strategy | *[Q6 Answer / In-place symlink vs scaffolding]* |
  >
  > **Reflecting on this summary, are you ready to execute the `/process` action?**
  > 1. Everything is accurate $\rightarrow$ Execute `/process` action
  > 2. Edit a specific answer (Specify question number to re-run)
  > 3. Other / Free-text (Add further instructions, constraints, or notes for execution)
* **Resulting Action**: Saves answers to `agent-workspace/plans/<branch_name>/GRILL_STATUS.md`, creates workspace symlinks under `agent-workspace/src/<layer>` (or copies files if scaffolding mode selected), stages non-code docs in `agent-workspace/plans/<feature-name>/resource/`, optionally generates modular `agent-workspace/src/<layer>/code_graph/` subfolders (containing `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md`), selectively populates relevant phase blueprints in `agent-workspace/plans/<feature-name>/` (`phase-1-summary.md` through `phase-6-operation.md`), and updates `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md` to finalize `/process`.


---

### Q-COV: Existing Test Coverage Discovery
* **Goal**: Catalogue the verification assets the legacy codebase already contains, so that `/plan` can author `phase-5-test.md` as a **delta against existing coverage** rather than a scope written from zero.
* **Auto-Detection Scanning Rule**:
  * Locate test directories by convention (`test/`, `tests/`, `spec/`, `__tests__/`, `*_test.go`, `*Test.java`).
  * Detect test runners and frameworks from manifests (`pytest.ini`, `jest.config.*`, `go.mod`, `pom.xml`, `package.json` scripts).
  * Detect fixture, mock, and factory directories.
  * Detect coverage configuration (`.coveragerc`, `codecov.yml`, `jest` coverage thresholds).
  * Detect CI steps that execute tests in `.github/workflows/` or `.gitlab-ci.yml`.
* **Reframed Grill Prompt**:
  > **Existing test assets detected: `<n>` suites across `<m>` directories, runner(s): `<list>`. How should they be catalogued?**
  > 1. Catalogue all discovered suites, runners, fixtures and coverage config into `resource/existing_coverage.md`
  > 2. Catalogue only suites relevant to the active feature scope
  > 3. Skip test discovery (no existing coverage, or greenfield feature)
  > 4. Other / Free-text (Describe custom coverage discovery scope)
* **Boundary**: Legacy tests are **read and catalogued only**. `/process` never modifies, relocates, refactors, or executes them.

---

## 4. Sync-Scoped Prompt (`--sync`)

**Q1–Q7 and Q-COV above do NOT run under `--sync`.** `--sync` is a separate short path off Node S0 (see [process_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process/process_action.md) §4, Node SY) that bypasses the legacy-ingestion interview entirely. It has exactly one prompt, asked only in interactive invocation.

### QY: Sync Target Selection
* **Goal**: Resolve which repository (or repositories) this invocation of `--sync` targets.
* **Precondition**: Asked **only** when `/process --sync` is invoked with no `<repo>` argument. Supplying `<repo>` (or `--all`) resolves this silently and skips the prompt — including when `--sync` is invoked non-interactively as a playbook precondition.
* **Auto-Detection Scanning Rule**:
  * Live-scan Local Workspace Root children and legacy symlink targets under `agent-workspace/src/<layer>` (per `process_action.md` §2.1).
  * For each discovered repository, fetch and compute its state (`aligned` | `ahead` | `behind` | `diverged` | `no-remote`) and working-tree cleanliness.
* **Reframed Grill Prompt**:
  > **`<n>` repositories discovered. Select a sync target:**
  >
  > | Repo | Ownership | State | Working Tree |
  > | :--- | :--- | :--- | :--- |
  > | `agent-workspace` | Framework-owned | `<state>` | `<clean \| dirty>` |
  > | `codebase-<layer>` | Project-owned | `<state>` | `<clean \| dirty>` |
  > | `<legacy-folder>` | Foreign / read-only | `<state>` | `<clean \| dirty>` |
  >
  > 1. Sync a specific repository (Specify name from the table above)
  > 2. Sync all discovered repositories in sequence
  > 3. Abort — no sync
  > 4. Other / Free-text (Describe custom sync scope)
* **Resulting Action**: Applies the ownership-classed fetch behavior defined in `process_action.md` §2.3 to the selected target(s), records derived-artifact staleness (§2.4) into `PROCESS_STATUS.md`, and terminates with the gate outcome defined in §2.5. No Q1–Q7 or Q-COV question is presented at any point in this path.
