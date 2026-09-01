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
- **Active Workflow**: `[init | process | plan | implement | qualify | operate | idle]`

---

## Block 1: Workflow Execution Matrix

This matrix tracks top-level workflows and focused sub-processes. The 6-Phase Planning Framework is integrated directly into the `/plan` workflow matrix, eliminating the need for a separate `PLAN_STATUS.md` file.

| Workflow / Sub-Process | Status | Focus / Artifact | Last Updated |
| :--- | :--- | :--- | :--- |
| **1. /init** | `[x] Done` | Environment checks, control plane scaffolding, Git branch creation | YYYY-MM-DD |
| **2. /process** | `[-] Not In Scope` | Legacy code & docs analysis (Brownfield only) | YYYY-MM-DD |
| **3. /plan** | `[>] In Progress` | 6-Phase Blueprinting Framework | YYYY-MM-DD |
| ├── **3.1 Phase 1: Summary** | `[x] Done` | High-level summary & folder map (`phase-1-summary.md`) | YYYY-MM-DD |
| ├── **3.2 Phase 2: Layout** | `[>] In Progress` | Design system & styling laws (`phase-2-layout.md`) | YYYY-MM-DD |
| ├── **3.3 Phase 3: Data** | `[ ] Not Started` | Data capturing, storing mechanisms & lifecycle events (`phase-3-data.md`) | YYYY-MM-DD |
| ├── **3.4 Phase 4: Engine** | `[ ] Not Started` | Core engine logic, DTO mappers & API services (`phase-4-engine.md`) | YYYY-MM-DD |
| ├── **3.5 Phase 5: Test** | `[ ] Not Started` | Verification Scope & Test Delta (`phase-5-test.md`) | YYYY-MM-DD |
| └── **3.6 Phase 6: Operations** | `[ ] Not Started` | Environments, Dockerfiles, Compose, CI/CD, Promotion Policy & Observability (`phase-6-operation.md`) | YYYY-MM-DD |
| **4. /implement** | `[ ] Not Started` | Code scaffolding & layout implementation | YYYY-MM-DD |
| **5. /qualify** | `[ ] Not Started` | Full-spectrum qualification & release gating | YYYY-MM-DD |
| **6. /operate** | `[ ] Not Started` | Image build, environment promotion & deployment (`WALKTHROUGH.md`) | YYYY-MM-DD |

### Status Key:
- `[ ] Not Started`: Workflow or sub-process has not been initiated.
- `[>] In Progress`: Workflow or sub-process is currently active.
- `[x] Done`: Workflow or sub-process has been successfully completed and verified.
- `[-] Not In Scope`: Workflow is omitted for this feature/operate scope.

---

## Block 2: Datestamped Daily Execution History

This section logs daily process initiations, completed milestones, and key decisions.

### [YYYY-MM-DD]
- **[HH:MM] Workflow Initiated**: `/init --release v1.0.0`
  - Created Git branch `release/v1.0.0`.
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
   - `/init --release <version>`: Creates a Git branch `release/<version>` from `main`/`master`, scaffolds `agent-workspace/plans/PROCESS_STATUS.md`, and registers the initial status matrix.
   - `/init --feature <feature-name>`: Creates a Git branch `feature/<feature-name>`, scaffolds `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md`, and initializes the workflow matrix with `process` marked as `[-] Not In Scope` by default for greenfield features.
   - **Branch Origination Rule**: When creating a new branch in an existing project (e.g. for a feature, bugfix, or hotfix), the parent branch is determined by:
     1. If only one branch exists, originate from it.
     2. If multiple branches exist but all are merged/rebased into `main`/`master`, select `main`/`master`.
     3. If multiple unmerged active branches exist: the user may specify the parent in the prompt; otherwise, the agent MUST ask the user which branch to originate from.
3. **Immutability of Closed Logs**: Past daily log entries in Block 2 must never be modified or overwritten; new events are strictly appended under the current date header.
4. **Brownfield Discovery Scope**: The `/process` workflow is responsible for discovering and cataloguing existing Docker configurations, tech stacks, programming languages, CI/CD pipelines, cloud infrastructure, **and existing test assets** in brownfield projects. These discoveries inform `/plan` Phase 6 (Operations) and Phase 5 (Verification Scope) decisions.
5. **Existing Coverage Catalogue**: Test-asset discovery is not optional context. Because `phase-5-test.md` is a **delta against coverage that already exists**, `/plan` cannot author a correct verification scope without knowing what the legacy codebase already proves. `/process` therefore catalogues existing suites, fixtures, and runners into `agent-workspace/plans/<feature-name>/resource/existing_coverage.md`.

---

## 4. Workflow Context Notification Law (Combined Multi-Layer Strategy)

To maintain continuous context awareness during active development, all workflows and status sheet tools MUST enforce the 3-Layer Workflow Context Notification Law:

1. **Layer 1 (Turn-by-Turn Response Banner Header)**: Every agent message during an active workflow begins with a 1-line quote header:
   `> 📍 **Active Workflow**: /<workflow_name> | **Scope**: <branch_or_feature> | **Node**: <Node_ID> (<Node_Name>)`
2. **Layer 2 (State Machine Node Transition Badges)**: Workflow playbooks print a stylized text transition box when moving between state machine steps (e.g. Node S2 $\rightarrow$ Node S3).
3. **Layer 3 (Persistent Disk Header Metadata)**: `PROCESS_STATUS.md`, `GRILL_STATUS.md`, and `phase-1-summary.md` maintain top-level metadata (`Active Workflow`, `Git Branch`, `Active Node`, `Last Updated`) in their header block.
