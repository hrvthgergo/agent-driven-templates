# Implementation Map: `/qualify` Action Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/qualify` action within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `actions/qualify/antigravity/guards/` in a future execution step.

### Role of this Implementation Map vs. Universal Design Baselines
* **Universal Design & Architectural Baselines (Platform-Agnostic)**: [qualify_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md), [qualify_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_questions.md), [verification_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/verification_taxonomy.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md), [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md), and [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/summary.md) form the platform-agnostic design specification. These baselines define the theoretical workflow, the 3-pillar qualification model, the Node Q1 Coverage Gate algorithm, defect attribution taxonomies, and release certification rules so they can be implemented in any AI agent environment.
* **Antigravity Implementation Guideline**: This document (`qualify_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
  * **Workflows (`workflows/`)**: Stateful execution playbooks defining the 6-node state machine (`workflows/qualify.md`), covering the fail-closed Node Q1 Coverage Gate, targeted vs. Docker compose execution, and `--propose` / `--force-gate` handling.
  * **Rules (`rules/`)**: Permanent constraint instructions enforcing unchangeable baselines and prompting laws (`rules/qualify-governor.md`, `rules/qualify-grill.md`).
  * **Skills (`skills/`)**: Specialized capability packages providing procedures and tools for coverage gate resolution, multi-tier test execution, layer defect attribution, coverage gap proposal authoring, and audit report generation (`skills/qualify-evaluator/SKILL.md`).
  * **Templates (`templates/`)**: Standardized document formats deployed into `agent-workspace/plans/<feature-name>/` (`QUALIFICATION_REPORT.md`, `qualification_log.json`, `PROCESS_STATUS.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Execution & Judgment Scope Boundary (No Test Asset Authoring)** | [qualify_action.md Section 1 & 2](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Rule & Skill Primitives | `rules/qualify-governor.md` (Baseline 2) & `skills/qualify-evaluator/SKILL.md` |
| **Three-Pillar Qualification Architecture** | [qualify_action.md Section 2](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Rule, Skill & Workflow Primitives | `rules/qualify-governor.md`, `workflows/qualify.md` |
| **Node Q1 Coverage Gate (Fail-Closed Before Environment Boot)** | [qualify_action.md Section 6](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) & [verification_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/verification_taxonomy.md) | Rule, Workflow & Skill Primitives | `rules/qualify-governor.md` (Baseline 1), `workflows/qualify.md` (Node Q1), `skills/qualify-evaluator/SKILL.md` |
| **Defect vs. Coverage Gap Distinction** | [qualify_action.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) & [verification_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/verification_taxonomy.md) | Rule & Skill Primitives | `rules/qualify-governor.md` (Baseline 4), `skills/qualify-evaluator/SKILL.md` |
| **Unratified Proposal Stamping (`origin: qualify, status: unratified`)** | [qualify_action.md Section 4](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Skill & Rule Primitives | `skills/qualify-evaluator/SKILL.md` & `rules/qualify-governor.md` |
| **Multi-Tier Hierarchical Execution (Unit → Integration → E2E → Regression)** | [qualify_action.md Section 6](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Workflow & Skill Primitives | `workflows/qualify.md` (Node Q3) & `skills/qualify-evaluator/SKILL.md` |
| **Multi-Layer Defect Attribution (Layout, Engine, Data, DevOps, Test Spec)** | [qualify_action.md Section 6](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Skill & Workflow Primitives | `skills/qualify-evaluator/SKILL.md` & `workflows/qualify.md` (Node Q4) |
| **Provisional Certification & `--force-gate` Override Handling** | [qualify_action.md Section 6 & 7](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Rule, Workflow & Template Primitives | `rules/qualify-governor.md`, `workflows/qualify.md`, `templates/QUALIFICATION_REPORT.md` |
| **Ratified Scenario Regression Promotion** | [qualify_action.md Section 4 & 6](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Skill & Workflow Primitives | `skills/qualify-evaluator/SKILL.md` & `workflows/qualify.md` (Node Q6) |
| **Sequential Q1–Q6 Minimal Grill Engine** | [qualify_questions.md Section 1–3](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_questions.md) | Rule & Workflow Primitives | `rules/qualify-grill.md` & `workflows/qualify.md` |
| **Audit Artifacts (`QUALIFICATION_REPORT.md` & `qualification_log.json`)** | [qualify_action.md Section 8](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_action.md) | Template & Skill Primitives | `templates/QUALIFICATION_REPORT.md`, `templates/qualification_log.json`, `skills/qualify-evaluator/SKILL.md` |
| **Process Status Matrix (`PROCESS_STATUS.md`) Sync** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/qualify.md` (Node Q6) |

---

## 3. Implementation Plan Schema & Task Sequence

### Block 1: Target Files & Scaffolding Checklist
- [ ] `[NEW]` `actions/qualify/antigravity/guards/rules/qualify-governor.md` - Core governor rule enforcing Coverage Gate precedence, no test asset authoring authority, inheritance of `TEST_STRATEGY.md` criteria, defect vs. coverage gap separation, and release gating constraints.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/rules/qualify-grill.md` - Execution-configuration interview rule guard enforcing Q1–Q6 prompts and neutral option presentation.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/workflows/qualify.md` - Stateful execution playbook governing the 6-node state machine ($Q1 \rightarrow Q6$), fail-closed coverage gate halt, CLI flags (`--unit`, `--integration`, `--e2e`, `--regression`, `--env`, `--report-only`, `--propose`, `--force-gate`), and interactive checkpoints.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/skills/qualify-evaluator/SKILL.md` - Core qualification evaluator skill for parsing `@scenario` citations, evaluating the coverage gate formula, executing multi-tier test suites, diagnosing failure stack traces for layer attribution, generating audit reports, and promoting ratified scenarios.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/templates/QUALIFICATION_REPORT.md` - Human-readable qualification audit report template with Section 0 Coverage Gate result, Test Suite breakdown, Defect Attribution, Coverage Gap Proposals, and Release Certification.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/templates/qualification_log.json` - Machine-readable JSON execution log template.
- [ ] `[NEW]` `actions/qualify/antigravity/guards/templates/PROCESS_STATUS.md` - Process status matrix update template tracking Row 5 (`/qualify`).

---

### Block 2: Execution Flow Categorization (Sequential & Parallel Streams)

#### Sequential Execution Stream (Strict Linear Order)
1. **Step 1: Core Qualification Governor Rule (`rules/qualify-governor.md`)**
   - Foundation for all execution constraints, Coverage Gate precedence, and authoring boundaries.
2. **Step 2: Execution-Configuration Grill Rule (`rules/qualify-grill.md`)**
   - Implements neutral Q1–Q6 prompt schema and scanning logic.
3. **Step 3: Stateful Workflow Playbook (`workflows/qualify.md`)**
   - Orchestrates the 6-node state machine ($Q1 \rightarrow Q6$), fail-closed gate routing, and interactive checkpoints.
4. **Step 5: Process Status & Verification Integration**
   - Final validation against `qualify_tests.md`.

#### Parallel Execution Stream (Decoupled Primitives)
- **Step 4.A: Qualification Evaluator Skill (`skills/qualify-evaluator/SKILL.md`)**
  - Implements procedural logic for gate calculation, multi-tier execution, layer attribution, and regression promotion.
- **Step 4.B: Audit & Report Templates (`templates/*`)**
  - Scaffolds standardized report and log schemas.

---

### Block 3: Step-by-Step Task Sequence

#### Step 1: Implement Core Qualification Governor Rule (`rules/qualify-governor.md`)
1. **Requirement Fulfilled**:
   - `qualify_action.md Section 1 & Section 2` and `qualify_questions.md Section 1` (Coverage Gate Precedence, No Authoring Authority, Inheritance of Certification Criteria, Defect vs. Coverage Gap Distinction, Release Gating).
2. **Prerequisites**:
   - Directory `actions/qualify/antigravity/guards/rules/` initialized.
3. **Actions Taken**:
   - `[NEW]` `actions/qualify/antigravity/guards/rules/qualify-governor.md`:
     * Enforce mandatory Node Q1 Coverage Gate execution before environment boot or test execution.
     * Prohibit writing harness code, assigning scenario IDs, amending `TEST_STRATEGY.md`, or altering scenario `status` fields.
     * Enforce strict distinction: Defects block release unconditionally; Coverage Gaps are proposals only (`origin: qualify, status: unratified`) and never block release unless accompanied by a defect.
     * Mandate that provisional runs (`--force-gate`) never unlock `/release`.
4. **Verification Fulfilled**:
   - Antigravity rule syntax and frontmatter validated.

#### Step 2: Implement Qualification Grill Rule (`rules/qualify-grill.md`)
1. **Requirement Fulfilled**:
   - `qualify_questions.md Section 1 to Section 3` (Sequential Q1–Q6 execution interview).
2. **Prerequisites**:
   - Step 1 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/qualify/antigravity/guards/rules/qualify-grill.md`:
     * Implement neutral prompting laws without `[Recommended]` bias labels.
     * Q1: Verification scope and scenario count scanning.
     * Q2: Coverage gate failure routing (Halt to `/implement --tests-only`, review in `/plan`, or override via `--force-gate`).
     * Q3: Environment selection (Docker compose, local running, staging URL).
     * Q4: Tier selection (Full matrix, single tier, report-only).
     * Q5: Defect routing confirmation across layers.
     * Q6: Coverage gap proposal review.
     * Mandate persistence to `GRILL_STATUS.md` with header `mode: qualify`.
4. **Verification Fulfilled**:
   - Confirm zero unchangeable baseline negotiations and proper conditional skipping rules.

#### Step 3: Implement Stateful Workflow Playbook (`workflows/qualify.md`)
1. **Requirement Fulfilled**:
   - `qualify_action.md Section 6 & Section 7` (6-Node State Machine Q1–Q6, fail-closed gate halt, command variants).
2. **Prerequisites**:
   - Steps 1 & 2 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/qualify/antigravity/guards/workflows/qualify.md`:
     * Define the 6 sequential nodes:
       - **Node Q1**: Scope Resolution & Coverage Gate (`phase-5-test.md` vs `@scenario` citations in `codebase-qualify/src/` & `codebase-*/tests/`). Fail closed if any ratified scenario is unproven.
       - **Node Q2**: Environment & Test Target Gate.
       - **Node Q3**: Multi-Tier Test Suite Execution (Unit $\rightarrow$ Integration $\rightarrow$ E2E $\rightarrow$ Regression).
       - **Node Q4**: Defect Identification & Layer Attribution.
       - **Node Q5**: Qualification Reporting (`QUALIFICATION_REPORT.md` & `qualification_log.json`).
       - **Node Q6**: Release Gating & Handoff to `/release`.
     * Implement CLI flag handling: `--unit`, `--integration`, `--e2e`, `--regression`, `--env <url>`, `--report-only`, `--propose`, `--force-gate "<justification>"`.
     * Implement 3-layer context notification headers and badges.
4. **Verification Fulfilled**:
   - State machine node transitions and fail-closed branches verified.

#### Step 4.A: Implement Qualification Evaluator Skill (`skills/qualify-evaluator/SKILL.md`)
1. **Requirement Fulfilled**:
   - `qualify_action.md Section 2, 4, 6` and `verification_taxonomy.md` (Coverage Gate math, Multi-Tier execution, Layer Attribution, Gap Proposal authoring, Regression Promotion).
2. **Prerequisites**:
   - Step 3 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/qualify/antigravity/guards/skills/qualify-evaluator/SKILL.md`:
     * **Procedure 1**: Coverage Gate calculation (`scope \setminus implemented`). Parse `@scenario SC-*` regex tokens across `codebase-qualify/src/` and `codebase-*/tests/`.
     * **Procedure 2**: Environment boot coordination with `codebase-devops` or direct invocation against `--env`.
     * **Procedure 3**: Multi-Tier runner execution scripts and JUnit/TAP output parsing.
     * **Procedure 4**: Layer Defect Attribution engine (analyzing stack traces for `layout`, `engine`, `data`, `devops`, `test_spec`).
     * **Procedure 5**: Coverage Gap authoring (formatting proposed scenario files with `origin: qualify, status: unratified`).
     * **Procedure 6**: Regression Catalog Promotion (copying ratified passing scenarios into `agent-workspace/tests/regression/`).
     * **Procedure 7**: Report generator writing `QUALIFICATION_REPORT.md` and `qualification_log.json`.
4. **Verification Fulfilled**:
   - Skill manifest, parameter schemas, and procedure steps validated.

#### Step 4.B: Implement Audit & Report Templates (`templates/*`)
1. **Requirement Fulfilled**:
   - `qualify_action.md Section 8` (Structured audit artifacts and status matrix).
2. **Prerequisites**:
   - Step 3 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/qualify/antigravity/guards/templates/QUALIFICATION_REPORT.md`: Comprehensive template containing Section 0 Coverage Gate, Section 1 Test Suite Summary, Section 2 Identified Defects & Layer Attribution, Section 3 Coverage Gap Proposals, Section 4 Unproven Scope, and Section 5 Release Certification.
   - `[NEW]` `actions/qualify/antigravity/guards/templates/qualification_log.json`: Standardized JSON audit schema.
   - `[NEW]` `actions/qualify/antigravity/guards/templates/PROCESS_STATUS.md`: Status update template marking Row 5 (`/qualify`) as `Completed`.
4. **Verification Fulfilled**:
   - Templates conform to markdown/JSON lint standards and qualification schema.

#### Step 5: Verification & Integration Test Suite (`qualify_tests.md`)
1. **Requirement Fulfilled**:
   - Complete end-to-end qualification test specification for Antigravity environment.
2. **Prerequisites**:
   - Steps 1 through 4 completed.
3. **Actions Taken**:
   - Validate full execution flow against [qualify_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/antigravity/qualify_tests.md).
4. **Verification Fulfilled**:
   - All 5 automated test suites pass, asserting Coverage Gate fail-closed behavior, multi-tier execution, layer defect attribution, gap proposal handling, and regression catalog promotion.
