---
name: plan
description: Interactive planning workflow for 6-phase blueprints, test strategies, scenarios, operations design, and versioned implementation maps
---

# `/plan` Workflow Execution Playbook

This stateful execution playbook defines the 7-node state machine governing interactive feature design, system impact analysis, test strategy assertion, Given/When/Then scenario authoring (`SC-*`), operations & environment topology design (`phase-6-operation.md` §0–§7), 6-phase blueprint generation, and versioned implementation map drafting within Google Antigravity.

---

## 1. Parameters & Operational Rules of Thumb

### CLI Parameter Handling
* `/plan`: Default interactive execution mode. Synthesizes initial feature understanding (Node S2), conducts sequential Q&A grill (Node S3, Q1–Q11 including Q10.1–Q10.5), scaffolds active 6-phase blueprints, scenarios, and operations specs (Node S4), and presents implementation map option (Node S5).
* `/plan --feature <feature_name>`: Explicitly specifies the target feature name and sandbox folder under `agent-workspace/plans/<feature_name>/`.
* `/plan --auto`: Automated execution mode. Scaffolds default blueprints and scenarios without pausing at Node S5 acceptance gate.
* `/plan --dry-run`: Preview mode. Simulates feature planning, displays proposed phase blueprints, test strategy, scenarios, operations design, and implementation maps in memory without persisting files to disk.
* `/plan --research <topic>`: Targeted topic research. Executes deep-dive architectural evaluation on `<topic>` and writes `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md`.
* `/plan --map`: Targeted implementation map drafting. Directly engages Node S5 to draft `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` adhering to `implementation_map_taxonomy.md`.
* `/plan --test-strategy`: Project-durable test strategy mode. Authors or amends `agent-workspace/tests/TEST_STRATEGY.md` (testing tiers, layer tooling, thresholds, mocking policy, defect severity, definition of certified).
* `/plan --ratify`: Scenario ratification mode. Reviews `origin: qualify, status: unratified` proposals carry-over queue and transitions status to `ratified` (or `retired` with recorded reason).

### Workflow Context Notification Law (Combined Multi-Layer Strategy)
Every turn during `/plan` MUST:
1. Open with a 1-line response banner quote:
   `> 📍 **Active Workflow**: /plan | **Scope**: <feature-name> | **Node**: <Node_ID>`
2. Print a stylized transition badge when entering new nodes:
   `=== [Node S<N>: <Node Name>] ===`
3. Maintain header metadata (`Workflow`, `Branch`, `Date`) in `PROCESS_STATUS.md` and `GRILL_STATUS.md`.

---

## 2. Execution State Machine Nodes (S1 – S7)

```mermaid
graph TD
    S1[Node S1: Check Environment & Preconditions] --> S2[Node S2: Initial Feature Understanding Summary]
    S2 --> S3[Node S3: Interactive Q&A Session<br/>Identify Affected System, phase-*.md Set, Subfolders,<br/>Verification Scope & Operations Design]
    S3 -->|Scope/Sub-Element Discovery or Research Request| S3_Docs[Draft phase_details/ Folders & Research Reports under knowledge/]
    S3_Docs --> S3
    S3 -->|Affected System, Strategy, Scenarios & Ops Design Finalized| S4[Node S4: Dynamic Blueprint Scaffolding & Scenario Authoring]
    S4 --> S5[Node S5: Execution Acceptance Gate & Implementation Map Option]
    S5 -->|Human Decision Turning Point / Revision| S3
    S5 -->|Option Selected: Draft Versioned Implementation Map| S5_Map[Draft implementation_map_v<version>.md in implementation_maps/<br/>(NO CODE EDITING)]
    S5_Map --> S6
    S5 -->|Approved / --auto| S6[Node S6: PROCESS_STATUS.md Sync & Log Update]
    S6 --> S7[Node S7: Planning Completed]
```

### Node S1: Check Environment & Preconditions
1. **Workspace Verification**: Assert that Agentic Environment (`.agents/`) and Folder-Based Control Plane (`agent-workspace/`) exist.
2. **Git Context Verification**: Verify Git context and active feature branch (`feature/<feature-name>`).
3. **Docker Daemon Check**: Execute `docker info` to verify container runtime status.
4. If preconditions are missing, halt execution and instruct developer to execute `/init`.

### Node S2: Initial Feature Understanding Summary
1. **FIRST ACTION**: As the very first user-facing action of `/plan`, synthesize initial feature understanding from `/init` baseline (`phase-1-summary.md`), `/process` findings (`resource/`, `restructure-proposal.md`), and the user prompt.
2. Output a structured **Initial Feature Understanding Summary** before asking any interview questions.
3. Initialize directory `agent-workspace/plans/<feature-name>/` and deploy tracking files `PROCESS_STATUS.md` and `GRILL_STATUS.md`.

### Node S3: Interactive Q&A Session (Q1 – Q11)
1. Invoke the neutral interview engine enforcing `rules/plan-grill.md`.
2. Execute sequential prompts neutrally without `[Recommended]` bias labels (respecting the max-2-questions-per-turn rule):
   * **Q1**: Confirm feature name and initial feature understanding summary.
   * **Q2**: Identify affected system layers and components.
   * **Q3**: Select active `phase-*.md` blueprint subset.
   * **Q4**: Evaluate multi-layer sub-element architecture (`phase_details/`).
   * **Q5**: Process requested topic research reports (`knowledge/`).
   * **Q6**: Phase 2 UI Layout & View Design specs (if UI affected).
   * **Q7**: Phase 3 Data Handling, Storing & Store Lifecycle specs (if Data affected).
   * **Q8**: Phase 4 Core Engine, API Contracts & Data Flow specs (if Engine/API affected).
   * **Q8b**: Test Strategy Assertion & Amendment (read/author `agent-workspace/tests/TEST_STRATEGY.md`).
   * **Q8c**: Carry-Over Ratification (review unratified proposals from previous `/qualify`).
   * **Q9**: Phase 5 Verification Scope Delta & Scenario Authoring (`phase-5-test.md` & `SC-<feature-slug>-<nnn>`).
   * **Q10 (Q10.1–Q10.5)**: Phase 6 Operations & Environment Design:
     - **Q10.1**: Environment Topology matrix & entry gates (`ENV-<id>`, purpose, services, entry gate ∈ {`none`, `certification: full`}).
     - **Q10.2**: Containerization & Image Impact (base images, multi-stage build targets, service orchestration).
     - **Q10.3**: Configuration & Secret Declarations (names and scope only — never a secret value).
     - **Q10.4**: CI/CD Pipeline Impact & Promotion Policy (mapped to 3-tier hierarchy, post-delivery hooks).
     - **Q10.5**: Observability & Monitoring Design (6a signals/instrumentation, 6b monitoring tooling/endpoints, 6c health/readiness/alert contracts).
   * **Q11**: Versioned Implementation Map drafting gate.
3. Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

### Node S4: Dynamic Blueprint Scaffolding, Scenario Authoring & Impact Drafting
1. Invoke `skills/plan-generator/SKILL.md`.
2. Scaffold active `phase-*.md` documents under `agent-workspace/plans/<feature-name>/` with embedded decisions and system impact analysis.
3. Scaffold `phase_details/<element_name>/` subfolders if multi-layer architecture was selected.
4. Author/amend `agent-workspace/tests/TEST_STRATEGY.md` if strategy gaps were identified in Q8b.
5. Author feature scenario files under `agent-workspace/tests/scenarios/SC-<feature-slug>-<nnn>.md` with frontmatter (`id`, `title`, `feature`, `tier`, `origin: plan`, `status: ratified`) and Given/When/Then behaviour criteria.
6. Populate `agent-workspace/plans/<feature-name>/phase-5-test.md` referencing `TEST_STRATEGY.md` and listing the binding scenario IDs in scope.
7. Populate `agent-workspace/plans/<feature-name>/phase-6-operation.md` adhering to the 8-section content contract (§0 Environment Topology matrix, §1 Containerization, §2 Compose, §3 Config/Secrets declarations [names only], §4 CI/CD Pipeline, §5 Delivery & Promotion Policy, §6 Observability & Health Contracts [6a/6b/6c], §7 ADRs).
8. **Strict Sandbox Boundary**: Strictly respect the workspace boundary rule—write ONLY to `agent-workspace/plans/<feature-name>/` (plus project-durable verification artifacts in `agent-workspace/tests/`). Zero code execution or source modification.

### Node S5: Execution Acceptance Gate & Implementation Map Option
1. Synthesize generated blueprints, scenarios, operations design, and system impact into an Execution Acceptance Summary for developer review.
2. Present explicit option to draft a software versioned implementation map (`implementation_map_v<version>.md`) adhering to `implementation_map_taxonomy.md`.
3. **STRICT PROHIBITION**: If selected, draft ONLY the map document in `agent-workspace/plans/<feature-name>/implementation_maps/`. Zero source code scaffolding or editing in `src/` or `codebase-*/` is permitted during `/plan`.
4. Log developer acceptance in `GRILL_STATUS.md`.

### Node S6: `PROCESS_STATUS.md` Sync & Log Update
1. Update `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`.
2. Synchronize Block 1 matrix sub-rows 3.1–3.6 (`[x] Done` for active blueprints, `[-] Not In Scope` for unneeded).
3. If an implementation map was drafted, mark implementation map row as `[x] Done`.
4. Ensure row 6 designates `/operate`.
5. Record datestamped entry in Block 2 daily history log.

### Node S7: Planning Completed
1. Output planning completion report summarizing generated blueprints, sub-element specs, test strategy, scenario IDs, operations contracts, and implementation map version.
2. Instruct developer to proceed to `/implement`.
