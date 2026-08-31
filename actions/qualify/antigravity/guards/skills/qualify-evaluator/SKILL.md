---
name: qualify-evaluator
description: Antigravity skill for coverage gate calculation, multi-tier test matrix execution, layer defect attribution, coverage gap proposal authoring, audit reporting, and regression catalog promotion
---

# `qualify-evaluator` Skill Procedure

This skill provides step-by-step procedures for evaluating the Node Q1 Coverage Gate, executing multi-tier test suites across layer repositories, diagnosing stack traces for layer defect attribution, authoring coverage gap proposals, generating qualification audit reports, and promoting ratified scenarios to the master regression catalog.

---

## 1. Node Q1 Coverage Gate Evaluation Procedure

1. Read `agent-workspace/plans/<feature-name>/phase-5-test.md` and parse the in-scope scenario ID list (`SC-<feature-slug>-<nnn>`).
2. Read each scenario file in `agent-workspace/tests/scenarios/<id>.md`:
   * Filter for scenarios where frontmatter `status == "ratified"`.
   * Exclude scenarios with `status == "unratified"` or `status == "retired"`.
3. Scan all source and test files in `codebase-qualify/src/` and `codebase-*/tests/` using regex pattern:
   ```regex
   @scenario\s+(SC-[a-zA-Z0-9_-]+)
   ```
4. Compute coverage sets:
   ```
   scope_ratified := { id in scope : tests/scenarios/<id>.md has status == "ratified" }
   implemented    := { id : citation found in codebase-qualify/src/ or codebase-*/tests/ }
   missing        := scope_ratified \ implemented
   ```
5. If `missing` is non-empty and `--force-gate` was not provided:
   * Format halt diagnostic listing all missing IDs and scenario titles.
   * Halt execution and return scope to `/implement --tests-only`.

---

## 2. Environment Provisioning & Connection Procedure

1. **Docker Compose Mode** (Default):
   * Inspect `codebase-devops/docker/docker-compose.yml`.
   * Invoke `docker compose up -d` to provision isolated database, backend, frontend, and runner networks.
   * Assert container health checks before launching test suites.
2. **Targeted Host Mode** (`--env <url>`):
   * Bypass `codebase-devops` container provisioning.
   * Direct test runners in `codebase-qualify/` to target host URL via `--env-url=<url>`.
3. **Local Active Mode**:
   * Verify localhost service ports and execute suites directly against active local instances.

---

## 3. Multi-Tier Hierarchical Test Suite Execution Procedure

Execute test suites in strict order, capturing stdout/stderr and exit codes:

1. **Tier 1: Layer Unit Tests** (`codebase-*/tests/`):
   * Execute unit test runners in each layer sub-repository (e.g. `pytest`, `cargo test`, `npm test`, `go test`).
   * Mandatory requirement: 100% pass rate.
2. **Tier 2: Cross-Layer Integration Tests** (`codebase-qualify/src/integration/`):
   * Execute contract verifiers, API pipeline tests, and database integration scripts.
3. **Tier 3: End-to-End User Journeys** (`codebase-qualify/src/e2e/`):
   * Execute headless browser automation scripts (Playwright / Cypress) validating full user flows across layers.
4. **Tier 4: Master Regression Catalog** (`agent-workspace/tests/regression/`):
   * Execute permanent regression assertions across the entire system.

---

## 4. Multi-Layer Defect Attribution Engine

When an assertion or test execution fails in Node Q3:

1. Parse error output, stack traces, HTTP status codes, and failure logs.
2. Match failure signatures against layer attribution heuristics:
   * **Layout Layer**: `ElementNotFoundException`, CSS selector mismatch, snapshot difference, React/Vue lifecycle crash, DOM visibility failure $\rightarrow$ Attribute to `codebase-layout` / `codebase-ui`.
   * **Engine Layer**: HTTP 500, unhandled service exception, DTO serialization error, business logic assertion failure $\rightarrow$ Attribute to `codebase-engine` / `codebase-backend`.
   * **Data Layer**: SQL syntax error, migration constraint violation, foreign key failure, connection pool exhaustion $\rightarrow$ Attribute to `codebase-data`.
   * **DevOps Layer**: Connection refused, container port conflict, timeout, missing env var $\rightarrow$ Attribute to `codebase-devops`.
   * **Test Specification**: Assertion expectation out-of-sync with ratified specification $\rightarrow$ Attribute to `test_spec`.
3. Format diagnostic summary with file, line number, stack trace snippet, and remediation recommendation.

---

## 5. Coverage Gap Proposal Authoring Procedure

When real-world testing surfaces untested behaviors or edge cases:

1. Draft a new scenario specification adhering to `agent-workspace/tests/templates/scenario.md`.
2. Assign next available scenario ID: `SC-<feature-slug>-<nnn>`.
3. Stamp metadata frontmatter strictly as:
   ```yaml
   id: SC-<feature-slug>-<nnn>
   title: <Descriptive Behavior Title>
   origin: qualify
   status: unratified
   ```
4. Save file to `agent-workspace/tests/scenarios/SC-<feature-slug>-<nnn>.md`.
5. Record proposal entry in `QUALIFICATION_REPORT.md` Section 3. Do NOT certify against unratified proposals.

---

## 6. Audit Report & Machine Log Generation Procedure

1. Populate `agent-workspace/plans/<feature-name>/QUALIFICATION_REPORT.md`:
   * Write Section 0: Coverage Gate Result (Ratified count, Implemented count, Missing count).
   * Write Section 1: Tier-by-tier execution table (Total, Passed, Failed, Skipped, Pass Rate).
   * Write Section 2: Identified defects with layer attribution.
   * Write Section 3: Discovered coverage gap proposals (`status: unratified`).
   * Write Section 4: Unproven scope and override justification (if `--force-gate` was used).
   * Write Section 5: Release certification recommendation (`full` vs. `provisional`).
2. Write `agent-workspace/plans/<feature-name>/qualification_log.json`:
   * Record JSON object with ISO 8601 timestamp, total duration, tier breakdowns, exit codes, and coverage gate result.

---

## 7. Regression Catalog Promotion Procedure

1. If overall status is `PASSED` and certification is `full`:
   * Ensure directory `agent-workspace/tests/regression/` exists.
   * For each scenario ID in `phase-5-test.md` with `status == "ratified"`:
     - Copy `agent-workspace/tests/scenarios/<id>.md` into `agent-workspace/tests/regression/<id>.md`.
2. Unratified proposals (`status: unratified`) MUST NOT be copied or promoted to regression.
