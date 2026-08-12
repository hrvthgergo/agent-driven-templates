# Rule Guard: Legacy Code & Docs Processing Interview (`rules/process-grill.md`)

This rule guard defines the unchangeable baselines, prompting laws, and sequential Q1–Q7 interview questions for the `/process` workflow's Grill Engine in Google Antigravity.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational safety, non-destructive file processing, and clean production layer separation, the following baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/process` interview**:

### Baseline 1: Read-Only Legacy Source Rule & Isolated Destination Execution
*   **Specification**: Original legacy code repositories and external source folders MUST remain 100% untouched and read-only. `/process` is STRICTLY FORBIDDEN from performing in-place edits, file moves, overwrites, or deletions inside original legacy source directories.
*   **Enforced Action**: All file copying, code graph generation, non-code doc resource staging, and blueprint synthesis MUST occur exclusively within the new workspace folder structure created during `/init` (`agent-workspace/` control plane and target `codebase-*` sub-repositories).

### Baseline 2: Target Layout Alignment & Clean Service Sub-Repos
*   **Specification**: Source code migration MUST target the sub-repository layer layout (`codebase-layout`, `codebase-engine`, etc.) created during `/init`.
*   **Enforced Action**: Production `codebase-*` sub-repositories contain strictly service implementation code and build specs required to build/run the service. Documentation overhead like Code Graphs are placed exclusively inside `agent-workspace/src/<layer>/code_graph/` (no symlinks required), and non-code legacy docs are staged inside `agent-workspace/plans/<branch_name>/resource/`.

---

## 2. Prompting Law

*   **Neutral Options Only**: The Grill Engine MUST NOT mark any option as `[Recommended]`. All options must be presented neutrally.
*   **Mandatory Free-Text Input**: Every multiple-choice question MUST include a final free-text input option (`Other / Free-text (...)`) enabling the user to provide custom instructions.
*   **Rule of 2**: Ask a maximum of 2 questions per turn to avoid cognitive overload.

---

## 3. Sequential Question List (Execution Order: Q1 to Q7)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

### Q1: `/init` Baseline Review & Verification
> **Here is the summary of project knowledge and legacy folders collected during `/init`:**
>
> | Category | Identified Baseline |
> | :--- | :--- |
> | **Project Vision** | *[Summary of purpose and milestone goals]* |
> | **Linked Folders** | *[Paths to local legacy code and doc directories]* |
> | **Software Stack** | *[Languages, frameworks, package managers]* |
> | **Target Layers** | *[Configured codebase-* sub-repositories]* |
>
> **Would you like to proceed with this legacy codebase baseline, or add/update linked legacy folder locations before scanning?**
> 1. Proceed with current baseline
> 2. Add additional local legacy folder paths
> 3. Other / Free-text (Specify updates to initial project baseline)

---

### Q2: Audit for Omitted Remote Sources & Submodules
> **Our automated audit checked your linked legacy folders for remote Git origins, submodules, and external documentation links.**
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
> | `[legacy_src/ui/...]` | UI / Presentation | `codebase-layout/src/` |
> | `[legacy_src/core/...]` | Core Business Logic | `codebase-engine/src/` |
> | `[legacy_docs/...]` | Non-Code Docs & Assets | `agent-workspace/plans/<branch_name>/resource/` |
>
> **How would you like to handle the legacy source and documentation mapping into target destinations?**
> 1. Accept proposed automatic classification & mapping (source code to `codebase-*`, non-code docs to `agent-workspace/plans/<branch_name>/resource/`)
> 2. Custom layer mapping (Specify custom destination paths for code and docs)
> 3. Keep all source code in a single sub-repository (`codebase-engine`)
> 4. Other / Free-text (Provide custom file/directory mapping instructions)

---

### Q4: Workspace Code Graphs & Selective Blueprint Extraction Strategy
> **How should legacy documentation and architectural specs be processed into `agent-workspace/plans/<branch_name>/` blueprints and workspace Code Graph subfolders?**
> 1. Full Extraction & Workspace Code Graphs: Parse legacy docs/code, stage non-code docs in `agent-workspace/plans/<branch_name>/resource/`, generate `agent-workspace/src/<layer>/code_graph/` subfolders (with `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), and selectively populate relevant phase blueprints
> 2. API & Data Schema Focus: Extract API endpoints and DB models into Phase 3 (`phase-3-engine.md`) and generate Code Graphs for backend services
> 3. High-Level Summary Only: Extract core goals into Phase 1 (`phase-1-summary.md`) without deep documentation restructuring
> 4. Other / Free-text (Specify custom documentation extraction guidelines)

---

### Q5: Workflow Execution Mode & Consent Strategy
> **Which execution option would you like to use for processing your legacy codebase?**
> 1. **Plan-First Mode (`/process --plan`)**: Create detailed `agent-workspace/plans/<branch_name>/restructure-proposal.md` and pause for review & approval before modifying any files.
> 2. **Immediate Execution Mode (`/process --auto`)**: Authorize immediate copying/moving of legacy files into `codebase-*` layers without stopping, recording the execution log automatically.
> 3. Other / Free-text (Specify custom execution or dry-run preferences)

---

### Q6: As-Is Code Migration & Path Linking Strategy
> **Legacy source code will be copied intact into the designed `codebase-*` sub-repositories without modifying or rewriting code. How should module resolution and path linking be configured in the workspace?**
> 1. Use standard workspace symbolic links (`agent-workspace/src/<layer>` $\rightarrow$ `../../codebase-<layer>/src/`)
> 2. Configure package aliases in root workspace configs (e.g. `tsconfig.json` paths, `pyproject.toml` PYTHONPATH)
> 3. Other / Free-text (Specify custom workspace link or environment configuration)

---

### Q7: Q&A Summary Verification & Execution Confirmation
> **Summary of Answers Gathered During `/process` Session:**
>
> | Environment | Question | Gathered Specification / Answer |
> | :--- | :--- | :--- |
> | **Agentic & Folder** | Q1 Baseline Review | *[Q1 Answer / Baseline status]* |
> | **Agentic** | Q2 Omitted Remotes Audit | *[Q2 Answer / Remotes & submodules]* |
> | **Folder & Software** | Q3 Legacy Source & Docs Mapping | *[Q3 Answer / Code to codebase-*, Docs to resource/]* |
> | **Agentic** | Q4 Code Graph & Docs | *[Q4 Answer / Workspace Code Graph subfolder & selective blueprint extraction scope]* |
> | **Governance** | Q5 Execution Mode | *[Q5 Answer / Plan-First vs Immediate]* |
> | **Software** | Q6 Path & Link Strategy | *[Q6 Answer / Symlink & path aliasing strategy]* |
>
> **Reflecting on this summary, are you ready to execute the `/process` workflow?**
> 1. Everything is accurate $\rightarrow$ Execute `/process` action
> 2. Edit a specific answer (Specify question number to re-run)
> 3. Other / Free-text (Add further instructions, constraints, or notes for execution)
