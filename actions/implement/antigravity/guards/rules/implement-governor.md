---
name: implement-governor
description: Core Governor Rule Guard for action implementation workflow, 3-leg dual grounding, artifact sync, 4-part step schema, test harness authority, and write boundaries
---

# `implement-governor` Rule Guard

This rule guard enforces core execution safety, write boundaries, mandatory 3-leg dual grounding prerequisites, inner agent artifact synchronization, 4-part step schema enforcement, test harness construction authority (`codebase-qualify/`), visible step-by-step progress, and token economy guards during the `/implement` workflow.

---

## 1. Mandatory Three-Leg Dual Grounding Constraint
The AI agent MUST NOT write, modify, or delete any source code or test files in `codebase-*`, `codebase-qualify/`, or `src/` unless ALL THREE of the following foundational conditions are verified:
1. **Implementation Map**: A valid, version-named implementation map (e.g. `implementation_map_v<version>.md` or `implementation_map_v1.0.0.md`) exists in `agent-workspace/plans/<feature-name>/implementation_maps/`.
2. **Verification Scope**: A valid test specification (`phase-5-test.md`) detailing critical system assertions and the in-scope scenario ID list exists in `agent-workspace/plans/<feature-name>/`.
3. **Ratified Scenario Set**: Every scenario ID listed in `phase-5-test.md` resolves to a file in `agent-workspace/tests/scenarios/<id>.md` carrying `status: ratified` per `verification_taxonomy.md` §6.

### Fail-Closed Precondition Resolution
If any of the three prerequisites is missing, ambiguous, or unratified (e.g., `status: draft` or retired), the agent MUST immediately **halt execution**, present the exact failure to the developer, and **return the scope to `/plan`**. `/implement` NEVER resolves a failed precondition by authoring, modifying, or ratifying missing artifacts itself.

---

## 2. Decision Persistence & Inner Agent Artifact Synchronization
1. **Mandatory Document Parity**: Every single result, decision, architectural choice, trade-off rationale, edge-case clarification, or step outcome recorded in inner agent docs (e.g. Antigravity Artifacts such as `implementation_plan.md` or `walkthrough.md`) MUST be immediately written and synchronized into the corresponding version-controlled files under `agent-workspace/plans/<feature-name>/`.
2. **Single Source of Truth**: The version-controlled files under `agent-workspace/plans/<feature-name>/` remain the sole authoritative record of truth for the codebase across Git history, developers, and future agent sessions.

---

## 3. Mandatory 4-Part Step Schema & Execution Stream Enforcement
Every implementation step defined in the target implementation map MUST contain:
1. **Requirement Fulfilled**: Explicit reference to `phase-*.md` blueprint sections.
2. **Prerequisites**: Verification that prior step dependencies and contracts are satisfied before starting.
3. **Actions Taken**: Clear list of target sub-repositories (`codebase-*`, `codebase-qualify/`) and files (`[NEW]`, `[MODIFY]`, `[REFACTOR]`).
4. **Verification Fulfilled**: Exact unit tests or assertions that MUST pass to complete the step.

### Stream Categorization
* **Sequential Steps**: Must be executed in strict numerical sequence.
* **Parallel Steps**: Decoupled tasks that MAY be executed concurrently or in flexible order.
* **Test Harness Stream**: Cross-layer integration tests scaffolded against `codebase-qualify/src/` (may be executed red-first via `--tests-only`).

---

## 4. Test Harness Construction Authority (`codebase-qualify/`) & `@scenario` Tagging
`codebase-qualify` is a first-class software layer governed by standard implementation rules:
1. **Harness Construction**: For each ratified scenario in `phase-5-test.md`, `/implement` scaffolds a corresponding cross-layer test in `codebase-qualify/src/`. Layer-local unit tests remain co-located in `codebase-<layer>/tests/`.
2. **Mandatory `@scenario` Citation**: Every harness test MUST declare the scenario it satisfies using the canonical token:
   ```
   @scenario SC-<feature-slug>-<nnn>
   ```
   The token MUST appear within the test's own declaration block (decorator list, annotation, docstring, or preceding comment lines).
3. **Red-First Construction**: The harness stream MAY be executed before feature code via `/implement --tests-only`, establishing a failing suite that feature code scaffolding turns green.
4. **Strict Action Boundary**: `/implement` builds harness code. It does NOT author scenarios, assign identifiers, amend `TEST_STRATEGY.md`, alter any `status` field, or render qualification verdicts.

---

## 5. Visible Step-by-Step Execution & Direct User Control
1. **Visible Progress**: Code scaffolding MUST proceed in transparent, followable step-by-step increments.
2. **Interruption Checkpoints**: Between scaffolding steps, the agent MUST maintain an active communication window where the user can interrupt, ask questions, or request micro-architectural adjustments.
3. **No Opaque Delegation**: Implementation execution MUST be performed directly by the agent in full view of the user. Delegating code execution to opaque background loops or multi-agent delegations is forbidden.

---

## 6. Token Economy Guard (Optional Features)
1. **Default State**: By default, `/implement` skips AST Code Graph updates (`agent-workspace/src/<layer>/code_graph/`) and System Documentation updates (`agent-workspace/docs/`) to prevent token bloat and excessive API overhead.
2. **When Enabled (`--code-graph`, `--docs`, `--full-sync`)**: The agent executes AST code graph updates or doc promotions on-demand after code scaffolding completes.

---

## 7. Directory Separation & Write Boundaries Constraint
The AI agent MUST respect strict directory boundaries during `/implement`:
* **Source Code & Unit Tests**: Written strictly to `codebase-*` sub-repositories (accessed via symlinks under `agent-workspace/src/<layer>/`).
* **Test Harness Suite**: Written strictly to `codebase-qualify/src/` (accessed via symlink `agent-workspace/src/qualify/`).
* **AST Code Graphs**: Written strictly to `agent-workspace/src/<layer>/code_graph/`. Zero structural documentation maps may be written directly inside production source code directories.
* **System Documentation**: Written strictly to `agent-workspace/docs/`.
* **Planning Artifacts**: `agent-workspace/plans/<feature-name>/` is updated with decisions, process status, and audit logs.
