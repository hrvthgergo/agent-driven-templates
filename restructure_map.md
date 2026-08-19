# Guards Framework: Restructure Map

This document defines the complete, ordered restructuring plan to reframe the Guards Framework from
its current "workflow" terminology into the new three-tier domain model:

> **Playbooks** orchestrate **Actions**. Actions are invoked through **Commands**.

All steps must be executed in the order listed. Step 1 (branch creation) is a prerequisite for all
subsequent steps. No modifications to any file or folder should be made outside of this plan.

---

## The New Domain Model (Reference)

| Tier | Term | Definition | Examples |
|:---|:---|:---|:---|
| **Tier 1** | **Playbook** | An orchestrated composition of actions with branching logic and feedback loops | "Greenfield Development Playbook", "Brownfield Onboarding Playbook" |
| **Tier 2** | **Action** | A self-contained, independently invocable lifecycle element with a single guiding question and cognitive persona | `/init`, `/plan`, `/implement`, `/qualify`, `/release`, `/process` |
| **Tier 3** | **Command** | A parametrized invocation of an action — a specific mode, flag, or building block within an action | `/init --release vX.Y.Z`, `/init --feature payment-gateway`, `/implement --code-graph`, `/implement --docs` |

---

## Step 1 — Create the Restructure Branch

**Type**: Git operation  
**Prerequisite**: None  
**Purpose**: Isolate all restructuring work from `main`. All subsequent steps execute on this branch.

```bash
git checkout -b restructure/actions-commands-playbooks
```

---

## Step 2 — Rename the Root Folder `software_dev_elements/` → `actions/`

**Type**: Directory rename  
**Prerequisite**: Step 1  
**Purpose**: The root container currently named `software_dev_elements` implies a vague "elements"
concept. The new name `actions/` directly expresses that this folder contains the six lifecycle
actions — each independently invocable by the user or an orchestrating agent.

```
BEFORE: software_dev_elements/
AFTER:  actions/
```

> [!NOTE]
> All internal subfolders (`init/`, `plan/`, `implement/`, `process/`, `qualify/`, `release/`)
> retain their names. The action names are already correct — only the container is renamed.

---

## Step 3 — Rename `*_workflow.md` Files → `*_action.md` Inside Each Action Folder

**Type**: File renames (6 files)  
**Prerequisite**: Step 2  
**Purpose**: Each action folder currently contains a primary specification file named
`<action>_workflow.md`. This name implies the file describes a workflow, but its actual content
is the action's specification: its guiding question, cognitive persona, internal steps (nodes),
preconditions, outputs, and guard definitions. Renaming to `<action>_action.md` aligns the file
name with its true role as the **authoritative action specification**.

| Before | After |
|:---|:---|
| `actions/init/init_workflow.md` | `actions/init/init_action.md` |
| `actions/process/process_workflow.md` | `actions/process/process_action.md` |
| `actions/plan/plan_workflow.md` | `actions/plan/plan_action.md` |
| `actions/implement/implement_workflow.md` | `actions/implement/implement_action.md` |
| `actions/qualify/qualify_workflow.md` | `actions/qualify/qualify_action.md` |
| `actions/release/release_workflow.md` | `actions/release/release_action.md` |

---

## Step 4 — Add a Commands Reference Section to Each `*_action.md`

**Type**: Content addition (6 files)  
**Prerequisite**: Step 3  
**Purpose**: Each action needs an explicit catalogue of its available commands — the parametrized
invocations a user or agent can issue. This section does not replace the existing internal step
nodes; it surfaces the user-facing entry points to the action.

For each `*_action.md`, add a dedicated **Commands Reference** section that lists:
- The base command (no flags — default mode)
- All supported flag variants (named commands), each with:
  - Its full invocation syntax
  - A one-line description of what it does / what mode it activates
  - Any preconditions or incompatibilities with other flags

**Example structure to add to `init_action.md`**:

```markdown
## Commands Reference

| Command | Description |
|:---|:---|
| `/init` | Default initialization — bootstraps a greenfield project from scratch |
| `/init --feature <feature-name>` | Initializes a new feature branch and scaffolds feature-scoped tracking |
| `/init --release <vX.Y.Z>` | Initializes a release branch and prepares release-scoped PROCESS_STATUS.md |
```

> [!NOTE]
> The specific commands for each action must be derived from the existing content of each
> `*_action.md` (formerly `*_workflow.md`). Flags and modes already described in the document
> body should be surfaced into this Commands Reference section — no new behaviour is invented.

---

## Step 5 — Populate the `playbooks/` Directory

**Type**: New file creation  
**Prerequisite**: Step 2 (the `actions/` folder must exist so playbooks can reference it)  
**Purpose**: The `playbooks/` directory currently exists but is empty (only a `.gitkeep`). Now
that actions are clearly defined, playbooks can be authored as compositions of those actions.

Each playbook is a markdown document that:
- Names a specific development scenario (e.g., "Greenfield", "Brownfield", "Hotfix")
- Describes the sequence and branching logic of actions to invoke
- References actions by their folder path under `actions/`
- Specifies which commands within each action to issue at each step

**Playbooks to create** (one per primary development scenario):

| File | Scenario |
|:---|:---|
| `playbooks/greenfield_playbook.md` | New project from scratch |
| `playbooks/brownfield_playbook.md` | Existing codebase onboarding |
| `playbooks/feature_playbook.md` | Incremental new feature on an existing project |
| `playbooks/hotfix_playbook.md` | Expedited patch on a released version |

> [!NOTE]
> The content for these playbooks already exists implicitly in `summary.md`, `user_guide.md`,
> and the mermaid lifecycle diagrams. Playbook creation is primarily a matter of extracting and
> formalising that content into dedicated, scenario-scoped documents.

---

## Step 6 — Update All Internal Cross-References

**Type**: Content edits across multiple files  
**Prerequisite**: Steps 2–4 (all renames must be complete before references are updated)  
**Purpose**: After renaming the root folder and the `*_workflow.md` files, all internal markdown
links and references that point to the old names will be broken. Every affected file must be
updated to reflect the new paths and filenames.

### Files Requiring Reference Updates

#### Root-Level Files
- `README.md` — update all mentions of `software_dev_elements/`, `*_workflow.md`, and the term
  "workflow" where it refers to an action (keep "workflow" where it refers to a playbook-level concept)
- `restructure_map.md` — update any self-references after execution (this file)

#### Inside `actions/` (root-level shared docs)
- `actions/summary.md` — update directory scaffold diagram, all file links, and the term
  "workflow" in the 3-tier structure rationale where it refers to an action
- `actions/user_guide.md` — update all section headers ("Phase 1: ... Workflow" → "Action 1: ..."),
  all mermaid diagram labels, all `*_workflow.md` links, and any use of "workflow" referring to an action
- `actions/implementation_map_taxonomy.md` — update references to workflow context
- `actions/process_handling.md` — update any workflow references
- `actions/grill_engine.md` — update any workflow references
- `actions/folder_structure.md` — update any workflow references
- `actions/code_graph_taxonomy.md` — update any workflow references
- `actions/multi_repo_architecture.md` — update any workflow references

#### Inside `actions/init/`
- `actions/init/init_action.md` — update self-references ("the `/init` workflow" → "the `/init` action")
  and all cross-links to other `*_workflow.md` files
- `actions/init/init_questions.md` — update any workflow references and cross-links
- `actions/init/antigravity/init_implementation_map.md` — update all references to
  `software_dev_elements/`, `init_workflow.md`, and workflow terminology where applicable
- `actions/init/antigravity/init_tests.md` — update references

#### Inside `actions/process/`
- `actions/process/process_action.md` — update self-references and cross-links
- `actions/process/process_questions.md` — update references
- `actions/process/antigravity/process_implementation_map.md` — update references
- `actions/process/antigravity/process_tests.md` — update references

#### Inside `actions/plan/`
- `actions/plan/plan_action.md` — update self-references and cross-links
- `actions/plan/plan_questions.md` — update references
- `actions/plan/antigravity/plan_implementation_map.md` — update references
- `actions/plan/antigravity/plan_tests.md` — update references

#### Inside `actions/implement/`
- `actions/implement/implement_action.md` — update self-references and cross-links
- `actions/implement/implement_questions.md` — update references
- `actions/implement/antigravity/implement_implementation_map.md` — update references
- `actions/implement/antigravity/implement_tests.md` — update references

#### Inside `actions/qualify/`
- `actions/qualify/qualify_action.md` — update self-references and cross-links

#### Inside `actions/release/`
- *(currently no content files beyond `.gitkeep`)*

### Terminology Substitution Rules for Step 6

When editing files, apply the following substitution rules consistently:

| Old term | New term | Condition |
|:---|:---|:---|
| "workflow" (referring to `/init`, `/plan`, etc.) | "action" | When describing one of the six lifecycle elements |
| "workflow" (referring to end-to-end lifecycle flow) | "playbook" | When describing a composed, multi-action sequence |
| "workflow steps" / "workflow phases" | "action steps" / "action phases" | Internal steps within a single action |
| `software_dev_elements/` | `actions/` | All path references |
| `*_workflow.md` | `*_action.md` | All file links |
| "Planned Development Workflows" (section title) | "Actions" | In `summary.md` |
| "Workflow Commands" | "Action Commands" | In `README.md` |
| "Workflow Mindsets" | "Action Mindsets" | In `README.md`, `summary.md`, `user_guide.md` |
| "Workflow Context Notification Law" | "Action Context Notification Law" | In `user_guide.md` |

> [!IMPORTANT]
> Not every occurrence of "workflow" should be replaced. The term retains its meaning in the
> following contexts and must **not** be changed:
> - Inside `actions/init/antigravity/guards/workflows/` — these are Antigravity-native primitives
>   and the term "workflow" there refers to Antigravity's own resource type, not the framework's concept
> - References to "Antigravity workflows" as a platform primitive
> - The `playbooks/` content itself, where "workflow" is appropriate at the playbook level

---

## Step 7 — Update the `README.md` Section Headers and Framing

**Type**: Content edits (1 file)  
**Prerequisite**: Step 6  
**Purpose**: The README is the first document any reader encounters. It currently frames the entire
framework in workflow-first language. It needs a dedicated section that introduces and explains the
three-tier model (Playbooks → Actions → Commands) before the reader reaches the mindset table.

Changes required:
- Add a **"Framework Domain Model"** section near the top (after "Core Philosophy") that introduces
  the Playbook / Action / Command hierarchy with a brief explanation and a reference table
- Rename section "Workflow Vocabulary & Design Language" → "Action & Command Vocabulary"
- Rename "Workflow Commands Name Process Phases" → "Action Commands Name Process Phases"
- Update the command table to label entries as "Action" not "Command" (since the table lists the
  base-form actions, not parametrized commands)
- Rename "Workflow Mindsets & The Guiding Questions Model" → "Action Mindsets & The Guiding Questions Model"
- Update the mindset table column header from "Workflow" to "Action"

---

## Step 8 — Verify Internal Consistency

**Type**: Review / QA pass  
**Prerequisite**: Steps 2–7  
**Purpose**: After all renames and content edits, perform a final consistency check to confirm
no broken links, stale terminology, or structural gaps remain.

Verification checklist:
- [ ] All markdown links from `README.md` resolve correctly under the new `actions/` path
- [ ] All markdown links within `actions/summary.md` resolve correctly
- [ ] All markdown links within `actions/user_guide.md` resolve correctly
- [ ] All markdown links within each `*_action.md` resolve correctly
- [ ] All markdown links within each `antigravity/*_implementation_map.md` resolve correctly
- [ ] The term "workflow" no longer appears in any file to describe a single lifecycle action
- [ ] The term "software_dev_elements" no longer appears in any file
- [ ] Each `*_action.md` contains a Commands Reference section (Step 4)
- [ ] Each playbook file exists and references actions using the `actions/` path (Step 5)
- [ ] The `guards/workflows/` folders inside antigravity tiers are untouched
- [ ] Git history is clean and all changes are committed on the restructure branch

---

## Summary: Execution Order

```
Step 1  →  git checkout -b restructure/actions-commands-playbooks
Step 2  →  Rename software_dev_elements/ → actions/
Step 3  →  Rename *_workflow.md → *_action.md (6 files)
Step 4  →  Add Commands Reference section to each *_action.md (6 files)
Step 5  →  Create playbook files in playbooks/ (4 files)
Step 6  →  Update all internal cross-references and terminology (all files)
Step 7  →  Update README.md structure and framing
Step 8  →  Verify internal consistency (QA checklist)
```

> [!TIP]
> Steps 2 and 3 are pure filesystem operations and should be done first and together before any
> content editing begins — this prevents editing files at paths that are about to move.
> Steps 4, 5, 6, and 7 are content operations and can be batched action-by-action
> (e.g., complete all changes for `init` before moving to `process`).
