# Rule Guard: Legacy Ingestion & Synchronization Interview (`rules/process-grill.md`)

This rule guard defines the unchangeable baselines, prompting laws, and sequential interview questions for the `/process` action's Grill Engine in Google Antigravity.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational safety, non-destructive file processing, and clean workspace layer separation, the following baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/process` interview**:

### Baseline 1: Read-Only Legacy Source Rule (No Code Logic Rewriting)
*   **Specification**: Original legacy code repositories and external source folders MUST NOT have their code logic rewritten or modified during `/process`. `/process` is strictly for discovery, symlinking, doc staging, and knowledge extraction.
*   **Enforced Action**: All code logic refactoring is deferred to `/plan` and `/implement`. Legacy code is either symlinked directly into `agent-workspace/src/<layer>` or copied intact into new sub-repositories.

### Baseline 2: Workspace Layer Alignment
*   **Specification**: Layer integration MUST target the workspace layer layout linked symbolically under `agent-workspace/src/<layer>` (e.g., `agent-workspace/src/layout`, `agent-workspace/src/engine`).
*   **Enforced Action**: Documentation overhead like Code Graphs are placed exclusively inside `agent-workspace/src/<layer>/code_graph/` (no symlinks required), and non-code legacy docs are staged inside `agent-workspace/plans/<branch_name>/resource/`.

---

## 2. Prompting Law

*   **Neutral Options Only**: The Grill Engine MUST NOT mark any option as `[Recommended]`. All options must be presented neutrally.
*   **Mandatory Free-Text Input**: Every multiple-choice question MUST include a final free-text input option (`Other / Free-text (...)`) enabling the user to provide custom instructions.
*   **Rule of 2**: Ask a maximum of 2 questions per turn to avoid cognitive overload.

---

## 3. Sequential Question List (Execution Order: Q1 to Q7)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below (bypassed entirely when `/process --sync` / `--pull` is invoked):

### Q1: `/init` Baseline Review & Verification
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
> **Our automated audit checked your linked legacy folders for remote Git origins, submodules, and external documentation links.**
>
> *Detected Remotes & Links:*
> * *[List of auto-detected Git remotes, submodules, and documentation URLs, if any]*
>
> **Are there any additional remote code repositories, Git submodules, or external documentation sources connected to this project that were forgotten or omitted during `/init`?**
> 1. No additional remote sources (Use detected links only)
> 2. Add remote Git code repository URL(s)
> 3. Add external documentation URL(s) (Notion, Confluence, Wiki, Google Drive)
> 4. Add Git submodule path(s) / URL(s)
> 5. Other / Free-text (Specify remote sources and access details)

---

### Q3: Legacy Source-to-Layer & Non-Code Docs Mapping Strategy
> **Based on file tree analysis, here is the proposed mapping of your legacy source code and non-code documentation:**
>
> | Legacy Source Path | Classification | Target Destination |
> | :--- | :--- | :--- |
> | `[legacy_src/ui/...]` | UI / Presentation | `agent-workspace/src/layout/` |
> | `[legacy_src/core/...]` | Core Business Logic | `agent-workspace/src/engine/` |
> | `[legacy_docs/...]` | Non-Code Docs & Assets | `agent-workspace/plans/<branch_name>/resource/` |
>
> **How would you like to handle the legacy source and documentation mapping into target destinations?**
> 1. Accept proposed automatic classification & mapping (source code to `agent-workspace/src/<layer>/`, non-code docs to `agent-workspace/plans/<branch_name>/resource/`)
> 2. Custom layer mapping (Specify custom destination paths for code and docs)
> 3. Map all source code to a single unified engine layer (`agent-workspace/src/engine`)
> 4. Other / Free-text (Provide custom file/directory mapping instructions)

---

### Q4: Workspace Code Graphs & Selective Blueprint Extraction Strategy
> **How should legacy documentation and architectural specs be processed into `agent-workspace/plans/<branch_name>/` blueprints and workspace Code Graph subfolders?**
> 1. Full Extraction & Workspace Code Graphs: Parse legacy docs/code, stage non-code docs in `agent-workspace/plans/<branch_name>/resource/`, generate `agent-workspace/src/<layer>/code_graph/` subfolders (with `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), and selectively populate relevant phase blueprints
> 2. API & Data Schema Focus: Extract DB models into Phase 3 (`phase-3-data.md`) and API endpoints into Phase 4 (`phase-4-engine.md`), generating Code Graphs for backend services
> 3. High-Level Summary Only: Extract core goals into Phase 1 (`phase-1-summary.md`) without deep documentation restructuring
> 4. Other / Free-text (Specify custom documentation extraction guidelines)

---

### Q-COV: Existing Test Coverage Discovery
> **Existing test assets detected: `<n>` suites across `<m>` directories, runner(s): `<list>`. How should they be catalogued?**
> 1. Catalogue all discovered suites, runners, fixtures and coverage config into `agent-workspace/plans/<branch_name>/resource/existing_coverage.md`
> 2. Catalogue only suites relevant to the active feature scope
> 3. Skip test discovery (no existing coverage, or greenfield feature)
> 4. Other / Free-text (Describe custom coverage discovery scope)

---

### Q5: Workflow Execution Mode & Proposal Generation
> **Which execution mode would you like to use for integrating your legacy codebase?**
> 1. **Standard Interactive Mode (`/process`)**: Summarize planned layer integrations and confirm before creating symlinks.
> 2. **Proposal Mode (`/process --proposal`)**: Generate detailed `agent-workspace/plans/<branch_name>/restructure-proposal.md` for upfront review before modifying workspace symlinks.
> 3. **Immediate Execution Mode (`/process --auto`)**: Authorize immediate creation of workspace symlinks and staging without pausing.
> 4. Other / Free-text (Specify custom execution or dry-run preferences)

---

### Q6: Integration Strategy: In-Place Symlink vs Scaffolding Migration
> **How should existing legacy source code be integrated into the workspace?**
> 1. **In-Place Symlink Mode**: Create symbolic links under `agent-workspace/src/<layer>` pointing directly to existing legacy directories (no duplicate storage, maintains single source of truth).
> 2. **Scaffolding & Copy Mode**: Scaffold new `codebase-*` sub-repositories and copy legacy files intact into them.
> 3. **Custom Workspace Link / Aliasing**: Configure custom path aliases in workspace configs (e.g. `tsconfig.json` paths, `pyproject.toml` PYTHONPATH).
> 4. Other / Free-text (Specify custom workspace link or environment configuration)

---

### Q7: Q&A Summary Verification & Execution Confirmation
> **Summary of Answers Gathered During `/process` Session:**
>
> | Environment | Question | Gathered Specification / Answer |
> | :--- | :--- | :--- |
> | **Agentic & Folder** | Q1 Baseline Review | *[Q1 Answer / Baseline status]* |
> | **Agentic** | Q2 Omitted Remotes Audit | *[Q2 Answer / Remotes & submodules]* |
> | **Folder & Software** | Q3 Legacy Source & Docs Mapping | *[Q3 Answer / Code to agent-workspace/src/<layer>, Docs to resource/]* |
> | **Agentic** | Q4 Code Graph & Docs | *[Q4 Answer / Workspace Code Graph subfolder & selective blueprint extraction scope]* |
> | **Qualify & Test** | Q-COV Test Coverage | *[Q-COV Answer / Discovery & cataloguing scope]* |
> | **Governance** | Q5 Execution Mode | *[Q5 Answer / Standard vs Proposal vs Immediate]* |
> | **Software** | Q6 Integration Strategy | *[Q6 Answer / In-place symlink vs scaffolding]* |
>
> **Reflecting on this summary, are you ready to execute the `/process` action?**
> 1. Everything is accurate $\rightarrow$ Execute `/process` action
> 2. Edit a specific answer (Specify question number to re-run)
> 3. Other / Free-text (Add further instructions, constraints, or notes for execution)
