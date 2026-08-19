---
name: init-scaffolder
description: Antigravity skill for pure control plane workspace scaffolding and gitkeep provisioning
---

# `init-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding directory structures, provisioning `.gitkeep` files, deploying process blueprints, and initializing control planes for both Greenfield/Major Feature mode and Quick & Simple mode.

---

## 1. Mode-Specific Scaffolding Procedures

### 1.1 Quick & Simple Mode Scaffolding Procedure
When `/init` runs in Quick & Simple Mode (bugfix or minor change):
1.  **Branch Creation**: Create and check out the target Git branch:
    `git checkout -b bugfix/<feature_name>` (or `feature/<feature_name>`).
2.  **Plan Directory Scaffolding**: Create `agent-workspace/plans/<feature_name>/`.
3.  **Template Deployment & Customization**:
    *   Deploy `templates/PROCESS_STATUS.md` to `agent-workspace/plans/<feature_name>/PROCESS_STATUS.md`.
    *   Deploy `templates/phase-1-summary.md` to `agent-workspace/plans/<feature_name>/phase-1-summary.md`, populating with aim, issue reference, and constraints.
    *   Save Q&A audit log to `agent-workspace/plans/<feature_name>/GRILL_STATUS.md` with `mode: quick_simple` header.
4.  **Preservation Rule**: Existing `agent-workspace/.agents/` control structures and `agent-workspace/src/` staging folders are strictly preserved without recreation.

### 1.2 Major Feature / Greenfield Mode Scaffolding Procedure
When `/init` runs in Greenfield or Major Feature Mode:
1.  **Control Plane Scaffolding**: Create `agent-workspace/.agents/` with subfolders: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`.
2.  **Plans Directory Scaffolding**: Create `agent-workspace/plans/<branch_name>/`.
3.  **Documentation & Entry Point Scaffolding**: Create empty staging directories `agent-workspace/docs/` and `agent-workspace/src/`.
4.  **Directory Preservation (`.gitkeep`)**: Touch a `.gitkeep` file inside **every scaffolded directory node** across `agent-workspace/` to ensure all empty directories are tracked in Git.
5.  **Template Deployment**: Deploy `templates/PROCESS_STATUS.md` and `templates/phase-1-summary.md` into `agent-workspace/plans/<branch_name>/`.

---

## 2. Brownfield Folder Linking Procedures

1.  If existing source code or document directories are present in the workspace, link their paths into `agent-workspace/plans/<branch_name>/phase-1-summary.md`.
2.  **Strict No-Restructuring**: Do NOT move, rename, or rewrite existing source files during `/init`. Direct legacy migration to the `/process` workflow.

---

## 3. Directory Preservation Verification Check

Verify that `.gitkeep` exists in every scaffolded directory node:
*   `test -f agent-workspace/.agents/rules/.gitkeep`
*   `test -f agent-workspace/.agents/workflows/.gitkeep`
*   `test -f agent-workspace/.agents/skills/.gitkeep`
*   `test -f agent-workspace/.agents/hooks/.gitkeep`
*   `test -f agent-workspace/.agents/sidecars/.gitkeep`
*   `test -f agent-workspace/docs/.gitkeep`
*   `test -f agent-workspace/src/.gitkeep`
