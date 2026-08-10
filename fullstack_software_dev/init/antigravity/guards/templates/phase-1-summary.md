# Phase 1 Summary Blueprint: Architectural Overview

**Project Name**: {{PROJECT_NAME}}  
**Branch**: {{GIT_BRANCH}}  
**Date**: {{DATE}}  

---

## 1. Executive Summary & Business Goals

{{PROJECT_VISION}}

---

## 2. Architecture & Tech Stack

*   **Architecture Pattern**: {{ARCHITECTURE_PATTERN}}
*   **Layer Skeletons**:
    *   `codebase-devops`: DevOps & Container Orchestration (`.github/workflows/`, `docker/`)
    *   `codebase-layout`: UI / Frontend Layer
    *   `codebase-engine`: Backend Engine / API Layer
*   **Tech Stack**: {{TECH_STACK}}

---

## 3. Directory & Symlink Mapping

*   `agent-workspace/src/devops` $\rightarrow$ `../../codebase-devops/src`
*   `agent-workspace/src/layout` $\rightarrow$ `../../codebase-layout/src`
*   `agent-workspace/src/engine` $\rightarrow$ `../../codebase-engine/src`
