# Grill Schema: Legacy Code & Docs Processing Questions (/process-history)

This document defines the Q&A interview schema, auto-detection rules, unchangeable baselines, and structured prompts used by the `/process-history` workflow's Grill Engine.

The primary objective of the `/process-history` workflow is to synthesize **three core knowledge sources**:
1. **`/init` Baseline Knowledge**: Metadata, linked folder paths, technology stack, and layer configurations collected during `/init`.
2. **Interactive Grill-Me Knowledge**: Developer choices gathered during this Q&A interview (execution options, layer mappings, import refactoring rules).
3. **Existing Codebase & Documentation Knowledge**: Deep code structures, module dependencies, API endpoints, database schemas, and specs extracted from legacy folders.

Based on these sources, `/process-history` **adds and restructures** previous implementations into the new `codebase-*` sub-repository layout created during `/init`, while **linking all previous remote origins, submodules, and documentation sources** to the workspace.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational safety, non-destructive file processing, and structural consistency, the following baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/process-history` interview**:

### Baseline 1: Read-Only Legacy Source Rule & Isolated Destination Execution
* **Specification**: Original legacy code repositories and external source folders MUST remain 100% untouched and read-only. `/process-history` is STRICTLY FORBIDDEN from performing in-place edits, file moves, overwrites, or deletions inside original legacy source directories.
* **Enforced Action**: All file copying, code refactoring, relative import path rewriting, and blueprint synthesis MUST occur exclusively within the new folder structure created during `/init` (`antigravity-workspace/` and target `codebase-*` sub-repositories). Original legacy repos remain pristine reference sources.

### Baseline 2: Target Layout Alignment
* **Specification**: File restructuring MUST target the sub-repository layer layout (`codebase-layout`, `codebase-engine`, etc.) created during `/init` and linked symbolically under `antigravity-workspace/src/`.

---

## 2. Questions & Scanning Blueprint

```
                      ┌──────────────────────────────────────┐
                      │ Start /process-history Scan & Audit  │
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

* **Prerequisite Enforcement Gate**: The Grill Engine MUST first check for `.agents/plans/PROCESS_STATUS.md`. If missing or if `/init` is marked `Not Started`, the agent MUST immediately stop execution and instruct the user to run `/init` first.
* **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom instructions.

---

## 3. Sequential Question List (Execution Order: Q1 to Q7)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

---

### Q1: `/init` Knowledge Synthesis & Baseline Review
* **Target Environment**: Agentic & Folder Environment
* **Goal**: Summarize knowledge gathered during `/init` (linked folders, tech stack, workspace layers) and confirm the baseline for legacy code processing.
* **Auto-Detection Scanning Rule**:
  * Inspect `.agents/plans/phase-1-summary.md` and `.agents/plans/PROCESS_STATUS.md`.
  * Read mapped local legacy folder paths, identified tech stack, and Docker configurations.
* **Reframed Grill Prompt**:
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
* **Target Environment**: Agentic Environment
* **Goal**: Discover any remote code origins, Git submodules, external documentation URLs, or cloud repositories linked to the legacy codebase that were omitted or forgotten during `/init`.
* **Auto-Detection Scanning Rule**:
  * Inspect `.git/config` and `.gitmodules` inside all linked legacy folder paths (`git remote -v`, `git submodule status`).
  * Scan `README.md` and documentation files across linked folders for external URLs (Confluence, Notion, Wiki, remote Git hosts).
* **Reframed Grill Prompt**:
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
* **Resulting Action**: Registers newly identified remotes and submodules into `.agents/plans/phase-1-summary.md` and updates repository tracking.

---

### Q3: Legacy Source-to-Layer Mapping Strategy
* **Target Environment**: Folder & Software Environment
* **Goal**: Determine how existing legacy source files and non-code documentation should be grouped and mapped:
  * **Source Code**: Mapped into `codebase-*` sub-repository skeletons (`codebase-layout/src/`, `codebase-engine/src/`).
  * **Non-Code Documentation & Assets**: Staged in **`.agents/plans/<feature-name>/resource/`** (or `.agents/plans/resource/`) as feature reference knowledge. (Global `docs/` is reserved for already implemented capabilities and will be updated later during `/implement`).
* **Auto-Detection Scanning Rule**:
  * Inspect file trees across linked legacy directories.
  * Auto-classify files by type and pattern:
    * UI / Views / Styles / Templates $\rightarrow$ `codebase-layout/src/`
    * Domain Logic / Models / Controllers / APIs / Services $\rightarrow$ `codebase-engine/src/`
    * Tests / Mocks / Fixtures $\rightarrow$ `codebase-tests/` (or layer internal test folders)
    * Specs / Architecture Docs / Manuals / Schemas / PDFs $\rightarrow$ `.agents/plans/<feature-name>/resource/`
* **Reframed Grill Prompt**:
  > **Based on file tree analysis, here is the proposed mapping of your legacy source code and documentation:**
  >
  > | Legacy Source Path | Classification | Target Destination |
  > | :--- | :--- | :--- |
  > | `[legacy_src/ui/...]` | UI / Presentation | `codebase-layout/src/` |
  > | `[legacy_src/core/...]` | Core Business Logic | `codebase-engine/src/` |
  > | `[legacy_docs/...]` | Non-Code Docs & Assets | `.agents/plans/<feature-name>/resource/` |
  >
  > **How would you like to handle the legacy source and documentation mapping?**
  > 1. Accept proposed automatic classification & mapping (code to codebase-*, non-code docs to .agents/plans/<feature-name>/resource/)
  > 2. Custom layer mapping (Specify custom destination paths for code and docs)
  > 3. Keep all source code in a single sub-repository (`codebase-engine`)
  > 4. Other / Free-text (Provide custom file/directory mapping instructions)

---

### Q4: Legacy Documentation, Workspace Code Graphs, & Blueprint Extraction Strategy
* **Target Environment**: Agentic Environment
* **Goal**: Define how legacy documentation, specifications, API schemas, and architecture notes should be extracted to populate relevant phase blueprints (`phase-1-summary.md` through `phase-5-operation.md` in `.agents/plans/<feature-name>/`) and generate **Workspace Code Graph Subfolders** (`antigravity-workspace/src/<layer>/code_graph/`).
* **Selective Blueprint Rule**: Phase blueprint documents are populated **selectively based on relevance** of identified content. Filling out all 5 phase documents is **not mandatory**.
* **Auto-Detection Scanning Rule**:
  * Scan linked legacy folders for markdown docs (`*.md`), OpenAPI/Swagger specs (`.yaml`, `.json`), database schemas (`.sql`, ORM models), and source code structural elements (interfaces, classes, functions, entities).
* **Reframed Grill Prompt**:
  > **How should legacy documentation and architectural specs be processed into `.agents/plans/<feature-name>/` blueprints and workspace Code Graph subfolders?**
  > 1. Full Extraction & Workspace Code Graphs: Parse legacy docs/code, stage non-code docs in `.agents/plans/<feature-name>/resource/`, generate `antigravity-workspace/src/<layer>/code_graph/` subfolders (with `graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`), and selectively populate relevant phase blueprints
  > 2. API & Data Schema Focus: Extract API endpoints and DB models into Phase 3 (`phase-3-engine.md`) and generate Code Graphs for backend services
  > 3. High-Level Summary Only: Extract core goals into Phase 1 (`phase-1-summary.md`) without deep documentation restructuring
  > 4. Other / Free-text (Specify custom documentation extraction guidelines)

---

### Q5: Workflow Execution Mode & Consent Strategy
* **Target Environment**: Software & Workflow Governance
* **Goal**: Select the operational execution mode for `/process-history`:
  * **Plan-First Mode (`/process-history` or `/process-history --plan`)**: Generate execution plan (`restructure-proposal.md`), pause execution, wait for developer review and explicit approval before modifying code.
  * **Immediate Execution Mode (`/process-history --auto` or `/process-history --apply`)**: Copy/move files into `codebase-*` structures immediately without pausing for approval, while recording `.agents/plans/restructure-proposal.md` as an audit log.
* **Reframed Grill Prompt**:
  > **Which execution option would you like to use for processing your legacy codebase?**
  > 1. **Plan-First Mode (`/process-history --plan`)**: Create detailed `.agents/plans/restructure-proposal.md` and pause for review & approval before modifying any files.
  > 2. **Immediate Execution Mode (`/process-history --auto`)**: Authorize immediate copying/moving of legacy files into `codebase-*` layers without stopping, recording the execution log automatically.
  > 3. Other / Free-text (Specify custom execution or dry-run preferences)

---

### Q6: As-Is Code Migration & Path Linking Strategy
* **Target Environment**: Software & Folder Environment
* **Goal**: Confirm that source files are copied intact without code modification, and determine path linking / alias configuration for workspace resolution.
* **Non-Rewriting Rule**: Source code logic and file contents MUST NOT be edited, rewritten, or refactored during `/process-history`. All files are copied intact.
* **Reframed Grill Prompt**:
  > **Legacy source code will be copied intact into the designed `codebase-*` sub-repositories without modifying or rewriting code. How should module resolution and path linking be configured in the workspace?**
  > 1. Use standard workspace symbolic links (`antigravity-workspace/src/<layer>` $\rightarrow$ `../codebase-<layer>/src/`)
  > 2. Configure package aliases in root workspace configs (e.g. `tsconfig.json` paths, `pyproject.toml` PYTHONPATH)
  > 3. Other / Free-text (Specify custom workspace link or environment configuration)

---

### Q7: Q&A Summary Verification & Execution Confirmation
* **Target Environment**: Cross-Environment Verification
* **Goal**: Format a clean summary table of all answers gathered across Q1–Q6, confirm the execution option, and initiate the `/process-history` action.
* **Execution Rule**:
  1. The Grill Engine MUST format and display a clean summary table of all answers gathered across Q1–Q6.
  2. The Grill Engine MUST prompt the user to confirm execution or edit answers.
* **Reframed Grill Prompt**:
  > **Summary of Answers Gathered During `/process-history` Session:**
  >
  > | Environment | Question | Gathered Specification / Answer |
  > | :--- | :--- | :--- |
  > | **Agentic & Folder** | Q1 Baseline Review | *[Q1 Answer / Baseline status]* |
  > | **Agentic** | Q2 Omitted Remotes Audit | *[Q2 Answer / Remotes & submodules]* |
  > | **Folder & Software** | Q3 Legacy Source Mapping | *[Q3 Answer / Layer mapping strategy]* |
  > | **Agentic** | Q4 Code Graph & Docs | *[Q4 Answer / Workspace Code Graph subfolder & blueprint extraction scope]* |
  > | **Governance** | Q5 Execution Mode | *[Q5 Answer / Plan-First vs Immediate]* |
  > | **Software** | Q6 Path & Link Strategy | *[Q6 Answer / Symlink & path aliasing strategy]* |
  >
  > **Reflecting on this summary, are you ready to execute the `/process-history` workflow?**
  > 1. Everything is accurate $\rightarrow$ Execute `/process-history` action
  > 2. Edit a specific answer (Specify question number to re-run)
  > 3. Other / Free-text (Add further instructions, constraints, or notes for execution)
* **Resulting Action**: Saves answers to `.agents/plans/GRILL_STATUS.md`, copies legacy files intact to target `codebase-*` layers, generates modular `antigravity-workspace/src/<layer>/code_graph/` subfolders (containing `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md`) inside the workspace layer directory (no symlinks required), populates all 5 phase blueprints in `.agents/plans/` (`phase-1-summary.md` through `phase-5-operation.md`), and updates `.agents/plans/PROCESS_STATUS.md` to finalize `/process-history`.
