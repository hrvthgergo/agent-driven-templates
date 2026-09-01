# Implementation Map: `/operate` Workflow Guards Creation (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Guards** that govern the `/operate` workflow within **Google Antigravity**. It details the planned actions and technical reasons, explicitly linking back to the documented design decisions and mapping them directly to Antigravity's native primitives (**Rules, Skills, Workflows, Hooks, and Templates**).

---

## 1. Overview & Objectives

The objective of this phase is to construct the environment-specific master guard assets for **Google Antigravity** under `actions/operate/antigravity/guards/`.

### Role of this Implementation Map vs. Universal Design Baselines
*   **Universal Design & Architectural Baselines (Platform-Agnostic)**: [operate_action.md](../operate_action.md) and [operate_questions.md](../operate_questions.md) form the platform-agnostic design specification. These baselines define the theoretical workflows, baselines, and state machine rules so they can be implemented in any AI agent environment (e.g., OpenAI Codex, Claude Code, Cursor, or Antigravity).
*   **Antigravity Implementation Guideline**: This document (`operate_implementation_map.md`) is the specific, concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
    *   **Workflows (`workflows/`)**: Stateful execution playbooks defining multi-step state machine nodes (e.g., `operate.md`).
    *   **Rules (`rules/`)**: Permanent constraint instructions enforcing baselines and prompting laws (e.g., `operate-grill.md`).
    *   **Skills (`skills/`)**: Specialized capability packages providing procedures and scripts for building images, asserting health, and executing delivery (e.g., `operate-deliver/SKILL.md`).
    *   **Templates (`templates/`)**: Standardized starter document formats deployed into `agent-workspace/plans/<feature-name>/` (e.g., `WALKTHROUGH.md`).

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

The implementation plan directly realizes the following design blueprints and `/grill-me` alignment decisions, mapped to Antigravity's native primitives:

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Pure Execution Mandate (No Authoring)** | `operate_action.md` §2.B | Rule Primitive | `rules/operate-grill.md` (Baseline 2) |
| **Fail-Closed Gates (Entry & Provenance)** | `operate_action.md` §2.A/E, `operate_questions.md` §1 | Rule & Workflow Primitives | `rules/operate-grill.md` (Baseline 1), `workflows/operate.md` (Node O2) |
| **Immutable Build & Re-Tagging Logic** | `operate_action.md` §2.E & §4 | Rule & Workflow Primitives | `rules/operate-grill.md` (Baseline 3), `workflows/operate.md` (Node O3) |
| **Automated Post-Delivery Hooks** | `operate_action.md` §5, `operate_questions.md` §1 | Rule & Workflow Primitives | `rules/operate-grill.md` (Baseline 4), `workflows/operate.md` (Node O4) |
| **Observability & Health Assertions** | `operate_action.md` §4 (O5) | Workflow & Skill Primitives | `workflows/operate.md`, `skills/operate-deliver/SKILL.md` |
| **Ops Findings Exception** | `operate_action.md` §2.D | Rule & Template Primitives | `rules/operate-grill.md`, `templates/WALKTHROUGH.md` |
| **Delivery Walkthrough Record** | `operate_action.md` §6 | Template Primitive | `templates/WALKTHROUGH.md` |
| **Process Status Synchronization** | `operate_action.md` §4 (O7) | Workflow Primitive | `workflows/operate.md` |

---

## 3. Step-by-Step Implementation Plan

### Step 1: Clean & Delete Existing Guard Assets

*   **List of Actions**:
    1.  Inspect directory `actions/operate/antigravity/guards/`.
    2.  If it exists and contains pre-existing guard files or subdirectories (`workflows/`, `rules/`, `templates/`, `skills/`), remove all existing sources inside it.
*   **Reasons & Design Decision Links**:
    *   *Clean Slate & Idempotency Guarantee*: Ensures that prior, partial, or outdated guard files are completely purged before scaffolding new master guard assets, guaranteeing a clean implementation run.

### Step 2: Scaffold Antigravity Guard Master Directory Tree

*   **List of Actions**:
    1.  Create Antigravity tier-3 guard root directory: `actions/operate/antigravity/guards/`.
    2.  Create primitive subdirectories:
        *   `actions/operate/antigravity/guards/workflows/`
        *   `actions/operate/antigravity/guards/rules/`
        *   `actions/operate/antigravity/guards/templates/`
        *   `actions/operate/antigravity/guards/skills/operate-deliver/`
*   **Reasons & Design Decision Links**:
    *   *Master Location*: Maintains master Antigravity guard primitives centrally before deployment, keeping the `/operate` implementation localized and organized.

### Step 3: Implement Stateful Workflow Playbook (`workflows/operate.md`)

*   **List of Actions**:
    1.  Create `actions/operate/antigravity/guards/workflows/operate.md`.
    2.  Define YAML frontmatter (`name: operate`, `description: Delivery and Operations workflow for Guards framework in Antigravity`).
    3.  Implement the strict 7-node sequential state machine execution nodes:
        *   **Node O1 (Target & Environment Resolution)**: Resolves `--env <name>` and `--version <vX.Y.Z>`; loads `phase-6-operation.md` Section 0 to establish the target.
        *   **Node O2 (Entry Gate & Provenance Gate)**: Evaluates gates fail-closed. Checks `QUALIFICATION_REPORT.md` certification state. If `certification: full` is required, checks digest identity against report. Halts on failure.
        *   **Node O3 (Image Build & Immutable Tagging)**: Checks `WALKTHROUGH.md` history for a source state match. Matches reuse the digest (re-tag). Unmatched states trigger a fresh build from `/implement` Dockerfiles.
        *   **Node O4 (Delivery / Promotion)**: Promotes the immutable digest to the target environment. Executes declared post-delivery hook from `phase-6-operation.md` §5 automatically.
        *   **Node O5 (Post-Deploy Observability & Health Assertion)**: Invokes `skills/operate-deliver/SKILL.md` to assert signal presence, health/readiness, and alert registration. Halts on failure. Surfaces unratified ops findings.
        *   **Node O6 (Walkthrough Record & Ops Finding Capture)**: Generates `WALKTHROUGH.md` in `agent-workspace/plans/<feature-name>/`, logging gates, digest, health, and any ops findings.
        *   **Node O7 (PROCESS_STATUS.md Sync & Handoff)**: Updates `PROCESS_STATUS.md` Row 6 to `Completed` with a datestamped entry and points to the Evolution Dialogue.
    4.  Implement CLI parameter handling: `/operate`, `/operate --env <name>`, `/operate --version <vX.Y.Z>`, `/operate --auto`, `/operate --dry-run`.
*   **Reasons & Design Decision Links**:
    *   *Strict Sequential Execution*: Implements the 7-node state machine detailed in `operate_action.md` §4.
    *   *Fail-Closed Architecture*: Evaluates Node O2 before any artifact in Node O3 is built or pushed.

### Step 4: Implement Minimal Q&A Grill Rule Guard (`rules/operate-grill.md`)

*   **List of Actions**:
    1.  Create `actions/operate/antigravity/guards/rules/operate-grill.md`.
    2.  Encode **Unchangeable Baseline Enforcement**:
        *   *Baseline 1*: Entry Gate & Provenance Gate Precedence (no `--force-gate` override exists).
        *   *Baseline 2*: No Authoring Authority (except ops findings with `origin: operate`).
        *   *Baseline 3*: Build Identity Is Keyed on Source State.
        *   *Baseline 4*: Post-Delivery Hooks Fire on Declaration.
        *   *Baseline 5*: Certification Requirement Is Inherited.
    3.  Encode **Q1–Q6 Prompts (Sequential Blueprint)**:
        *   Q1: Feature scope & target environment resolution (Skippable if `--env` supplied).
        *   Q2: Version & build action preview (build vs. reuse digest) (Skippable if `--version` supplied).
        *   Q3: Entry gate failure routing (Presented *only* on failure; no override, just remedy choices).
        *   Q4: Provenance gate mismatch routing (Presented *only* on failure).
        *   Q5: Delivery confirmation & execution mode (Skippable via `--auto` / `--dry-run`).
        *   Q6: Ops finding review (Presented *only* if O5 surfaced findings).
    4.  Encode **Audit Log Persistence**:
        *   Maintain `GRILL_STATUS.md` with header `mode: operate`.
*   **Reasons & Design Decision Links**:
    *   *Minimal Negotiation*: Implements the minimal, un-overrideable Q&A schema defined in `operate_questions.md`.

### Step 5: Implement Document Templates (`templates/WALKTHROUGH.md`)

*   **List of Actions**:
    1.  Create `actions/operate/antigravity/guards/templates/WALKTHROUGH.md`.
    2.  Implement the template sections mirroring `operate_action.md` §6:
        *   Header with feature name, environment, version, digest, gates.
        *   Section 1: Gate Results.
        *   Section 2: Certification Reference.
        *   Section 3: Observability & Health Assertion Results (Signals, Readiness, Alerts).
        *   Section 4: Delivery Actions (PR reference, Hooks executed).
        *   Section 5: Ops Findings (origin: operate, status: unratified).
*   **Reasons & Design Decision Links**:
    *   *Walkthrough Record*: Standardizes the post-delivery record as specified.

### Step 6: Implement Delivery Operations Skill (`skills/operate-deliver/SKILL.md`)

*   **List of Actions**:
    1.  Create `actions/operate/antigravity/guards/skills/operate-deliver/SKILL.md` with YAML frontmatter (`name: operate-deliver`).
    2.  Define **Build & Digest Checking Procedures**: Utilities for verifying source state changes against history and retrieving previous image digests.
    3.  Define **Promotion & Deployment Procedures**: Execution steps for pushing images without altering Dockerfiles or YAML files.
    4.  Define **Health Assertion Evaluators**: Logic to test signal presence, ping health endpoints per soak durations, and verify alert registration.
*   **Reasons & Design Decision Links**:
    *   *Execution Engine*: Encapsulates the scriptable tasks of asserting health and resolving digest hashes without granting any authoring authority (adhering to `operate_action.md` §2.B).

### Step 7: Verification & Testing

*   **List of Actions**:
    1.  Verify YAML frontmatter in `workflows/operate.md`, `rules/operate-grill.md`, and `skills/operate-deliver/SKILL.md`.
    2.  Verify structural alignment and baseline adherence against `operate_action.md`.
*   **Reasons & Design Decision Links**:
    *   *Quality Assurance*: Ensures artifacts are deployment-ready.

### Step 8: Workflow E2E Testing

*   **List of Actions**:
    1.  Execute end-to-end scenarios defined in `operate_tests.md` inside an isolated sandbox.
    2.  Assert gate failures, image reuse logic, ops finding generation, and `WALKTHROUGH.md` generation correctly map to real outcomes.
*   **Reasons & Design Decision Links**:
    *   Validates `/operate` workflow functionality against `operate_action.md` and `operate_questions.md` specifications.
