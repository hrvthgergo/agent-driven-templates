# Grill Schema: Operations & Delivery Questions (/operate)

This document defines the interactive Q&A schema executed by the [Grill Engine](../grill_engine.md)
at the start of the `/operate` action. It is deliberately **minimal**: `/operate` is a pure execution
action, and everything it needs to know — environment topology, entry gates, image specs, promotion
policy, health and observability contracts — was decided upstream by `/plan` (design) and
`/implement` (construction). The grill confirms *where and what to deliver*, never *what the
topology, gate, or policy is*.

---

## 1. Unchangeable Baselines (No Questions Asked)

These are never negotiated with the developer. They are asserted, and violations halt the action.
Unlike `/qualify`, `/operate` has **no override flag at all** — there is no `--force-gate` equivalent.
A failed gate here has exactly one outcome: halt.

### Baseline 1: Entry Gate & Provenance Gate Precedence
* **Specification**: Node O2 evaluates both gates, fail-closed, before any build or push. The entry
  gate is read from `phase-6-operation.md` §0 and is never re-litigated at execution time; the
  provenance gate applies unconditionally to every `certification: full` environment. No flag
  disables either gate, and neither may be answered around in the grill.

### Baseline 2: No Authoring Authority
* **Specification**: `/operate` writes no Dockerfile, compose file, pipeline YAML, dashboard
  definition, alert rule, or collector configuration; defines no environment and alters no entry
  gate. Its single bounded exception is authoring an **ops finding** with `origin: operate,
  status: unratified`, per [operate_action.md](./operate_action.md) §2.D.

### Baseline 3: Build Identity Is Keyed on Source State, Not on `--version`
* **Specification**: Whether Node O3 builds fresh or reuses a previously recorded digest is computed
  automatically from source-state matching against the feature's `WALKTHROUGH.md` history. This is
  never a developer choice — the grill previews the computed result (Q2) but does not offer to
  override it.

### Baseline 4: Post-Delivery Hooks Fire on Declaration, Not on Request
* **Specification**: If `phase-6-operation.md` §5 declares a post-delivery hook for the target
  environment, Node O4 executes it automatically after a successful promotion. There is no
  `--deploy` flag and no grill question offering to trigger or skip a declared hook manually.

### Baseline 5: Certification Requirement Is Inherited
* **Specification**: Whether the target environment requires `certification: full` is declared in
  `phase-6-operation.md` §0 and cannot be renegotiated at execution time. `/operate` applies the
  declared gate; it does not set it.

---

## 2. Questions & Scanning Blueprint

| # | Question | Auto-Detection Source | Skippable |
| :--- | :--- | :--- | :--- |
| Q1 | Feature scope & target environment resolution | `--env` flag, `phase-6-operation.md` §0 | Yes (`--env` supplied and unambiguous) |
| Q2 | Version & build action preview | `--version` flag, `WALKTHROUGH.md` history | Yes (`--version` supplied) |
| Q3 | Entry gate failure routing | Node O2 entry gate output | No (only when gate fails) |
| Q4 | Provenance gate mismatch routing | Node O2 provenance gate output | No (only when digest mismatches) |
| Q5 | Delivery confirmation & execution mode | Command flags (`--auto`, `--dry-run`) | Yes (`--auto` or `--dry-run` supplied) |
| Q6 | Ops finding review | Node O5 assertion output | Yes (no findings surfaced) |

---

## 3. Sequential Question List

### Q1: Feature Scope & Target Environment Resolution
* **Goal**: Confirm which feature is being delivered and which declared environment receives it.
* **Auto-Detection Scanning Rule**:
  * Read `--env <name>` if supplied; resolve against `phase-6-operation.md` §0.
  * If no `--env` is supplied and exactly one environment is declared, auto-select it. If multiple
    exist, prompt.
* **Reframed Grill Prompt**:
  > **Delivering `<feature-name>` to `<env-id>` — purpose: `<purpose>`, entry gate: `<none | certification: full>`. Proceed?**
  > 1. Confirm target environment and continue
  > 2. Target a different environment declared in `phase-6-operation.md` §0
  > 3. Abort delivery
  > 4. Other / Free-text (Describe custom target resolution)

---

### Q2: Version & Build Action Preview
* **Goal**: Confirm the release version tag and preview whether Node O3 will build fresh or reuse a
  previously recorded digest.
* **Auto-Detection Scanning Rule**:
  * Read `--version <vX.Y.Z>` if supplied.
  * Resolve the current source state (commit/tag per `codebase-<layer>/`) and check it against prior
    entries in `agent-workspace/plans/<feature-name>/WALKTHROUGH.md`.
* **Reframed Grill Prompt**:
  > **Version `<vX.Y.Z>` — source state `<matches | does not match>` a prior successful build. This run will `[Reuse the recorded digest and re-tag | Build fresh]`. Proceed?**
  > 1. Confirm version and computed build action
  > 2. Specify a different `--version` tag
  > 3. Abort delivery
  > 4. Other / Free-text (Describe custom version handling)

---

### Q3: Entry Gate Failure Routing
* **Goal**: Present a failed entry gate and route the developer to the correct remedy.
* **Precondition**: Asked **only** when the entry gate fails (target requires `certification: full`
  and `QUALIFICATION_REPORT.md` shows anything other than `full`, or is absent). On a passing gate
  this question is skipped silently. **No override exists** — every option below is a remedy, not a
  bypass.
* **Auto-Detection Scanning Rule**:
  * Read the current certification state from `QUALIFICATION_REPORT.md`, if present.
* **Reframed Grill Prompt**:
  > **Entry gate FAILED. `<env-id>` requires `certification: full`; current state is `<provisional | absent>`.**
  >
  > **How should this be resolved?**
  > 1. Halt and return to `/qualify` to obtain a full certification
  > 2. Target a different environment whose entry gate is `none`
  > 3. Review whether `<env-id>`'s entry gate should change (routes to `/plan` Phase 6 — this run does not proceed)
  > 4. Other / Free-text (Describe custom resolution)

---

### Q4: Provenance Gate Mismatch Routing
* **Goal**: Present a digest mismatch and route the developer to the correct remedy.
* **Precondition**: Asked **only** when the entry gate passed but the digest being promoted does not
  match the digest recorded in `QUALIFICATION_REPORT.md`. **No override exists.**
* **Auto-Detection Scanning Rule**:
  * Compare the digest computed at the current source state against the certified digest.
* **Reframed Grill Prompt**:
  > **Provenance gate FAILED. The digest for the current source state does not match the certified digest in `QUALIFICATION_REPORT.md`.**
  >
  > **This means the source changed since certification. How should this be resolved?**
  > 1. Halt and return to `/qualify` to certify the current source state
  > 2. Deliver the previously **certified** digest instead of the current source state (no rebuild)
  > 3. Target a different environment whose entry gate is `none`
  > 4. Other / Free-text (Describe custom resolution)

---

### Q5: Delivery Confirmation & Execution Mode
* **Goal**: Re-cap the resolved delivery configuration and obtain final developer consent before
  Node O3 (build) and Node O4 (promotion) execute.
* **Auto-Detection Scanning Rule**:
  * Check CLI flags (`--auto`, `--dry-run`).
* **Reframed Grill Prompt**:
  > **Review delivery configuration:**
  > * Feature: `<feature-name>`
  > * Target Environment: `<env-id>` (entry gate: `<none | certification: full>` — `PASSED`)
  > * Version: `<vX.Y.Z>`
  > * Build Action: `<Build | Reuse>`
  > * Post-Delivery Hook: `<declared hook | none declared>`
  > * Execution Mode: `[Interactive | --auto | --dry-run]`
  >
  > **Would you like to proceed with delivery now?**
  > 1. Confirm and execute delivery
  > 2. Revise target environment, version, or execution mode
  > 3. Abort delivery
  > 4. Other / Free-text (Describe custom execution startup)

---

### Q6: Ops Finding Review
* **Goal**: Review anything Node O5's observability and health assertions surfaced that the design
  or construction did not anticipate.
* **Precondition**: Asked only when Node O5 produced at least one candidate ops finding. Findings
  never block a passing delivery — they are proposals, per §2.D.
* **Auto-Detection Scanning Rule**:
  * List each candidate finding with the assertion class it surfaced from (signal presence, health
    & readiness, or alert registration) and whether it is also a blocking assertion failure.
* **Reframed Grill Prompt**:
  > **`<n>` ops findings surfaced during delivery. These are recorded as `origin: operate, status: unratified` and are input to the next `/plan` Phase 6 cycle — never acted on directly.**
  > `Health check timeout too aggressive under real load — 3a Signal Presence`
  >
  > **How should they be recorded?**
  > 1. Record all as proposals in `WALKTHROUGH.md`
  > 2. Record all, and flag one or more as high-priority for the next `/plan` cycle
  > 3. Discard a finding as a false positive (explain why)
  > 4. Other / Free-text (Describe custom handling)

---

## 4. Post-Grill Handoff

On completion the grill writes its audit log to
`agent-workspace/plans/<feature-name>/GRILL_STATUS.md` with header `mode: operate`, and the action
proceeds to Node O2 (Entry Gate & Provenance Gate). Both gate results are recorded in
`WALKTHROUGH.md` regardless of outcome — a halted delivery still produces a record of what was
attempted and why it stopped.
