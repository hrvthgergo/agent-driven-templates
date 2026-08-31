# Grill Schema: Release Qualification Questions (/qualify)

This document defines the interactive Q&A schema executed by the [Grill Engine](../grill_engine.md)
at the start of the `/qualify` action. It is deliberately **minimal**: `/qualify` is an execution and
judgment action, and most of what it needs was decided upstream by `/plan` (criteria) and
`/implement` (harness). The grill confirms *how to run*, never *what counts as correct*.

---

## 1. Unchangeable Baselines (No Questions Asked)

These are never negotiated with the developer. They are asserted, and violations halt the action.

### Baseline 1: Coverage Gate Precedence
* **Specification**: The Node Q1 coverage gate executes **before** environment boot and before any test runs. It is never deferred, reordered, or skipped. The only override is `--force-gate`, which produces a `provisional` certification that cannot unlock `/release`.

### Baseline 2: No Authoring Authority
* **Specification**: `/qualify` writes no harness code, assigns no scenario identifiers, amends no `TEST_STRATEGY.md`, and alters no `status` field. Its single bounded exception is authoring a coverage-gap proposal with `origin: qualify, status: unratified`, per [verification_taxonomy.md](../verification_taxonomy.md) §6.3.

### Baseline 3: Certification Criteria Are Inherited
* **Specification**: What counts as "certified" is declared in `agent-workspace/tests/TEST_STRATEGY.md` and cannot be renegotiated at execution time. `/qualify` applies the definition; it does not set it.

### Baseline 4: Defect and Coverage Gap Are Distinct
* **Specification**: A **defect** may block a release with no ratification required. A **coverage gap** is a proposal only and may never be certified against. The two are reported in separate blocks of `QUALIFICATION_REPORT.md`.

---

## 2. Questions & Scanning Blueprint

| # | Question | Auto-Detection Source | Skippable |
| :--- | :--- | :--- | :--- |
| Q1 | Verification scope confirmation | `phase-5-test.md`, `tests/scenarios/` | No |
| Q2 | Coverage gate result acknowledgement | Node Q1 output | No (only when gate fails) |
| Q3 | Test environment target | `codebase-devops/docker/`, `--env` flag | Yes (`--env` supplied) |
| Q4 | Tier selection | Command flags, `TEST_STRATEGY.md` | Yes (`--all` default) |
| Q5 | Defect routing confirmation | Node Q4 attribution output | Yes (no failures) |
| Q6 | Coverage gap proposal review | Node Q4 discovery output | Yes (no gaps found) |

---

## 3. Sequential Question List

### Q1: Verification Scope Confirmation
* **Goal**: Confirm which feature scope is being qualified and surface the ratified scenario count.
* **Auto-Detection Scanning Rule**:
  * Read `agent-workspace/plans/<feature-name>/phase-5-test.md`; extract the scenario ID list.
  * Resolve each ID against `agent-workspace/tests/scenarios/`; count `ratified`, `unratified`, `retired`.
* **Reframed Grill Prompt**:
  > **Qualifying `<feature-name>`: `<n>` ratified scenarios in scope (`<m>` unratified proposals excluded). Proceed?**
  > 1. Confirm scope and run the coverage gate
  > 2. Target a different feature scope
  > 3. Abort qualification
  > 4. Other / Free-text (Describe custom scope)

---

### Q2: Coverage Gate Failure Handling
* **Goal**: Present a failed Node Q1 gate and route the developer to the correct remedy.
* **Precondition**: Asked **only** when `missing` is non-empty. On a passing gate this question is skipped silently.
* **Auto-Detection Scanning Rule**:
  * List every ratified in-scope ID with no `@scenario` citation, with its scenario title.
* **Reframed Grill Prompt**:
  > **Coverage gate FAILED. `<k>` ratified scenarios have no harness:**
  > `SC-<feature>-005 — <title>`
  >
  > **This is a construction gap, not a test failure. How should it be resolved?**
  > 1. **(Recommended)** Halt and return to `/implement --tests-only` to build the missing harness
  > 2. Review whether the missing scenarios should be retired or de-scoped in `/plan`
  > 3. Override with `--force-gate` (requires justification; yields a **provisional** certification that cannot unlock `/release`)
  > 4. Other / Free-text (Describe custom resolution)

---

### Q3: Test Environment Target
* **Goal**: Determine where the suites execute.
* **Auto-Detection Scanning Rule**:
  * Check for `codebase-devops/docker/docker-compose.yml`; detect any already-running services.
  * Skip entirely if `--env <url>` was supplied.
* **Reframed Grill Prompt**:
  > **Which environment should the qualification matrix run against?**
  > 1. Boot an isolated container network via `codebase-devops/docker/docker-compose.yml`
  > 2. Run against an already-running local environment
  > 3. Run against an external staging URL (`--env <url>`)
  > 4. Other / Free-text (Describe custom environment)

---

### Q4: Tier Selection
* **Goal**: Confirm which testing tiers execute in this run.
* **Auto-Detection Scanning Rule**:
  * Read the declared tiers from `agent-workspace/tests/TEST_STRATEGY.md` §1. A tier not declared there may not be selected.
  * Default to the full matrix when no tier flag is supplied.
* **Reframed Grill Prompt**:
  > **Which tiers should run?**
  > 1. **(Recommended)** Full matrix — Unit → Integration → E2E → Regression
  > 2. Single tier only (`--unit`, `--integration`, `--e2e`, or `--regression`)
  > 3. Report-only from existing results (`--report-only`)
  > 4. Other / Free-text (Describe custom tier combination)

---

### Q5: Defect Routing Confirmation
* **Goal**: Confirm layer attribution for each failure and the correction loop it triggers.
* **Precondition**: Asked only when failures were detected at Node Q4.
* **Auto-Detection Scanning Rule**:
  * For each failure, identify the responsible layer (`layout`, `engine`, `data`, `devops`, or `test_spec`) and the severity level per `TEST_STRATEGY.md` §5.
* **Reframed Grill Prompt**:
  > **`<n>` failures attributed. Confirm routing:**
  > `SC-<feature>-004 → engine layer → /implement`
  >
  > 1. Confirm attribution and route correction loops
  > 2. Re-attribute one or more defects manually
  > 3. Route to `/plan` instead (architectural or requirement gap, not a code defect)
  > 4. Other / Free-text (Describe custom routing)

---

### Q6: Coverage Gap Proposal Review
* **Goal**: Review behaviour discovered during execution for which no criterion existed.
* **Precondition**: Asked only when `/qualify` identified untested behaviour.
* **Auto-Detection Scanning Rule**:
  * List each proposed scenario with the tier that surfaced it and whether it also constitutes a defect.
* **Reframed Grill Prompt**:
  > **`<n>` coverage gaps discovered. These are recorded as `status: unratified` and are NOT certified against.**
  > `SC-<feature>-007 — <behaviour>` *(also a defect: blocks release)*
  >
  > **How should they be handled?**
  > 1. **(Recommended)** File as proposals for the next `/plan --ratify` cycle; block release only on those that are also defects
  > 2. Fast-track — halt now and return to `/plan --ratify` immediately, then `/implement --tests-only`
  > 3. Record as proposals and raise none as blockers
  > 4. Other / Free-text (Describe custom handling)

---

## 4. Post-Grill Handoff

On completion the grill writes its audit log to
`agent-workspace/plans/<feature-name>/GRILL_STATUS.md` with header `mode: qualify`, and the action
proceeds to Node Q2 (Environment & Test Target Gate). The coverage gate result from Node Q1 is
recorded in `QUALIFICATION_REPORT.md` Section 0 regardless of outcome.
