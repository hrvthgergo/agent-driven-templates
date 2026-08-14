---
name: init-scaffolder
description: Antigravity skill for dual-mode workspace scaffolding, relative symlinking, and Docker provisioning
---

# `init-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding directories, provisioning `.gitkeep` files, creating relative symbolic links, and generating Docker orchestration configurations for both Greenfield/Major Feature mode and Quick & Simple mode.

---

## 1. Mode-Specific Scaffolding Procedures

### 1.1 Quick & Simple Mode Scaffolding Procedure
When `/init` runs in Quick & Simple Mode (bugfix or minor change):
1.  **Branch Creation**: Create and check out the target Git branch:
    `git checkout -b bugfix/<feature_name>` (or `feature/<feature_name>`).
2.  **Plan Directory Scaffolding**: Create `agent-workspace/plans/<feature_name>/`.
3.  **Template Deployment & Customization**:
    *   Deploy `templates/PROCESS_STATUS.md` to `agent-workspace/plans/<feature_name>/PROCESS_STATUS.md`.
    *   Deploy `templates/phase-1-summary.md` to `agent-workspace/plans/<feature_name>/phase-1-summary.md`, populating with aim, issue reference, constraints, and inherited architecture from `agent-workspace/plans/initial/GRILL_STATUS.md`.
    *   Save Q&A audit log to `agent-workspace/plans/<feature_name>/GRILL_STATUS.md` with `mode: quick_simple` header and inherited stack data.
4.  **Preservation Rule**: Existing `codebase-*` sub-repositories, `agent-workspace/.agents/` control structures, and `agent-workspace/src/` relative symlinks are strictly preserved without recreation.

### 1.2 Major Feature / Greenfield Mode Scaffolding Procedure
When `/init` runs in Greenfield or Major Feature Mode:
1.  **Control Plane Scaffolding**: Create `agent-workspace/.agents/` with subfolders: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`.
2.  **Plans Directory Scaffolding**: Create `agent-workspace/plans/<branch_name>/`.
3.  **Documentation & Entry Point Scaffolding**: Create `agent-workspace/docs/` and `agent-workspace/src/`.
4.  **DevOps Sub-Repository**: Create `codebase-devops/` with subfolders: `.github/workflows/`, `docker/`, `config/`, `src/`, `tests/`.
5.  **Layer Sub-Repositories**: Create layer sub-repositories (e.g. `codebase-layout/`, `codebase-engine/`) with subfolders: `src/`, `config/`, `tests/`, `.github/workflows/`.
6.  **Directory Preservation (`.gitkeep`)**: Touch a `.gitkeep` file inside **every scaffolded directory node** across `agent-workspace/` and all `codebase-*` sub-repositories to ensure empty directories are tracked in Git.
7.  **Relative Symbolic Linking**: Execute pure relative symlink creation (see Section 2).
8.  **Hybrid Docker Provisioning**: Generate Docker container files (see Section 3).
9.  **Template Deployment**: Deploy `templates/PROCESS_STATUS.md` and `templates/phase-1-summary.md` into `agent-workspace/plans/<branch_name>/`.

---

## 2. Relative Symbolic Linking & 3-Part Verification

1.  Create relative symbolic links inside `agent-workspace/src/`:
    *   `cd agent-workspace/src && ln -s ../../codebase-devops/src devops`
    *   `cd agent-workspace/src && ln -s ../../codebase-layout/src layout`
    *   `cd agent-workspace/src && ln -s ../../codebase-engine/src engine`
2.  **Symlink Purity**: Assert that every item inside `agent-workspace/src/` is strictly a relative symlink pointing to an underlying `codebase-*` directory (zero non-symlink folders allowed).
3.  **3-Part Verification Check**:
    *   *Part 1 (Link Attribute)*: `test -L agent-workspace/src/<layer>`
    *   *Part 2 (Active Target Resolution)*: `test -d agent-workspace/src/<layer>`
    *   *Part 3 (Relative Path Format)*: `readlink agent-workspace/src/<layer>` starts with `../../` (asserting portability).

---

## 3. Hybrid Docker Scaffolding

1.  Scaffold `codebase-devops/docker/dev.Dockerfile` (agent sandbox container environment).
2.  Scaffold `codebase-devops/docker/docker-compose.yml` (multi-service local orchestrator linking layer sub-repositories).
3.  Scaffold standalone production `Dockerfile` in each `codebase-<layer_name>/Dockerfile`.
