---
name: qualify-grill
description: Execution-configuration Grill Rule Guard for release qualification Q&A interview schema, neutral prompting laws, and GRILL_STATUS.md persistence
---

# `qualify-grill` Rule Guard

This rule guard enforces the sequential execution-configuration interview schema (Q1–Q6) during the `/qualify` action per [qualify_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/actions/qualify/qualify_questions.md).

---

## 1. Unchangeable Baselines (No Negotiation)
The agent MUST NOT formulate interview questions that negotiate or compromise the following immutable constraints:
1. **Coverage Gate Precedence**: Node Q1 gate evaluates before environment boot and before tests execute. It cannot be disabled, reordered, or deferred.
2. **No Authoring Authority**: `/qualify` does not write harness code or amend `TEST_STRATEGY.md`.
3. **Inherited Certification Criteria**: The criteria declared in `agent-workspace/tests/TEST_STRATEGY.md` govern qualification; they cannot be redefined at runtime.
4. **Defect vs. Coverage Gap Separation**: Defects block release; gaps are proposals only (`status: unratified`).

---

## 2. Prompting Rules & Neutrality Law
1. **Zero Bias Policy**: All selectable options MUST be presented neutrally. The AI agent MUST NOT prefix options with `[Recommended]`, `[Default]`, or suggestive framing unless explicitly declared in the question specification.
2. **Structured Options**: Every question MUST provide structured choices plus an explicit *Other / Free-text* escape hatch.
3. **Max Questions Per Turn**: Present at most 1–2 sequential questions per user interaction turn.
4. **Conditional Skipping**: Questions with prerequisites (Q2, Q5, Q6) MUST be skipped silently when preconditions are not met.

---

## 3. Sequential Q1–Q6 Interview Schema

### Q1: Verification Scope Confirmation
* **Scanning**: Read `phase-5-test.md` and count `ratified`, `unratified`, and `retired` scenarios in `tests/scenarios/`.
* **Prompt**:
  > Qualifying `<feature-name>`: `<n>` ratified scenarios in scope (`<m>` unratified proposals excluded). Proceed?
  > 1. Confirm scope and run the coverage gate
  > 2. Target a different feature scope
  > 3. Abort qualification
  > 4. Other / Free-text (Describe custom scope)

### Q2: Coverage Gate Failure Handling (Conditional)
* **Precondition**: Evaluated ONLY if Node Q1 coverage gate finds missing citations (`missing` is non-empty).
* **Prompt**:
  > Coverage gate FAILED. `<k>` ratified scenarios have no harness:
  > `SC-<feature>-<nnn> — <title>`
  >
  > This is a construction gap, not a test failure. How should it be resolved?
  > 1. Halt and return to `/implement --tests-only` to build the missing harness
  > 2. Review whether the missing scenarios should be retired or de-scoped in `/plan`
  > 3. Override with `--force-gate` (requires justification; yields a provisional certification that cannot unlock `/release`)
  > 4. Other / Free-text (Describe custom resolution)

### Q3: Test Environment Target
* **Scanning**: Detect `codebase-devops/docker/docker-compose.yml` or active services. Skip if `--env <url>` was supplied on CLI.
* **Prompt**:
  > Which environment should the qualification matrix run against?
  > 1. Boot an isolated container network via `codebase-devops/docker/docker-compose.yml`
  > 2. Run against an already-running local environment
  > 3. Run against an external staging URL (`--env <url>`)
  > 4. Other / Free-text (Describe custom environment)

### Q4: Tier Selection
* **Scanning**: Read declared tiers in `agent-workspace/tests/TEST_STRATEGY.md` §1. Default to full matrix when no flag supplied.
* **Prompt**:
  > Which tiers should run?
  > 1. Full matrix — Unit → Integration → E2E → Regression
  > 2. Single tier only (`--unit`, `--integration`, `--e2e`, or `--regression`)
  > 3. Report-only from existing results (`--report-only`)
  > 4. Other / Free-text (Describe custom tier combination)

### Q5: Defect Routing Confirmation (Conditional)
* **Precondition**: Evaluated ONLY when failures occur in Node Q3.
* **Prompt**:
  > `<n>` failures attributed. Confirm routing:
  > `SC-<feature>-<nnn> → <layer> layer → /implement`
  >
  > 1. Confirm attribution and route correction loops
  > 2. Re-attribute one or more defects manually
  > 3. Route to `/plan` instead (architectural or requirement gap, not a code defect)
  > 4. Other / Free-text (Describe custom routing)

### Q6: Coverage Gap Proposal Review (Conditional)
* **Precondition**: Evaluated ONLY when untested behaviors are uncovered.
* **Prompt**:
  > `<n>` coverage gaps discovered. These are recorded as `status: unratified` and are NOT certified against.
  > `SC-<feature>-<nnn> — <behaviour>`
  >
  > How should they be handled?
  > 1. File as proposals for the next `/plan --ratify` cycle; block release only on those that are also defects
  > 2. Fast-track — halt now and return to `/plan --ratify` immediately, then `/implement --tests-only`
  > 3. Record as proposals and raise none as blockers
  > 4. Other / Free-text (Describe custom handling)

---

## 4. Grill State Persistence
Upon completing the interview, all selections and user responses MUST be written to `agent-workspace/plans/<feature-name>/GRILL_STATUS.md` with top-level metadata:
```markdown
# Grill Engine Status: Release Qualification (/qualify)
- **Active Action**: `/qualify`
- **Scope**: `<feature-name>`
- **Mode**: `qualify`
- **Coverage Gate Result**: `[PASSED | FAILED | OVERRIDDEN]`
- **Timestamp**: YYYY-MM-DDTHH:MM:SSZ
```
