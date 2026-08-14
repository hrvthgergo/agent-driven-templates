# Verification & Test Specification: `/init` Workflow (Dual-Mode Scenarios)

This document defines the test scenarios, mock execution sequences, user input simulations, and verification assertions for testing the `/init` workflow within **Google Antigravity**. It covers both **Quick & Simple Mode** (bugfix/minor) and **Major Feature / Greenfield Mode** (full deep-dive).

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/init` (Bootstrapping workflow for Guards framework)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenarios**:
    1.  **Scenario A (Major Feature / Greenfield)**: Full deep-dive multi-repo setup (`codebase-devops` + `codebase-layout` + `codebase-engine`), exercising Q0 auto-selection → Q1–Q10 → S3–S7.
    2.  **Scenario B (Quick & Simple / Bugfix)**: Fast-track initialization in an already-initialized workspace, exercising Q0 mode gate → QS1–QS3 → S3–S7 with stack inheritance.
*   **Primary Objective**: Validate end-to-end execution of the `/init` dual-path state machine (S1 → S2 → S2a *or* S2b → S3 → S4 → S5 → S6 → S7), asserting correct mode selection, interview depth, audit logging, workspace scaffolding, and stack inheritance behavior.

---

## 2. Test Setup & Pre-conditions

### Scenario A: Greenfield Pre-conditions
1.  **Clean Workspace Directory**: A newly initialized root directory containing no prior `agent-workspace/` folder or pre-existing project status sheets.
2.  **Docker Daemon Status**: Docker daemon active and accessible (`docker info` returns exit code `0`).
3.  **Version Control Context**: Git repository initialized in workspace root (`git init`).

### Scenario B: Quick & Simple Pre-conditions
1.  **Already Initialized Workspace**: A workspace that has completed a prior greenfield `/init` run — `agent-workspace/plans/initial/GRILL_STATUS.md` and `agent-workspace/plans/initial/PROCESS_STATUS.md` exist with populated stack profile.
2.  **Docker Daemon Status**: Docker daemon active and accessible (`docker info` returns exit code `0`).
3.  **Version Control Context**: Git repository initialized, `initial` branch exists, workspace is on `main` or any non-feature branch.

---

## 3. Scenario A: Major Feature / Greenfield — Mock Execution Sequence

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Q0 Auto-Selection → Q1 to Q10 + Node S4)

For greenfield (no `agent-workspace/plans/initial/` exists), Q0 is auto-skipped and Major Feature Mode is auto-selected:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Environment & Branch Initialization** | System checks Docker status (`docker info`) and creates `initial` Git branch. | Checks out `initial` branch (`git branch --show-current`). |
| **S2** | **Mode Gate (Q0)** | Auto-selected: *Major Feature / Greenfield Mode* (no prior `initial/` exists). | `GRILL_STATUS.md` header metadata: `mode: major_feature`. Transitions to S2b. |
| **Q1** | **Project Scope, Purpose, & Milestones** | Selected Option 1 (*Fullstack web application*) + Custom text: *"A fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release."* | Purpose and vision baseline recorded in `agent-workspace/plans/initial/phase-1-summary.md`. |
| **Q2** | **Local System Folders** | Selected Option 2 (*No - Create a new project folder*) → **Q2.b**: Selected Option 1 (*Current working directory*). | Project root set to current working directory. |
| **Q3** | **Cloud Documentation Repository** | Selected Option 4 (*No external documentation repository*). | Auto-detection scan failure statement acknowledged. External documentation URLs set to `None`. |
| **Q4** | **Additional Remote Code Repos** | Selected Option 2 (*No - Single remote repository only*). | Secondary remotes set to `None`. |
| **Q5** | **Cloud Git Provider** | Selected Option 1 (*GitHub*) → **Q5.a**: Selected Option 2 (*No pre-created project*). | Git provider set to GitHub. Origin URL configured. |
| **Q6** | **Architecture Design Pattern** | Selected Option 1 (*Modular Monolith / Layered Architecture*). | Architectural rules recorded in `agent-workspace/plans/initial/phase-1-summary.md`. |
| **Q7** | **Layer Scope & Sub-repos** | Selected Option 1 (*Fullstack - UI Layout + Backend Engine*). | Sub-repository skeletons registered: `codebase-devops`, `codebase-layout`, and `codebase-engine`. |
| **Q8** | **Software Stack & Frameworks** | Selected Option 4 (*Other / Free-text*) → Inputs: *"Engine API in Go with PostgreSQL; UI Layout in Vanilla JS and Pure CSS."* | Package manifests (`go.mod`, `package.json`) generated inside respective sub-repositories. |
| **Q9** | **Agent Guidance Rules & Tooling** | Selected Option 1 (*Standard Guards framework defaults*). | Core rules, skills, workflows deployed to `agent-workspace/.agents/`. |
| **Q10** | **Summary Verification & Reflection** | Displays Q1–Q9 recap matrix. Selected Option 1 (*Everything is accurate → Proceed to finalize Q&A*). | Q&A finalized. Permanent audit log written to `agent-workspace/plans/initial/GRILL_STATUS.md`. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary & planned scaffolding steps. Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5 workspace scaffolding. |

---

## 4. Scenario B: Quick & Simple / Bugfix — Mock Execution Sequence

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Q0 Mode Selection → QS1 to QS3 + Node S4)

For an already-initialized workspace, Q0 is presented:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Environment Check** | System checks Docker status (`docker info`). Verifies workspace is already initialized (`agent-workspace/plans/initial/` exists). | Docker verified. No new `initial` branch created. |
| **S2** | **Mode Gate (Q0)** | Selected Option 1 (*Quick & Simple — Bugfix / Minor Change*). | `GRILL_STATUS.md` header metadata: `mode: quick_simple`. Transitions to S2a. |
| **QS1** | **Aim & Reason of the Change** | Free-text input: *"Fix checkout button alignment on mobile view — button overflows container on screens < 375px."* + Branch name: `fix-checkout-button`. | Aim recorded in `agent-workspace/plans/fix-checkout-button/phase-1-summary.md`. Git branch `bugfix/fix-checkout-button` created and checked out. |
| **QS2** | **Issue & Bug Reference** | Selected Option 1 (*Yes — Link issue*) → Input: *"GitHub Issue #142 — Checkout button overflow on mobile"*. | Issue reference `#142` recorded in `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` under "Issue Reference" section. |
| **QS3** | **Pre-Planning Decisions & Constraints** | Selected Option 1 (*No — Proceed with initialization, no blockers*). | No additional constraints recorded. Audit log finalized into `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` with QS1–QS3 transcript + inherited stack profile. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary (aim, issue ref, inherited stack). Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5. |

### Quick & Simple Mode: Stack Inheritance Verification

| Inherited Property | Source File | Expected Behavior |
| :--- | :--- | :--- |
| Tech Stack (Go + Vanilla JS) | `agent-workspace/plans/initial/GRILL_STATUS.md` | Copied into feature `GRILL_STATUS.md` without re-prompting. |
| Architecture Pattern (Modular Monolith) | `agent-workspace/plans/initial/GRILL_STATUS.md` | Inherited. No Q6 prompt presented. |
| Cloud Provider (GitHub) | `agent-workspace/plans/initial/GRILL_STATUS.md` | Inherited. No Q5 prompt presented. |
| Layer Scope (devops + layout + engine) | `agent-workspace/plans/initial/GRILL_STATUS.md` | Inherited. No Q7 prompt presented. |
| Docker Configuration (Hybrid Strategy) | Baseline 1 (Unchangeable) | Always enforced. No prompt in any mode. |

---

## 5. Verification Assertions & Validation Matrix

### 5.1 Shared Assertions (Both Scenarios)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Docker Verification | Host Environment | `docker info` returns exit code `0`. |
| **S2** | Mode Gate Record | `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` | Header contains `mode:` field set to either `quick_simple` or `major_feature`. |
| **S4** | Execution Acceptance Record | `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` | Contains Execution Acceptance Summary and User Confirmation record (`Accepted`). |
| **S5** | Control Directory & `.gitkeep` | `agent-workspace/.agents/` | Directories present: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`. **`.gitkeep` present inside every control folder node**. |
| **S6** | Pre-Commit Safety Hook | `.git/hooks/pre-commit` | File installed, executable (`chmod +x`), intercepts commits missing valid `PROCESS_STATUS.md`. |
| **S7** | Execution Output | Subprocess Stdout | Terminal prints completion summary report and recommended next workflow command (`/plan` or `/process`). |

### 5.2 Scenario A-Specific Assertions (Greenfield)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Branch Creation | Git Context | Greenfield run creates and checks out `initial` branch (`git branch --show-current` returns `initial`). |
| **S2b** | Full Audit Log | `agent-workspace/plans/initial/GRILL_STATUS.md` | Contains full Q1–Q10 transcript, question texts, selected options, and user inputs. |
| **S5** | Plans Directory | `agent-workspace/plans/initial/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains `/init` row marked `Completed`. Sub-rows 3.1–3.6 for 6 planning phases present. Block 2 daily history updated. |
| **S5** | Architecture Summary | `agent-workspace/plans/initial/phase-1-summary.md` | Contains vision, Go + Vanilla JS stack, Modular Monolith pattern, and folder map. |
| **S5** | DevOps Sub-Repo & Docker | `codebase-devops/` | Contains `.github/workflows/ci.yml`, `docker/dev.Dockerfile`, `docker/docker-compose.yml`, `config/`, `Dockerfile`, `src/`, `tests/`. |
| **S5** | Layer Sub-Repos & `.gitkeep` | `codebase-layout/`, `codebase-engine/` | Created with `src/`, `config/`, `tests/`, standalone `Dockerfile`. **`.gitkeep` in every folder node**. |
| **S5** | Symlink Purity | `agent-workspace/src/devops`, `src/layout`, `src/engine` | Relative symlinks to `../../codebase-*/src`. Pass 3-part verification. **Zero non-symlink folders inside `agent-workspace/src/`**. |

### 5.3 Scenario B-Specific Assertions (Quick & Simple)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | No Duplicate Branch | Git Context | Does NOT create a new `initial` branch. Existing workspace structure preserved. |
| **S2a** | Quick Audit Log | `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` | Contains QS1–QS3 transcript + inherited stack profile from `initial/GRILL_STATUS.md`. Mode recorded as `quick_simple`. |
| **S2a** | Inheritance Verification | `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` | Tech stack, architecture pattern, cloud provider, and layer scope values match `agent-workspace/plans/initial/GRILL_STATUS.md`. |
| **S2a** | No Deep-Dive Questions | Execution Flow | Q1–Q10 prompts are NOT presented. Only QS1–QS3 are executed. |
| **S5** | Feature Plans Directory | `agent-workspace/plans/fix-checkout-button/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Feature Phase Summary | `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` | Contains aim/reason from QS1, issue reference `#142` from QS2. |
| **S5** | Feature Process Status | `agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md` | Block 1 matrix initialized with `/init` row marked `Completed`. Block 2 daily history updated. |
| **S5** | Feature Branch | Git Context | Branch `bugfix/fix-checkout-button` created and checked out. |
| **S5** | No New Sub-Repos | Filesystem | No new `codebase-*` sub-repositories created. Existing layer sub-repos preserved untouched. |

---

## 6. Automated Execution Scripts

### 6.1 Scenario A: Greenfield Test

```bash
# 1. Prepare clean test directory
mkdir -p /tmp/test-init-greenfield && cd /tmp/test-init-greenfield
git init

# 2. Run /init workflow in dry-run mode first to verify output
/init --dry-run

# 3. Run full /init workflow execution in interactive mode
/init

# 4. Run automated assertions
test -f agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: GRILL_STATUS.md present"
test -f agent-workspace/plans/initial/PROCESS_STATUS.md && echo "ASSERT PASS: PROCESS_STATUS.md present"
test -f agent-workspace/.agents/skills/.gitkeep && echo "ASSERT PASS: .gitkeep in skills/"
test -d codebase-devops/docker && echo "ASSERT PASS: codebase-devops/docker present"
test -f codebase-devops/docker/dev.Dockerfile && echo "ASSERT PASS: dev.Dockerfile present"
test -f codebase-devops/docker/docker-compose.yml && echo "ASSERT PASS: docker-compose.yml present"
test -f codebase-layout/src/.gitkeep && echo "ASSERT PASS: .gitkeep in codebase-layout/src/"
test -L agent-workspace/src/devops && echo "ASSERT PASS: Symlink src/devops present"
test -L agent-workspace/src/layout && echo "ASSERT PASS: Symlink src/layout present"
test -L agent-workspace/src/engine && echo "ASSERT PASS: Symlink src/engine present"
test -x .git/hooks/pre-commit && echo "ASSERT PASS: Pre-commit hook executable"
grep -q "mode: major_feature" agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: Mode recorded as major_feature"
```

### 6.2 Scenario B: Quick & Simple Test

```bash
# Pre-condition: Run Scenario A first to have an initialized workspace
cd /tmp/test-init-greenfield

# 1. Run /init in Quick & Simple mode (simulate selecting option 1 at Q0)
/init

# 2. Run automated assertions for Quick & Simple mode
test -f agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Feature GRILL_STATUS.md present"
test -f agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md && echo "ASSERT PASS: Feature PROCESS_STATUS.md present"
test -f agent-workspace/plans/fix-checkout-button/phase-1-summary.md && echo "ASSERT PASS: Feature phase-1-summary.md present"
grep -q "mode: quick_simple" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Mode recorded as quick_simple"
grep -q "#142" agent-workspace/plans/fix-checkout-button/phase-1-summary.md && echo "ASSERT PASS: Issue reference recorded"
git branch --show-current | grep -q "bugfix/fix-checkout-button" && echo "ASSERT PASS: Bugfix branch created"

# 3. Verify inheritance — feature GRILL_STATUS should contain stack from initial
grep -q "Go" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Stack inherited (Go)"
grep -q "Vanilla JS" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Stack inherited (Vanilla JS)"

# 4. Verify no new sub-repos were created
test ! -d codebase-fix-checkout-button && echo "ASSERT PASS: No new sub-repo created for Quick & Simple"
```
