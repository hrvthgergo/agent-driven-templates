# Verification & Test Specification: `/process` Action (Brownfield Scenario)

This document defines the test scenario, mock execution sequence, real-world legacy test dataset integration, user input simulation, and verification assertions for testing the `/process` action within **Google Antigravity**.

---

## 1. Test Overview & Objectives

*   **Target Action**: `/process` (Brownfield Legacy Code & Docs Processing)
*   **Target Environment**: Google Antigravity Agent Execution Environment
*   **Real-World Test Resource**: [ai-chronicle-hub](https://github.com/hrvthgergo/ai-chronicle-hub) (`https://github.com/hrvthgergo/ai-chronicle-hub.git`)
*   **Test Scenario**: Real-World Brownfield Legacy Integration & Analysis (Cloning `ai-chronicle-hub`, analyzing legacy UI/backend components, creating in-place workspace layer symlinks under `agent-workspace/src/`, staging non-code docs in `agent-workspace/plans/initial/resource/`, generating workspace code graphs, and selectively populating phase blueprints).
*   **Primary Objective**: Validate end-to-end execution of the `/process` action state machine (Nodes S0 $\rightarrow$ S6) using `ai-chronicle-hub` as test data, asserting:
    1. **Prerequisite Check (Node S0)**: Halts execution if `/init` has not been completed.
    2. **Read-Only Legacy Source Policy**: The cloned `ai-chronicle-hub` repository remains 100% untouched and unedited.
    3. **In-Place Layer Symlinks & Non-Code Docs Staging (Node S5)**: Creates symbolic links inside `agent-workspace/src/layout` and `agent-workspace/src/engine` pointing to `ai-chronicle-hub/` without copying or duplicating files, while non-code documentation and assets are staged inside `agent-workspace/plans/initial/resource/`.
    4. **On-Demand Proposal Mode (`--proposal`)**: Validates that `/process --proposal` generates `agent-workspace/plans/initial/restructure-proposal.md` and pauses for confirmation, while standard `/process` applies layer symlinks directly.
    5. **By-Request Code Graph Generation (`--code-graph`)**: When `--code-graph` flag is used, scoped code graph folders are created inside `agent-workspace/src/<layer>/code_graph/` containing `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md` with Version Stamp Headers. Skipped by default without the flag.
    6. **Selective Blueprint & Status Synthesis (Node S6)**: Selectively populates relevant phase blueprints in `agent-workspace/plans/initial/` based on identified domain knowledge (filling out all 6 is optional) and updates `PROCESS_STATUS.md` Row 2.0 to `Completed`.

---

## 2. Brownfield Test Setup & Pre-conditions

To ensure isolated, reproducible test runs, the test environment MUST execute the following setup sequence prior to action execution:

1.  **Isolated Test Sandbox**: Create and enter an isolated test execution directory (`/tmp/test-process/`).
2.  **Test Data Repository Fetching**: Clone the test dataset repository during the test cycle:
    ```bash
    git clone https://github.com/hrvthgergo/ai-chronicle-hub.git /tmp/test-process/ai-chronicle-hub
    ```
3.  **Read-Only Integrity Check Baseline**: Calculate and record MD5 checksums for all source files in `/tmp/test-process/ai-chronicle-hub/` before running the action.
4.  **Initialized Workspace Context**: Execute `/init` to bootstrap `agent-workspace/` (pure control plane with empty `src/` staging directory), create `agent-workspace/plans/initial/PROCESS_STATUS.md` (Row 1.0 `/init` marked `Completed`), and register `/tmp/test-process/ai-chronicle-hub` as the linked legacy folder in `phase-1-summary.md`.

---

## 3. Simulated Execution Sequence & Brownfield Q&A

### Command Invocation
```bash
/process
```

### Mock User Input Sequence (Q1 to Q7 Prompts for `ai-chronicle-hub`)

The test harness simulates an interactive user session responding to the sequential Q1–Q7 interview prompts enforced by `rules/process-grill.md`:

| Step | Prompt Title | Mock User Selection / Input | Asserted Output & Action |
| :--- | :--- | :--- | :--- |
| **Q1** | **`/init` Baseline Review** | Selected Option 1 (*Proceed with current baseline*). | Discovered legacy source folder (`ai-chronicle-hub`) confirmed. |
| **Q2** | **Omitted Remote Sources Audit** | Selected Option 1 (*No additional remote sources*). | Remote Git origin (`https://github.com/hrvthgergo/ai-chronicle-hub.git`) acknowledged and registered. |
| **Q3** | **Legacy Source & Non-Code Docs Mapping** | Selected Option 1 (*Accept proposed automatic classification*). | UI components mapped to `agent-workspace/src/layout/`, backend logic to `agent-workspace/src/engine/`, non-code docs to `agent-workspace/plans/initial/resource/`. |
| **Q4** | **Code Graph & Blueprint Scope** | Selected Option 1 (*Full Extraction & Workspace Code Graphs*). | Selective blueprint synthesis and `agent-workspace/src/<layer>/code_graph/` subfolder generation configured. |
| **Q5** | **Execution Mode Selection** | Selected Option 1 (*Standard Interactive Mode*). | Summarizes planned symlink creation; developer confirms execution. |
| **Q6** | **Integration Strategy** | Selected Option 1 (*In-Place Symlink Mode*). | Configures direct symlinks under `agent-workspace/src/` to existing codebase without file copies. |
| **Q7** | **Summary Verification** | Displays Q1–Q6 recap matrix. Selected Option 1 (*Execute /process action*). | Execution authorized. Symbolic links created in `agent-workspace/src/`, non-code docs staged in `resource/`, blueprints populated. |

---

## 4. Verification Assertions & Validation Matrix

Upon completion of Node S6, the test harness executes automated verification checks asserting that all physical and logical resources were scaffolded exactly as designed:

| Node | Verification Target | Asserted Resource Path | Expected State / Content Assertion |
| :--- | :--- | :--- | :--- |
| **S0** | Prerequisite Gate | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Row 1.0 (`/init`) verified as `Completed`. (If missing, execution halts). |
| **S1–S6** | Read-Only Integrity | `/tmp/test-process/ai-chronicle-hub/` | Original `ai-chronicle-hub` files 100% untouched. MD5 checksums match pre-test baseline. |
| **S4** | Proposal Mode Flag (`--proposal`) | `agent-workspace/plans/initial/restructure-proposal.md` | File exists ONLY if `/process --proposal` was invoked; documents planned mappings and symlinks. |
| **S5** | In-Place Layer Symlinks | `agent-workspace/src/layout`<br/>`agent-workspace/src/engine` | Symbolic links exist and point directly to corresponding directories in `/tmp/test-process/ai-chronicle-hub/` (`test -L` evaluates true). |
| **S5** | Resource Staging | `agent-workspace/plans/initial/resource/` | Non-code legacy documentation, schemas, and assets staged in `resource/`. |
| **S6** | By-Default (No `--code-graph` flag) | `agent-workspace/src/layout/code_graph/` | Subfolder does **NOT** exist. Code Graph skipped by default to preserve token efficiency. |
| **S6** | By-Request (`--code-graph` flag) | `agent-workspace/src/layout/code_graph/`<br/>`agent-workspace/src/engine/code_graph/` | Subfolders exist inside `src/<layer>/`. Each contains `graph.md`, `process_flow.md`, `data_flow.md`, and `risk_analysis.md` with Version Stamp Headers. |
| **S6** | Phase Blueprints | `agent-workspace/plans/initial/phase-*.md` | Relevant phase blueprint documents populated with synthesized domain knowledge extracted from `ai-chronicle-hub` (filling out blueprints is selective/relevance-based). |
| **S6** | Guard Process Status | `agent-workspace/plans/initial/PROCESS_STATUS.md` | Block 1 matrix contains Row 2.0 (`/process`) marked `Completed`. Block 2 daily history updated. |

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

# 5. Execute /process action (default in-place symlink mode)
/process

# 6a. Assert in-place layer symlinks created pointing to existing codebase
test -L agent-workspace/src/layout && echo "ASSERT PASS: agent-workspace/src/layout is a valid symlink"
test -L agent-workspace/src/engine && echo "ASSERT PASS: agent-workspace/src/engine is a valid symlink"

# 6b. Assert default behavior: code_graph skipped without --code-graph flag
test ! -d agent-workspace/src/layout/code_graph && echo "ASSERT PASS: code_graph skipped by default (token economy)"

# 6c. Optionally: run with --code-graph flag to validate on-request generation
/process --code-graph
test -f agent-workspace/src/layout/code_graph/graph.md && echo "ASSERT PASS: Workspace code_graph/graph.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/process_flow.md && echo "ASSERT PASS: Workspace code_graph/process_flow.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/data_flow.md && echo "ASSERT PASS: Workspace code_graph/data_flow.md present (on-request)"
test -f agent-workspace/src/layout/code_graph/risk_analysis.md && echo "ASSERT PASS: Workspace code_graph/risk_analysis.md present (on-request)"

# 6d. Assert legacy source code integrity (100% untouched)
md5sum -c /tmp/legacy-checksums.txt && echo "ASSERT PASS: Original ai-chronicle-hub repo 100% untouched"
```

