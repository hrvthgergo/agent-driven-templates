# Implementation Map: `/implement` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/implement` workflow within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `actions/implement/antigravity/guards/` in a future execution step.

### Role of this Implementation Map vs. Universal Design Baselines
* **Universal Design & Architectural Baselines (Platform-Agnostic)**: [implement_action.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md), [implement_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_questions.md), [implementation_map_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implementation_map_taxonomy.md), [code_graph_taxonomy.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/code_graph_taxonomy.md), [folder_structure.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/folder_structure.md), and [summary.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/summary.md) form the platform-agnostic design specification. These baselines define theoretical workflows, state machine rules, and write boundary constraints so they can be implemented in any AI agent environment.
* **Antigravity Implementation Guideline**: This document (`implement_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
  * **Workflows (`workflows/`)**: Stateful execution playbooks defining the 7-node state machine (`workflows/implement.md`).
  * **Rules (`rules/`)**: Permanent constraint instructions enforcing unchangeable baselines and prompting laws (`rules/implement-grill.md`, `rules/implement-governor.md`).
  * **Skills (`skills/`)**: Specialized capability packages providing procedures for code scaffolding, AST code graph generation/updating, and system documentation updates (`skills/implement-scaffolder/SKILL.md`).
  * **Templates (`templates/`)**: Standardized document and node templates deployed into workspace layers and documentation directories (`code_graph_node.md`, `system_doc_template.md`, `PROCESS_STATUS.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Mandatory Dual Grounding Mandate (3-Leg)** | [implement_action.md Section 1 & 3.A](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Workflow Primitives | `rules/implement-governor.md` & `workflows/implement.md` |
| **Repository & Infrastructure Provisioning Authority (`[C] / [W]`)** | [implement_action.md Section 3.J](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) & [directory_handling_roles.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/directory_handling_roles.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Decision Persistence & Artifact Sync** | [implement_action.md Section 1 & 3.B](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **4-Part Step Schema Enforcement** | [implement_action.md Section 2.A](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Sequential, Parallel & Test Harness Streams** | [implement_action.md Section 2.B & 3.I](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Workflow & Skill Primitives | `workflows/implement.md` & `skills/implement-scaffolder/SKILL.md` |
| **Test Harness Authority & `@scenario` Tagging** | [implement_action.md Section 3.I](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Observability Artifacts Partitioning** | [implement_action.md Section 3.J](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Red-First Harness Isolation (`--tests-only`)** | [implement_action.md Section 3.I & 5](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Workflow & Skill Primitives | `workflows/implement.md` & `skills/implement-scaffolder/SKILL.md` |
| **Visible Step-by-Step Execution** | [implement_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Workflow Primitive | `workflows/implement.md` (Node S4) |
| **Token Economy Guard (Optional Features)** | [implement_action.md Section 1 & 3.G/H](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Workflow Primitives | `rules/implement-governor.md` & `workflows/implement.md` |
| **Directory Separation & Production Cleanliness** | [implement_action.md Section 3.E/I/J](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Sequential Q1–Q9 (incl. Q4b) Grill Engine** | [implement_questions.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_questions.md) | Rule & Workflow Primitives | `rules/implement-grill.md` & `workflows/implement.md` |
| **Branch Process Status (`PROCESS_STATUS.md`) Sync** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/implement.md` |

---

## 3. Implementation Plan Schema & Task Sequence

### Block 1: Target Files & Scaffolding Checklist
- [ ] `[NEW]` `actions/implement/antigravity/guards/rules/implement-governor.md` - Core governor rule enforcing 3-leg dual grounding, artifact sync, 4-part step schema, repository provisioning authority, harness construction authority, `@scenario` tagging, and write boundaries.
- [ ] `[NEW]` `actions/implement/antigravity/guards/rules/implement-grill.md` - Micro-architecture interview rule guard enforcing Q1–Q9 prompts (including Q4b harness ordering).
- [ ] `[NEW]` `actions/implement/antigravity/guards/workflows/implement.md` - Stateful execution playbook governing 7-node state machine with repository provisioning in Node S4, `--tests-only` mode, and 3-leg fail-closed Node S2.
- [ ] `[NEW]` `actions/implement/antigravity/guards/skills/implement-scaffolder/SKILL.md` - Scaffolder skill for repository provisioning (`codebase-*`, `codebase-qualify/`, `codebase-devops/`), incremental code modification, observability partitioning, harness construction in `codebase-qualify/src/`, `@scenario` tag injection, AST graphs, and doc updates.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/code_graph_node.md` - Structural node template.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/system_doc_template.md` - Global system documentation update template.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/PROCESS_STATUS.md` - Process status matrix update template.

---

### Block 2: Execution Flow Categorization (Sequential, Parallel & Test Harness Streams)

#### Sequential Execution Stream (Strict Linear Order)
1. **Step 1: Core Implementation Governor Rule (`rules/implement-governor.md`)**
   - Foundation for all execution constraints, 3-leg grounding, repository provisioning authority, and write boundaries.
2. **Step 2: Micro-Architecture Grill Rule (`rules/implement-grill.md`)**
   - Implements neutral Q1–Q9 prompt schema (including Q4b harness ordering).
3. **Step 3: Stateful Workflow Playbook (`workflows/implement.md`)**
   - Orchestrates the 7-node state machine, repository provisioning in Node S4, `--tests-only` execution, and interactive checkpoints.
4. **Step 5: Process Status & Qualification Integration**
   - Final validation against `implement_tests.md`.

#### Parallel Execution Stream (Decoupled Primitives)
- **Step 4.A: Scaffolding Skill (`skills/implement-scaffolder/SKILL.md`)**
  - Handles repository provisioning (`codebase-<layer>/`, `codebase-qualify/`, `codebase-devops/`), feature code scaffolding, observability instrumentation vs infrastructure partitioning, `codebase-qualify/src/` test harness construction, and `@scenario` tagging.
- **Step 4.B: Document & Node Templates (`templates/*`)**

---

### Block 3: Step-by-Step Task Sequence

#### Step 1: Implement Core Implementation Governor Rule (`rules/implement-governor.md`)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 1 & Section 3` (Mandatory 3-Leg Dual Grounding, Repository & Infrastructure Provisioning Authority, Inner Artifact Alignment, Test Harness Authority & `@scenario` Tagging, Observability Artifacts Partitioning, Token Economy Guard, and Write Boundaries).
2. **Prerequisites**:
   - Directory `actions/implement/antigravity/guards/rules/` initialized.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/rules/implement-governor.md`: Define constraints prohibiting code editing without map, test plan, and ratified scenarios; enforce fail-closed return to `/plan` on precondition failure; establish sole provisioner authority over `codebase-*`, `codebase-qualify/`, and `codebase-devops/` applying the skeleton contract; mandate `@scenario SC-<feature-slug>-<nnn>` tag inside test declaration blocks in `codebase-qualify/src/`; partition observability artifacts (instrumentation in `codebase-<layer>/`, monitoring infra in `codebase-devops/`); enforce strict harness write boundaries (no scenario authorship or verdict rendering).
4. **Verification Fulfilled**:
   - Antigravity rule syntax and frontmatter validated.

#### Step 2: Implement Micro-Architecture Grill Rule (`rules/implement-grill.md`)
1. **Requirement Fulfilled**:
   - `implement_questions.md Section 1 to Section 3` (Sequential Q1–Q9 micro-architecture interview, including Q4b Test Harness Construction Ordering).
2. **Prerequisites**:
   - Step 1 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/rules/implement-grill.md`: Implement neutral prompting laws, scenario ratification scanning in Q2, Q4b harness ordering prompt (Red-first, Feature-first, Interleaved), and ratified scenarios count in Q9 recap.
4. **Verification Fulfilled**:
   - Confirm zero `[Recommended]` bias labels and persistence to `GRILL_STATUS.md`.

#### Step 3: Implement Stateful Workflow Playbook (`workflows/implement.md`)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 5` (7-Node State Machine S1–S7 with visible checkpoints, repository provisioning as first act of Node S4, `--tests-only` mode, and 3-leg Node S2 gate).
2. **Prerequisites**:
   - Steps 1 & 2 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/workflows/implement.md`: Implement 7-node state machine with CLI parameter handling (`--auto`, `--plan`, `--code-graph`, `--docs`, `--full-sync`, `--dry-run`, `--tests-only`), 3-leg Node S2 resolution gate returning to `/plan` on failure, and Node S4 repository provisioning and harness construction loop.
4. **Verification Fulfilled**:
   - Workflow transitions verified through all 7 nodes.

#### Step 4.A: Implement Scaffolder Skill (`skills/implement-scaffolder/SKILL.md`) (Parallel Stream)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 2, Section 3 & Section 3.I/J` (Repository provisioning, code scaffolding, `codebase-qualify/src/` harness building, `@scenario` tagging, observability partitioning, AST code graph updating, doc promotion).
2. **Prerequisites**:
   - Workflow playbook structure established.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/skills/implement-scaffolder/SKILL.md`: Detail execution directory provisioning (`codebase-<layer>/`, `codebase-qualify/`, `codebase-devops/`) applying the `/init`-owned skeleton contract, relative symlink registration under `agent-workspace/src/<layer>/`, incremental code scaffolding procedure, `@scenario SC-<feature-slug>-<nnn>` tag injection, `--tests-only` red-first execution, observability instrumentation and infrastructure partitioning, optional AST graph updates, and optional doc updates.
4. **Verification Fulfilled**:
   - Skill procedure references verified against `code_graph_taxonomy.md`, `verification_taxonomy.md`, and `directory_handling_roles.md`.

#### Step 4.B: Implement Template Assets (`templates/*`) (Parallel Stream)
1. **Requirement Fulfilled**:
   - `code_graph_taxonomy.md`, `verification_taxonomy.md`, `directory_handling_roles.md`, and `process_handling.md`.
2. **Prerequisites**:
   - Directory `actions/implement/antigravity/guards/templates/` initialized.
3. **Actions Taken**:
   - `[NEW]` `templates/code_graph_node.md`, `templates/system_doc_template.md`, `templates/PROCESS_STATUS.md` (with `/qualify` pointing to `QUALIFICATION_REPORT.md` and `/operate` pointing to `release_notes.md` or `WALKTHROUGH.md`).
4. **Verification Fulfilled**:
   - Templates conform to 2-block status matrix and code graph taxonomy schemas.

---

### Block 4: Verification Commands
Automated and manual verification procedures defined in [implement_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/antigravity/implement_tests.md).

---

### Block 5: Acceptance Criteria & Consent Gate
- All 7 guard files scaffolded adhering to Antigravity primitive standards.
- Rejection tests assert 3-leg dual grounding before code modification (map, test plan, ratified scenarios).
- Repository provisioning authority over `codebase-<layer>/`, `codebase-qualify/`, and `codebase-devops/` verified.
- Test harness construction in `codebase-qualify/src/` enforces `@scenario SC-<feature-slug>-<nnn>` tag syntax.
- `/implement --tests-only` mode verified for red-first harness building.
- Working tree clean and synchronized.
