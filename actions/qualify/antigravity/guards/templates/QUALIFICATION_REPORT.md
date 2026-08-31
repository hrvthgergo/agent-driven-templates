# Qualification Audit Report: [Feature Name] - [Version]

- **Date**: YYYY-MM-DD
- **Target Map**: `implementation_map_v<version>.md`
- **Verification Scope**: `phase-5-test.md`
- **Coverage Gate (Node Q1)**: [PASSED | FAILED | OVERRIDDEN]
- **Certification**: [full | provisional]
- **Overall Status**: [PASSED | CONDITIONALLY_PASSED | FAILED]

---

## 0. Coverage Gate Result

| Ratified in Scope | Proven by Harness | Missing | Gate Status |
| :--- | :--- | :--- | :--- |
| {{ratified_count}} | {{implemented_count}} | {{missing_count}} | {{gate_status}} |

*{{gate_summary_statement}}*

---

## 1. Test Suite Execution Summary

| Test Tier | Total | Passed | Failed | Skipped | Pass Rate |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Layer Unit Tests (`codebase-*/`) | {{unit_total}} | {{unit_passed}} | {{unit_failed}} | {{unit_skipped}} | {{unit_pass_rate}}% |
| Integration Tests (`codebase-qualify/`) | {{integration_total}} | {{integration_passed}} | {{integration_failed}} | {{integration_skipped}} | {{integration_pass_rate}}% |
| E2E User Journeys (`codebase-qualify/`) | {{e2e_total}} | {{e2e_passed}} | {{e2e_failed}} | {{e2e_skipped}} | {{e2e_pass_rate}}% |
| Regression Protection (`tests/`) | {{regression_total}} | {{regression_passed}} | {{regression_failed}} | {{regression_skipped}} | {{regression_pass_rate}}% |
| **Total** | **{{grand_total}}** | **{{grand_passed}}** | **{{grand_failed}}** | **{{grand_skipped}}** | **{{grand_pass_rate}}%** |

---

## 2. Identified Defects & Layer Attribution

*(List all failures discovered during execution, attributed to responsible layer)*

### Defect 1: [Short Title]
- **Affected Scenario**: `SC-<feature-slug>-<nnn>`
- **Responsible Layer**: `[layout | engine | data | devops | test_spec]`
- **Failure Summary**: `<Brief description of unexpected behavior>`
- **Diagnostic Snippet**:
  ```text
  <Stack trace or HTTP response snippet>
  ```
- **Remediation Route**: `[Route to /implement for code fix | Route to /plan for design review]`

---

## 3. Coverage Gap Proposals

*Scenarios discovered during execution for which no criterion previously existed.*
*Authored with `origin: qualify, status: unratified`. NOT certified against.*
*Inputs to the next `/plan --ratify` cycle.*

| Proposed ID | Behavior Description | Discovered In Tier | Blocker? |
| :--- | :--- | :--- | :--- |
| `SC-<feature>-<nnn>` | `<Description of discovered unverified behavior>` | `<Tier>` | `[Yes — Filed as Defect | No — Proposal Only]` |

---

## 4. Unproven Scope

*Populated only when the Node Q1 coverage gate was overridden via `--force-gate`.*
*(Empty on a full certification.)*

- **Override Justification**: `{{override_justification_or_none}}`
- **Unproven Ratified IDs**: `{{unproven_scenario_ids_or_none}}`

---

## 5. Release Certification

- [ ] Coverage gate passed (every ratified in-scope scenario proven)
- [ ] Unit test baseline satisfied (100% pass rate)
- [ ] Cross-layer contract verification satisfied
- [ ] Zero regressions detected in core capabilities
- [ ] Certification is `full` (not `provisional`)

**Recommendation**: `[Proceed to /release | Halt: Fix Layer Defects via /implement | Review in /plan]`
