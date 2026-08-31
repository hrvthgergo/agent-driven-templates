# Project Test Strategy & Verification Policy

<!-- Author: /plan | Project-Durable Specification -->

This document establishes the project-wide testing tiers, layer tooling, execution thresholds, mocking policies, defect severity definitions, and criteria for "Certified" release qualification.

---

## 1. Testing Tiers & Harness Architecture

| Tier | Target Scope | Authoring Authority | Execution Action | Pass Requirement |
| :--- | :--- | :--- | :--- | :--- |
| **Unit Tier** | Isolated function/module logic across `codebase-<layer>/` | `/implement` | `/qualify --unit` | 100% Pass Rate |
| **Integration Tier** | Cross-module API contracts & DB flows in `codebase-qualify/` | `/implement` | `/qualify --integration` | 100% Pass Rate |
| **E2E Tier** | End-to-end user journeys & browser automation in `codebase-qualify/` | `/implement` | `/qualify --e2e` | 100% Pass Rate |
| **Regression Tier** | Master regression catalog in `agent-workspace/tests/` | `/implement` | `/qualify --regression` | Zero Regression Breaks |

---

## 2. Layer Tooling & Framework Standards

* **Layout / Frontend Layer**: Vitest, React Testing Library, Playwright.
* **Engine / Backend Layer**: Pytest, Pytest-Asyncio, HTTPX / Go testing package.
* **Data Layer**: Testcontainers for SQL/NoSQL ephemeral databases, Alembic test migrations.
* **DevOps / Container Layer**: Docker Compose test profiles, Hadolint, Trivy.

---

## 3. Execution Thresholds & Quality Gates

* **Code Coverage Threshold**: Minimum 80% line coverage required across business logic.
* **Flakiness Policy**: Zero tolerance for flaky tests; flaky assertions must be quarantined or fixed immediately.
* **Performance Budget**: Unit test suites must complete within 30 seconds; Integration suites within 120 seconds.

---

## 4. Mocking & Isolation Policy

* **External Third-Party Services (Stripe, Twilio, OAuth Providers)**: MUST be mocked or stubbed using contract test fixtures.
* **Internal Inter-Layer Communication**: Real interfaces preferred in integration tests; contract mocks allowed only for bounded contexts.
* **Database State**: Ephemeral in-memory or containerized DB per test run; test state isolation is strictly required.

---

## 5. Defect Severity & Certified Qualification Criteria

* **Severity 1 (Blocker)**: Critical path failure, security vulnerability, data loss $\rightarrow$ Release Blocked.
* **Severity 2 (Major)**: Non-critical feature failure with no workaround $\rightarrow$ Release Blocked.
* **Severity 3 (Minor)**: UI cosmetic issue or edge case with straightforward workaround $\rightarrow$ Certified with Caveats.
* **Definition of Certified**: 100% scenario pass rate for all ratified scenarios in scope, zero Sev 1/2 defects, and all regression suites green.
