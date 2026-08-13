# Guard Specification: Interactive Planning (/plan)

This document serves as the authoritative baseline specification for the `/plan` workflow in the **Guards Framework**. It governs how AI agents interactively create, maintain, and structure token-optimized, agent-ready 6-phase blueprint documentation, research reports, and version-linked implementation maps before code execution begins.

---

## 1. General Introduction & Core Philosophy

The `/plan` workflow is the architectural bridge between environment setup (`/init` / `/process`) and code implementation (`/implement`). It transforms raw ideas, feature requirements, and historical context into structured, unambiguous Phase Blueprints, research summaries, decision records, and structured implementation roadmaps.

```mermaid
graph LR
    Init["/init<br/>Environment Setup"] --> ProcHist["/process<br/>Legacy Resource Ingestion"]
    ProcHist --> Plan["/plan (Resource Usage & Knowledge Governance Rule)<br/>• Collect Knowledge & Research<br/>• Analyze System Impact (Partial vs. Full)<br/>• Select Simple vs. Multi-Layer Phase Details<br/>• Design Feature Capabilities & Decisions in phase-*.md<br/>• Draft Versioned Implementation Maps (Optional)<br/>• Store All Artifacts in plans/<feature-name>/<br/>  to share context with downstream agents"]
    Init --> Plan
    Plan --> Implement["/implement<br/>Action Implementation<br/>(Guided by versioned implementation_map_v<version>.md)"]
```

### Core Philosophy: `/plan` as a Resource Usage & Knowledge Governance Rule
Fundamentally, **the `/plan` workflow is a governed rule for resource usage and knowledge collection**:
- **Knowledge Collection & Analysis**: During `/plan`, the developer and AI agent collect research, analyze system impact, explore design alternatives, and capture strategic decisions for a new or modified system capability.
- **Context Sharing for Downstream Agents**: The overarching goal of storing all blueprints, research reports, and implementation maps strictly inside `agent-workspace/plans/<feature-name>/` is **to share complete, unambiguous context with AI agents in downstream phases** (`/implement`, `/verify`, `/release`).
- **Initial Feature Understanding Summary First**: Every `/plan` execution begins with the agent summarizing its initial understanding of the feature (synthesizing `/init`, `/process`, and user prompt context) before any questions are asked.
- **Affected System, Blueprint & Subfolder Identification Q&A**: Following the summary, the interactive Q&A session starts. Its primary goals are to pinpoint **which parts of the system are affected**, determine **which specific `phase-*.md` documents must be created**, and evaluate **whether a multi-layer phase details subfolder structure is needed**.
- **Decisions Embedded Directly in `phase-*.md`**: Decisions are documented **directly within the active `phase-*.md` documents** (and their sub-element blueprints inside `phase_details/`). There is no separate decisions folder.
- **Research Reports Saved in `knowledge/` & Linked**: Whenever research is requested to evaluate options, the report is saved under `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md` and linked directly inside the relevant `phase-*.md` files.
- **Version-Based Implementation Maps**: Implementation maps drafted in `implementation_maps/` are named after the target software version created from that map (e.g. `implementation_map_v1.0.0.md`), naturally linking planning to implementation and release.
- **All Planning Artifacts Placed in `plans/<feature-name>/`**: **EVERY document created or modified during `/plan`**—including 6-phase blueprints, research reports, and versioned implementation maps—MUST be placed inside `agent-workspace/plans/<feature-name>/`.
- **Iterative & Elastic Character**: Accommodates evolving ideas, mid-planning sub-element discovery, design alternatives, and strategic human decision turning points.

### Universal Design vs. Environment Implementation
- **Universal Design Specifications (Tier 2 - Platform-Agnostic)**:
  - [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md): Central framework sitemap and operational lifecycle.
  - [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md): Interactive Q&A interview engine rules.
  - [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md): Process status matrix and release governance rules.
  - [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/code_graph_taxonomy.md): Code graph structure and taxonomy specification.
  - [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/implementation_map_taxonomy.md): Implementation map structure and schema specification.
  - [plan_workflow.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/plan/plan_workflow.md) (*This Document*): Core `/plan` state machine design, boundary rules, and execution reasoning.
  - [plan_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/plan/plan_questions.md): Interactive planning questionnaire schema and scanning rules.
- **Environment-Specific Execution Guidelines (Tier 3 - Antigravity)**:
  - `antigravity/plan_implementation_map.md`: Antigravity-specific execution roadmap using native primitives (**rules, skills, workflows, templates, hooks**).
  - `antigravity/plan_tests.md`: Verification test suite for `/plan` execution.

---

## 2. Core Architectural Principles & Boundary Rules

### A. Workflow Preconditions & Pipeline Handoff
1. **`/init` is Mandatory**: `/init` (or `/init --feature <name>` / `/init --release <v>`) **must** have been executed prior to running `/plan`. `/init` establishes Git branches, provisions root `.agents/` control structures, and scaffolds the initial architectural baseline (`phase-1-summary.md`).
2. **`/process` is Optional**: For brownfield codebases, `/process` ingests legacy documentation and code history, drafting `restructure-proposal.md`. When present, `/plan` reads and incorporates these findings into the feature blueprints.

### B. Resource Usage Governance & Strict Feature Sandbox (`agent-workspace/plans/<feature-name>/`)
All creation, editing, research drafting, and decision documentation generated during `/plan` **MUST reside strictly inside `agent-workspace/plans/<feature-name>/`** to serve as the single source of truth for downstream agents:

1. **6-Phase Blueprints with Embedded Decisions**: `phase-1-summary.md` through `phase-6-operation.md` (active subset, including `phase-3-data.md` for data capturing, storing mechanisms, and data store lifecycle management). All architectural choices, ADRs, trade-off rationale, and design decisions are documented **directly inside the relevant `phase-*.md` documents**.
2. **Process & Interview Trackers**: `PROCESS_STATUS.md` and `GRILL_STATUS.md`.
3. **Research Reports & Topic Knowledge Summaries (`knowledge/`)**:
   - Whenever the user requests a research report or topic deep-dive to evaluate options during planning, the agent writes the document directly to `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md` (or `knowledge_summary_<topic>.md`).
   - Markdown links in `phase-1-summary.md` (and active phase blueprints) point to these research reports to provide complete contextual lineage.
4. **Version-Named Implementation Maps (`implementation_maps/`)**:
   - Implementation maps are stored in `agent-workspace/plans/<feature-name>/implementation_maps/` and are **named based on the software version** created from that map (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_layout.md`).
   - This explicitly ties the implementation roadmap to the software version produced during `/implement` and `/release`.

### C. Multi-Layer Sub-Element Architecture & On-Demand Subfolders Rule (`phase_details/`)
Complex features may encompass multiple distinct layers (e.g. web UI + mobile app UI, multiple microservice APIs, or distinct databases). The Guards Framework manages this complexity through an **on-demand hierarchy**:

1. **Default Simple Layout**: By default, features use the flat, simple 6 `phase-*.md` document structure directly inside `agent-workspace/plans/<feature-name>/`. Subfolders are **not** created unless required.
2. **Phase Blueprints as Governors**: In complex multi-layer features:
   - Top-level `phase-*.md` documents act as **master governors / orchestrators** for the entire feature.
   - Subfolders are created under `agent-workspace/plans/<feature-name>/phase_details/<element_name>/` (e.g. `phase_details/web_ui/`, `phase_details/mobile_app/`, `phase_details/payment_api/`).
   - Each subfolder contains sub-element design specs and phase blueprints governing that specific component.
3. **Q&A Identification & Mid-Planning Discovery**:
   - The need for multi-layer subfolders is evaluated during the Node S3 Q&A session.
   - If new sub-elements are discovered **mid-planning** as ideas evolve, the folder structure adapts dynamically to provision the necessary subfolders under `agent-workspace/plans/<feature-name>/phase_details/`.

### D. Versioned Implementation Map & Asynchronous Execution Rule
System components can be implemented **in parallel, sequentially, or all at once**. Consequently, the workflow supports decoupled implementation planning guided by a **versioned implementation map**:

1. **Structured Document & Version Naming**: An implementation map is a formal document adhering to [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/implementation_map_taxonomy.md). It is named after the target software version (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_engine.md`).
2. **Step-by-Step Agent Guidance**: Serves as the agent's authoritative roadmap during the `/implement` workflow.
3. **Flexible Creation Lifecycle**: An `implementation_map_v<version>.md` can be created:
   - **At the end of the `/plan` phase** (via an explicit option in Node S5), OR
   - **At the beginning of the `/implement` phase**.
4. **Partial & Decoupled Scope**: A versioned implementation map can cover:
   - **A single part for a specific version** (e.g. `implementation_map_v1.1.0_layout.md`),
   - **Multiple parts**, OR
   - **The entire feature version at once** (`implementation_map_v1.0.0.md`).

### E. Implementation Map Sandbox Guard (No Code Execution in `/plan`)
When the option to create a versioned `implementation_map_v<version>.md` is selected during `/plan`:
- **Allowed Action**: The agent identifies the target implementation scope/version and drafts `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` adhering to the structured implementation map schema.
- **STRICT PROHIBITION**: **ONLY the creation/drafting of the `implementation_map.md` document is allowed during `/plan`. NO code scaffolding, file editing in `src/` or `codebase-*/`, or actual code implementation is permitted during `/plan`!** Source code implementation remains strictly reserved for the `/implement` workflow.

### F. Dynamic Blueprint Lifecycle & Iterative Scope Evolution
Feature designs within `agent-workspace/plans/<feature-name>/` can relate to **isolated parts of the system** or **the entire system**. Consequently, blueprint generation follows a dynamic, evolving method:

1. **Start with Feature Understanding Summary**: The workflow starts by articulating a clear summary of the planned feature capabilities.
2. **Identify Affected System Parts**: The Q&A session evaluates which system layers (Frontend, Data, Engine, API, DB, Ops) are impacted and whether multi-layer subfolders (`phase_details/`) are needed.
3. **Select Required `phase-*.md` Blueprint Set**: A feature may contain all 6 phase blueprint documents (`phase-1-summary.md` through `phase-6-operation.md`, including `phase-3-data.md`) or only a relevant subset.
4. **Elastic Mid-Planning Scope Evolution**: **The number of active `phase-*.md` files, sub-element folders, and their defined scope can dynamically change and evolve *during* the planning phase**.

### G. System-Wide Documentation Taxonomy & Resource Separation
The Guards Framework strictly decouples theoretical design intent, system-wide feature summaries, and implementation-level structural code graphs:

1. **`plans/<feature-name>/` (Feature Design, Knowledge & Impact Sandbox - Written during `/plan`)**:
   - Holds feature design blueprints with embedded decisions, System Impact Analysis, topic research reports, `phase_details/` sub-element design folders, and versioned implementation maps.
2. **`docs/` (General System Documentation - Written during `/implement`)**:
   - Contains general system-wide documentation describing all active features across the entire system.
   - Maintained and updated during `/implement` when code changes are completed.
3. **`codebase-*/code_graph/` or `src/*/code_graph/` (Inner Structural Code Maps - Written during `/implement`)**:
   - Contains AST-level taxonomy, component call graphs, DTO schemas, and class/module dependency graphs detailing the inner structure of the source code.
   - Built and maintained during `/implement` using [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/code_graph_taxonomy.md).

### H. Filesystem Boundary Guard Rule
The `/plan` workflow enforces a strict write sandbox:
- **Allowed Workspace**: All write, edit, create, and delete actions are **strictly restricted to**:
  - **`agent-workspace/plans/<feature-name>/`** (and all its subfolders)
- **Forbidden Actions**: `/plan` is **strictly prohibited** from modifying general system documentation in `docs/`, code graphs in `src/*/code_graph/`, or source code files (`src/`, `codebase-*/`). General system documentation updates and code graph generation are explicitly deferred to `/implement`.

---

## 3. Directory Layout & Document Hierarchy

### Default Simple Layout (Baseline)
```text
agent-workspace/plans/<feature-name>/
├── PROCESS_STATUS.md               # Feature status matrix & execution history log
├── GRILL_STATUS.md                 # Stateful Q&A interview transcript log
├── phase-1-summary.md              # Phase 1: Architecture, System Coverage, Decisions & System Impact Analysis
├── phase-2-layout.md              # Phase 2: Design System, UI Layout & Component Decisions
├── phase-3-data.md                # Phase 3: Data Handling, Capturing, Storing Mechanisms & Data Store Lifecycle
├── phase-4-engine.md              # Phase 4: Core Engine, API Contracts, Data Flow & DB Decisions
├── phase-5-verification.md        # Phase 5: Test Specifications & Regression Assertions
├── phase-6-operation.md           # Phase 6: Docker, Compose & Infrastructure Decisions
├── knowledge/                      # Topic Research Reports & Knowledge Summaries requested during /plan
│   ├── research_report_<topic>.md    # Research report evaluating options requested by user
│   └── knowledge_summary_<topic>.md   # Deep-dive topic overview
└── implementation_maps/            # Version-named Implementation Maps drafted at end of /plan
    ├── implementation_map_v1.0.0.md   # Version-linked full feature implementation map
    └── implementation_map_v1.1.0_layout.md # Version-linked partial layout map
```

### Complex Multi-Layer Layout (On-Demand / Identified during Q&A)
```text
agent-workspace/plans/<feature-name>/
├── PROCESS_STATUS.md               # Master status matrix tracking overall and sub-element workflows
├── GRILL_STATUS.md                 # Stateful Q&A transcript
├── phase-1-summary.md              # Master Architecture & Vision Governor (with top-level decisions)
├── phase-2-layout.md              # Master Design System & UI Governor
├── phase-3-data.md                # Master Data Handling & Lifecycle Governor
├── phase-4-engine.md              # Master Core Engine & API Contracts Governor
├── phase-5-verification.md        # Master Test & Assertion Governor
├── phase-6-operation.md           # Master Operations & Deployment Governor
├── phase_details/                  # Detailed sub-element design folders (created on-demand)
│   ├── web_ui/                     # Web interface layout & component specs
│   │   └── phase-2-layout.md       # Sub-element UI layout spec & decisions
│   ├── mobile_app/                 # App interface layout & view specs
│   │   └── phase-2-layout.md       # Sub-element Mobile UI spec & decisions
│   ├── auth_api/                   # Authentication API & DTO specs
│   │   └── phase-4-engine.md       # Sub-element API contract spec & decisions
│   └── inventory_db/               # Inventory Database & Schema specs
│       └── phase-3-data.md         # Sub-element DB schema & data store lifecycle spec
├── knowledge/                      # Research reports (linked directly into phase-*.md)
│   └── research_report_<topic>.md
└── implementation_maps/            # Version-named Implementation Maps
    └── implementation_map_v1.0.0.md
```

---

## 4. Detailed Step-by-Step State Machine Design

Execution of the `/plan` workflow follows a strict 7-node sequential state machine starting with an initial feature summary, leading into affected system & multi-layer subfolder identification Q&A, and offering an optional Versioned Implementation Map drafting gate at Node S5:

```mermaid
graph TD
    S1[Node S1: Check Environment & Preconditions] --> S2[Node S2: Initial Feature Understanding Summary]
    S2 --> S3[Node S3: Interactive Q&A Session<br/>Identify Affected System, phase-*.md Set & Subfolders]
    S3 -->|Scope/Sub-Element Discovery or Research Request| S3_Docs[Draft phase_details/ Folders & Research Reports under knowledge/]
    S3_Docs --> S3
    S3 -->|Affected System & Blueprint Structure Finalized| S4[Node S4: Dynamic Blueprint Scaffolding & Embedded Decision Drafting]
    S4 --> S5[Node S5: Execution Acceptance Gate & Implementation Map Option]
    S5 -->|Human Decision Turning Point / Revision| S3
    S5 -->|Option Selected: Draft Versioned Implementation Map| S5_Map[Identify Map Version/Scope & Draft implementation_map_v<version>.md in plans/<feature-name>/<br/>(NO CODE EDITING)]
    S5_Map --> S6
    S5 -->|Approved / --auto| S6[Node S6: PROCESS_STATUS.md Sync & Log Update]
    S6 --> S7[Node S7: Planning Completed]
```

---

### Step Descriptions & Implementation Reasoning

#### Step 1: Check Environment & Preconditions (Node S1)
* **Description**: Verifies workspace initialization (`.agents/` and active Git branch state). Asserts Docker engine status.
* **Storage Actions**: Reads `agent-workspace/plans/PROCESS_STATUS.md` or git branch metadata.

#### Step 2: Initial Feature Understanding Summary (Node S2)
* **Description**: **As the very first action of `/plan`**, the agent synthesizes its initial understanding of the feature scope (from `/init` outputs, `/process` outputs, and initial user prompt) and presents an **Initial Feature Understanding Summary** to the developer.
* **Reasoning**: Establishing a shared understanding up front aligns the developer and agent before asking detailed Q&A questions.
* **Storage Actions**: Initializes `agent-workspace/plans/<feature-name>/` directory structure and logs initial summary.

#### Step 3: Interactive Q&A Session - Affected System, Blueprint & Subfolder Identification (Node S3)
* **Description**: Immediately follows the initial summary. Executes stateful Q&A interview governed by [grill_engine.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md).
* **Primary Goals**:
  1. Identify **which parts of the system are affected** (Frontend, Engine, API, DB, Operations; partial sub-module vs. full system).
  2. Determine **which specific `phase-*.md` documents should be created** for this feature.
  3. Evaluate **whether multi-layer subfolders (`phase_details/`) are required** (for complex features with multiple UIs or APIs), or if the default simple layout is sufficient.
  4. Support mid-planning discovery: if new sub-elements surface during Q&A, dynamically provision subfolders under `agent-workspace/plans/<feature-name>/phase_details/`.
  5. Support developer requests for **research reports** (`knowledge/`), writing reports to `knowledge/research_report_<topic>.md` and linking them directly inside `phase-*.md`.
* **Storage Actions**: Updates `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

#### Step 4: Dynamic Blueprint Scaffolding & Impact Drafting (Node S4)
* **Description**: Scaffolds the selected active phase blueprint documents (`phase-1-summary.md` plus identified `phase-*.md` set) and any required `phase_details/` subfolder specs under `agent-workspace/plans/<feature-name>/`, explicitly documenting feature design, master governors, embedded decisions, affected system parts, and system impact analysis.
* **Rules**: Strictly respects the Workspace Boundary rule (writing ONLY to `agent-workspace/plans/<feature-name>/`).
* **Storage Actions**: Deploys/updates populated phase blueprint files and sub-element specs.

#### Step 5: Execution Acceptance Gate & Implementation Map Option (Node S5)
* **Description**: Synthesizes the generated blueprint set into an Execution Acceptance Summary for developer review.
* **Versioned Implementation Map Option**:
  - Developers can choose an explicit option: **Draft Versioned Implementation Map for Target Release**.
  - When selected, the agent identifies the target software version and scope (e.g. `v1.0.0` or `v1.1.0_layout`) and drafts `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` adhering to [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/implementation_map_taxonomy.md).
  - **STRICT PROHIBITION**: ONLY the creation of the versioned map document inside `agent-workspace/plans/<feature-name>/` is allowed. **Zero code scaffolding or source code modification is permitted during `/plan`**.
* **Storage Actions**: Writes `implementation_map_v<version>.md` and appends acceptance status to `GRILL_STATUS.md`.

#### Step 6: PROCESS_STATUS.md Sync & Log Update (Node S6)
* **Description**: Synchronizes `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`. Updates Block 1 matrix sub-rows to reflect active phase blueprints, sub-elements, and drafted versioned implementation maps (`[x] Done` for active, `[-] Not In Scope` for unneeded), and appends datestamped entry to Block 2.
* **Storage Actions**: Writes updated `PROCESS_STATUS.md`.

#### Step 7: Planning Completed (Node S7)
* **Description**: Displays completion report listing generated phase blueprints, sub-element design folders, drafted versioned implementation maps, and instructions to proceed to `/implement`.
* **Storage Actions**: Final state transition complete.

---

## 5. Knowledge Consumption & Lifecycle Deferred Operations

```mermaid
graph TD
    subgraph Phase1_Plan [/plan Workflow Sandbox]
        InitIn["/init Output<br/>(phase-1-summary.md)"] --> S2_Summary["Node S2: Initial Feature Understanding Summary"]
        HistIn["/process Output<br/>(restructure-proposal.md)"] --> S2_Summary
        S2_Summary --> S3_QA["Node S3: Q&A Session<br/>Identify Affected System, phase-*.md Set & Subfolders"]
        S3_QA --> S5_MapOption["Node S5: Draft Versioned Implementation Map (Optional)"]
        S5_MapOption --> PlanOut["agent-workspace/plans/<feature-name>/<br/>• PROCESS_STATUS.md<br/>• phase-1-summary.md (Governor with Embedded Decisions)<br/>• Selected phase-*.md set<br/>• phase_details/ (On-Demand Subfolders)<br/>• knowledge/ (Research Reports linked into phase-*.md)<br/>• implementation_maps/ (Version-linked maps: implementation_map_v1.0.0.md)<br/>(Structured context & map repository for downstream agents)"]
    end

    subgraph Phase2_Implement [/implement Sandbox]
        PlanOut --> ImpExec["Code Scaffolding & Verification<br/>(Guided by version-linked implementation_map_v<version>.md schema)"]
        ImpExec --> DocsGen["General System Docs<br/>(docs/)"]
        ImpExec --> GraphGen["Inner Structural Code Graphs<br/>(src/*/code_graph/)"]
    end
```

---

## 6. Summary of Guard Elements for `/plan`

1. **Precondition Guard**: Halts execution if `.agents/` or `/init` baseline is missing.
2. **Resource Usage & Knowledge Governance Guard**: Establishes `/plan` as the governed rule for collecting, analyzing, and structuring knowledge in `agent-workspace/plans/<feature-name>/` to share complete context with downstream AI agents.
3. **Initial Summary Mandate**: Forces `/plan` to open with an agent synthesis of feature understanding before starting Q&A.
4. **Embedded Decisions Guard**: Prohibits creating a separate decisions subfolder; forces all architectural decisions and trade-off choices to be documented directly within active `phase-*.md` documents.
5. **Research Report Linkage Guard**: Stores research reports in `knowledge/research_report_<topic>.md` and mandates direct markdown file links inside `phase-*.md` blueprints.
6. **Version-Linked Implementation Map Guard**: Governs the creation of `implementation_map_v<version>.md` files named after the target software version, while strictly forbidding code execution during `/plan`.
7. **Phase Details Hierarchy Guard**: Maintains simple flat `phase-*.md` blueprints by default, while dynamically creating `phase_details/` subfolders for multi-layer features using top-level phase docs as master governors.
8. **All-Documents Sandbox Guard**: Enforces that **ALL** documents generated during `/plan` (blueprints, subfolders, research reports, implementation maps) reside strictly within `agent-workspace/plans/<feature-name>/`.
9. **System Identification & Blueprint Selection Guard**: Directs the Q&A session to identify affected system parts and select the exact subset of `phase-*.md` documents and subfolder structures to create.
10. **Elastic Design Guard**: Governs iterative human decision turning points, design pivots, mid-planning sub-element discovery, and idea explorations during planning.
11. **Boundary Guard**: Restricts write actions strictly to `agent-workspace/plans/<feature-name>/`. Prohibits modifying `docs/`, `src/*/code_graph/`, or source code during `/plan`.
12. **Documentation Taxonomy Guard**: Decouples feature design & impact (`plans/<feature-name>/`) from general system docs (`docs/`) and inner code structure (`code_graph/`).
13. **System Impact Guard**: Enforces explicit documentation of feature aftermath/impact on existing system features.
14. **Grill State Engine**: Governed by `grill_engine.md`, auto-saving interview progress into `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.
15. **Process Guard**: Governed by `process_handling.md`, maintaining Block 1 matrix and Block 2 datestamped execution history in `PROCESS_STATUS.md`.
16. **Workflow Context Notification Guard**: Enforces the 3-Layer Workflow Context Notification Law (1-line turn banners `> 📍 **Active Workflow**: /plan | **Scope**: <feature> | **Node**: <Node_ID>`, state node transition badges, and persistent disk header metadata).
