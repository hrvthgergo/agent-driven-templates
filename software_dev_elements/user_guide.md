# Guards Framework: End-User Guide & Operational Manual

This document serves as the official user guide for the **Guards Framework**, explaining how developers and AI agents navigate the software planning and development lifecycle step by step.

---

## 1. Executive Summary & Framework Lifecycle

The Guards Framework enforces a disciplined, token-optimized, and safe development process for both new (greenfield) projects and existing (brownfield) codebases. The operational journey follows a clear, sequential flow:

```mermaid
graph TD
    Start([Development Goal]) --> Init["1. Initialization (/init)<br/>• Bootstraps Agentic, Software & Folder Environments<br/>• Establishes Git branch & PROCESS_STATUS.md<br/>• Makes zero code or logic changes"]
    
    Init --> CheckType{Brownfield Legacy Code?}
    
    CheckType -->|Yes: Existing Legacy Code/Docs| Process["2. Legacy Processing (/process)<br/>• Ingests previous design & code intact<br/>• Stages legacy docs into feature resource folders<br/>• Generates workspace Code Graphs"]
    CheckType -->|No: Greenfield or Clean Feature| Plan["3. Interactive Planning (/plan)<br/>• Synthesizes feature understanding<br/>• Conducts Q&A Grill session & system impact analysis<br/>• Generates Phase Blueprints & ADRs for downstream agents"]
    
    Process --> Plan
    
    Plan --> Implement["4. Action Implementation (/implement)<br/>• Scaffolds code logic & UI components<br/>• Updates general system docs & code graphs"]
    
    Implement --> Qualify["5. Release Qualification (/qualify)<br/>• Runs unit, integration, and E2E tests"]
    
    Qualify --> Release["6. Release & Operations (/release)<br/>• Builds Docker images & creates PRs"]
```

---

## 2. Core Workflow Principles

### Phase 1: Environment Initialization (`/init`)
- **Universal Entry Point**: Every development activity **always** begins with the `/init` workflow—whether bootstrapping a greenfield software project from scratch or extending an existing system with new feature capabilities.
- **Preparation of the Three Environments**: `/init` prepares the three core framework environments for the upcoming work:
  - **Agentic Environment**: Provisions `.agents/` control structures (rules, workflows, skills, hooks, sidecars).
  - **Software-Based Environment**: Asserts Docker engine status, container privileges, and execution sandbox settings.
  - **Folder-Based Environment**: Establishes Git branches (`initial` or `feature/<name>`), scaffolds layer skeletons (`codebase-*`), and deploys status tracking sheets (`PROCESS_STATUS.md`).
- **Strict Boundary Rule**: `/init` limits its scope strictly to environment setup and high-level folder linking. It **does not make any code, logic, or structural refactoring changes** to the codebase.

### Phase 2: Ingestion of Existing Systems (`/process`)
- **Brownfield Context Ingestion**: For projects that possess pre-designed or previously implemented code and documentation from past development, `/process` runs immediately after `/init`.
- **Structured Knowledge Organization**: `/process` ingests, analyzes, and reorganizes previous design artifacts and implementation sources:
  - **Intact Source Migration**: Copies legacy source code intact into target `codebase-*` sub-repositories without modifying code logic.
  - **Resource Staging**: Stages non-code legacy documentation and assets into `.agents/plans/<feature-name>/resource/` for feature reference.
  - **Code Graph Generation**: Builds workspace-scoped Code Graphs (`antigravity-workspace/src/<layer>/code_graph/`) detailing structural node topologies.

### Phase 3: Structured Feature Planning (`/plan`)
- **Architectural Bridge**: Once `/init` (and `/process`, if applicable) finishes successfully, the workspace is structured and ready for architectural design. This is where the `/plan` workflow begins.
- **Downstream Agent Guidance**: All planning artifacts are stored inside `.agents/plans/<feature-name>/` to share complete, unambiguous context with AI agents executing downstream implementation (`/implement`), qualification (`/qualify`), and deployment (`/release`).

### Phase 4: Action Implementation (`/implement`)
- **Execution Engine & Highest Complexity**: `/implement` is the most complex workflow in the framework lifecycle, responsible for physical code creation across `codebase-*` sub-repositories.
- **Mandatory Dual Grounding & First Action**: Every implementation MUST stand on both an `implementation_map_v<version>.md` AND a Verification Scope (`phase-5-test.md`). The very first action when `/implement` is invoked is verifying these two resources.
- **Structured 4-Part Step Schema**: Scaffolding steps follow a strict 4-part structure (Requirement, Prerequisites, Actions, Verification) and are categorized into Sequential vs. Parallel execution streams.
- **Visible Step-by-Step Execution**: Scaffolding runs in a transparent, followable loop where the user can interrupt, ask questions, or request clarification at any time (no opaque subagent delegation).
- **Mandatory Inner Agent Artifact Synchronization**: All decisions, plan updates, and conversation outcomes recorded in inner agent docs (Artifacts) MUST be immediately synchronized and written into version-controlled files under `.agents/plans/<feature-name>/`.
- **Token Economy Guard**: AST Code Graph (`src/<layer>/code_graph/`) and System Documentation (`docs/`) updates are optional add-ons (`--code-graph`, `--docs`) to prevent token bloat during routine code scaffolding.

### Phase 5: Release Qualification (`/qualify`)
- **Holistic Quality Assurance**: `/qualify` acts as the mandatory quality gate and defect attribution engine before any code can be packaged or deployed.
- **Three-Pillar Testing Architecture**: Separates living test governance (`agent-workspace/tests/`), test execution code (`codebase-qualify/`), and environment orchestration (`codebase-devops/`).
- **Comprehensive Lifecycle Supervision**: Supervises all testing tiers (layer unit tests, cross-layer contract suites, E2E browser flows, and regression catalogs), performs multi-layer defect attribution, and generates audit artifacts (`QUALIFICATION_REPORT.md` and `qualification_log.json`).

### Phase 6: Release & Operations (`/release`)
- **Production Packaging & Deployment**: Builds production-ready Docker containers, generates Git release tags, opens pull requests, produces walkthrough summaries, and coordinates deployment handoffs.

---

## 3. Workflow Mindsets & The Guiding Questions Model

A cornerstone of the Guards Framework is that **every workflow answers a fundamentally different question and requires a distinct cognitive mindset**:

| Workflow | The Guiding Question | Cognitive Mindset | Core Responsibility & Boundaries |
| :--- | :--- | :--- | :--- |
| **`/init`** | **"Where and how do we work?"** | **System Administrator** | Bootstraps environments, sandboxes, layer skeletons, and tracking sheets. Makes zero code edits. |
| **`/process`** | **"What already exists?"** | **Archaeologist & Analyst** | Ingests brownfield legacy code intact, stages reference docs, and generates code graphs. |
| **`/plan`** | **"What should the system do?"** | **Architect & Designer** | Designs blueprints across 6 phases (including `phase-5-test.md`), analyzes system impact, and drafts implementation maps. |
| **`/implement`** | **"Does my code work?"** | **Software Engineer** | Scaffolds code layer-by-layer and writes unit tests in `codebase-*/tests/` to verify local logic in isolation. |
| **`/qualify`** | **"Does the whole system work?"** | **Quality Engineer (QA)** | Runs cross-layer integration, E2E scenarios, and regression suites (`codebase-qualify/` & `tests/`), attributes defects, and gates release. |
| **`/release`** | **"Is the system delivered?"** | **Release & DevOps Operator** | Builds production Docker images, tags release versions, generates audit walkthroughs, and creates pull requests. |

### Clear Separation of Testing Concerns

- **The Architect (`/plan`)** asks: *"What needs testing?"* $\rightarrow$ Defines requirements in `phase-5-test.md` and master scenarios in `agent-workspace/tests/`.
- **The Developer (`/implement`)** asks: *"Does my code work?"* $\rightarrow$ Scaffolds unit tests co-located in `codebase-<layer>/tests/` to verify components in isolation.
- **The Quality Engineer (`/qualify`)** asks: *"Does the whole system work?"* $\rightarrow$ Implements cross-layer harnesses in `codebase-qualify/`, boots environments, executes full matrices, isolates defect root causes, and certifies release readiness.

---

## 4. Workflow Context Notification Law (Combined Multi-Layer Strategy)

To ensure complete transparency and context awareness during pair programming sessions, the framework enforces a mandatory **3-Layer Workflow Context Notification Law**:

1. **Layer 1: Turn-by-Turn Response Banner Header**: Every AI agent response during an active workflow MUST open with a 1-line markdown banner header before any regular text or tool output:
   > 📍 **Active Workflow**: `/<workflow_name>` | **Scope**: `<branch_or_feature>` | **Node**: `<Node_ID> (<Node_Name>)`
2. **Layer 2: State Machine Node Transition Badges**: Playbooks MUST print a stylized text/markdown box upon entering any new state machine node (e.g. Node S2 $\rightarrow$ Node S3):
   ```text
   ┌──────────────────────────────────────────────────────────────────────────────┐
   │  WORKFLOW STEP TRANSITION: /process                                          │
   │  Current Node: Node S3 - Q&A Grill Gate                                      │
   │  Target Branch: feature/payment-gateway  | Status: In Progress               │
   └──────────────────────────────────────────────────────────────────────────────┘
   ```
3. **Layer 3: Persistent Disk Header Metadata**: Status tracking sheets (`PROCESS_STATUS.md`, `GRILL_STATUS.md`, `restructure-proposal.md`, `phase-1-summary.md`) MUST contain top-level metadata recording active workflow state, current node, git branch/feature scope, and datestamp.

---

## 5. Overview of the Three Core Environments

The framework coordinates three distinct execution layers during initialization and planning:

| Environment | Purpose | Core Components Scaffolded / Governed |
| :--- | :--- | :--- |
| **Agentic Environment** | Governs AI agent execution, constraints, and tool access. | `.agents/rules/`, `.agents/workflows/`, `skills/`, `hooks/`, `sidecars/` |
| **Software-Based Environment** | Asserts containerized runtime, build privileges, and tool protocols. | Docker verification (`docker info`), `dev.Dockerfile`, `docker-compose.yml`, MCP configs |
| **Folder-Based Environment** | Maintains physical code separation, symlink maps, and feature tracking. | `codebase-*` layer skeletons, `src/` symlink maps, `.agents/plans/<feature-name>/`, `PROCESS_STATUS.md` |

---

## 6. Next Steps & Guide Extensions

This initial version of the User Guide establishes the core operational mental model and workflow sequencing. As feature development progresses, subsequent sections will expand to include:
- Step-by-step CLI usage guides and flag reference tables (`--auto`, `--plan`, `--dry-run`, `--scope`, `--coverage`).
- Greenfield vs. Brownfield operational walkthroughs.
- Detailed guidelines for downstream execution workflows (`/implement`, `/qualify`, `/release`).
