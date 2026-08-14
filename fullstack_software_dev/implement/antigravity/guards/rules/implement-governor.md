---
name: implement-governor
description: Core Governor Rule Guard for action implementation workflow, dual grounding, artifact sync, 4-part step schema, and write boundaries
---

# `implement-governor` Rule Guard

This rule guard enforces core execution safety, write boundaries, mandatory dual grounding prerequisites, inner agent artifact synchronization, 4-part step schema enforcement, visible step-by-step progress, and token economy guards during the `/implement` workflow.

---

## 1. Mandatory Dual Grounding Constraint
The AI agent MUST NOT write, modify, or delete any source code files in `codebase-*` or `src/` unless BOTH of the following foundational conditions are verified:
1. A valid, version-named implementation map (e.g. `implementation_map_v1.0.0.md`) exists in `agent-workspace/plans/<feature-name>/implementation_maps/`.
2. A valid test specification (`phase-5-verification.md` or feature test plan detailing critical system assertions) exists in `agent-workspace/plans/<feature-name>/`.

If either prerequisite is missing, the agent MUST immediately halt execution, notify the developer, and prompt to draft the missing prerequisite before touching code.

---

## 2. Decision Persistence & Inner Agent Artifact Synchronization
1. **Mandatory Document Parity**: Every single result, decision, architectural choice, trade-off rationale, edge-case clarification, or step outcome recorded in inner agent docs (e.g. Antigravity Artifacts such as `implementation_plan.md` or `walkthrough.md`) MUST be immediately written and synchronized into the corresponding version-controlled files under `agent-workspace/plans/<feature-name>/`.
2. **Single Source of Truth**: The version-controlled files under `agent-workspace/plans/<feature-name>/` remain the sole authoritative record of truth for the codebase across Git history, developers, and future agent sessions.

---

## 3. Mandatory 4-Part Step Schema & Execution Stream Enforcement
Every implementation step defined in the target implementation map MUST contain:
1. **Requirement Fulfilled**: Explicit reference to `phase-*.md` blueprint sections.
2. **Prerequisites**: Verification that prior step dependencies and contracts are satisfied before starting.
3. **Actions Taken**: Clear list of target sub-repositories (`codebase-*`) and files (`[NEW]`, `[MODIFY]`, `[REFACTOR]`).
4. **Verification Fulfilled**: Exact unit tests or assertions that MUST pass to complete the step.

* **Sequential Steps**: Must be executed in strict numerical sequence.
* **Parallel Steps**: Decoupled tasks that MAY be executed concurrently or in flexible order.

---

## 4. Visible Step-by-Step Execution & Direct User Control
1. **Visible Progress**: Code scaffolding MUST proceed in transparent, followable step-by-step increments.
2. **Interruption Checkpoints**: Between scaffolding steps, the agent MUST maintain an active communication window where the user can interrupt, ask questions, or request micro-architectural adjustments.
3. **No Opaque Delegation**: Implementation execution MUST be performed directly by the agent in full view of the user. Delegating code execution to opaque background loops or multi-agent delegations is forbidden.

---

## 5. Token Economy Guard (Optional Features)
1. **Default State**: By default, `/implement` skips AST Code Graph updates (`agent-workspace/src/<layer>/code_graph/`) and System Documentation updates (`agent-workspace/docs/`) to prevent token bloat and excessive API overhead.
2. **When Enabled (`--code-graph`, `--docs`, `--full-sync`)**: The agent executes AST code graph updates or doc promotions on-demand after code scaffolding completes.

---

## 6. Directory Separation & Write Boundaries Constraint
The AI agent MUST respect strict directory boundaries during `/implement`:
* **Source Code & Unit Tests**: Written strictly to `codebase-*` sub-repositories (accessed via symlinks under `agent-workspace/src/<layer>/`).
* **AST Code Graphs**: Written strictly to `agent-workspace/src/<layer>/code_graph/`. Zero structural documentation maps may be written directly inside production source code directories.
* **System Documentation**: Written strictly to `agent-workspace/docs/`.
* **Planning Artifacts**: `agent-workspace/plans/<feature-name>/` is updated with decisions, process status, and audit logs.
