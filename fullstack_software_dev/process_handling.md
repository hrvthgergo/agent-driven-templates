# Guard Process Handling Specification

This document defines the requirements, structure, and release-governance rules for the **Guard Process Handling Document** (`PROCESS_STATUS.md`). This component serves as the central operational log and lifecycle state machine for all agent-driven development workflows.

---

## 1. Overview & Core Philosophy

When a project adopts the Guards framework, its entire development process is governed by state-tracked workflows. The **Guard Process Handling Document** ensures that AI agents and human developers maintain complete visibility, accountability, and traceability across all stages of development.

### Core Principles
- **Release & Feature Governance**: Every document is strictly tied to a specific release version (e.g. `v1.0.0`) or parallel feature branch (e.g. `feature/user-auth`). A new release or feature initiative **must** be managed by a fresh process handling document.
- **Two-Block Architecture**:
  1. **Block 1: Concise Workflow Status Matrix** (Lists main workflows and statuses).
  2. **Block 2: Datestamped Daily Execution History** (Records daily process initiations and milestones).
- **Git Branch Integration**: The `/init` workflow can initialize new releases (`/init --release <version>`) or feature branches (`/init --feature <name>`) directly from existing source baselines, creating the corresponding Git branch and provisioning its isolated process status document.

---

## 2. Document Template (`PROCESS_STATUS.md`)

```markdown
# Guard Process Status: [Release / Feature Name]

- **Target Release / Feature**: `[e.g., release/v1.0.0 or feature/ui-dashboard]`
- **Git Branch**: `[e.g., release/v1.0.0]`
- **Initialization Date**: `YYYY-MM-DD`
- **Active Workflow**: `[init | process-history | plan | implement | verify | release | idle]`

---

## Block 1: Workflow Execution Matrix

This matrix tracks the top-level workflows and optional sub-processes. Sub-processes must remain concise and focused; no bloated or diffused states are allowed.

| Workflow | Status | Sub-Processes / Key Focus | Last Updated |
| :--- | :--- | :--- | :--- |
| **1. /init** | `[x] Done` | Environment checks, layer symlinks, Git branch creation | YYYY-MM-DD |
| **2. /process-history** | `[-] Not In Scope` | Legacy code & docs analysis (Brownfield only) | YYYY-MM-DD |
| **3. /plan** | `[>] In Progress` | 5-Phase Blueprinting (Phases 1-5) | YYYY-MM-DD |
| **4. /implement** | `[ ] Not Started` | Code scaffolding & layout implementation | YYYY-MM-DD |
| **5. /verify** | `[ ] Not Started` | Automated test suite execution & E2E checks | YYYY-MM-DD |
| **6. /release** | `[ ] Not Started` | Docker builds, PR creation & deployment | YYYY-MM-DD |

### Status Key:
- `[ ] Not Started`: Workflow has not been initiated.
- `[>] In Progress`: Workflow is currently active.
- `[x] Done`: Workflow has been successfully completed and verified.
- `[-] Not In Scope`: Workflow is omitted for this feature/release scope.

---

## Block 2: Datestamped Daily Execution History

This section logs daily process initiations, completed milestones, and key decisions.

### [YYYY-MM-DD]
- **[HH:MM] Workflow Initiated**: `/init --release v1.0.0`
  - Created Git branch `release/v1.0.0`.
  - Discovered 2 layer skeletons (`codebase-layout`, `codebase-engine`).
  - Scaffolded `.agents/` control directory and `PROCESS_STATUS.md`.
- **[HH:MM] Workflow Initiated**: `/plan --phase 1`
  - Started requirements gathering and initial architecture summary drafting.

### [YYYY-MM-DD]
- **[HH:MM] Workflow Initiated**: `/implement`
  - Applied layout DTO mappings and engine API routes.
```

---

## 3. Release Governance & Branching Rules

1. **Release Isolation**: Every release milestone (e.g. `v1.0.0`, `v1.1.0`) or parallel feature branch (`feature/<name>`) MUST have its own independent `PROCESS_STATUS.md` state tracking document.
2. **`/init` Branch Initialization**:
   - `/init --release <version>`: Creates a Git branch `release/<version>` from `main`/`master`, scaffolds `.agents/plans/PROCESS_STATUS_release_<version>.md` (or `PROCESS_STATUS.md`), and registers the initial status matrix.
   - `/init --feature <feature-name>`: Creates a Git branch `feature/<feature-name>`, scaffolds `.agents/plans/PROCESS_STATUS_feature_<name>.md`, and initializes the workflow matrix with `process-history` marked as `[-] Not In Scope` by default for greenfield features.
3. **Immutability of Closed Logs**: Past daily log entries in Block 2 must never be modified or overwritten; new events are strictly appended under the current date header.
