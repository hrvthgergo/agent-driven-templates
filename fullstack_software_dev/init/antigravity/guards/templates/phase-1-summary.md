# Phase 1 Summary Blueprint: Architectural Overview

**Project / Feature Name**: {{PROJECT_NAME}}  
**Branch**: {{GIT_BRANCH}}  
**Date**: {{DATE}}  
**Mode**: {{MODE}}  

---

## 1. Executive Summary & Change Scope

### Aim & Purpose
{{PROJECT_VISION_OR_AIM}}

### Issue & Ticket Reference
{{ISSUE_REFERENCE}}

### Pre-Planning Decisions & Constraints
{{PRE_PLANNING_DECISIONS}}

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
