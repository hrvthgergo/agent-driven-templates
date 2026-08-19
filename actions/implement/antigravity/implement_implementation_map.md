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
| **Mandatory Dual Grounding Mandate** | [implement_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L45-L53) | Rule & Workflow Primitives | `rules/implement-governor.md` & `workflows/implement.md` |
| **Decision Persistence & Artifact Sync** | [implement_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L27-L35) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **4-Part Step Schema Enforcement** | [implement_action.md Section 2.A](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L58-L75) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Sequential vs. Parallel Streams** | [implement_action.md Section 2.B](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L76-L95) | Workflow & Skill Primitives | `workflows/implement.md` & `skills/implement-scaffolder/SKILL.md` |
| **Visible Step-by-Step Execution** | [implement_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L36-L44) | Workflow Primitive | `workflows/implement.md` (Node S4) |
| **Token Economy Guard (Optional Features)** | [implement_action.md Section 1](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L27-L35) | Rule & Workflow Primitives | `rules/implement-governor.md` & `workflows/implement.md` |
| **Directory Separation & Production Cleanliness** | [implement_action.md Section 3.E](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_action.md#L125-L140) | Rule & Skill Primitives | `rules/implement-governor.md` & `skills/implement-scaffolder/SKILL.md` |
| **Sequential Q1–Q9 Micro-Architecture Grill** | [implement_questions.md Section 3](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/implement_questions.md#L45-L160) | Rule & Workflow Primitives | `rules/implement-grill.md` & `workflows/implement.md` |
| **Branch Process Status (`PROCESS_STATUS.md`) Sync** | [process_handling.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/process_handling.md) | Template & Workflow Primitives | `templates/PROCESS_STATUS.md` & `workflows/implement.md` |

---

## 3. Implementation Plan Schema & Task Sequence

### Block 1: Target Files & Scaffolding Checklist
- [ ] `[NEW]` `actions/implement/antigravity/guards/rules/implement-governor.md` - Core governor rule enforcing dual grounding, artifact sync, 4-part step schema, and write boundaries.
- [ ] `[NEW]` `actions/implement/antigravity/guards/rules/implement-grill.md` - Micro-architecture interview rule guard.
- [ ] `[NEW]` `actions/implement/antigravity/guards/workflows/implement.md` - Stateful execution playbook governing 7-node state machine.
- [ ] `[NEW]` `actions/implement/antigravity/guards/skills/implement-scaffolder/SKILL.md` - Scaffolder skill for incremental code modification, optional AST graph building, and optional doc updates.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/code_graph_node.md` - Structural node template.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/system_doc_template.md` - Global system documentation update template.
- [ ] `[NEW]` `actions/implement/antigravity/guards/templates/PROCESS_STATUS.md` - Process status matrix update template.

---

### Block 2: Execution Flow Categorization (Sequential vs. Parallel Streams)

#### Sequential Execution Stream (Strict Linear Order)
1. **Step 1: Core Implementation Governor Rule (`rules/implement-governor.md`)**
   - Foundation for all execution constraints and write boundaries.
2. **Step 2: Micro-Architecture Grill Rule (`rules/implement-grill.md`)**
   - Implements neutral Q1–Q9 prompt schema.
3. **Step 3: Stateful Workflow Playbook (`workflows/implement.md`)**
   - Orchestrates the 7-node state machine and interactive checkpoints.
4. **Step 5: Process Status & Verification Integration**
   - Final validation against `implement_tests.md`.

#### Parallel Execution Stream (Decoupled Primitives)
- **Step 4.A: Scaffolding Skill (`skills/implement-scaffolder/SKILL.md`)**
- **Step 4.B: Document & Node Templates (`templates/*`)**

---

### Block 3: Step-by-Step Task Sequence

#### Step 1: Implement Core Implementation Governor Rule (`rules/implement-governor.md`)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 1 & Section 3` (Mandatory Dual Grounding, Inner Artifact Alignment, Token Economy Guard, and Write Boundaries).
2. **Prerequisites**:
   - Directory `actions/implement/antigravity/guards/rules/` initialized.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/rules/implement-governor.md`: Define constraints prohibiting code editing without map & test plan, enforcing 100% artifact sync to `plans/`, and keeping code graph/doc updates optional.
4. **Verification Fulfilled**:
   - Antigravity rule syntax and frontmatter validated.

#### Step 2: Implement Micro-Architecture Grill Rule (`rules/implement-grill.md`)
1. **Requirement Fulfilled**:
   - `implement_questions.md Section 1 to Section 3` (Sequential Q1–Q9 micro-architecture interview).
2. **Prerequisites**:
   - Step 1 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/rules/implement-grill.md`: Implement neutral prompting laws and sequential Q1–Q9 prompts.
4. **Verification Fulfilled**:
   - Confirm zero `[Recommended]` bias labels and persistence to `GRILL_STATUS.md`.

#### Step 3: Implement Stateful Workflow Playbook (`workflows/implement.md`)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 5` (7-Node State Machine S1–S7 with visible checkpoints).
2. **Prerequisites**:
   - Steps 1 & 2 completed.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/workflows/implement.md`: Implement 7-node state machine with CLI parameter handling (`--auto`, `--plan`, `--code-graph`, `--docs`, `--full-sync`, `--dry-run`).
4. **Verification Fulfilled**:
   - Workflow transitions verified through all 7 nodes.

#### Step 4.A: Implement Scaffolder Skill (`skills/implement-scaffolder/SKILL.md`) (Parallel Stream)
1. **Requirement Fulfilled**:
   - `implement_action.md Section 2 & Section 3` (Code scaffolding, AST code graph updating, doc promotion).
2. **Prerequisites**:
   - Workflow playbook structure established.
3. **Actions Taken**:
   - `[NEW]` `actions/implement/antigravity/guards/skills/implement-scaffolder/SKILL.md`: Detail incremental code scaffolding procedure, optional AST graph updates, and optional doc updates.
4. **Verification Fulfilled**:
   - Skill procedure references verified against `code_graph_taxonomy.md`.

#### Step 4.B: Implement Template Assets (`templates/*`) (Parallel Stream)
1. **Requirement Fulfilled**:
   - `code_graph_taxonomy.md` and `process_handling.md`.
2. **Prerequisites**:
   - Directory `actions/implement/antigravity/guards/templates/` initialized.
3. **Actions Taken**:
   - `[NEW]` `templates/code_graph_node.md`, `templates/system_doc_template.md`, `templates/PROCESS_STATUS.md`.
4. **Verification Fulfilled**:
   - Templates conform to 2-block status matrix and code graph taxonomy schemas.

---

### Block 4: Verification Commands
Automated and manual verification procedures defined in [implement_tests.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/implement/antigravity/implement_tests.md).

---

### Block 5: Acceptance Criteria & Consent Gate
- All 7 guard files scaffolded adhering to Antigravity primitive standards.
- Rejection tests assert dual grounding before code modification.
- Working tree clean and synchronized.
