---
name: qualify-governor
description: Core Governor Rule Guard for release qualification workflow, Coverage Gate precedence, execution & judgment scope boundaries, layer defect attribution, and release certification gating
---

# `qualify-governor` Rule Guard

This rule guard enforces core execution safety, scope boundaries, mandatory Node Q1 Coverage Gate precedence, defect versus coverage gap distinctions, layer defect attribution, and release certification constraints during the `/qualify` action.

---

## 1. Mandatory Node Q1 Coverage Gate Precedence
The AI agent MUST execute the **Node Q1 Coverage Gate** BEFORE booting any environment (e.g. Docker compose networks) and BEFORE running any test suites:
1. **Scope Extraction**: Read `agent-workspace/plans/<feature-name>/phase-5-test.md` and extract all listed scenario IDs.
2. **Ratification Filter**: Resolve each ID against `agent-workspace/tests/scenarios/<id>.md`. Filter for scenarios carrying `status: ratified`. Scenarios marked `status: unratified` or `status: retired` are excluded from the gate.
3. **Harness Citation Check**: Scan `codebase-qualify/src/` and `codebase-*/tests/` for the canonical `@scenario <id>` citation token within test declaration blocks (docstrings, decorators, annotations, comments).
4. **Gate Math**: Compute `missing := ratified \ implemented`.
5. **Fail-Closed Enforcement**:
   - If `missing` is non-empty, the agent MUST immediately **halt execution**, report every missing scenario ID with its title, and **return to `/implement --tests-only`**.
   - The agent MUST NOT boot containers, execute tests, or render a certification verdict on a failed gate.

### Bounded Gate Override (`--force-gate`)
* The only permitted override is `/qualify --force-gate "<justification>"`.
* The justification MUST be recorded verbatim in `QUALIFICATION_REPORT.md` Section 4.
* The run MUST be stamped `certification: provisional`.
* **A provisional certification is strictly prohibited from unlocking the `/operate` action.**

---

## 2. Strict Execution & Judgment Boundary (No Authoring Authority)
`/qualify` **executes and judges**. It authors no test assets:
1. **No Harness Authoring**: The agent MUST NOT write, patch, or scaffold test automation code inside `codebase-qualify/` or `codebase-*/tests/`. Harness construction belongs strictly to `/implement`.
2. **No Scenario Authority**: The agent MUST NOT assign scenario identifiers (`SC-*`), amend `TEST_STRATEGY.md`, or alter the `status` field of any scenario.
3. **Single Bounded Exception (Coverage Gap Proposals)**: When real-world execution uncovers untested behaviour, `/qualify` MAY author a new scenario file under `agent-workspace/tests/scenarios/` stamped strictly with:
   ```yaml
   origin: qualify
   status: unratified
   ```
   The agent MUST NOT certify against unratified proposals. They are surfaced in Section 3 of `QUALIFICATION_REPORT.md` as inputs to the next `/plan --ratify` cycle.

---

## 3. Defect Versus Coverage Gap Distinction
The agent MUST classify all findings into one of two distinct categories and handle them according to strict governance rules:

| Finding | Classification | Governance & Gating Authority |
| :--- | :--- | :--- |
| **Defect** | Observed behaviour contradicts a ratified scenario or is self-evidently broken. | **Full Blocker.** Report defect, perform layer attribution, and **block the release gate** (no ratification required). |
| **Coverage Gap** | System behaviour is untested because no criterion was previously authored in `/plan`. | **Proposal Only.** Author proposal stamped `origin: qualify, status: unratified`. List in Report Section 3. **May not block release or be certified against.** |

---

## 4. Multi-Layer Defect Attribution Mandate
When a test failure occurs during Node Q3 execution, the agent MUST parse stack traces, HTTP responses, console logs, and failure screenshots to perform **Layer Attribution**:
* **Layout Layer Defect**: UI rendering glitches, CSS regressions, component state errors, missing DOM elements.
* **Engine Layer Defect**: API contract violations, logic bugs, unhandled exceptions, incorrect HTTP status codes.
* **Data Layer Defect**: Database migration failures, schema mismatches, relational constraint violations.
* **DevOps Layer Defect**: Container port mapping errors, environment variable misconfigurations, network timeouts.
* **Test Specification Defect**: Stale mocks or invalid assertion expectations discovered during execution.

Attributed defects MUST be documented in Section 2 of `QUALIFICATION_REPORT.md` with diagnostic context to route actionable remediation to `/implement` or `/plan`.

---

## 5. Multi-Tier Hierarchical Execution Order
When executing test matrices in Node Q3, tests MUST execute in strict hierarchical sequence:
1. **Tier 1: Layer Unit Tests** (`codebase-*/tests/`) — Micro-pipeline baseline.
2. **Tier 2: Cross-Layer Integration Tests** (`codebase-qualify/src/integration/`) — Contract & API pipelines.
3. **Tier 3: End-to-End User Journeys** (`codebase-qualify/src/e2e/`) — Headless browser user flows.
4. **Tier 4: Master Regression Catalog** (`agent-workspace/tests/regression/`) — System-wide integrity suite.

---

## 6. Regression Catalog Promotion & Release Gating
1. **Promotion Rule**: Upon achieving a 100% pass rate across all tiers with full certification, the agent MUST promote only **ratified** feature scenarios into `agent-workspace/tests/regression/`. Unratified proposals are NEVER promoted.
2. **Release Gating**: If all release criteria are met and certification is `full`, the agent updates `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md` marking the `/qualify` row as `[x] Done` and unlocks `/operate`. If defects exist or certification is `provisional`, the `/qualify` row remains blocked.
