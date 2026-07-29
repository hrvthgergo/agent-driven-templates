---
name: init-scaffolder
description: Antigravity skill instructing the agent on workspace directory scaffolding, universal .gitkeep provisioning, relative symbolic linking with 3-part verification, and Hybrid Docker generation.
---

# Action Skill: Workspace Scaffolding & Multi-Repo Provisioning (`init-scaffolder`)

This skill package defines the exact procedural instructions for scaffolding repository structures, provisioning `.gitkeep` files, creating relative symbolic links with a 3-part verification check, and generating Hybrid Docker files during the `/init` workflow in Google Antigravity.

---

## Procedure 1: Directory Scaffolding & Universal `.gitkeep` Provisioning

When creating workspace structures, the agent MUST execute the following steps:

1. **Scaffold Control Directory Layout**:
   - Create `antigravity-workspace/` and `.agents/` (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/`).
   - Create `antigravity-workspace/docker/`, `antigravity-workspace/docs/`, and `antigravity-workspace/src/`.

2. **Scaffold Sub-repository Skeletons**:
   - For each layer identified in Q7 (e.g. `codebase-layout`, `codebase-engine`), create:
     - `codebase-<layer_name>/src/`
     - `codebase-<layer_name>/config/`
     - `codebase-<layer_name>/tests/`
     - `codebase-<layer_name>/.github/workflows/`

3. **Provision Universal `.gitkeep` Files**:
   - Touch `.gitkeep` inside **every created directory node** (`.agents/rules/.gitkeep`, `.agents/skills/.gitkeep`, `.agents/hooks/.gitkeep`, `.agents/sidecars/.gitkeep`, `.agents/plans/.gitkeep`, `codebase-<layer_name>/src/.gitkeep`, `codebase-<layer_name>/config/.gitkeep`, `codebase-<layer_name>/tests/.gitkeep`, etc.).
   - *Rationale*: Git tracks files rather than empty directory paths. Provisioning `.gitkeep` across all folders ensures that empty placeholder folders and sub-repo layouts are fully tracked, preserved, and synchronized on remote Git origins immediately after `/init` runs.

---

## Procedure 2: Relative Symbolic Linking & 3-Part Verification

1. **Create Relative Symlinks**:
   - Navigate to `antigravity-workspace/src/`.
   - Create relative symbolic link pointing to the corresponding sub-repository source directory:
     ```bash
     ln -s ../../codebase-<layer_name>/src <layer_alias>
     ```

2. **Execute Mandatory 3-Part Verification Check**:
   - For every created symlink, run the 3-part verification test:
     1. **Attribute Assertion**: Check that the link attribute exists:
        ```bash
        test -L antigravity-workspace/src/<layer_alias>
        ```
     2. **Active Target Resolution**: Confirm that the symlink target resolves to an active, valid directory (catching dangling links):
        ```bash
        test -d antigravity-workspace/src/<layer_alias>
        ```
     3. **Relative Path Assertion**: Assert that the link target uses relative rather than absolute pathing for cross-machine and CI/CD portability:
        ```bash
        TARGET=$(readlink antigravity-workspace/src/<layer_alias>)
        [[ "$TARGET" != /* ]] || { echo "[ERROR] Symlink is absolute!"; exit 1; }
        ```

---

## Procedure 3: Hybrid Docker Provisioning

1. **Scaffold Orchestrator Sandbox (`antigravity-workspace/docker/dev.Dockerfile`)**:
   - Create multi-stage development container spec for agent execution.

2. **Scaffold Orchestrator Compose (`antigravity-workspace/docker/docker-compose.yml`)**:
   - Create docker-compose configuration linking sub-repository services and volume mounts:
     ```yaml
     version: '3.8'
     services:
       dev-sandbox:
         build:
           context: .
           dockerfile: dev.Dockerfile
         volumes:
           - ../../:/workspace
       layer-layout:
         build:
           context: ../../codebase-layout
           dockerfile: Dockerfile
       layer-engine:
         build:
           context: ../../codebase-engine
           dockerfile: Dockerfile
     ```

3. **Scaffold Standalone Layer Dockerfiles**:
   - Provision standalone `Dockerfile` inside each `codebase-<layer_name>` sub-repository root.

---

## Procedure 4: Brownfield Folder Linking (No Code Restructuring)

1. **Surface Folder Linking**:
   - For brownfield projects with pre-existing source code or documentation folders, create relative symlinks under `antigravity-workspace/src/` or `antigravity-workspace/docs/` pointing to existing folders.
2. **Strict Non-Interference Constraint**:
   - **DO NOT perform deep code analysis, refactoring, or file moving during `/init`**. All codebase restructuring is strictly decoupled into `/process-history`.
