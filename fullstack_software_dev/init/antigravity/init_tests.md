# Verification & Test Specification: `/init` Workflow (Greenfield Scenario)

This document defines the test scenario, mock execution sequence, user input simulation, and verification assertions for testing the `/init` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/init` (Bootstrapping workflow for Guards framework)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenario**: Greenfield Multi-Repo Setup (Fullstack Web App: `codebase-devops` DevOps + `codebase-layout` UI + `codebase-engine` Backend)
*   **Primary Objective**: Validate end-to-end execution of the `/init` workflow state machine (Nodes S1 $\rightarrow$ S7), asserting that all Q1–Q10 prompts generate neutral choices, persistent `GRILL_STATUS.md` audit logs, Node S4 Execution Acceptance Gate prompts, `initial` branch creation, `agent-workspace/plans/initial/` relocation, pure relative symlinks under `agent-workspace/src/`, `codebase-devops` sub-repository scaffolding (`.github/workflows/`, `docker/dev.Dockerfile`, `docker/docker-compose.yml`, `config/`), `PROCESS_STATUS.md` process matrices, and `.git/hooks/pre-commit` safety interceptors.

---

## 2. Greenfield Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST meet the following pre-conditions prior to command execution:

1.  **Clean Workspace Directory**: A newly initialized root directory containing no prior `agent-workspace/` folder or pre-existing project status sheets.
2.  **Docker Daemon Status**: Docker daemon active and accessible (`docker info` returns exit code `0`).
3.  **Version Control Context**: Git repository initialized in workspace root (`git init`).

---

## 3. Simulated Execution Sequence & Greenfield Q&A

### Command Invocation
```bash
/init
```

### Mock User Input Sequence (Q1 to Q10 Greenfield Prompts & Node S4 Execution Acceptance)

The test harness simulates an interactive user session responding to the sequential Q1–Q10 interview prompts enforced by `rules/init-grill.md` and confirming Node S4 Execution Acceptance:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **S1** | **Environment & Branch Initialization** | System checks Docker status (`docker info`) and creates `initial` Git branch. | Checks out `initial` branch (`git branch --show-current`). |
| **Q1** | **Project Scope, Purpose, & Milestones** | Selected Option 1 (*Fullstack web application*) + Custom text: *"A fullstack e-commerce engine with real-time inventory management targeting Q3 MVP release."* | Purpose and vision baseline recorded in `agent-workspace/plans/initial/phase-1-summary.md`. |
| **Q2** | **Local System Folders** | Selected Option 2 (*No - Create a new project folder*) $\rightarrow$ **Q2.b**: Selected Option 1 (*Current working directory*). | Project root set to current working directory. |
| **Q3** | **Cloud Documentation Repository** | Selected Option 4 (*No external documentation repository*). | Auto-detection scan failure statement acknowledged. External documentation URLs set to `None`. |
| **Q4** | **Additional Remote Code Repos** | Selected Option 2 (*No - Single remote repository only*). | Secondary remotes set to `None`. |
| **Q5** | **Cloud Git Provider** | Selected Option 1 (*GitHub*) $\rightarrow$ **Q5.a**: Selected Option 2 (*No pre-created project*). | Git provider set to GitHub. Origin URL configured. |
| **Q6** | **Architecture Design Pattern** | Selected Option 1 (*Modular Monolith / Layered Architecture*). | Architectural rules recorded in `agent-workspace/plans/initial/phase-1-summary.md`. |
| **Q7** | **Layer Scope & Sub-repos** | Selected Option 1 (*Fullstack - UI Layout + Backend Engine*). | Sub-repository skeletons registered: `codebase-devops`, `codebase-layout`, and `codebase-engine`. |
| **Q8** | **Software Stack & Frameworks** | Selected Option 4 (*Other / Free-text*) $\rightarrow$ Inputs: *"Engine API in Go with PostgreSQL; UI Layout in Vanilla JS and Pure CSS."* | Package manifests (`go.mod`, `package.json`) generated inside respective sub-repositories. |
| **Q9** | **Agent Guidance Rules & Tooling** | Selected Option 1 (*Standard Guards framework defaults*). | Core rules, skills, workflows deployed to `agent-workspace/.agents/`. |
| **Q10** | **Summary Verification & Reflection** | Displays Q1–Q9 recap matrix. Selected Option 1 (*Everything is accurate $\rightarrow$ Proceed to finalize Q&A*). | Q&A finalized. Permanent audit log written to `agent-workspace/plans/initial/GRILL_STATUS.md`. |
| **S4** | **Node S4 Execution Acceptance Gate** | Agent displays understanding summary & planned scaffolding steps. Selected Option 1 (*Proceed with execution*). | User acceptance logged; transitions to Node S5 workspace scaffolding. |

---

## 4. Verification Assertions & Validation Matrix

Upon completion of Node S7, the test harness executes automated verification checks asserting that all physical and logical resources were scaffolded exactly as designed:

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S1** | Docker & Branch Verification | Host Environment & Git Context | `docker info` returns exit code `0`. Greenfield run creates and checks out the `initial` branch (`git branch --show-current` returns `initial`). |
| **S2** | Permanent Audit Log | `agent-workspace/plans/initial/GRILL_STATUS.md` | File exists. Contains full Q1–Q10 transcript, question texts, selected options, and user inputs. |
| **S4** | Execution Acceptance Record | `agent-workspace/plans/initial/GRILL_STATUS.md` | Contains Execution Acceptance Summary and User Confirmation record (`Accepted`). |
| **S5** | Control Directory & `.gitkeep` | `agent-workspace/.agents/` | Directories present: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`. **`.gitkeep` present inside every control folder node**. |
| **S5** | Relocated Plans Directory | `agent-workspace/plans/initial/` | Direct subfolder of `agent-workspace/`. Houses `GRILL_STATUS.md`, `PROCESS_STATUS.md`, and `phase-1-summary.md`. |
| **S5** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains `/init` row marked `Completed`. Sub-rows 3.1–3.6 for 6 planning phases present. Block 2 daily history updated with datestamped entry. |
| **S5** | Architecture Summary | `agent-workspace/plans/initial/phase-1-summary.md` | File exists. Contains vision, Go + Vanilla JS stack, Modular Monolith pattern, and folder map. |
| **S5** | DevOps Sub-Repo & Docker | `codebase-devops/` | Sub-repository created containing `.github/workflows/ci.yml`, `docker/dev.Dockerfile`, `docker/docker-compose.yml`, `config/`, `Dockerfile`, `src/`, `tests/`. |
| **S5** | Layer Sub-Repos & `.gitkeep` | `codebase-layout/`, `codebase-engine/` | Sub-repository folders created. Each contains `src/`, `config/`, `tests/`, and standalone `Dockerfile`. **`.gitkeep` present inside every sub-repo folder node**. |
| **S5** | Symlink Purity | `agent-workspace/src/devops`<br/>`agent-workspace/src/layout`<br/>`agent-workspace/src/engine` | Relative symlinks created pointing to `../../codebase-devops/src`, `../../codebase-layout/src`, and `../../codebase-engine/src`. Pass 3-part verification check. **Zero non-symlink folders inside `agent-workspace/src/`**. |
| **S6** | Pre-Commit Safety Hook | `.git/hooks/pre-commit` | File installed, executable (`chmod +x`), intercepts commits missing valid `PROCESS_STATUS.md`. |
| **S7** | Execution Output | Subprocess Stdout | Terminal prints completion summary report and recommended next workflow command (`/plan` or `/process`). |

---

## 5. Automated Execution Script

To execute this test scenario automatically in an Antigravity sandbox:

```bash
# 1. Prepare clean test directory
mkdir -p /tmp/test-init-workspace && cd /tmp/test-init-workspace
git init

# 2. Run /init workflow in dry-run mode first to verify output
/init --dry-run

# 3. Run full /init workflow execution in interactive mode (accepting Node S4 summary)
/init

# 4. Run /init workflow in automated mode to test --auto flag bypass
/init --auto

# 5. Run automated assertions
test -f agent-workspace/plans/initial/GRILL_STATUS.md && echo "ASSERT PASS: GRILL_STATUS.md present in agent-workspace/plans/initial/"
test -f agent-workspace/plans/initial/PROCESS_STATUS.md && echo "ASSERT PASS: PROCESS_STATUS.md present in agent-workspace/plans/initial/"
test -f agent-workspace/.agents/skills/.gitkeep && echo "ASSERT PASS: .gitkeep present in agent-workspace/.agents/skills/"
test -d codebase-devops/docker && echo "ASSERT PASS: codebase-devops/docker present"
test -f codebase-devops/docker/dev.Dockerfile && echo "ASSERT PASS: dev.Dockerfile present in codebase-devops/docker/"
test -f codebase-devops/docker/docker-compose.yml && echo "ASSERT PASS: docker-compose.yml present in codebase-devops/docker/"
test -f codebase-layout/src/.gitkeep && echo "ASSERT PASS: .gitkeep present in codebase-layout/src/"
test -L agent-workspace/src/devops && echo "ASSERT PASS: Relative symlink src/devops present"
test -L agent-workspace/src/layout && echo "ASSERT PASS: Relative symlink src/layout present"
test -x .git/hooks/pre-commit && echo "ASSERT PASS: Pre-commit hook executable"
```
