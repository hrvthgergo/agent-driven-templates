---
name: implement-grill
description: Micro-Architecture Q&A Interview Rule Guard for action implementation
---

# `implement-grill` Rule Guard

This rule guard governs the `/implement` Grill-me Q&A interview engine, enforcing mandatory dual grounding baselines, micro-architectural starting point alignment, AST code graph taxonomies, system doc update options, neutral choice presentation, and permanent audit logging.

---

## 1. Unchangeable Baselines

1. **Baseline 1: Mandatory Dual Grounding Mandate**: Code implementation MUST stand firmly on BOTH a valid `implementation_map_v<version>.md` AND a Test Plan (`phase-5-verification.md`).
2. **Baseline 2: Strict Directory Separation & Production Cleanliness**: Source code in `codebase-*`, AST code graphs in `agent-workspace/src/<layer>/code_graph/`, and system documentation in `agent-workspace/docs/`.
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

## 3. Sequential Q1 – Q9 Prompts

* **Q1: Implementation Map & Target Version Selection**: Confirm which version-named map (`implementation_map_v1.0.0.md`) inside `implementation_maps/` governs execution.
* **Q2: Verification Test Plan & Critical Feature Assertions Alignment**: Confirm unit and integration test scaffolding strategy based on `phase-5-verification.md`.
* **Q3: Starting Layer / Component Entry Point**: Confirm starting architectural layer (`codebase-data`, `codebase-engine`, `codebase-ui`, `codebase-ops`).
* **Q4: Scaffolding Strategy & Visible Step Boundary**: Select execution mode (`--plan` for step-by-step confirmation with diff preview, `--auto` for continuous scaffolding, or `--dry-run`).
* **Q5: Sequential vs. Parallel Stream Execution Order**: Confirm sequencing of decoupled parallel execution tasks.
* **Q6: Token Economy & AST Code Graph Update Options (`--code-graph`)**: Confirm whether AST Code Graph generation in `src/<layer>/code_graph/` is activated (Skipped by default).
* **Q7: Token Economy & System Documentation Promotion Options (`--docs`)**: Confirm whether general system documentation in `agent-workspace/docs/` is updated (Skipped by default).
* **Q8: Sub-Repository / Multi-Repo Symlink Integrity Verification**: Run symlink resolution check on `agent-workspace/src/`.
* **Q9: Final Implementation Confirmation & Execution Start**: Recap chosen options and obtain developer approval to commence code scaffolding.
