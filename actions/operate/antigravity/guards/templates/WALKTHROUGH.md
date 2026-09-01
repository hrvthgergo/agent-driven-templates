# Delivery Walkthrough: [Feature Name] - [Version]

- **Date**: YYYY-MM-DD
- **Target Environment**: `ENV-<id>`
- **Version**: `vX.Y.Z`
- **Source State**: `<commit/tag per codebase-<layer>, the O3 lookup key>`
- **Image Digest**: `sha256:...`
- **Build Action**: `[Built | Reused — matched <date> entry]`
- **Entry Gate**: `[none | certification: full]` — `[PASSED | FAILED | N/A]`
- **Provenance Gate**: `[PASSED | FAILED | N/A — entry gate is none]`

## 1. Gate Results

| Gate | Requirement | Result |
| :--- | :--- | :--- |
| Entry Gate | `<gate from phase-6-operation.md §0>` | `<result>` |
| Provenance Gate | Digest matches `QUALIFICATION_REPORT.md` | `<result>` |

## 2. Certification Reference
- **Source Report**: `QUALIFICATION_REPORT.md` (`<date>`)
- **Certification**: `[full | provisional | N/A]`

## 3. Observability & Health Assertion Results

### 3a. Signal Presence
| Signal | Type | Endpoint | Result |
| :--- | :--- | :--- | :--- |

### 3b. Health & Readiness
| Check | Expected | Soak | Result |
| :--- | :--- | :--- | :--- |

### 3c. Alert Registration
| Alert Rule | Routing Target | Registered |
| :--- | :--- | :--- |

## 4. Delivery Actions
- **PR / Merge Reference**: `<link or N/A>`
- **Post-Delivery Hook**: `[<hook from phase-6-operation.md §5> executed | none declared]`

## 5. Ops Findings
*Recorded per §2.D. `origin: operate`, `status: unratified`. Input to the next `/plan` Phase 6 cycle.*

| Finding | Discovered In | Blocker? |
| :--- | :--- | :--- |
| *(none)* | | |
