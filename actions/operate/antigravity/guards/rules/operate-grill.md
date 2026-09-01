---
name: operate-grill
description: Interactive Q&A constraints and routing logic for /operate
---

# Grill Rules: `/operate`

This rule guard enforces the minimal negotiation interactive Q&A for the delivery phase. The grill confirms *where* and *what* to deliver, never *what the topology, gate, or policy is*.

## 1. Unchangeable Baselines (No Negotiation)
1.  **Entry Gate & Provenance Gate Precedence**: Node O2 evaluates both gates fail-closed before any build or push. No `--force-gate` override exists.
2.  **No Authoring Authority**: `/operate` writes no Dockerfile, compose file, or infrastructure config. Its single bounded authoring exception is an ops finding with `origin: operate, status: unratified` in `WALKTHROUGH.md`.
3.  **Build Identity Is Keyed on Source State**: The decision to build fresh or reuse a digest is computed automatically based on history matching.
4.  **Post-Delivery Hooks Fire on Declaration**: Hooks declared in `phase-6-operation.md` §5 fire automatically. There is no `--deploy` flag.
5.  **Certification Requirement Is Inherited**: The entry gate is inherited from `phase-6-operation.md` §0 and cannot be renegotiated.

## 2. Interactive Prompts Blueprint

### Q1: Feature Scope & Target Environment Resolution
- **Trigger**: Always, unless `--env` is supplied and unambiguous.
- **Prompt**: Confirm target environment, purpose, and required entry gate.
- **Options**: Confirm, Target different environment, Abort, Other/Free-text.

### Q2: Version & Build Action Preview
- **Trigger**: Always, unless `--version` is supplied.
- **Prompt**: Preview if Node O3 will reuse a prior digest or build fresh.
- **Options**: Confirm, Specify different tag, Abort, Other/Free-text.

### Q3: Entry Gate Failure Routing
- **Trigger**: *Only* when target requires `certification: full` but report is absent or provisional.
- **Prompt**: State entry gate failure and require remedy.
- **Options**: Halt and return to `/qualify`, Target different (gate: none) environment, Route to `/plan` Phase 6, Other/Free-text.

### Q4: Provenance Gate Mismatch Routing
- **Trigger**: *Only* when entry gate passes but source digest mismatches certified digest.
- **Prompt**: State provenance failure and require remedy.
- **Options**: Halt and return to `/qualify`, Deliver certified digest instead of current source, Target different environment, Other/Free-text.

### Q5: Delivery Confirmation & Execution Mode
- **Trigger**: Always, unless `--auto` or `--dry-run` is active.
- **Prompt**: Re-cap configuration (Env, Version, Build Action, Hooks) and request consent to execute O3 and O4.
- **Options**: Confirm and execute, Revise configuration, Abort, Other/Free-text.

### Q6: Ops Finding Review
- **Trigger**: *Only* if Node O5 health assertions surface failures/findings.
- **Prompt**: Review unratified ops findings.
- **Options**: Record all in WALKTHROUGH, Record and flag high-priority, Discard false positive, Other/Free-text.

## 3. Post-Grill Handoff
- Always persist the audit log to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md` with header `mode: operate` and proceed to Node O2.
