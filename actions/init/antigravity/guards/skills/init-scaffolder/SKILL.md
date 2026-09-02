---
name: init-scaffolder
description: Antigravity skill for pure control plane workspace scaffolding and gitkeep provisioning
---

# `init-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding directory structures, provisioning `.gitkeep` files, deploying process blueprints, and initializing control planes under `agent-workspace/`.

---

## 1. Control Plane Scaffolding Procedures

When `/init` executes Node S5 workspace scaffolding:
1.  **Control Plane Scaffolding**: Create `agent-workspace/.agents/` with subfolders: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`.
2.  **Plans Directory Scaffolding**: Create `agent-workspace/plans/<scope_name>/` (e.g. `agent-workspace/plans/initial/` or `agent-workspace/plans/<feature_name>/`).
3.  **Documentation & Entry Point Scaffolding**: Create staging directories `agent-workspace/docs/` and `agent-workspace/src/`.
4.  **Directory Preservation (`.gitkeep`)**: Touch a `.gitkeep` file inside **every scaffolded directory node** across `agent-workspace/` to guarantee all empty directories are tracked in Git.
5.  **Template Deployment**: Deploy `templates/PROCESS_STATUS.md` and `templates/phase-1-summary.md` into `agent-workspace/plans/<scope_name>/`.

---

## 2. Brownfield Folder Linking Procedures

1.  If existing source code or document directories are present in the workspace, link their paths into `agent-workspace/plans/<scope_name>/phase-1-summary.md`.
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
