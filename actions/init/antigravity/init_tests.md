# Verification & Test Specification: `/init` Workflow (Flat Q1–Q9 Schema)

This document defines the test scenarios, mock execution sequences, user input simulations, and verification assertions for testing the `/init` workflow within **Google Antigravity**. It covers both **Greenfield Initialization with Fresh Git Setup** and **Feature Scope Initialization in an Existing Workspace (Adopt Setup)** under the flat, sequential Q1–Q9 schema.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/init` (Bootstrapping workflow for Guards framework)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenarios**:
    1.  **Scenario A (Greenfield Initialization — Fresh Git Setup)**: Full control plane setup (`agent-workspace/` with `.agents/`, `plans/initial/`, `docs/`, `src/`), exercising flat Q1–Q9 sequential interview with fresh Git initialization, `.gitkeep` directory preservation across all nodes, primary remote origin setup, and initial push.
    2.  **Scenario B (Feature Scope Initialization — Adopt Setup)**: Initialization in an existing workspace, exercising flat Q1–Q9 interview with detected conformant root, adopt Git setup, issue reference linking, feature-bound plan scaffolding (`plans/<scope_name>/`), and branch checkout guarantee.
*   **Primary Objective**: Validate end-to-end execution of the single-path linear state machine (S1 $\rightarrow$ S2 $\rightarrow$ S3 $\rightarrow$ S4 $\rightarrow$ S5 $\rightarrow$ S6 $\rightarrow$ S7), flat Q1–Q9 interview schema, Baselines 1–4, and branch checkout guarantee.

---

## 2. Test Setup & Pre-conditions

### Scenario A: Greenfield Pre-conditions
1.  **Clean Workspace Directory**: A newly initialized root directory containing no prior `agent-workspace/` folder or pre-existing project status sheets.
2.  **Version Control Context**: Bare remote repository available for remote push simulation (`mock-remote.git`).
3.  **Filesystem Access**: Read/write privileges in the workspace path.

### Scenario B: Feature Scope / Adopt Pre-conditions
1.  **Already Initialized Workspace**: A workspace that has completed a prior greenfield `/init` run — `agent-workspace/plans/initial/GRILL_STATUS.md` and `agent-workspace/plans/initial/PROCESS_STATUS.md` exist.
2.  **Version Control Context**: Git repository initialized on `agent-workspace/`, `initial` branch exists, workspace is on `main` or any non-feature branch.

---

## 3. Scenario A: Greenfield Initialization (Fresh Git Setup) — Mock Execution Sequence

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Sequential Q1 to Q9 + Node S4)

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Check Environment** | System verifies filesystem write access and Git binary availability. | Environment verified. |
| **Q1** | **Local Workspace Parent Directory** | Selected Option 1 (*Use current directory — empty, ready for new root*). | Parent directory resolved to current working directory. Clean Root Mandate passed. |
| **Q2** | **Project Scope, Purpose, & Names** | Selected Option 1 (*Fullstack web application*) + Custom text: *"A fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release."*<br/>Root Name: `ecommerce-engine`<br/>Scope Name: `initial`. | Project vision and names recorded. Target scope resolved to `initial`. |
| **Q3** | **Git Set-up & Primary Remote Origin** | Selected Option 3 (*Initialize fresh repository*) → Input: `https://github.com/org/my-project.git`. | Git resolution set to `initialize` with remote origin URL. (Mutations deferred to S5/S6 per Baseline 3). |
| **Q4** | **Local Documentation Repository** | Selected Option 2 (*No local documentation folder*). | Local documentation paths set to `None`. |
| **Q5** | **Remote / Cloud Documentation Repository** | Selected Option 4 (*No external documentation repository*). | External documentation URLs set to `None`. |
| **Q6** | **Further Documentation & Issue References** | Selected Option 3 (*No further documentation*). | Issue reference set to `None`. |
| **Q7** | **Agent Guidance Rules & Tooling** | Selected Option 1 (*Standard Guards framework defaults*). | Core rules, skills, workflows marked for deployment to `agent-workspace/.agents/`. |
| **Q8** | **Constraints & Pre-Planning Decisions** | Selected Option 1 (*No — No blockers or constraints to record*). | No constraints recorded. |
| **Q9** | **Summary Verification & Reflection** | Displays Q1–Q8 recap matrix. Selected Option 1 (*Everything is accurate → Proceed to finalize /init*). | Q&A finalized. Full audit log written to `agent-workspace/plans/initial/GRILL_STATUS.md`. |
| **S3** | **Lightweight Scan & Path Verification** | Verifies directory paths; asserts `agent-workspace/tests/TEST_STRATEGY.md` status. | Records test strategy gap without halting. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary & planned scaffolding steps. Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5 workspace scaffolding. |

---

## 4. Scenario B: Feature Scope Initialization (Adopt Setup) — Mock Execution Sequence

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Sequential Q1 to Q9 + Node S4)

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Check Environment** | System verifies filesystem write access and Git binary availability. | Environment verified. |
| **Q1** | **Local Workspace Parent Directory** | Selected Option 1 (*Use current directory — conformant root found at cwd*). | Parent directory resolved. Conformant root detected. |
| **Q2** | **Project Scope, Purpose, & Names** | Free-text input: *"Fix checkout button alignment on mobile view — button overflows container on screens < 375px."*<br/>Root Name: *(Skipped — conformant root detected)*<br/>Scope Name: `fix-checkout-button`. | Aim and scope recorded. Target scope resolved to `fix-checkout-button`. |
| **Q3** | **Git Set-up & Primary Remote Origin** | Selected Option 1 (*Adopt existing local repository in place*). | Git resolution set to `adopt`. Remote divergence check passed. |
| **Q4** | **Local Documentation Repository** | Selected Option 2 (*No local documentation folder*). | Local documentation paths set to `None`. |
| **Q5** | **Remote / Cloud Documentation Repository** | Selected Option 4 (*No external documentation repository*). | External documentation URLs set to `None`. |
| **Q6** | **Further Documentation & Issue References** | Selected Option 1 (*Yes — Link issue*) → Input: *"GitHub Issue #142 — Checkout button overflow on mobile"*. | Issue reference `#142` recorded in `agent-workspace/plans/fix-checkout-button/phase-1-summary.md`. |
| **Q7** | **Agent Guidance Rules & Tooling** | Selected Option 1 (*Standard Guards framework defaults*). | Existing `.agents/` preserved. |
| **Q8** | **Constraints & Pre-Planning Decisions** | Selected Option 1 (*No — Proceed with initialization, no blockers*). | No constraints recorded. |
| **Q9** | **Summary Verification & Reflection** | Displays Q1–Q8 recap matrix. Selected Option 1 (*Everything is accurate → Proceed to finalize /init*). | Q&A finalized. Full audit log written to `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md`. |
| **S3** | **Lightweight Scan & Path Verification** | Verifies directory paths and asserts test strategy status. | Target paths verified. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary. Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5. |

---

## 5. Verification Assertions & Validation Matrix

### 5.1 Shared Assertions (Both Scenarios)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Environment Check | Host Environment | Filesystem write access verified; Git binary confirmed. |
| **S2** | Full Q1–Q9 Audit Log | `agent-workspace/plans/<scope_name>/GRILL_STATUS.md` | Contains full Q1–Q9 transcript, question texts, selected options, and user inputs. |
| **S3** | Test Strategy Assertion | Execution Log | Asserts `agent-workspace/tests/TEST_STRATEGY.md` presence; logs gap if missing without halting. |
| **S4** | Execution Acceptance Record | `agent-workspace/plans/<scope_name>/GRILL_STATUS.md` | Contains Execution Acceptance Summary and User Confirmation record (`Accepted`). |
| **S5** | Control Directory & `.gitkeep` | `agent-workspace/.agents/` | Directories present: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`. **`.gitkeep` present inside every control folder node**. |
| **S5** | Pure Control Plane Scope | Filesystem | `agent-workspace/` created. **Zero `codebase-*/` sub-repositories created during `/init`**. |
| **S6** | Pre-Commit Safety Hook | `.git/hooks/pre-commit` | File installed, executable (`chmod +x`), intercepts commits missing valid `PROCESS_STATUS.md`. |
| **S7** | Branch Checkout Guarantee | Git Context | Active branch matches target scope (`initial` or `feature/<scope_name>` / `bugfix/<scope_name>`). |
| **S7** | Execution Output | Subprocess Stdout | Terminal prints completion summary report and recommended next workflow command (`/plan` or `/process`). |

### 5.2 Scenario A-Specific Assertions (Greenfield — Fresh Git Setup)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1/S7** | Branch Creation & Checkout | Git Context | Greenfield run creates and checks out `initial` branch (`git branch --show-current` returns `initial`). |
| **S2** | Q1–Q9 Audit Log | `agent-workspace/plans/initial/GRILL_STATUS.md` | Contains full Q1–Q9 transcript, `root_name: ecommerce-engine`, and `scope_name: initial`. |
| **S5** | Plans Directory | `agent-workspace/plans/initial/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains `/init` row marked `Completed`. Sub-rows 3.1–3.6 for 6 planning phases present. Block 2 daily history updated. |
| **S5** | Architecture Summary | `agent-workspace/plans/initial/phase-1-summary.md` | Contains project vision, names, and folder map. |
| **S5** | Empty Staging Folders | `agent-workspace/docs/`, `agent-workspace/src/` | Created with `.gitkeep` placeholders, ready for future planning/process actions. |
| **S6/S7** | Remote Origin & Push | Git Context | `git remote get-url origin` returns configured URL; initial documentation committed and pushed to remote origin. |

### 5.3 Scenario B-Specific Assertions (Feature Scope — Adopt Setup)

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1/S7** | Feature Branch Checkout | Git Context | Branch `bugfix/fix-checkout-button` (or `feature/fix-checkout-button`) created and checked out. |
| **S2** | Feature Audit Log | `agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md` | Contains full Q1–Q9 transcript with `git_setup: adopt`. |
| **S5** | Feature Plans Directory | `agent-workspace/plans/fix-checkout-button/` | Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Feature Phase Summary | `agent-workspace/plans/fix-checkout-button/phase-1-summary.md` | Contains aim/reason from Q2, issue reference `#142` from Q6. |
| **S5** | Feature Process Status | `agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md` | Block 1 matrix initialized with `/init` row marked `Completed`. Block 2 daily history updated. |
| **S5** | No New Sub-Repos | Filesystem | No new `codebase-*` sub-repositories created. |

---

## 6. Automated Execution Scripts

### 6.1 Scenario A: Greenfield Test (Fresh Git Setup)

```bash
# 1. Prepare clean test directory and mock remote repository
mkdir -p /tmp/test-init-greenfield && cd /tmp/test-init-greenfield
git init --bare /tmp/mock-remote.git

# 2. Run /init workflow in dry-run mode first to verify output
/init --dry-run

# 3. Run full /init workflow execution in interactive mode
/init

# 4. Run automated assertions
test -f agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: GRILL_STATUS.md present"
test -f agent-workspace/plans/initial/PROCESS_STATUS.md && echo "ASSERT PASS: PROCESS_STATUS.md present"
test -f agent-workspace/plans/initial/phase-1-summary.md && echo "ASSERT PASS: phase-1-summary.md present"
test -f agent-workspace/.agents/rules/.gitkeep && echo "ASSERT PASS: .gitkeep in rules/"
test -f agent-workspace/.agents/workflows/.gitkeep && echo "ASSERT PASS: .gitkeep in workflows/"
test -f agent-workspace/.agents/skills/.gitkeep && echo "ASSERT PASS: .gitkeep in skills/"
test -f agent-workspace/.agents/hooks/.gitkeep && echo "ASSERT PASS: .gitkeep in hooks/"
test -f agent-workspace/.agents/sidecars/.gitkeep && echo "ASSERT PASS: .gitkeep in sidecars/"
test -f agent-workspace/docs/.gitkeep && echo "ASSERT PASS: .gitkeep in docs/"
test -f agent-workspace/src/.gitkeep && echo "ASSERT PASS: .gitkeep in src/"
test ! -d codebase-devops && echo "ASSERT PASS: No codebase-devops created during /init"
test ! -d codebase-layout && echo "ASSERT PASS: No codebase-layout created during /init"
test ! -d codebase-engine && echo "ASSERT PASS: No codebase-engine created during /init"
test -x .git/hooks/pre-commit && echo "ASSERT PASS: Pre-commit hook executable"
grep -q "Q1 Local Workspace Parent Directory" agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: Q1 recorded"
grep -q "Q3 Git Set-up" agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: Q3 recorded"
git branch --show-current | grep -q "initial" && echo "ASSERT PASS: Branch checkout assertion passed"
git ls-remote --heads origin initial | grep -q "refs/heads/initial" && echo "ASSERT PASS: Initial commit pushed to remote origin"
.git/hooks/pre-commit && echo "ASSERT PASS: Pre-commit hook passed validation"
```

### 6.2 Scenario B: Feature Scope Test (Adopt Setup)

```bash
# Pre-condition: Run Scenario A first to have an initialized workspace
cd /tmp/test-init-greenfield

# 1. Run /init for new feature scope
/init

# 2. Run automated assertions for feature scope
test -f agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Feature GRILL_STATUS.md present"
test -f agent-workspace/plans/fix-checkout-button/PROCESS_STATUS.md && echo "ASSERT PASS: Feature PROCESS_STATUS.md present"
test -f agent-workspace/plans/fix-checkout-button/phase-1-summary.md && echo "ASSERT PASS: Feature phase-1-summary.md present"
grep -q "Q6 Further Documentation" agent-workspace/plans/fix-checkout-button/GRILL_STATUS.md && echo "ASSERT PASS: Q6 recorded"
grep -q "#142" agent-workspace/plans/fix-checkout-button/phase-1-summary.md && echo "ASSERT PASS: Issue reference recorded"
git branch --show-current | grep -q "bugfix/fix-checkout-button" && echo "ASSERT PASS: Feature branch checked out"

# 3. Verify no new sub-repos were created
test ! -d codebase-fix-checkout-button && echo "ASSERT PASS: No new sub-repo created"

# 4. Verify pre-commit hook validation on feature branch
.git/hooks/pre-commit && echo "ASSERT PASS: Pre-commit hook passed validation on bugfix branch"
```
