---
name: implement-grill
description: Micro-Architecture Q&A Interview Rule Guard for action implementation
---

# `implement-grill` Rule Guard

This rule guard governs the `/implement` Grill-me Q&A interview engine, enforcing mandatory 3-leg dual grounding baselines, micro-architectural starting point alignment, test harness ordering, AST code graph taxonomies, system doc update options, neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines

1. **Baseline 1: Mandatory Three-Leg Dual Grounding Mandate**: Code implementation MUST stand firmly on THREE resolved foundations: (1) a valid `implementation_map_v<version>.md` under `agent-workspace/plans/<feature-name>/implementation_maps/`, (2) a Verification Scope (`phase-5-test.md`), and (3) a fully resolved scenario set — every scenario ID listed in `phase-5-test.md` resolving to a file in `agent-workspace/tests/scenarios/` with `status: ratified`. `/implement` never authors missing artifacts; precondition failures return the scope to `/plan`.
2. **Baseline 2: Strict Directory Separation & Production Cleanliness**: Source code in `codebase-*`, test harnesses in `codebase-qualify/src/`, deployment & observability configurations in `codebase-devops/`, AST code graphs in `agent-workspace/src/<layer>/code_graph/`, and system documentation in `agent-workspace/docs/`.
3. **Baseline 3: Mandatory 4-Part Step Schema Enforcement**: Requirement Fulfilled, Prerequisites, Actions Taken, Verification Fulfilled for every step.
4. **Baseline 4: Mandatory Decision Persistence & Inner Agent Artifact Alignment**: 100% sync between agent inner docs (Artifacts) and version-controlled files in `agent-workspace/plans/<feature-name>/`.
5. **Baseline 5: Token Economy Guard (Optional Maintenance)**: AST Code Graph and System Docs updates are optional add-ons, bypassed by default.
6. **Baseline 6: Visible Step-by-Step Execution & Direct User Control**: Visible progress, user interruption checkpoints, and zero opaque subagent delegation.

---

## 2. Prompting Laws

* **Zero Bias**: Do NOT prefix any option with `[Recommended]`.
* **Mandatory Free-Text**: Always include `Other / Free-text (...)` as the final choice in every prompt.
* **Audit Persistence**: Write all questions, option choices, and user answers permanently to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md`.

---

## 3. Sequential Q1 – Q9 Prompts (incl. Q4b)

* **Q1: Implementation Map & Target Version Selection**: Confirm which version-named map (`implementation_map_v1.0.0.md`) inside `implementation_maps/` governs execution.
* **Q2: Verification Test Plan & Scenario Ratification Alignment**: Scan `phase-5-test.md`, extract scenario IDs, assert each carries `status: ratified` in `agent-workspace/tests/scenarios/`, and confirm unit/integration test scaffolding strategy.
* **Q3: Starting Layer / Component Entry Point**: Confirm starting architectural layer (`codebase-data`, `codebase-engine`, `codebase-ui`, `codebase-devops`).
* **Q4: Scaffolding Strategy & Visible Step Boundary**: Select execution mode (`--plan` for step-by-step confirmation with diff preview, `--auto` for continuous scaffolding, or `--dry-run`).
* **Q4b: Test Harness Construction Ordering (Red-First vs. Feature-First)**: Determine when the cross-layer Test Harness stream (`codebase-qualify/`) is built relative to feature code:
  1. Red-first (Build harness ahead of feature code via `/implement --tests-only`)
  2. Feature-first (Scaffold feature code first, then build harness)
  3. Interleaved (Build scenario harness alongside the step that satisfies it)
  4. Other / Free-text
* **Q5: Sequential vs. Parallel Stream Execution Order**: Confirm sequencing of decoupled parallel execution tasks, including the Test Harness stream (`codebase-qualify/`) and DevOps stream (`codebase-devops/`).
* **Q6: Token Economy & AST Code Graph Update Options (`--code-graph`)**: Confirm whether AST Code Graph generation in `src/<layer>/code_graph/` is activated (Skipped by default).
* **Q7: Token Economy & System Documentation Promotion Options (`--docs`)**: Confirm whether general system documentation in `agent-workspace/docs/` is updated (Skipped by default).
* **Q8: Sub-Repository / Multi-Repo Symlink Integrity Verification**: Run symlink resolution check on `agent-workspace/src/` (including `qualify` and `devops`).
* **Q9: Final Implementation Confirmation & Execution Start**: Recap chosen options (Target Map, Verification Scope, Ratified Scenarios in Scope count, Harness Ordering, Execution Mode) and obtain developer approval to commence code scaffolding.

