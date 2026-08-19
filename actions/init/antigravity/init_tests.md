# Verification & Test Specification: `/init` Workflow (Dual-Mode Scenarios)

This document defines the test scenarios, mock execution sequences, user input simulations, and verification assertions for testing the `/init` workflow within **Google Antigravity**. It covers both **Quick & Simple Mode** (bugfix/minor) and **Major Feature / Greenfield Mode** (full deep-dive).

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/init` (Bootstrapping workflow for Guards framework)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenarios**:
    1.  **Scenario A (Major Feature / Greenfield)**: Full deep-dive control plane setup (`agent-workspace/` with `.agents/`, `plans/`, `docs/`, `src/`), exercising Q0 auto-selection → Q1–Q7 → S3–S7 with remote origin setup and push.
    2.  **Scenario B (Quick & Simple / Bugfix)**: Fast-track initialization in an already-initialized workspace, exercising Q0 mode gate → QS1–QS3 → S3–S7 with workspace profile inheritance.
*   **Primary Objective**: Validate end-to-end execution of the `/init` dual-path state machine (S1 → S2 → S2a *or* S2b → S3 → S4 → S5 → S6 → S7), asserting correct mode selection, interview depth, audit logging, control plane scaffolding, and remote synchronization.

---

## 2. Test Setup & Pre-conditions

### Scenario A: Greenfield Pre-conditions
1.  **Clean Workspace Directory**: A newly initialized root directory containing no prior `agent-workspace/` folder or pre-existing project status sheets.
2.  **Version Control Context**: Git repository initialized in workspace root (`git init`).
3.  **Filesystem Access**: Read/write privileges in the workspace path.

### Scenario B: Quick & Simple Pre-conditions
1.  **Already Initialized Workspace**: A workspace that has completed a prior greenfield `/init` run — `agent-workspace/plans/initial/GRILL_STATUS.md` and `agent-workspace/plans/initial/PROCESS_STATUS.md` exist.
2.  **Version Control Context**: Git repository initialized, `initial` branch exists, workspace is on `main` or any non-feature branch.

---

## 3. Scenario A: Major Feature / Greenfield — Mock Execution Sequence

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Q0 Auto-Selection → Q1 to Q7 + Node S4)

For greenfield (no `agent-workspace/plans/initial/` exists), Q0 is auto-skipped and Major Feature Mode is auto-selected:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Environment & Branch Initialization** | System checks filesystem write access and creates `initial` Git branch. | Checks out `initial` branch (`git branch --show-current`). |
| **S2** | **Mode Gate (Q0)** | Auto-selected: *Major Feature / Greenfield Mode* (no prior `initial/` exists). | `GRILL_STATUS.md` header metadata: `mode: major_feature`. Transitions to S2b. |
| **Q1** | **Project Scope, Purpose, & Milestones** | Selected Option 1 (*Fullstack web application*) + Custom text: *"A fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release."* | Purpose and vision baseline recorded in `agent-workspace/plans/initial/phase-1-summary.md`. |
| **Q2** | **Local System Folders** | Selected Option 2 (*No - Create a new project folder*) → **Q2.b**: Selected Option 1 (*Current working directory*). | Project root set to current working directory. |
| **Q3** | **Cloud Documentation Repository** | Selected Option 4 (*No external documentation repository*). | External documentation URLs set to `None`. |
| **Q4** | **Additional Remote Code Repos** | Selected Option 2 (*No - Single remote repository only*). | Secondary remotes set to `None`. |
| **Q5** | **Primary Remote Git Origin & Provider** | Selected Option 1 (*GitHub*) → Input: `https://github.com/org/my-project.git`. | Remote Git origin registered as `origin`. |
| **Q6** | **Agent Guidance Rules & Tooling** | Selected Option 1 (*Standard Guards framework defaults*). | Core rules, skills, workflows deployed to `agent-workspace/.agents/`. |
| **Q7** | **Summary Verification & Reflection** | Displays Q1–Q6 recap matrix. Selected Option 1 (*Everything is accurate → Proceed to finalize Q&A*). | Q&A finalized. Permanent audit log written to `agent-workspace/plans/initial/GRILL_STATUS.md`. |
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
| **S1** | **Environment Check** | System verifies workspace is already initialized (`agent-workspace/plans/initial/` exists). | Environment verified. No new `initial` branch created. |
| **S2** | **Mode Gate (Q0)** | Selected Option 1 (*Quick & Simple — Bugfix / Minor Change*). | `GRILL_STATUS.md` header metadata: `mode: quick_simple`. Transitions to S2a. |
| **QS1** | **Aim & Reason of the Change** | Free-text input: *"Fix checkout button alignment on mobile view — button overflows container on screens < 375px."* + Branch name: `fix-checkout-button`. | Aim recorded in `agent-workspace/plans/fix-checkout-button/phase-1-summary.md`. Git branch `bugfix/fix-checkout-button` created and checked out. |
| **QS2** | **Issue & Bug Reference** | Selected Option 1 (*Yes — Link issue*) → Input: *"GitHub Issue #142 — Checkout button overflow on mobile"*. | Issue reference `#142` recorded in `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` under "Issue Reference" section. |
| **QS3** | **Pre-Planning Decisions & Constraints** | Selected Option 1 (*No — Proceed with initialization, no blockers*). | No additional constraints recorded. Audit log finalized into `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` with QS1–QS3 transcript. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary. Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5. |

---

## 5. Verification Assertions & Validation Matrix

### 5.1 Shared Assertions (Both Scenarios)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Environment Check | Host Environment | Filesystem write access verified; Git binary confirmed. |
| **S2** | Mode Gate Record | `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` | Header contains `mode:` field set to either `quick_simple` or `major_feature`. |
| **S4** | Execution Acceptance Record | `agent-workspace/plans/<branch_name>/GRILL_STATUS.md` | Contains Execution Acceptance Summary and User Confirmation record (`Accepted`). |
| **S5** | Control Directory & `.gitkeep` | `agent-workspace/.agents/` | Directories present: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`. **`.gitkeep` present inside every control folder node**. |
| **S6** | Pre-Commit Safety Hook | `.git/hooks/pre-commit` | File installed, executable (`chmod +x`), intercepts commits missing valid `PROCESS_STATUS.md`. |
| **S7** | Execution Output | Subprocess Stdout | Terminal prints completion summary report and recommended next workflow command (`/plan` or `/process`). |

### 5.2 Scenario A-Specific Assertions (Greenfield)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Branch Creation | Git Context | Greenfield run creates and checks out `initial` branch (`git branch --show-current` returns `initial`). |
| **S2b** | Full Audit Log | `agent-workspace/plans/initial/GRILL_STATUS.md` | Contains full Q1–Q7 transcript, question texts, selected options, and user inputs. |
| **S5** | Plans Directory | `agent-workspace/plans/initial/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains `/init` row marked `Completed`. Sub-rows 3.1–3.6 for 6 planning phases present. Block 2 daily history updated. |
| **S5** | Architecture Summary | `agent-workspace/plans/initial/phase-1-summary.md` | Contains project vision and folder map. |
| **S5** | Pure Control Plane | Filesystem | `agent-workspace/` created. **Zero `codebase-*/` sub-repositories created during `/init`**. |
| **S5** | Empty Staging Folders | `agent-workspace/docs/`, `agent-workspace/src/` | Created with `.gitkeep` placeholders, ready for future planning/process actions. |
| **S6/S7** | Remote Origin & Push | Git Context | `git remote get-url origin` returns configured URL; initial documentation committed and pushed to remote origin. |

### 5.3 Scenario B-Specific Assertions (Quick & Simple)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | No Duplicate Branch | Git Context | Does NOT create a new `initial` branch. Existing workspace structure preserved. |
| **S2a** | Quick Audit Log | `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` | Contains QS1–QS3 transcript. Mode recorded as `quick_simple`. |
| **S2a** | No Deep-Dive Questions | Execution Flow | Q1–Q7 prompts are NOT presented. Only QS1–QS3 are executed. |
| **S5** | Feature Plans Directory | `agent-workspace/plans/fix-checkout-button/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Feature Phase Summary | `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` | Contains aim/reason from QS1, issue reference `#142` from QS2. |
| **S5** | Feature Process Status | `agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md` | Block 1 matrix initialized with `/init` row marked `Completed`. Block 2 daily history updated. |
| **S5** | Feature Branch | Git Context | Branch `bugfix/fix-checkout-button` created and checked out. |
| **S5** | No New Sub-Repos | Filesystem | No new `codebase-*` sub-repositories created. |

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
test -f agent-workspace/docs/.gitkeep && echo "ASSERT PASS: .gitkeep in docs/"
test -f agent-workspace/src/.gitkeep && echo "ASSERT PASS: .gitkeep in src/"
test ! -d codebase-devops && echo "ASSERT PASS: No codebase-devops created during /init"
test ! -d codebase-layout && echo "ASSERT PASS: No codebase-layout created during /init"
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

# 3. Verify no new sub-repos were created
test ! -d codebase-fix-checkout-button && echo "ASSERT PASS: No new sub-repo created for Quick & Simple"
```
