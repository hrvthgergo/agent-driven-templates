# Verification & Test Specification: `/process` Workflow (Brownfield Scenario)

This document defines the test scenario, mock execution sequence, real-world legacy test dataset integration, user input simulation, and verification assertions for testing the `/process` workflow within **Google Antigravity**.

---

## 1. Test Overview & Objectives

*   **Target Workflow**: `/process` (Brownfield Legacy Code & Docs Processing)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Real-World Test Resource**: [ai-chronicle-hub](https://github.com/hrvthgergo/ai-chronicle-hub) (`https://github.com/hrvthgergo/ai-chronicle-hub.git`)
*   **Test Scenario**: Real-World Brownfield Legacy Migration & Analysis (Cloning `ai-chronicle-hub`, analyzing legacy UI/backend components, staging non-code docs in `agent-workspace/plans/initial/resource/`, generating workspace code graphs, and selectively populating phase blueprints).
*   **Primary Objective**: Validate end-to-end execution of the `/process` workflow state machine (Nodes S0 $\rightarrow$ S7) using `ai-chronicle-hub` as test data, asserting:
    1. **Prerequisite Check (Step 0)**: Halts execution if `/init` has not been completed.
    2. **Read-Only Legacy Source Policy**: The cloned `ai-chronicle-hub` repository remains 100% untouched and unedited.
    3. **As-Is File Migration & Non-Code Docs Staging**: Source code from `ai-chronicle-hub` is copied intact into target `codebase-*` sub-repositories without code modifications, while non-code documentation and assets are staged inside `agent-workspace/plans/initial/resource/`.
    4. **Dual Execution Options**: Validates both Plan-First (`--plan`) and Immediate Execution (`--auto`) modes.
    5. **By-Request Code Graph Generation**: When `--code-graph` flag is used, scoped code graph folders are created inside `agent-workspace/src/<layer>/code_graph/` containing `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md` with Version Stamp Headers (keeping `codebase-*` repos clean of doc overhead, no symlinks required). Skipped by default without the flag.
    6. **Selective Blueprint & Status Synthesis**: Selectively populates relevant phase blueprints in `agent-workspace/plans/initial/` based on identified domain knowledge (filling out all 6 is optional) and updates `PROCESS_STATUS.md` Row 2.0 to `Completed`.

---

## 2. Brownfield Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST execute the following setup sequence prior to workflow execution:

1.  **Isolated Test Sandbox**: Create and enter an isolated test execution directory (`/tmp/test-process/`).
2.  **Test Data Repository Fetching**: Clone the test dataset repository during the test cycle:
    ```bash
    git clone https://github.com/hrvthgergo/ai-chronicle-hub.git /tmp/test-process/ai-chronicle-hub
    ```
3.  **Read-Only Integrity Check Baseline**: Calculate and record MD5 checksums for all source files in `/tmp/test-process/ai-chronicle-hub/` before running the workflow.
4.  **Initialized Workspace Context**: Execute `/init` to bootstrap `agent-workspace/`, scaffold `codebase-devops`, `codebase-layout`, and `codebase-engine` layer skeletons, create `agent-workspace/plans/initial/PROCESS_STATUS.md` (Row 1.0 `/init` marked `Completed`), and register `/tmp/test-process/ai-chronicle-hub` as the linked legacy folder.

---

## 3. Simulated Execution Sequence & Brownfield Q&A

### Command Invocation
```bash
/process --plan
```

### Mock User Input Sequence (Q1 to Q7 Prompts for `ai-chronicle-hub`)

The test harness simulates an interactive user session responding to the sequential Q1–Q7 interview prompts enforced by `rules/process-grill.md`:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **Q1** | **`/init` Baseline Review** | Selected Option 1 (*Proceed with current baseline*). | Discovered legacy source folder (`ai-chronicle-hub`) confirmed. |
| **Q2** | **Omitted Remote Sources Audit** | Selected Option 1 (*No additional remote sources*). | Remote Git origin (`https://github.com/hrvthgergo/ai-chronicle-hub.git`) acknowledged and registered. |
| **Q3** | **Legacy Source & Non-Code Docs Mapping** | Selected Option 1 (*Accept proposed automatic classification*). | UI components mapped to `codebase-layout/src/`, backend logic to `codebase-engine/src/`, non-code docs to `agent-workspace/plans/initial/resource/`. |
| **Q4** | **Code Graph & Blueprint Scope** | Selected Option 1 (*Full Extraction & Workspace Code Graphs*). | Selective blueprint synthesis and `agent-workspace/src/<layer>/code_graph/` subfolder generation configured. |
| **Q5** | **Execution Mode Selection** | Selected Option 1 (*Plan-First Mode --plan*). | `agent-workspace/plans/initial/restructure-proposal.md` drafted; consent gate triggered. |
| **Q6** | **Path & Link Strategy** | Selected Option 1 (*Use standard workspace symbolic links*). | Workspace symlinks verified under `agent-workspace/src/`. |
| **Q7** | **Summary Verification** | Displays Q1–Q6 recap matrix. Selected Option 1 (*Execute /process action*). | Execution authorized. Source code copied intact into `codebase-*` layers, non-code docs staged in `resource/`, Code Graphs generated, blueprints populated. |

---

## 4. Verification Assertions & Validation Matrix

Upon completion of Node S7, the test harness executes automated verification checks asserting that all physical and logical resources were scaffolded exactly as designed:

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S0** | Prerequisite Gate | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Row 1.0 (`/init`) verified as `Completed`. (If missing, execution halts). |
| **S1–S7** | Read-Only Integrity | `/tmp/test-process/ai-chronicle-hub/` | Original `ai-chronicle-hub` files 100% untouched. MD5 checksums match pre-test baseline. |
| **S4** | Migration Proposal | `agent-workspace/plans/initial/restructure-proposal.md` | File exists. Documents source mapping from `ai-chronicle-hub` to `codebase-*` sub-repos and `resource/` staging. |
| **S6** | As-Is File Migration & Resource Staging | `codebase-layout/src/`<br/>`codebase-engine/src/`<br/>`agent-workspace/plans/initial/resource/` | Source code copied intact into `codebase-*` layers. Non-code legacy documentation and assets staged in `agent-workspace/plans/initial/resource/`. |
| **S7** | By-Default (No `--code-graph` flag) | `agent-workspace/src/layout/code_graph/` | Subfolder does **NOT** exist. Code Graph skipped by default to preserve token efficiency. |
| **S7** | By-Request (`--code-graph` flag) | `agent-workspace/src/layout/code_graph/`<br/>`agent-workspace/src/engine/code_graph/` | Subfolders exist inside `src/<layer>/`. Each contains `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md` with Version Stamp Headers. Production `codebase-*` repos clean of doc overhead. |
| **S7** | Phase Blueprints | `agent-workspace/plans/initial/phase-*.md` | Relevant phase blueprint documents populated with synthesized domain knowledge extracted from `ai-chronicle-hub` (filling out blueprints is selective/relevance-based). |
| **S7** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains Row 2.0 (`/process`) marked `Completed`. Block 2 daily history updated. |

---

## 5. Automated Test Execution Script

To execute this test scenario automatically in an Antigravity sandbox:

```bash
# 1. Prepare clean test sandbox directory
mkdir -p /tmp/test-process && cd /tmp/test-process
git init

# 2. Clone test dataset repository (as part of test cycle setup)
git clone https://github.com/hrvthgergo/ai-chronicle-hub.git /tmp/test-process/ai-chronicle-hub

# 3. Calculate pre-test file checksums to assert read-only integrity
find /tmp/test-process/ai-chronicle-hub -type f -exec md5sum {} + > /tmp/legacy-checksums.txt

# 4. Run /init first to satisfy prerequisite gate and link ai-chronicle-hub
/init

# 5. Execute /process workflow (default mode - no code graph generation)
/process --plan

# 6a. Assert default behavior: code_graph skipped without --code-graph flag
test ! -d agent-workspace/src/layout/code_graph && echo "ASSERT PASS: code_graph skipped by default (token economy)"

# 6b. Optionally: run with --code-graph flag to validate on-request generation
/process --code-graph
test -f agent-workspace/src/layout/code_graph/graph.md && echo "ASSERT PASS: Workspace code_graph/graph.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/process_flow.md && echo "ASSERT PASS: Workspace code_graph/process_flow.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/data_flow.md && echo "ASSERT PASS: Workspace code_graph/data_flow.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/risk_analysis.md && echo "ASSERT PASS: Workspace code_graph/risk_analysis.md present (on-request)"
md5sum -c /tmp/legacy-checksums.txt && echo "ASSERT PASS: Original ai-chronicle-hub repo 100% untouched"
```
