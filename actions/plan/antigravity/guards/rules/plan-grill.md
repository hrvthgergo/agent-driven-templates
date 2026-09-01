---
name: plan-grill
description: Neutral Q&A Grill Rule Guard and Unchangeable Baselines for /plan
---

# Plan Grill Rules & Questionnaire Schema

This rule defines the unchangeable baselines, prompting laws, auto-detection scanning rules, and structured sequential interview schema governing the `/plan` interactive session.

---

## 1. Unchangeable Baselines (No Questions Asked)

The following ten baselines are solid and non-negotiable. Zero questions are asked about these baselines during `/plan`:

1. **Baseline 1: Initial Feature Understanding Summary Mandate (Node S2)**: Every `/plan` session MUST open with the agent synthesizing its initial understanding of the feature (from `/init`, `/process`, and user prompt) and presenting an **Initial Feature Understanding Summary** to the developer before any questions are asked.
2. **Baseline 2: Strict Feature Plan Sandbox (`agent-workspace/plans/<feature-name>/`)**: All feature-specific files created or modified during `/plan`—including active phase blueprints, `knowledge/` research reports, `phase_details/` folders, and versioned `implementation_maps/`—MUST reside strictly within `agent-workspace/plans/<feature-name>/`.
3. **Baseline 3: Decisions Embedded Directly in `phase-*.md` (No Decisions Subfolder)**: Architectural decisions, ADR trade-off rationale, and design choices MUST be documented directly inside active `phase-*.md` documents (and their sub-element blueprints inside `phase_details/`). There is no separate decisions folder.
4. **Baseline 4: Implementation Map Sandbox Guard (No Code Execution in `/plan`)**: Creating or drafting a versioned `implementation_map_v<version>.md` inside `agent-workspace/plans/<feature-name>/` is allowed, but **ZERO code scaffolding, file creation, or source code modification in `src/` or `codebase-*/` is permitted during `/plan`**. Source code implementation remains strictly reserved for `/implement`.
5. **Baseline 5: Version-Based Implementation Map Naming & Schema**: Implementation map documents MUST be named after the target software version created from that map (e.g. `implementation_map_v1.0.0.md` or `implementation_map_v1.1.0_layout.md`) and MUST adhere to the Tier 1 schema defined in `implementation_map_taxonomy.md`.
6. **Baseline 6: Verification Design Authority Guard**: `/plan` is the **sole design authority for verification** (`TEST_STRATEGY.md`, `phase-5-test.md`, and `tests/scenarios/SC-*.md`) and the **sole ratification authority** (`/plan --ratify`). `/plan` is strictly prohibited from writing harness code or executing tests.
7. **Baseline 7: Scenario Identity Guard**: Enforces immutable `SC-<feature-slug>-<nnn>` identifiers assigned in creation order. Identifiers are never reused and never renumbered. Scenarios authored in `/plan` carry `origin: plan` and `status: ratified`.
8. **Baseline 8: Strategy Hoisting Guard**: Tooling, thresholds, and mocking policy are defined once in `agent-workspace/tests/TEST_STRATEGY.md`. `phase-5-test.md` references the strategy and lists scenario IDs; it never restates tooling, thresholds, or mocking policy.
9. **Baseline 9: Operations Design Authority Guard**: `/plan` is the **sole design authority for operations**: environment topology, image specifications, configuration and secret *declarations*, pipeline topology, promotion policy, and observability contracts (§0–§7 of `phase-6-operation.md`). `/plan` specifies and never constructs (no Dockerfiles, Compose files, pipeline YAMLs, or deploy scripts). Secrets are declared as **names only — never values**. Observability contracts in §6c are never authored as `SC-*` scenarios.
10. **Baseline 10: First-Definer Rule**: The first feature to define an environment (§0) or monitoring tool (§6b) owns the canonical row; later features reference it and record deltas.

---

## 2. Prompting Laws

1. **Neutrality Law**: The Grill Engine MUST NOT mark any option as `[Recommended]`. All options must be presented neutrally.
2. **Free-Text Option Law**: Every multiple-choice question MUST include a final free-text input option enabling the user to provide custom specifications.
3. **Turn Economy Law**: Respect the max-2-questions-per-turn prompting rule.
4. **Context Notification Law**: Every turn MUST output the 1-line response banner quote (`> 📍 **Active Workflow**: /plan | **Scope**: <feature> | **Node**: <Node_ID>`).

---

## 3. Sequential Questionnaire Schema (Q1 to Q11)

The Grill Engine MUST evaluate and ask questions in the strict sequential order listed below:

### Q1: Feature Name & Initial Understanding Verification
* **Goal**: Confirm the feature slug name (`<feature-name>`) and verify the initial feature understanding summary presented in Node S2.
* **Auto-Detection Scanning Rule**: Read branch name (`feature/<feature-name>`) or prompt text; inspect `agent-workspace/plans/PROCESS_STATUS.md`.
* **Prompt**:
  > **Would you like to confirm the feature name and initial feature understanding summary?**
  > 1. Yes, the summary and feature name are accurate. Proceed to system identification.
  > 2. Adjust feature name or target scope (Specify custom feature name or scope adjustments below)
  > 3. Other / Free-text (Describe custom feature summary adjustments)
* **Resulting Action**: Initializes directory `agent-workspace/plans/<feature-name>/` and creates `PROCESS_STATUS.md` and `GRILL_STATUS.md`.

### Q2: System Layer Impact & Affected Components
* **Goal**: Identify which layers and components of the system are affected by the proposed feature capability.
* **Auto-Detection Scanning Rule**: Analyze prompt text and `/process` restructure proposal for keywords (`UI`, `frontend`, `data`, `store`, `database`, `engine`, `API`, `Docker`, `CI/CD`).
* **Prompt**:
  > **Which parts of the system are affected by this feature?**
  > 1. UI Layout & View Presentation Layer (Web, App, or UI components)
  > 2. Data Handling & Storing Layer (Data capturing, storing mechanisms, database models/schemas, persistence strategies, store lifecycle)
  > 3. Core Engine, API Contracts & Backend Data Services Layer
  > 4. Verification Specifications & Test Suites
  > 5. Docker Containerization & Infrastructure Operations Layer
  > 6. Full System (All layers affected)
  > 7. Other / Free-text (Describe affected system components in detail)
* **Resulting Action**: Determines active system layers for System Impact Analysis in `phase-1-summary.md`.

### Q3: Dynamic Phase Blueprint Subset Selection (`phase-*.md`)
* **Goal**: Determine the exact subset of `phase-*.md` blueprint documents to create for this feature.
* **Auto-Detection Scanning Rule**: Map selected affected layers from Q2 directly to corresponding phase blueprints.
* **Prompt**:
  > **Which phase blueprint documents should be scaffolded for this feature?**
  > 1. Standard Flat Subset (Scaffold Phase 1 + Phase blueprints corresponding to affected system layers)
  > 2. Complete 6-Phase Blueprint Set (Scaffold Phase 1 through Phase 6)
  > 3. Custom Phase Selection (Select specific Phase 2 - Phase 6 documents below)
  > 4. Other / Free-text (Describe custom blueprint document requirements)
* **Resulting Action**: Scaffolds active `phase-*.md` documents in `agent-workspace/plans/<feature-name>/`.

### Q4: Multi-Layer Sub-Element Architecture & Phase Details (`phase_details/`)
* **Goal**: Evaluate whether the feature is complex and requires multi-layer phase details subfolders (`phase_details/<element_name>/`).
* **Auto-Detection Scanning Rule**: Check if Q2 identified multiple UIs (web and mobile) or multiple microservices/databases.
* **Prompt**:
  > **Does this feature require multi-layer phase details subfolders for distinct sub-elements?**
  > 1. No (Use default simple flat layout with top-level phase-*.md blueprints)
  > 2. Yes (Create subfolders under phase_details/<element_name>/ for web UI, mobile app, or APIs)
  > 3. Other / Free-text (Describe custom phase details folder requirements)
* **Resulting Action**: If Yes, provisions subfolders under `agent-workspace/plans/<feature-name>/phase_details/<element_name>/`.

### Q5: Topic Research Reports & Idea Explorations (`knowledge/`)
* **Goal**: Determine if deep-dive research reports or idea explorations should be generated under `knowledge/`.
* **Prompt**:
  > **Would you like to request any research reports or topic evaluations for this feature?**
  > 1. No research reports needed at this time
  > 2. Yes (Specify research topic, e.g. authentication protocol, DB migration strategy, API performance)
  > 3. Other / Free-text (Describe topic research requirements)
* **Resulting Action**: Writes research report to `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md` and links it in `phase-*.md`.

### Q6: Phase 2 - UI Layout & View Design (If UI Affected)
* **Goal**: Gather technical specifications for UI views, component hierarchy, design system tokens, and responsive layout decisions.
* **Prompt**:
  > **What are the key UI layout, styling, and view component requirements?**
  > 1. Vanilla CSS / Custom Design Tokens with responsive grid boundaries
  > 2. Framework component library integration (Specify framework below)
  > 3. Other / Free-text (Describe UI layout, component hierarchy, and design tokens)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-2-layout.md`.

### Q7: Phase 3 - Data Handling, Storing & Store Lifecycle (If Data Affected)
* **Goal**: Gather specifications for data management, capturing mechanisms, storage engine models, database schemas, persistence policies, and data store lifecycle events.
* **Prompt**:
  > **What are the data handling, capturing, storing, and data store lifecycle requirements?**
  > 1. Relational data model with SQL migration scripts, indexing, and automated backup lifecycle
  > 2. Document/NoSQL key-value store with event stream capturing and TTL retention policies
  > 3. Hybrid persistence model with caching, event logging, and automated lifecycle archiving
  > 4. Other / Free-text (Describe data models, capture/storage mechanisms, and lifecycle events)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-3-data.md`.

### Q8: Phase 4 - Core Engine, API Contracts & Data Flow (If Backend/API Affected)
* **Goal**: Gather specifications for domain services, API endpoints, DTO mappers, backend execution logic, and service routing.
* **Prompt**:
  > **What are the backend core engine, API contract, and service integration requirements?**
  > 1. RESTful API contracts with JSON DTO mappers and core service routing
  > 2. Event-driven message processing with microservice engine handlers
  > 3. Other / Free-text (Describe API endpoints, domain service logic, and DTOs)
* **Resulting Action**: Populates `agent-workspace/plans/<feature-name>/phase-4-engine.md`.

### Q8b: Test Strategy Assertion & Amendment
* **Goal**: Confirm the project-durable test strategy covers this feature, and amend it once, project-wide if it does not.
* **Auto-Detection Scanning Rule**: Read `agent-workspace/tests/TEST_STRATEGY.md`. If absent, trigger first-time authoring.
* **Prompt**:
  > **Test strategy status: `<present | absent>`. Declared tiers: `<list>`. Does this feature require anything not yet declared?**
  > 1. Strategy is sufficient — proceed to scenario authoring
  > 2. Amend the strategy (add a tier, tool, threshold, or mocking policy) — applied project-wide via `/plan --test-strategy`
  > 3. Author the strategy for the first time (tiers, tooling per layer, thresholds, mocking policy, defect severity, definition of certified)
  > 4. Other / Free-text (Describe the strategy gap)
* **Resulting Action**: Creates or amends `agent-workspace/tests/TEST_STRATEGY.md`.

### Q8c: Carry-Over Ratification
* **Goal**: Adopt or reject scenarios proposed by previous `/qualify` runs.
* **Auto-Detection Scanning Rule**: Read prior cycle's `QUALIFICATION_REPORT.md` Coverage Gap Proposals block for `origin: qualify, status: unratified`.
* **Prompt**:
  > **`<n>` unratified proposals carried over from the last qualification run. How should each be handled?**
  > 1. Adopt into this feature's verification scope (`status: ratified`)
  > 2. Adopt but defer to a later feature scope
  > 3. Reject with a recorded reason (`status: retired`)
  > 4. Other / Free-text (Describe per-scenario disposition)
* **Resulting Action**: Applies status transitions in `agent-workspace/tests/scenarios/`.

### Q9: Phase 5 - Verification Scope Delta & Scenario Authoring
* **Goal**: Determine which behaviours this feature must prove, and author one ratified scenario per behaviour.
* **Auto-Detection Scanning Rule**: Read `resource/existing_coverage.md`; determine next free ordinal in `SC-<feature-slug>-<nnn>`.
* **Prompt**:
  > **Which behaviours must this feature prove? Each becomes a ratified scenario with a permanent identifier.**
  > 1. Enumerate behaviours now (agent proposes a scenario set for review)
  > 2. Derive them from the phase blueprints already drafted
  > 3. Extend or supersede specific existing scenarios (identify by `SC-*` ID)
  > 4. Other / Free-text (Describe the verification delta)
* **Resulting Action**: Populates `phase-5-test.md` referencing `TEST_STRATEGY.md` and listing scenario IDs; writes scenario files to `agent-workspace/tests/scenarios/`.

### Q10: Phase 6 - Operations & Environment Design (If Ops Affected)
* **Goal**: Gather environment topology, container profiles, configuration/secret declarations, CI/CD pipeline impact, and promotion policy decisions across 5 focused sub-questions.

#### Q10.1: Environment Topology
* **Goal**: Determine which environments this feature targets, and whether a new environment is required.
* **Auto-Detection Scanning Rule**: Read `phase-6-operation.md` §0 from prior feature cycles for existing `ENV-*` definitions (First-Definer Rule).
* **Prompt**:
  > **Which environments does this feature target, and does it require a new one?**
  > 1. Existing environments only (reference current topology; no new `ENV-*` row)
  > 2. A new environment is required (specify purpose, services, and entry gate — `none` or `certification: full`)
  > 3. Other / Free-text (Describe environment topology impact)
* **Resulting Action**: Populates `phase-6-operation.md` §0 (Environment Topology).

#### Q10.2: Containerization & Image Impact
* **Goal**: Gather container profiles, base images, and service orchestration decisions.
* **Prompt**:
  > **What are the containerization and service orchestration requirements?**
  > 1. Multi-container Compose orchestration with environment variable isolation
  > 2. Standalone container image build with no new orchestrated services
  > 3. Other / Free-text (Describe Dockerfiles, base images, and Compose profiles)
* **Resulting Action**: Populates `phase-6-operation.md` §1–§2 (Containerization & Service Orchestration).

#### Q10.3: Configuration & Secret Declarations
* **Goal**: Declare configuration keys and secret names this feature requires, scoped by environment (**names and scope only — never a value**).
* **Prompt**:
  > **What configuration keys or secrets does this feature require? (Names and scope only — never a value.)**
  > 1. No new configuration or secrets required
  > 2. New configuration/secret keys required (specify key name, scope, and target environments)
  > 3. Other / Free-text (Describe configuration or secret declarations)
* **Resulting Action**: Populates `phase-6-operation.md` §3 (Configuration & Secret Declarations).

#### Q10.4: CI/CD Pipeline Impact & Promotion Policy
* **Goal**: Map this feature onto the 3-tier CI/CD hierarchy and determine its delivery/promotion policy.
* **Prompt**:
  > **What CI/CD pipeline and promotion policy changes does this feature require?**
  > 1. No pipeline changes; standard promotion policy applies
  > 2. Pipeline changes required (specify layer micro-pipeline, qualification pipeline, or macro-pipeline impact and promotion edges)
  > 3. Other / Free-text (Describe pipeline topology or promotion policy changes)
* **Resulting Action**: Populates `phase-6-operation.md` §4–§5 (CI/CD Pipeline Topology & Delivery/Promotion Policy).

#### Q10.5: Observability & Monitoring Design
* **Goal**: Declare what the system must emit, which tool observes it, and what conditions constitute unhealthy.
* **Auto-Detection Scanning Rule**: Read prior cycles' `phase-6-operation.md` §6b for declared tooling (First-Definer Rule).
* **Prompt**:
  > **What observability and monitoring contracts does this feature require?**
  > 1. No new observability contracts (existing health checks and monitoring suffice)
  > 2. New signals, health checks, or alert conditions required (specify signal names, monitoring tool, thresholds, soak windows, and routing targets)
  > 3. Other / Free-text (Describe observability and monitoring requirements)
* **Resulting Action**: Populates `phase-6-operation.md` §6 (blocks 6a, 6b, 6c). Observability contracts are never authored as `SC-*` scenarios.

### Q11: Versioned Implementation Map Drafting Gate (Node S5)
* **Goal**: Determine if a versioned `implementation_map_v<version>.md` should be drafted at the conclusion of `/plan`.
* **Prompt**:
  > **Would you like to draft a version-linked Implementation Map for a target software release now?**
  > 1. Defer implementation map creation to the beginning of /implement
  > 2. Draft Full Feature Release Map (Specify target version, e.g. `implementation_map_v1.0.0.md`)
  > 3. Draft Partial Scope Release Map (Specify target version and scope, e.g. `implementation_map_v1.1.0_layout.md`)
  > 4. Other / Free-text (Describe custom versioned implementation map requirements)
* **Resulting Action**: If option 2 or 3 selected, drafts `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md`.
