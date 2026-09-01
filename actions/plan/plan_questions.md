# Grill Schema: Interactive Planning Questions (/plan)

This document defines the Q&A interview questionnaire schema, auto-detection scanning rules, unchangeable baselines, and structured prompts used by the `/plan` workflow's Grill Engine session.

The primary objective of the `/plan` Grill-Me session is to guide the developer and AI agent through the interactive design of a new or modified feature, identifying affected system parts, selecting active `phase-*.md` blueprint subsets, evaluating multi-layer subfolders, capturing research reports, and linking version-based implementation maps inside `agent-workspace/plans/<feature-name>/`.

---

## 1. Unchangeable Baselines (No Questions Asked)

To ensure operational stability and system governance, the following five baselines are solid and non-negotiable. **Zero questions are asked about these baselines during the `/plan` interview**:

### Baseline 1: Initial Feature Understanding Summary Mandate (Node S2)
* **Specification**: Every `/plan` session **MUST** open with the agent synthesizing its initial understanding of the feature (from `/init` outputs, `/process` outputs, and user prompt context) and presenting an **Initial Feature Understanding Summary** to the developer before any questions are asked.

### Baseline 2: Strict Feature Plan Sandbox (`agent-workspace/plans/<feature-name>/`)
* **Specification**: ALL files created or modified during `/plan`—including active phase blueprints, `knowledge/` research reports, `phase_details/` folders, and versioned `implementation_maps/`—MUST reside strictly within `agent-workspace/plans/<feature-name>/`.

### Baseline 3: Decisions Embedded Directly in `phase-*.md` (No Decisions Subfolder)
* **Specification**: Architectural decisions, ADR trade-off rationale, and design choices MUST be documented **directly inside active `phase-*.md` documents** (and their sub-element blueprints inside `phase_details/`). There is no separate decisions folder.

### Baseline 4: Implementation Map Sandbox Guard (No Code Execution in `/plan`)
* **Specification**: Creating or drafting a versioned `implementation_map_v<version>.md` inside `agent-workspace/plans/<feature-name>/` is allowed, but **ZERO code scaffolding, file creation, or source code modification in `src/` or `codebase-*/` is permitted during `/plan`**. Source code implementation remains strictly reserved for `/implement`.

### Baseline 5: Version-Based Implementation Map Naming & Schema
* **Specification**: Implementation map documents MUST be named after the target software version created from that map (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_layout.md`) and MUST adhere to the Tier 1 schema defined in [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implementation_map_taxonomy.md).

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
  * Inspect `agent-workspace/plans/PROCESS_STATUS.md` for active feature rows.
* **Reframed Grill Prompt**:
  > **Would you like to confirm the feature name and initial feature understanding summary?**
  > *Please review the Initial Feature Understanding Summary presented above:*
  > 1. Yes, the summary and feature name are accurate. Proceed to system identification.
  > 2. Adjust feature name or target scope (Specify custom feature name or scope adjustments below)
  > 3. Other / Free-text (Describe custom feature summary adjustments)
* **Resulting Action**: Initializes directory `agent-workspace/plans/<feature-name>/` and creates `PROCESS_STATUS.md` and `GRILL_STATUS.md` tracking files.

---

### Q2: System Layer Impact & Affected Components
* **Goal**: Identify which layers and components of the system are affected by the proposed feature capability.
* **Auto-Detection Scanning Rule**:
  * Analyze prompt text and `/process` restructure proposal for keywords (`UI`, `frontend`, `data`, `store`, `database`, `engine`, `API`, `Docker`, `CI/CD`).
* **Reframed Grill Prompt**:
  > **Which parts of the system are affected by this feature?**
  > *Select all system layers that require design changes or new components:*
  > 1. UI Layout & View Presentation Layer (Web, App, or UI components)
  > 2. Data Handling & Storing Layer (Data capturing, storing mechanisms, database models/schemas, persistence strategies, store lifecycle)
  > 3. Core Engine, API Contracts & Backend Data Services Layer
  > 4. Verification Specifications & Test Suites
  > 5. Docker Containerization & Infrastructure Operations Layer
  > 6. Full System (All layers affected)
  > 7. Other / Free-text (Describe affected system components in detail)
* **Resulting Action**: Determines which system layers require active documentation in `phase-1-summary.md` under **System Impact Analysis**.

---

### Q3: Dynamic Phase Blueprint Subset Selection (`phase-*.md`)
* **Goal**: Determine the exact subset of `phase-*.md` blueprint documents to create for this feature.
* **Auto-Detection Scanning Rule**:
  * Map selected affected layers from Q2 directly to corresponding phase blueprints (`Phase 1` is mandatory baseline; `Phase 2` for UI; `Phase 3` for Data; `Phase 4` for Engine/API; `Phase 5` for Verification; `Phase 6` for Ops).
* **Reframed Grill Prompt**:
  > **Which phase blueprint documents should be scaffolded for this feature?**
  > *Note: Phase 1 (Architecture & Vision) is mandatory for all features.*
  > 1. Standard Flat Subset (Scaffold Phase 1 + Phase blueprints corresponding to affected system layers)
  > 2. Complete 6-Phase Blueprint Set (Scaffold Phase 1 through Phase 6)
  > 3. Custom Phase Selection (Select specific Phase 2 - Phase 6 documents below)
  > 4. Other / Free-text (Describe custom blueprint document requirements)
* **Resulting Action**: Scaffolds active `phase-*.md` documents in `agent-workspace/plans/<feature-name>/` and marks unneeded blueprints as `[-] Not In Scope` in `PROCESS_STATUS.md`.

---

### Q4: Multi-Layer Sub-Element Architecture & Phase Details (`phase_details/`)
* **Goal**: Evaluate whether the feature is complex and requires a multi-layer phase details subfolder structure (e.g. web UI + mobile app UI, multiple APIs/DBs), using top-level phase docs as master governors.
* **Auto-Detection Scanning Rule**:
  * Check if Q2 identified multiple UIs (web and mobile app) or multiple distinct microservices/databases.
* **Reframed Grill Prompt**:
  > **Does this feature require multi-layer phase details subfolders for distinct sub-elements?**
  > *By default, features use a simple flat folder layout. For complex multi-layer features, top-level phase docs act as master governors while subfolders govern individual sub-elements.*
  > 1. No (Use default simple flat layout with top-level phase-*.md blueprints)
  > 2. Yes (Create subfolders under phase_details/<element_name>/ for web UI, mobile app, or APIs)
  > 3. Other / Free-text (Describe custom phase details folder requirements)
* **Resulting Action**: If Yes, provisions subfolders under `agent-workspace/plans/<feature-name>/phase_details/<element_name>/` and links them to the master governor phase blueprints.

---

### Q5: Topic Research Reports & Idea Explorations (`knowledge/`)
* **Goal**: Determine if deep-dive research reports or idea explorations should be generated under `knowledge/` to evaluate options during planning.
* **Auto-Detection Scanning Rule**:
  * Inspect prompt for topic research requests or legacy documentation analysis needs.
* **Reframed Grill Prompt**:
  > **Would you like to request any research reports or topic evaluations for this feature?**
  > 1. No research reports needed at this time
  > 2. Yes (Specify research topic, e.g. authentication protocol, DB migration strategy, API performance)
  > 3. Other / Free-text (Describe topic research requirements)
* **Resulting Action**: Writes requested research report inside `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md` and links it directly in the active `phase-*.md` documents.

---

### Q6: Phase 2 - UI Layout & View Design (If UI is Affected)
* **Goal**: Gather technical specifications for UI views, component hierarchy, design system tokens, and responsive layout decisions.
* **Reframed Grill Prompt**:
  > **What are the key UI layout, styling, and view component requirements?**
  > 1. Vanilla CSS / Custom Design Tokens with responsive grid boundaries
  > 2. Framework component library integration (Specify framework below)
  > 3. Other / Free-text (Describe UI layout, component hierarchy, and design tokens)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-2-layout.md` with UI specs and layout decisions.

---

### Q7: Phase 3 - Data Handling, Storing & Store Lifecycle (If Data/Database Affected)
* **Goal**: Gather specifications for data management, capturing mechanisms, storage engine models, database schemas, persistence policies, and data store lifecycle events (migrations, retention, backups, events).
* **Reframed Grill Prompt**:
  > **What are the data handling, capturing, storing, and data store lifecycle requirements?**
  > 1. Relational data model with SQL migration scripts, indexing, and automated backup lifecycle
  > 2. Document/NoSQL key-value store with event stream capturing and TTL retention policies
  > 3. Hybrid persistence model with caching, event logging, and automated lifecycle archiving
  > 4. Other / Free-text (Describe data models, capture/storage mechanisms, and lifecycle events)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-3-data.md` with data handling specs, storage schemas, and lifecycle decisions.

---

### Q8: Phase 4 - Core Engine, API Contracts & Data Flow (If Backend/API Affected)
* **Goal**: Gather specifications for domain services, API endpoints, DTO mappers, backend execution logic, and architectural engine decisions.
* **Reframed Grill Prompt**:
  > **What are the backend core engine, API contract, and service integration requirements?**
  > 1. RESTful API contracts with JSON DTO mappers and core service routing
  > 2. Event-driven message processing with microservice engine handlers
  > 3. Other / Free-text (Describe API endpoints, domain service logic, and DTOs)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-4-engine.md` with backend specs and engine decisions.

---

### Q8b: Test Strategy Assertion & Amendment
* **Goal**: Confirm the project-durable test strategy covers this feature, and amend it **once, project-wide** if it does not.
* **Precondition**: Runs before Q9. A feature may not proceed to scenario authoring against an absent or insufficient strategy.
* **Auto-Detection Scanning Rule**:
  * Read `agent-workspace/tests/TEST_STRATEGY.md`. If absent, this feature triggers first-time authoring.
  * Compare the tiers this feature requires against the tiers declared in strategy §1.
  * Read `resource/existing_coverage.md` (if `/process` ran) to see what the legacy codebase already proves.
* **Reframed Grill Prompt**:
  > **Test strategy status: `<present | absent>`. Declared tiers: `<list>`. Does this feature require anything not yet declared?**
  > 1. Strategy is sufficient — proceed to scenario authoring
  > 2. Amend the strategy (add a tier, tool, threshold, or mocking policy) — applied project-wide via `/plan --test-strategy`
  > 3. Author the strategy for the first time (tiers, tooling per layer, thresholds, mocking policy, defect severity, definition of certified)
  > 4. Other / Free-text (Describe the strategy gap)
* **Boundary**: Tooling, mocking policy, and coverage thresholds are answered **here, once, for the project** — never per feature in `phase-5-test.md`. Per-feature deviation from the strategy is not permitted.
* **Resulting Action**: Creates or amends `agent-workspace/tests/TEST_STRATEGY.md`.

---

### Q8c: Carry-Over Ratification
* **Goal**: Adopt or reject scenarios proposed by the previous `/qualify` run.
* **Auto-Detection Scanning Rule**:
  * Read the prior cycle's `QUALIFICATION_REPORT.md` **Coverage Gap Proposals** block.
  * List every scenario carrying `origin: qualify, status: unratified`.
* **Reframed Grill Prompt**:
  > **`<n>` unratified proposals carried over from the last qualification run:**
  > `SC-<feature>-007 — <behaviour>`
  >
  > **How should each be handled?**
  > 1. Adopt into this feature's verification scope (`status: ratified`)
  > 2. Adopt but defer to a later feature scope
  > 3. Reject with a recorded reason (`status: retired`)
  > 4. Other / Free-text (Describe per-scenario disposition)
* **Boundary**: `/plan --ratify` is the **sole authority** for scenario status transitions. No other action may alter a `status` field.
* **Resulting Action**: Applies status transitions in `agent-workspace/tests/scenarios/`.

---

### Q9: Phase 5 - Verification Scope Delta & Scenario Authoring
* **Goal**: Determine which behaviours this feature must prove, and author one ratified scenario per behaviour.
* **Auto-Detection Scanning Rule**:
  * Read `resource/existing_coverage.md` to establish what is already proven — `phase-5-test.md` is a **delta against existing coverage**, not a scope written from zero.
  * Determine the next free ordinal in the `SC-<feature-slug>-<nnn>` sequence.
* **Reframed Grill Prompt**:
  > **Which behaviours must this feature prove? Each becomes a ratified scenario with a permanent identifier.**
  > 1. Enumerate behaviours now (agent proposes a scenario set for review)
  > 2. Derive them from the phase blueprints already drafted
  > 3. Extend or supersede specific existing scenarios (identify by `SC-*` ID)
  > 4. Other / Free-text (Describe the verification delta)
* **Scenario Authoring Rules**:
  * One file per scenario under `agent-workspace/tests/scenarios/`, named after its identifier.
  * Identifiers follow `SC-<feature-slug>-<nnn>`, assigned in creation order, **never reused and never renumbered**.
  * Scenarios authored here carry `origin: plan` and `status: ratified`.
  * Body states behaviour in given/when/then form — **what must be true**, never **how it is proven**. Mechanism belongs to the harness, which `/implement` builds.
* **Resulting Action**: Populates `phase-5-test.md` with the scope delta and the list of scenario IDs in scope; writes scenario files to `agent-workspace/tests/scenarios/`. That ID list is the binding input to the `/qualify` Node Q1 coverage gate.

---

### Q10: Phase 6 - Docker & Operations Deployment Impact (If Ops Affected)
* **Goal**: Gather environment topology, container profiles, configuration/secret declarations, CI/CD pipeline impact, and promotion policy decisions.
* **Structure**: Q10 is asked as five sub-questions (Q10.1–Q10.5), each populating a distinct section of `phase-6-operation.md`'s eight-section content contract (see [plan_action.md](./plan_action.md) §3). Respecting the Grill Engine's max-2-questions-per-turn rule: Q10.1 + Q10.2 in one turn, Q10.3 + Q10.4 in the next, then Q10.5.

#### Q10.1: Environment Topology
* **Goal**: Determine which environments this feature targets, and whether a new environment is required.
* **Auto-Detection Scanning Rule**:
  * Read `phase-6-operation.md` §0 from prior feature cycles, if present, for existing `ENV-*` definitions (First-Definer Rule).
* **Reframed Grill Prompt**:
  > **Which environments does this feature target, and does it require a new one?**
  > 1. Existing environments only (reference the current topology; no new `ENV-*` row)
  > 2. A new environment is required (specify purpose, services, and entry gate — `none` or `certification: full`)
  > 3. Other / Free-text (Describe environment topology impact)
* **Resulting Action**: Populates `phase-6-operation.md` §0 (Environment Topology).

#### Q10.2: Containerization & Image Impact
* **Goal**: Gather container profiles, base images, and service orchestration decisions.
* **Reframed Grill Prompt**:
  > **What are the containerization and service orchestration requirements?**
  > 1. Multi-container Compose orchestration with environment variable isolation
  > 2. Standalone container image build with no new orchestrated services
  > 3. Other / Free-text (Describe Dockerfiles, base images, and Compose profiles)
* **Resulting Action**: Populates `phase-6-operation.md` §1–§2 (Containerization & Service Orchestration).

#### Q10.3: Configuration & Secret Declarations
* **Goal**: Declare configuration keys and secret names this feature requires, scoped by environment.
* **Reframed Grill Prompt**:
  > **What configuration keys or secrets does this feature require? (Names and scope only — never a value.)**
  > 1. No new configuration or secrets required
  > 2. New configuration/secret keys required (specify key name, scope, and target environments)
  > 3. Other / Free-text (Describe configuration or secret declarations)
* **Resulting Action**: Populates `phase-6-operation.md` §3 (Configuration & Secret Declarations).

#### Q10.4: CI/CD Pipeline Impact & Promotion Policy
* **Goal**: Map this feature onto the 3-tier CI/CD hierarchy and determine its delivery/promotion policy.
* **Reframed Grill Prompt**:
  > **What CI/CD pipeline and promotion policy changes does this feature require?**
  > 1. No pipeline changes; standard promotion policy applies
  > 2. Pipeline changes required (specify layer micro-pipeline, qualification pipeline, or macro-pipeline impact and promotion edges)
  > 3. Other / Free-text (Describe pipeline topology or promotion policy changes)
* **Resulting Action**: Populates `phase-6-operation.md` §4–§5 (CI/CD Pipeline Topology & Delivery/Promotion Policy).

#### Q10.5: Observability & Monitoring Design
* **Goal**: Declare what the system must emit, which tool observes it, and what conditions constitute unhealthy.
* **Auto-Detection Scanning Rule**:
  * Read prior cycles' `phase-6-operation.md` §6b for already-declared tooling (First-Definer Rule).
  * For brownfield, read `resource/` for any monitoring stack `/process` discovered.
* **Reframed Grill Prompt**:
  > **What observability and monitoring contracts does this feature require?**
  > 1. No new observability contracts (existing health checks and monitoring suffice)
  > 2. New signals, health checks, or alert conditions required (specify signal names, monitoring tool, thresholds, soak windows, and routing targets)
  > 3. Other / Free-text (Describe observability and monitoring requirements)
* **Boundary**: Declares **what** must be emitted and **what** constitutes unhealthy — never the emission code, dashboard definition, alert-rule YAML, or collector config. Observability contracts are never authored as `SC-*` scenarios.
* **Resulting Action**: Populates `phase-6-operation.md` §6 (blocks 6a, 6b, 6c).

---

### Q11: Versioned Implementation Map Drafting Gate (Node S5)
* **Goal**: Determine if a versioned `implementation_map_v<version>.md` should be drafted at the end of `/plan` for target software releases.
* **Reframed Grill Prompt**:
  > **Would you like to draft a version-linked Implementation Map for a target software release now?**
  > *Note: Implementation maps are named after the target software version (e.g. implementation_map_v1.0.0.md) and provide step-by-step guidance for /implement. Only document drafting is performed during /plan; zero code execution is allowed.*
  > 1. Defer implementation map creation to the beginning of /implement
  > 2. Draft Full Feature Release Map (Specify target version, e.g. `implementation_map_v1.0.0.md`)
  > 3. Draft Partial Scope Release Map (Specify target version and scope, e.g. `implementation_map_v1.1.0_layout.md`)
  > 4. Other / Free-text (Describe custom versioned implementation map requirements)
* **Resulting Action**: If option 2 or 3 selected, drafts `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` adhering to [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implementation_map_taxonomy.md).
