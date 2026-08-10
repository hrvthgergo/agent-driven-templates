---
name: init
description: Bootstrapping workflow for Guards framework in Antigravity
---

# `/init` Workflow Execution Playbook

This stateful execution playbook defines the 7-node state machine governing project initialization and scaffolding within Google Antigravity.

---

## 1. Parameters & Operational Rules of Thumb

### CLI Parameter Handling
*   `/init`: Default interactive execution.
    *   **Greenfield run** (uninitialized workspace): Scaffolds base framework and creates Git branch `initial`.
    *   **Re-run** (initialized workspace without options): Treated as a **New Feature Initialization**, prompting for a feature name and creating Git branch `feature/<feature_name>`.
*   `/init --auto`: Non-interactive execution mode. Bypasses the Node S4 Execution Acceptance prompt and automatically executes all planned scaffolding tasks.
*   `/init --feature <feature_name>`: Explicitly initializes a new feature scope on Git branch `feature/<feature_name>` and creates plan subfolder `agent-workspace/plans/<feature_name>/`.
*   `/init --add-layer <layer_name>`: Introduces a new layer skeleton `codebase-<layer_name>`, registers its relative symlink under `agent-workspace/src/<layer_name>`, provisions its standalone `Dockerfile`, and updates `codebase-devops/docker/docker-compose.yml`.
*   `/init --dry-run`: Simulates the initialization sequence, previewing proposed folder structures, relative symlinks, Docker files, and plan sheets without writing changes to disk.
*   `/init --force`: Overwrites default `.agents/` control rules and workflows while preserving user custom phase blueprints.

---

## 2. Execution State Machine Nodes (S1 – S7)

### Node S1: Check Environment & Branch Initialization
1.  **Docker Healthcheck**: Execute `docker info` to verify that Docker daemon is running and accessible.
2.  **Git Context Verification**: Verify Git installation and workspace root `.git` state.
3.  **Branch Creation**:
    *   If workspace is uninitialized (greenfield): Create and check out the baseline Git branch: `git checkout -b initial`.
    *   If workspace is already initialized: Create and check out feature Git branch: `git checkout -b feature/<feature_name>`.

### Node S2: Q&A Grill Gate
1.  Invoke the neutral interview engine enforcing `rules/init-grill.md`.
2.  Sequential prompts Q1 to Q10 are executed neutrally without `[Recommended]` bias labels.
3.  Persist all questions, options, and user choices permanently into `agent-workspace/plans/<branch_name>/GRILL_STATUS.md`.

### Node S3: Lightweight Layer Scan & Linking
1.  Perform surface-level directory inspection to detect existing source or document folders.
2.  Auto-detect Git remote origin URLs from `.git/config` if present.
3.  Strictly preserve brownfield code—do NOT perform any codebase restructuring or file relocation.

### Node S4: Execution Acceptance Gate
1.  Synthesize gathered information into an understanding summary and list planned scaffolding tasks.
2.  **User Acceptance Prompt**:
    *   If `--auto` flag is present: Log automatic bypass and proceed to Node S5.
    *   If interactive mode: Present understanding summary and prompt user for explicit approval (*"Proceed with execution?"*).
3.  Log acceptance decision into `agent-workspace/plans/<branch_name>/GRILL_STATUS.md`.

### Node S5: Scaffolding Workspace & `PROCESS_STATUS.md`
1.  Invoke `skills/init-scaffolder/SKILL.md`.
2.  Scaffold `agent-workspace/` control structures (`.agents/rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`).
3.  Create feature/branch planning directory: `agent-workspace/plans/<branch_name>/`.
4.  Scaffold `codebase-devops/` sub-repository (`.github/workflows/ci.yml`, `docker/dev.Dockerfile`, `docker/docker-compose.yml`, `config/`, `Dockerfile`, `src/`, `tests/`).
5.  Scaffold layer skeletons `codebase-<layer_name>` (`src/`, `config/`, `tests/`, `Dockerfile`, `.github/workflows/`).
6.  Provision a `.gitkeep` file inside **every scaffolded directory node**.
7.  Create relative symbolic links under `agent-workspace/src/` (`devops`, `layout`, `engine` $\rightarrow$ `../../codebase-X/src`). Enforce symlink purity (zero non-symlink folders in `agent-workspace/src/`). Perform 3-part verification check.
8.  Deploy starter templates: `templates/PROCESS_STATUS.md` and `templates/phase-1-summary.md` to `agent-workspace/plans/<branch_name>/`.

### Node S6: Git Hook Registration & Remote Setup
1.  Register Git remotes based on Q4/Q5 selections.
2.  Install `hooks/pre-commit-plan-validator.sh` into `.git/hooks/pre-commit` and grant execution permissions (`chmod +x`).

### Node S7: Initialization Done
1.  Mark `/init` step as `Completed` in `agent-workspace/plans/<branch_name>/PROCESS_STATUS.md` Block 1 matrix.
2.  Record datestamped entry in Block 2 daily history.
3.  Output initialization summary and recommend next command (`/plan` or `/process-history`).
