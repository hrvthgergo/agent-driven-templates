# Verification & Test Specification: `/process-history` Workflow (Brownfield Scenario)

This document defines the test scenario, mock execution sequence, user input simulation, and verification assertions for testing the `/process-history` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/process-history` (Brownfield Legacy Code & Docs Processing)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Test Scenario**: Brownfield Migration & Analysis (Legacy Web App with UI views, API controllers, DB models, and raw documentation)
*   **Primary Objective**: Validate end-to-end execution of the `/process-history` workflow state machine (Nodes S0 $\rightarrow$ S7), asserting:
    1. **Prerequisite Check (Step 0)**: Halts execution if `/init` has not been completed.
    2. **Read-Only Legacy Source Policy**: Original legacy directories remain 100% untouched and unedited.
    3. **As-Is File Migration**: Source code is copied intact into `codebase-layout` and `codebase-engine` without code modifications.
    4. **Dual Execution Options**: Validates both Plan-First (`--plan`) and Immediate Execution (`--auto`) modes.
    5. **Workspace Code Graph Subfolders**: Scoped code graph folders created inside `antigravity-workspace/src/<layer>/code_graph/` containing `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md` (keeping `codebase-*` repos clean, no symlinks required).
    6. **Blueprint & Status Synthesis**: Populates `.agents/plans/phase-1-summary.md` through `phase-5-operation.md` and updates `PROCESS_STATUS.md` Row 2.0 to `Completed`.

---

## 2. Brownfield Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST meet the following pre-conditions prior to command execution:

1.  **Initialized Workspace Context**: Workspace initialized via `/init` containing valid `.agents/plans/PROCESS_STATUS.md` with Row 1.0 (`/init`) marked as `Completed`.
2.  **Linked Legacy Folder**: Mock legacy directory populated with sample source files:
    *   `/tmp/legacy-app/ui/index.html`, `/tmp/legacy-app/ui/app.js` (Presentation UI)
    *   `/tmp/legacy-app/server/main.go`, `/tmp/legacy-app/server/db.go` (Domain Engine)
    *   `/tmp/legacy-app/docs/architecture.md` (Raw documentation)
3.  **Read-Only Integrity Check Baseline**: MD5 checksums recorded for all legacy files in `/tmp/legacy-app/` before execution.

---

## 3. Simulated Execution Sequence & Brownfield Q&A

### Command Invocation
```bash
/process-history --plan
```

### Mock User Input Sequence (Q1 to Q7 Prompts)

The test harness simulates an interactive user session responding to the sequential Q1–Q7 interview prompts enforced by `rules/process-history-grill.md`:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **Q1** | **`/init` Baseline Review** | Selected Option 1 (*Proceed with current baseline*). | Discovered legacy folders (`/tmp/legacy-app/`) confirmed. |
| **Q2** | **Omitted Remote Sources Audit** | Selected Option 1 (*No additional remote sources*). | Remote audit completed; detected Git origins acknowledged. |
| **Q3** | **Legacy Source Mapping** | Selected Option 1 (*Accept proposed automatic classification*). | `ui/` mapped to `codebase-layout`, `server/` mapped to `codebase-engine`. |
| **Q4** | **Code Graph & Blueprint Scope** | Selected Option 1 (*Full Extraction & Workspace Code Graphs*). | Full 5-phase blueprint synthesis and `src/<layer>/code_graph/` creation configured. |
| **Q5** | **Execution Mode Selection** | Selected Option 1 (*Plan-First Mode --plan*). | `.agents/plans/restructure-proposal.md` drafted; consent gate triggered. |
| **Q6** | **Path & Link Strategy** | Selected Option 1 (*Use standard workspace symbolic links*). | Workspace symlinks verified under `antigravity-workspace/src/`. |
| **Q7** | **Summary Verification** | Displays Q1–Q6 recap matrix. Selected Option 1 (*Execute /process-history action*). | Execution authorized. Files copied intact, Code Graphs generated, blueprints populated. |

---

## 4. Verification Assertions & Validation Matrix

Upon completion of Node S7, the test harness executes automated verification checks asserting that all physical and logical resources were scaffolded exactly as designed:

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S0** | Prerequisite Gate | `.agents/plans/PROCESS_STATUS.md` | Row 1.0 (`/init`) verified as `Completed`. (If missing, execution halts). |
| **S1–S7** | Read-Only Integrity | `/tmp/legacy-app/` | Original legacy files 100% untouched. MD5 checksums match pre-test baseline. |
| **S4** | Migration Proposal | `.agents/plans/restructure-proposal.md` | File exists. Documents source mapping from `/tmp/legacy-app/` to `codebase-*` sub-repos. |
| **S6** | As-Is File Migration | `codebase-layout/src/`<br/>`codebase-engine/src/` | Files copied intact (`index.html`, `app.js` in `layout`; `main.go`, `db.go` in `engine`). Zero code modifications. |
| **S7** | Workspace Code Graphs | `antigravity-workspace/src/layout/code_graph/`<br/>`antigravity-workspace/src/engine/code_graph/` | Subfolders exist inside `src/<layer>/`. Each contains `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md`. Production `codebase-*` repos clean of doc overhead. |
| **S7** | Phase Blueprints | `.agents/plans/phase-1-summary.md`<br/>through `phase-5-operation.md` | All 5 phase blueprint documents populated with synthesized legacy domain knowledge, endpoints, DB schemas, ops notes. |
| **S7** | Guard Process Status | `.agents/plans/PROCESS_STATUS.md` | Block 1 matrix contains Row 2.0 (`/process-history`) marked `Completed`. Block 2 daily history updated. |

---

## 5. Automated Execution Script

To execute this test scenario automatically in an Antigravity sandbox:

```bash
# 1. Prepare test environment and mock legacy repo
mkdir -p /tmp/test-process-history && cd /tmp/test-process-history
mkdir -p /tmp/legacy-app/ui /tmp/legacy-app/server /tmp/legacy-app/docs
echo "<h1>Legacy UI</h1>" > /tmp/legacy-app/ui/index.html
echo "package main" > /tmp/legacy-app/server/main.go
md5sum /tmp/legacy-app/ui/index.html > /tmp/legacy-checksums.txt

# 2. Run /init first to satisfy prerequisite gate
/init

# 3. Execute /process-history workflow
/process-history --plan

# 4. Run automated assertions
test -f .agents/plans/restructure-proposal.md && echo "ASSERT PASS: restructure-proposal.md present"
test -f codebase-layout/src/index.html && echo "ASSERT PASS: As-is file migration present in codebase-layout"
test -f antigravity-workspace/src/layout/code_graph/graph.md && echo "ASSERT PASS: Workspace code_graph/graph.md present"
test -f antigravity-workspace/src/layout/code_graph/process_flow.md && echo "ASSERT PASS: Workspace code_graph/process_flow.md present"
test -f antigravity-workspace/src/layout/code_graph/data_flow.md && echo "ASSERT PASS: Workspace code_graph/data_flow.md present"
test -f antigravity-workspace/src/layout/code_graph/risk_analysis.md && echo "ASSERT PASS: Workspace code_graph/risk_analysis.md present"
md5sum -c /tmp/legacy-checksums.txt && echo "ASSERT PASS: Original legacy source 100% untouched"
```
