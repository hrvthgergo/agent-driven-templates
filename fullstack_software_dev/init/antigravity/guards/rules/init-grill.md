---
name: init-grill
description: Rule guard governing the sequential Q1–Q10 interview engine, baseline enforcement, neutral choice laws, and permanent audit logging in Google Antigravity.
---

# Rule Guard: `/init` Q&A Grill Engine

This rule guard defines the strict laws, baselines, question execution sequence, and permanent audit logging rules that govern the interactive interview during the `/init` workflow in Google Antigravity.

---

## 1. Solid Unchangeable Baselines (Zero Questions Asked)

The agent MUST enforce the following two architectural baselines without prompting the user or asking for confirmation:

1. **Baseline 1: The Hybrid Docker Handling Strategy**:
   - Central orchestrator setup (`antigravity-workspace/docker/dev.Dockerfile` for agent sandbox + `antigravity-workspace/docker/docker-compose.yml` for multi-service linking) combined with standalone `Dockerfile` specs in each `codebase-<layer_name>` sub-repository.
2. **Baseline 2: Standard Guards Folder Layout**:
   - Standard 3-tier layout with `.agents/` control directories (`rules/`, `workflows/`, `skills/`, `hooks/`, `sidecars/`, `plans/`) and universal `.gitkeep` directory preservation.

---

## 2. Neutral Prompting Law

When asking questions during the `/init` Grill session, the agent MUST strictly adhere to the following prompting constraints:

- **FORBID `[Recommended]` Tags**: DO NOT use `[Recommended]` or any biased leading markers on any choice option. All options must be presented in a completely neutral, list-based manner.
- **MANDATORY Free-Text Choice**: Every question's option list MUST conclude with a free-text choice option: `Other / Free-text (...)` allowing the user to provide custom inputs or describe specific requirements.

---

## 3. Sequential Q1–Q10 Question Execution Schema

---

### Question Q1: Project Scope, Purpose, & Key Milestones
- **Context**: Discovers high-level vision and objectives.
- **Options**:
  1. Fullstack web application
  2. Backend API service / microservice
  3. Frontend client / UI library
  4. Other / Free-text (...)

---

### Question Q2: Local System Folders & Workspace Path
- **Context**: Defines workspace location.
- **Q2.a Path Listing & Auto-Detection**:
  - Prompt ONLY for local folder paths.
  - DO NOT ask for remote origin URLs in Q2.a. If the specified directory is controlled by a version handling system (`.git`), auto-detect the remote origin directly from `.git/config`.
- **Q2.b Options**:
  1. Current working directory (`./`)
  2. Create a new sub-folder path
  3. Other / Free-text (...)

---

### Question Q3: Cloud Documentation Repositories
- **Context**: Checks for external documentation repositories.
- **Mandatory Scan Failure Statement**:
  - Before asking Q3, the agent MUST explicitly state to the user whether local scanning found any documentation repositories:
    > *"Scanning local workspace files found no external documentation repository. Please specify if external cloud documentation exists:"*
- **Options**:
  1. GitHub Wiki / Notion / Confluence URL
  2. Existing local `docs/` folder
  3. Google Docs / External link
  4. No external documentation repository
  5. Other / Free-text (...)

---

### Question Q4: Additional Remote Repositories
- **Context**: Discovers secondary remote code repositories.
- **Options**:
  1. Add secondary Git remote repository URL
  2. No (Single remote repository only)
  3. Other / Free-text (...)

---

### Question Q5: Cloud Git Provider & Pre-created Project Check
- **Context**: Identifies Git host platform.
- **Options**:
  1. GitHub
  2. GitLab
  3. Bitbucket
  4. Other / Free-text (...)
- **Q5.a Sub-question**:
  - *Has a remote project/repository already been created on the provider?*
  1. Yes (Provide remote origin URL)
  2. No pre-created project
  3. Other / Free-text (...)

---

### Question Q6: Software Architecture Pattern
- **Context**: Establishes structural design pattern.
- **Options**:
  1. Modular Monolith / Layered Architecture
  2. Microservices Architecture
  3. Component-based Frontend / Single Page App
  4. Other / Free-text (...)

---

### Question Q7: Layer Scope & Sub-repository Skeletons
- **Context**: Determines initial `codebase-*` sub-repository layer scope.
- **Options**:
  1. Fullstack (UI Layout + Backend Engine) $\rightarrow$ Skeletons: `codebase-layout` & `codebase-engine`
  2. UI Only $\rightarrow$ Skeleton: `codebase-layout`
  3. Backend Only $\rightarrow$ Skeleton: `codebase-engine`
  4. Multi-Layer / Custom Scope
  5. Other / Free-text (...)

---

### Question Q8: Software Stack & Frameworks
- **Context**: Specifies programming languages, frameworks, and databases per layer.
- **Options**:
  1. Node.js / TypeScript + React / Next.js
  2. Python / FastAPI / Django + PostgreSQL
  3. Go + PostgreSQL / Redis
  4. Other / Free-text (...)

---

### Question Q9: Agent Guidance Rules & Tooling
- **Context**: Selects guard rule capabilities and tools.
- **Options**:
  1. Standard Guards framework defaults (`.agents/` directory)
  2. Custom rule set
  3. Other / Free-text (...)

---

### Question Q10: Q&A Summary Verification & Open Reflection
- **Context**: Summarizes all answers from Q1 through Q9 in a structured recap matrix and allows open user reflection before finalizing initialization.
- **Recap Matrix Format**:
  | Question | Summary of Answers / Choices |
  | :--- | :--- |
  | Q1: Scope & Purpose | [User Answer] |
  | Q2: Local Folders | [User Answer] (Remote origin auto-detected: [Config URL]) |
  | Q3: Cloud Docs | [User Answer] |
  | Q4: Remotes | [User Answer] |
  | Q5: Git Provider | [User Answer] |
  | Q6: Architecture | [User Answer] |
  | Q7: Layer Scope | [User Answer] |
  | Q8: Tech Stack | [User Answer] |
  | Q9: Guiders | [User Answer] |
- **Prompt**:
  - *"Please review the summary matrix above. Do you have any additional information, notes, or modifications to add before we finalize `/init`?"*
- **Options**:
  1. Everything is accurate $\rightarrow$ Proceed to finalize `/init`
  2. Modify a specific answer (Specify question number)
  3. Add additional reflection / free-text notes (...)

---

## 4. Permanent Audit Log Persistence (`GRILL_STATUS.md`)

Upon completion of Question Q10:
1. Write the full transcript of all 10 questions, options, user choices, and free-text notes into **`.agents/plans/GRILL_STATUS.md`**.
2. Retain `.agents/plans/GRILL_STATUS.md` permanently alongside `PROCESS_STATUS.md` as an immutable audit log of the initialization interview session.
