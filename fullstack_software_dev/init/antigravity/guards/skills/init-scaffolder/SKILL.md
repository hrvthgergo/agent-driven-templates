---
name: init-scaffolder
description: Antigravity skill for workspace scaffolding, relative symlinking, and Docker provisioning
---

# `init-scaffolder` Skill Procedure

This skill provides step-by-step procedures for scaffolding directories, provisioning `.gitkeep` files, creating relative symbolic links, and generating Docker orchestration configurations.

---

## 1. Directory Tree Scaffolding & `.gitkeep` Provisioning

1.  Create control directory: `agent-workspace/.agents/` with subfolders: `rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`.
2.  Create feature/branch planning directory: `agent-workspace/plans/<branch_name>/`.
3.  Create human documentation directory: `agent-workspace/docs/`.
4.  Create source entry point directory: `agent-workspace/src/`.
5.  Create infrastructure sub-repository: `codebase-devops/` with subfolders: `.github/workflows/`, `docker/`, `config/`, `src/`, `tests/`.
6.  Create layer sub-repositories: `codebase-layout/` and `codebase-engine/` with subfolders: `src/`, `config/`, `tests/`, `.github/workflows/`.
7.  **Provision `.gitkeep`**: Touch a `.gitkeep` file inside **every scaffolded directory node** across `agent-workspace/` and all `codebase-*` sub-repositories to ensure empty directories are tracked in Git.

---

## 2. Relative Symbolic Linking & 3-Part Verification

1.  Create relative symbolic links inside `agent-workspace/src/`:
    *   `cd agent-workspace/src && ln -s ../../codebase-devops/src devops`
    *   `cd agent-workspace/src && ln -s ../../codebase-layout/src layout`
    *   `cd agent-workspace/src && ln -s ../../codebase-engine/src engine`
2.  **Symlink Purity**: Assert that every item inside `agent-workspace/src/` is strictly a relative symlink pointing to an underlying `codebase-*` directory.
3.  **3-Part Verification Check**:
    *   Part 1: Verify link attribute (`test -L agent-workspace/src/<layer>`).
    *   Part 2: Verify active target resolution (`test -d agent-workspace/src/<layer>`).
    *   Part 3: Assert relative path format (`readlink agent-workspace/src/<layer>` starts with `../../`).

---

## 3. Hybrid Docker Scaffolding

1.  Scaffold `codebase-devops/docker/dev.Dockerfile` (agent sandbox container environment).
2.  Scaffold `codebase-devops/docker/docker-compose.yml` (multi-service local orchestrator linking `codebase-layout` and `codebase-engine`).
3.  Scaffold standalone production `Dockerfile` in `codebase-layout/Dockerfile` and `codebase-engine/Dockerfile`.
