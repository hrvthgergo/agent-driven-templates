# Grill Schema: Interactive Planning Questions (/plan)

This document defines the Q&A interview questionnaire schema, auto-detection scanning rules, unchangeable baselines, and structured prompts used by the `/plan` workflow's Grill Engine session.

The primary objective of the `/plan` Grill-Me session is to guide the developer and AI agent through the interactive design of a new or modified feature, identifying affected system parts, selecting active `phase-*.md` blueprint subsets, evaluating multi-layer subfolders, and capturing all knowledge and decisions inside `.agents/plans/<feature-name>/`.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational stability and system governance, the following four baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/plan` interview**:

### Baseline 1: Initial Feature Understanding Summary Mandate (Node S2)
* **Specification**: Every `/plan` session **MUST** open with the agent synthesizing its initial understanding of the feature (from `/init` outputs, `/process` outputs, and user prompt context) and presenting an **Initial Feature Understanding Summary** to the developer before any questions are asked.

### Baseline 2: Strict Feature Plan Sandbox (`.agents/plans/<feature-name>/`)
* **Specification**: ALL files created or modified during `/plan`—including active phase blueprints, `knowledge/` research notes, `decisions/` ADRs, `sub_elements/` folders, and `implementation_maps/`—MUST reside strictly within `.agents/plans/<feature-name>/`.

### Baseline 3: Implementation Map Sandbox Guard (No Code Execution in `/plan`)
* **Specification**: Creating or drafting an `implementation_map.md` inside `.agents/plans/<feature-name>/` is allowed, but **ZERO code scaffolding, file creation, or source code modification in `src/` or `codebase-*/` is permitted during `/plan`**. Source code implementation remains strictly reserved for `/implement`.

### Baseline 4: Structured Implementation Map Schema
* **Specification**: All `implementation_map.md` documents drafted during `/plan` MUST adhere to the Tier 1 schema defined in [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/implementation_map_taxonomy.md).

---

## 2. Questions & Scanning Blueprint

```
                      ┌─────────────────────────────────┐
                      │   Start /plan Scan & Check      │
                      └────────────────┬────────────────┘
                                       │
                      Present Initial Feature Summary (S2)
                                       │
                    For each question in Schema (Q1 - Q11):
                                       │
                      Does Scan/Context auto-answer?
                      /                             \
                   (Yes)                            (No)
                   /                                   \
        [Auto-answer Question]                 [Run Q&A Interview]
```

* **Prompting Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. Options must be listed neutrally. Every multiple-choice question MUST include a final free-text input option enabling the user to describe custom thoughts.

---

## 3. Sequential Question List (Execution Order: Q1 to Q11)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

### Q1: Feature Name & Initial Understanding Verification
* **Goal**: Confirm the feature slug name (`<feature-name>`) and verify the initial feature understanding summary presented in Node S2.
* **Auto-Detection Scanning Rule**:
  * Read existing branch name (e.g. `feature/<feature-name>`) or prompt text.
  * Inspect `.agents/plans/PROCESS_STATUS.md` for active feature rows.
* **Reframed Grill Prompt**:
  > **Would you like to confirm the feature name and initial feature understanding summary?**
  > *Please review the Initial Feature Understanding Summary presented above:*
  > 1. Yes, the summary and feature name are accurate. Proceed to system identification.
  > 2. Adjust feature name or target scope (Specify custom feature name or scope adjustments below)
  > 3. Other / Free-text (Describe custom feature summary adjustments)
* **Resulting Action**: Initializes directory `.agents/plans/<feature-name>/` and creates `PROCESS_STATUS.md` and `GRILL_STATUS.md` tracking files.

---

### Q2: System Layer Impact & Affected Components
* **Goal**: Identify which layers and components of the system are affected by the proposed feature capability.
* **Auto-Detection Scanning Rule**:
  * Analyze prompt text and `/process` restructure proposal for keywords (`UI`, `frontend`, `engine`, `API`, `database`, `Docker`, `CI/CD`).
* **Reframed Grill Prompt**:
  > **Which parts of the system are affected by this feature?**
  > *Select all system layers that require design changes or new components:*
  > 1. UI Layout & View Presentation Layer (Web, App, or UI components)
  > 2. Core Engine, API Contracts & Backend Data Services Layer
  > 3. Verification Specifications & Test Suites
  > 4. Docker Containerization & Infrastructure Operations Layer
  > 5. Full System (All layers affected)
  > 6. Other / Free-text (Describe affected system components in detail)
* **Resulting Action**: Determines which system layers require active documentation in `phase-1-summary.md` under **System Impact Analysis**.

---

### Q3: Dynamic Phase Blueprint Subset Selection (`phase-*.md`)
* **Goal**: Determine the exact subset of `phase-*.md` blueprint documents to create for this feature.
* **Auto-Detection Scanning Rule**:
  * Map selected affected layers from Q2 directly to corresponding phase blueprints (`Phase 1` is mandatory baseline; `Phase 2` for UI; `Phase 3` for Engine/API/DB; `Phase 4` for Verification; `Phase 5` for Ops).
* **Reframed Grill Prompt**:
  > **Which phase blueprint documents should be scaffolded for this feature?**
  > *Note: Phase 1 (Architecture & Vision) is mandatory for all features.*
  > 1. Standard Flat Subset (Scaffold Phase 1 + Phase blueprints corresponding to affected system layers)
  > 2. Complete 5-Phase Blueprint Set (Scaffold Phase 1 through Phase 5)
  > 3. Custom Phase Selection (Select specific Phase 2 - Phase 5 documents below)
  > 4. Other / Free-text (Describe custom blueprint document requirements)
* **Resulting Action**: Scaffolds active `phase-*.md` documents in `.agents/plans/<feature-name>/` and marks unneeded blueprints as `[-] Not In Scope` in `PROCESS_STATUS.md`.

---

### Q4: Multi-Layer Sub-Element Architecture & Subfolders (`sub_elements/`)
* **Goal**: Evaluate whether the feature is complex and requires a multi-layer subfolder structure (e.g. web UI + mobile app UI, multiple APIs/DBs), using top-level phase docs as master governors.
* **Auto-Detection Scanning Rule**:
  * Check if Q2 identified multiple UIs (web and mobile app) or multiple distinct microservices/databases.
* **Reframed Grill Prompt**:
  > **Does this feature require multi-layer subfolders for distinct sub-elements?**
  > *By default, features use a simple flat folder layout. For complex multi-layer features, top-level phase docs act as master governors while subfolders govern individual sub-elements.*
  > 1. No (Use default simple flat layout with top-level phase-*.md blueprints)
  > 2. Yes (Create subfolders under sub_elements/<element_name>/ for web UI, mobile app, or APIs)
  > 3. Other / Free-text (Describe custom sub-element folder requirements)
* **Resulting Action**: If Yes, provisions subfolders under `.agents/plans/<feature-name>/sub_elements/<element_name>/` and links them to the master governor phase blueprints.

---

### Q5: Topic Knowledge Summaries & Research Notes (`knowledge/`)
* **Goal**: Determine if deep-dive topic research notes or knowledge summaries should be generated to support design decisions.
* **Auto-Detection Scanning Rule**:
  * Inspect prompt for topic research requests or legacy documentation analysis needs.
* **Reframed Grill Prompt**:
  > **Would you like to request any topic research notes or knowledge summaries for this feature?**
  > 1. No research notes needed at this time
  > 2. Yes (Specify research topic, e.g. authentication protocol, DB migration strategy, API performance)
  > 3. Other / Free-text (Describe topic research requirements)
* **Resulting Action**: Creates requested knowledge summaries inside `.agents/plans/<feature-name>/knowledge/knowledge_summary_<topic>.md`.

---

### Q6: Architecture Decision Records (ADRs) & Trade-Off Matrices (`decisions/`)
* **Goal**: Determine if formal Architecture Decision Records (ADRs) or evaluation matrices are needed for key design choices.
* **Auto-Detection Scanning Rule**:
  * Check if architectural trade-offs (e.g., REST vs. gRPC, SQL vs. NoSQL) were identified.
* **Reframed Grill Prompt**:
  > **Should any formal Architecture Decision Records (ADRs) or trade-off matrices be created?**
  > 1. No formal ADRs required
  > 2. Yes (Specify architectural decision to record, e.g. technology selection, state management)
  > 3. Other / Free-text (Describe architectural decision context)
* **Resulting Action**: Creates ADRs inside `.agents/plans/<feature-name>/decisions/adr_<topic>.md`.

---

### Q7: Phase 2 - UI Layout & View Design (If UI is Affected)
* **Goal**: Gather technical specifications for UI views, component hierarchy, design system tokens, and responsive layout behavior.
* **Reframed Grill Prompt**:
  > **What are the key UI layout, styling, and view component requirements?**
  > 1. Vanilla CSS / Custom Design Tokens with responsive grid boundaries
  > 2. Framework component library integration (Specify framework below)
  > 3. Other / Free-text (Describe UI layout, component hierarchy, and design tokens)
* **Resulting Action**: Populates `.agents/plans/<feature-name>/phase-2-layout.md`.

---

### Q8: Phase 3 - Core Engine, API Contracts & Data Flow (If Backend/API Affected)
* **Goal**: Gather specifications for domain services, API endpoints, DTO mappers, database schemas, and inter-feature data flow.
* **Reframed Grill Prompt**:
  > **What are the backend core engine, API contract, and database schema requirements?**
  > 1. RESTful API contracts with JSON DTO mappers and relational database models
  > 2. Event-driven message processing with microservice engine handlers
  > 3. Other / Free-text (Describe API endpoints, domain service logic, DTOs, and DB schemas)
* **Resulting Action**: Populates `.agents/plans/<feature-name>/phase-3-engine.md`.

---

### Q9: Phase 4 - Verification Specifications & Test Suites (If Executable Scope)
* **Goal**: Gather specifications for unit tests, integration test runners, E2E fixtures, and regression test suites.
* **Reframed Grill Prompt**:
  > **What verification test suites and test assertion specs should be created?**
  > 1. Unit & Integration test suite with mock API/DB contracts
  > 2. End-to-End (E2E) browser/API verification suite
  > 3. Other / Free-text (Describe test runners, assertion matrices, and test fixtures)
* **Resulting Action**: Populates `.agents/plans/<feature-name>/phase-4-verification.md`.

---

### Q10: Phase 5 - Docker & Operations Deployment Impact (If Ops Affected)
* **Goal**: Gather container profiles, environment variable configurations, Compose orchestration details, and infrastructure impact.
* **Reframed Grill Prompt**:
  > **What are the Docker containerization and operations deployment impact requirements?**
  > 1. Multi-container Compose orchestration with environment variable isolation
  > 2. Standalone container image build with CI/CD deployment pipeline integration
  > 3. Other / Free-text (Describe Dockerfiles, Compose profiles, and environment variables)
* **Resulting Action**: Populates `.agents/plans/<feature-name>/phase-5-operation.md`.

---

### Q11: Optional Structured Implementation Map Drafting Gate (Node S5)
* **Goal**: Determine if a structured `implementation_map_<scope>.md` should be drafted at the end of `/plan` for ready components.
* **Reframed Grill Prompt**:
  > **Would you like to draft a structured Implementation Map for ready components now?**
  > *Note: Implementation maps provide step-by-step guidance for /implement. Only document drafting is performed during /plan; zero code execution is allowed.*
  > 1. Defer implementation map creation to the beginning of /implement
  > 2. Draft Full Feature Implementation Map (`implementation_map_full.md`)
  > 3. Draft Partial Implementation Map (e.g. `implementation_map_layout.md` or `implementation_map_engine.md`)
  > 4. Other / Free-text (Describe custom implementation map scope)
* **Resulting Action**: If option 2 or 3 selected, drafts `.agents/plans/<feature-name>/implementation_maps/implementation_map_<scope>.md` adhering to [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/implementation_map_taxonomy.md).
