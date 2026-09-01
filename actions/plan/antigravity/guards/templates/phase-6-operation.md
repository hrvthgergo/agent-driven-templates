# Phase 6: Operations & Environment Design

<!-- Universal Content Contract: plan_action.md §3 -->

This document establishes the operational specifications, environment topology, containerization profiles, configuration/secret declarations, CI/CD promotion policies, and observability contracts for this feature.

---

## 0. Environment Topology

<!-- First-Definer Rule: First feature defining an environment owns the canonical definition -->

| Environment ID | Purpose | Services | Config Source | Entry Gate | Promoted From |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `ENV-local` | Local Developer Sandbox | All Layer Services | `.env.local` | `none` | N/A |
| `ENV-staging` | Integration & Qualification Gate | All Layer Services | Vault / Secret Manager | `certification: full` | `ENV-local` |
| `ENV-prod` | Production User Serving | High-Availability Cluster | Vault / Secret Manager | `certification: full` | `ENV-staging` |

---

## 1. Containerization & Image Specifications

* **Base Images**: [e.g. `python:3.12-slim`, `node:20-alpine`]
* **Multi-Stage Build Targets**: [e.g. `builder`, `test`, `runtime`]
* **Runtime Profile & Resource Limits**: [CPU/Memory limits, non-root user execution]
* **Image Naming Scheme**: `[registry]/[project]/[layer]:v[version]`

---

## 2. Service Orchestration & Compose

* **Services**: [List of services, dependencies, and startup order]
* **Networks & Ports**: [Internal bridge networks, exposed host ports]
* **Volumes & Persistence**: [Named volumes for ephemeral or persistent local data]

---

## 3. Configuration & Secret Declarations

<!-- Names and scope only — NEVER record a secret value -->

| Key / Secret Name | Type | Target Layer Scope | Target Environments | Source / Provider |
| :--- | :--- | :--- | :--- | :--- |
| `APP_PORT` | `config` | `engine`, `layout` | `ENV-local`, `ENV-staging`, `ENV-prod` | Environment Variable |
| `DB_PASSWORD` | `secret` | `engine`, `data` | `ENV-staging`, `ENV-prod` | Vault / KMS |
| `JWT_SECRET_KEY` | `secret` | `engine` | `ENV-staging`, `ENV-prod` | Vault / KMS |

---

## 4. CI/CD Pipeline Topology

* **Tier 1: Layer Micro-Pipelines**: Runs autonomous unit tests and image linting inside `codebase-<layer>/`.
* **Tier 2: Qualification Pipeline**: Runs integration test suites, API contracts, and E2E journeys in `codebase-qualify/`.
* **Tier 3: Platform Macro-Pipeline**: Builds production release images, executes smoke verification, and promotes containers in `codebase-devops/`.

---

## 5. Delivery & Promotion Policy

* **Versioning Scheme**: Semantic Versioning (`vX.Y.Z`).
* **Image Tagging & Digest**: Images tagged with semantic version and referenced by immutable SHA256 digest.
* **Promotion Edges**: `ENV-local` $\rightarrow$ `ENV-staging` $\rightarrow$ `ENV-prod`.
* **Rebuild & Rollback Policy**: Fast-rollback to previous verified digest upon health check failure.
* **Post-Delivery Hooks**:
  - `ENV-staging`: Notify `#dev-alerts` Slack channel on deployment success.
  - `ENV-prod`: Trigger CDN cache purge and register release event in monitoring platform.

---

## 6. Observability & Health Contracts

### 6a. Signals & Instrumentation Contract
<!-- Declares WHAT must be emitted; implementation code is built by /implement -->

| Signal Name | Signal Type | Source Layer Scope | Emitted When |
| :--- | :--- | :--- | :--- |
| `http_requests_total` | `metric` | `layout`, `engine` | On every inbound HTTP request completion |
| `auth_login_latency_ms` | `metric` | `engine` | On user login attempt completion |
| `user_auth_audit_event` | `log` | `engine` | On authentication success or credential failure |

### 6b. Monitoring Tooling & Endpoints
<!-- First-Definer Rule applies -->

| Tool / Platform | Scrape / Ingest Endpoint | Target Environments | Ingestion Protocol |
| :--- | :--- | :--- | :--- |
| Prometheus | `/metrics` | `ENV-staging`, `ENV-prod` | Prometheus Pull (HTTP) |
| OpenTelemetry Collector | `/v1/traces` | `ENV-staging`, `ENV-prod` | OTLP / gRPC |

### 6c. Health, Readiness & Alert Contracts
<!-- Asserts post-deploy conditions in /operate at Node O5 -->

| Check / Contract | Endpoint / Command | Expected Response | Timeout | Soak Duration | Alert Condition & Routing Target |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Liveness Probe | `GET /healthz` | HTTP 200 `{"status": "ok"}` | 5s | 30s | Fails > 3 consecutive $\rightarrow$ PagerDuty |
| Readiness Probe | `GET /ready` | HTTP 200 `{"ready": true}` | 5s | N/A | Fails $\rightarrow$ Drop from ingress |
| Error Rate Alert | Metric threshold | Error rate $< 1\%$ | 60s | 5m | Error rate $> 1\%$ for 5m $\rightarrow$ `#oncall` |

---

## 7. Operations Decisions (Embedded ADRs)

* **Decision 1**: [Context $\rightarrow$ Options evaluated $\rightarrow$ Choice $\rightarrow$ Consequences & trade-offs].
