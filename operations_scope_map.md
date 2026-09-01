# Guards Framework: Operations Scope Map

This document defines the complete, ordered execution plan that records three scope decisions
across the framework documentation set:

> **D1** — `/operate` is a pure execution action.
> **D2** — `/plan` has no authority to modify any document outside `plans/` and its subfolders.
> **D3** — Environment design becomes a first-class capability of `/plan` Phase 6.

All steps execute in the order listed. Steps are grouped into four workstreams; **W1 must complete
before W2, W2 before W3.** No modifications to any file or folder outside this plan.

> [!IMPORTANT]
> **Read `D0` first.** One conflict must be resolved by the user before Step 1 begins.
> Do not guess at it, and do not begin W1 until it is answered.

---

## D0 — Blocking Decision Required Before Execution

**The conflict.** Decision D2 states `/plan` may write only within `plans/`. But three documents
currently assign `/plan` ownership of two artifacts that live **outside** `plans/`:

| Artifact | Assigned to `/plan` by |
|:---|:---|
| `agent-workspace/tests/TEST_STRATEGY.md` | `plan_action.md` §I, `verification_taxonomy.md` §8, `folder_structure.md` |
| `agent-workspace/tests/scenarios/**` | `plan_action.md` §I, `verification_taxonomy.md` §8, `folder_structure.md` |

Taken literally, D2 strips `/plan` of its verification design authority and voids the verification
taxonomy. Two readings are available:

**Reading A — Enumerated allow-list (RECOMMENDED).**
The intent of D2 is *`/plan` designs, never constructs; `/plan` never touches a code repository.*
`§H` is rewritten as an explicit allow-list of **design surfaces inside `agent-workspace/`**:

```
ALLOWED:    agent-workspace/plans/<feature-name>/**
            agent-workspace/tests/TEST_STRATEGY.md
            agent-workspace/tests/scenarios/**

FORBIDDEN:  any codebase-*/ repository (all paths, without exception)
            agent-workspace/src/**
            agent-workspace/docs/**
            agent-workspace/tests/regression/**   (owned by /qualify)
```

Preserves verification ownership. Kills every `/plan`-creates-infrastructure claim. Recommended.

**Reading B — Literal.**
`plans/**` is the only writable path. `TEST_STRATEGY.md` and `scenarios/` must then move inside
`plans/`, which contradicts `folder_structure.md`'s deliberate statement that they are
"project-durable and sit deliberately outside any single feature sandbox." Choosing B requires a
second, larger plan to relocate the verification artifacts and rewrite `verification_taxonomy.md`.

**Action**: Confirm A or B. This plan is written for **Reading A**. If B is chosen, stop and
request a revised plan.

---

## Known Consequences of D2 (accepted, not open questions)

**C1 — `/implement` inherits repository provisioning.**
If `/plan` cannot create `codebase-*` skeletons, symlinks, or Docker files, and `/init` explicitly
does not, then `/implement` must. This plan adds a provisioning node to `/implement`. This is a real
scope addition, and it is the direct and intended consequence of D2.

**C2 — No project-durable operations artifact exists.**
Because D3 places environment design in `phase-6-operation.md` (which lives inside `plans/`), there
is no `agent-workspace/ops/` equivalent to `TEST_STRATEGY.md`. Environment definitions are therefore
feature-scoped. This plan handles it with a **first-definer rule** (W2, Step 6): the first feature to
define an environment owns its canonical definition; later features reference and delta it. This is a
deliberate trade-off of durability for boundary purity.

**C3 — Lifecycle diagrams are intentionally NOT restructured.**
`/operate` gains `--env <name>` targeting, but every mermaid lifecycle diagram keeps `/operate`
positioned after `/qualify`. Pre-certification delivery is expressed as an **environment gate
property** (an environment whose entry gate is `none`), not as a lifecycle rewrite. Do not modify any
mermaid diagram's node ordering in this plan.

---

# W1 — `/plan` Write Boundary (Decision D2)

## Step 1 — Rewrite `plan_action.md` §H as an Enumerated Allow-List

**Type**: Content replacement
**File**: `actions/plan/plan_action.md` (section `### H. Filesystem Boundary Guard Rule`, ~line 114)

Replace the section body with the allow-list from **D0 Reading A**. Requirements:
- Present ALLOWED and FORBIDDEN as two explicit path lists in a fenced `text` block.
- State the governing principle in one sentence: *`/plan` produces design artifacts only; it never
  creates, scaffolds, or provisions a repository, container, pipeline, or symlink.*
- Add an explicit sentence naming `/implement` as the action that provisions everything `/plan`
  specifies.
- Add a cross-reference to the new §J created in Step 8.

## Step 2 — Correct `multi_repo_architecture.md` (4 sites)

**Type**: Content edits
**File**: `actions/multi_repo_architecture.md`

| Line | Current claim | Required change |
|:---|:---|:---|
| 19 | "Software layers (`codebase-*`) and relative symlinks are **introduced during `/plan` Phase 1**" | Introduced during **`/implement`**, per the layer scope `/plan` Phase 1 specifies |
| 31 | "`codebase-devops/`: **Initialized during `/plan` Phase 6**" | Specified in `/plan` Phase 6; **initialized during `/implement`** |
| 32 | "`codebase-<layer>/`: **Initialized during `/plan` Phase 1**" | Specified in `/plan` Phase 1; **initialized during `/implement`** |
| 33 | "`codebase-qualify/`: **Initialized during `/plan` Phase 5**" | Specified in `/plan` Phase 5; **initialized during `/implement`** |
| 82 | Docker configs "planned and **provisioned** during `/plan` Phase 6" | **Planned** in `/plan` Phase 6; **provisioned during `/implement`** |

Apply the same correction to §5 *Layer Expansion Workflow* (~line 155+): `/plan --evolve` **specifies**
the new layer; `/implement` provisions the sub-repository, registers the symlink, and updates
`docker-compose.yml`.

## Step 3 — Correct `folder_structure.md`

**Type**: Content edit
**File**: `actions/folder_structure.md`, line 3

Change "…are introduced during `/plan` (greenfield) or linked in-place during `/process` (brownfield)"
to attribute greenfield provisioning to `/implement`, retaining `/process` for brownfield in-place
linking. Also update the *Verification Artifact Ownership* note at the file's end if it implies `/plan`
performs filesystem provisioning.

## Step 4 — Correct the `/plan` Mindset Row (3 files, identical text)

**Type**: Content edits
**Files**:
- `README.md` line 83
- `actions/summary.md` line 148
- `actions/user_guide.md` (the `/plan` row in the Action Mindsets table)

Remove the clause "**and creates `codebase-*` sub-repositories with `src/` symlinks**" from all three.
Replace with wording that keeps `/plan` as the action that *determines layer scope* while attributing
creation to `/implement`. Preserve the existing verification-authority clause verbatim.

## Step 5 — Correct `/init` Forward-References (2 sites)

**Type**: Content edits
**Files**: `actions/init/init_action.md` lines 35 and 249; `actions/init/init_questions.md` line 22

These say layers/Docker are "introduced during `/plan`". Change to: **designed** during `/plan`,
**introduced** during `/implement`. Do not otherwise alter `/init` scope.

---

# W2 — Environment Design Capability (Decision D3)

## Step 6 — Expand the `phase-6-operation.md` Template

**Type**: Full file replacement
**File**: `actions/plan/antigravity/guards/templates/phase-6-operation.md`

The current template has three stub sections and **no environment concept at all**. Replace it
entirely with the following structure. Keep every section a fillable template with bracketed
guidance — this is a `/plan` blueprint, not a filled document.

```markdown
# Phase 6: Operations, Environments & Delivery Design

> Design authority: `/plan`. Constructed by `/implement`. Executed by `/operate`.
> This document specifies. It never contains a Dockerfile, a compose file, or pipeline YAML.

## 0. Environment Topology

*First-Definer Rule: the first feature to define an environment owns its canonical row. Later
features reference the existing definition and record only their delta.*

| ID | Purpose | Services | Config Source | Entry Gate | Promoted From |
|:---|:---|:---|:---|:---|:---|
| `ENV-local` | Developer sandbox | [...] | `codebase-devops/docker/` | `none` | — |
| `ENV-test` | Qualification target | [...] | `codebase-devops/config/test` | `none` | build |
| `ENV-production` | Live | [...] | `codebase-devops/config/prod` | `certification: full` | `ENV-test` |

* **Entry Gate values**: `none` | `certification: full`
* **Delta for this feature**: [Which environments change, and how]

## 1. Containerization & Image Specifications
[Base images, multi-stage targets, runtime profiles, image naming.]

## 2. Service Orchestration & Compose
* **Services**: [Containers, networks, volumes, ports]
* **Startup ordering / dependencies**: [...]

## 3. Configuration & Secret Declarations
*Declare names and scopes only. Never record a secret value in this document.*

| Key | Scope | Environments | Source |
|:---|:---|:---|:---|
| `[KEY_NAME]` | [layer / global] | [ENV-*] | [config path / secret store] |

## 4. CI/CD Pipeline Topology
Map this feature onto the 3-tier hierarchy from `multi_repo_architecture.md` §3:

| Tier | Repository | Triggered by | Change required? |
|:---|:---|:---|:---|
| Layer micro-pipeline | `codebase-<layer>/.github/workflows/` | [...] | [Yes/No — what] |
| Qualification pipeline | `codebase-qualify/.github/workflows/` | [...] | [Yes/No — what] |
| Global macro-pipeline | `codebase-devops/.github/workflows/` | [...] | [Yes/No — what] |

## 5. Delivery & Promotion Policy
* **Versioning scheme**: [e.g. semver `vX.Y.Z`, RC suffixes]
* **Image tagging**: [tag + immutable digest]
* **Promotion edges**: [`ENV-test` → `ENV-production`]
* **Rebuild policy**: [Default: promote the certified digest; never rebuild per environment]
* **Rollback**: [Target, trigger, and who authorizes]

## 6. Health & Readiness Contracts
*These become the assertions `/operate` runs after every delivery.*

| Check | Endpoint / Command | Expected | Timeout |
|:---|:---|:---|:---|
| [...] | [...] | [...] | [...] |

## 7. Operations Decisions (Embedded ADRs)
* **Decision 1**: [Context → Options → Choice → Consequence]
```

## Step 7 — Expand Q10 into Four Sub-Questions

**Type**: Content expansion
**File**: `actions/plan/plan_questions.md` (`### Q10`, ~line 222)

> [!WARNING]
> **Do NOT renumber Q11.** Q11 (Implementation Map Drafting Gate) is cross-referenced from
> `plan.md`, `plan_tests.md`, and `plan_implementation_map.md`. Expand Q10 into sub-questions
> `Q10.1`–`Q10.4` under the existing Q10 heading. Insert no new top-level question numbers.

Author four sub-questions, each following the existing schema (**Goal**, **Reframed Grill Prompt**
with 3 numbered options where the third is "Other / Free-text", **Resulting Action** naming the
target section of `phase-6-operation.md`):

| Sub-Q | Topic | Populates |
|:---|:---|:---|
| **Q10.1** | Environment topology — which environments this feature targets, and whether any new environment is required | §0 |
| **Q10.2** | Containerization & image impact | §1–§2 |
| **Q10.3** | Configuration & secret declarations | §3 |
| **Q10.4** | CI/CD pipeline impact & promotion policy | §4–§5 |

Respect the Grill Engine's max-2-questions-per-turn rule (`grill_engine.md`): Q10.1+Q10.2 in one
turn, Q10.3+Q10.4 in the next.

## Step 8 — Add §J "Operations Design Authority" to `plan_action.md`

**Type**: New section
**File**: `actions/plan/plan_action.md`, immediately after `### I. Verification Design Authority`

Mirror §I's structure and tone. Must state:
1. `/plan` is the **sole design authority for operations**: environment topology, image
   specifications, configuration and secret *declarations*, pipeline topology, promotion policy,
   and health contracts.
2. All of it is recorded in `phase-6-operation.md` — inside the `plans/` sandbox, consistent with §H.
3. `/plan` writes **no** Dockerfile, no compose file, no pipeline YAML, no deploy script. Those are
   code, built by `/implement`.
4. `/plan` never holds a secret value — only its name, scope, and source.
5. Close with a `> [!IMPORTANT]` note mirroring §I: **gates precede delivery.** Because environment
   entry gates are authored by `/plan` and version-controlled, `/operate` cannot weaken a gate
   without producing a visible diff against a `/plan`-owned artifact. That, not authorship of the
   pipeline, is what makes delivery governed.

## Step 9 — Propagate Q10 Expansion to Antigravity Tier

**Type**: Content edits
**Files**:
- `actions/plan/antigravity/guards/workflows/plan.md` line 76 — expand the Q10 bullet to name the four sub-questions
- `actions/plan/antigravity/plan_tests.md` line 64 — expand the Q10 test row into four rows, one per sub-question, each asserting the correct `phase-6-operation.md` section is populated
- `actions/plan/antigravity/plan_implementation_map.md` line 131 — update the Q10 entry

## Step 10 — Add `/plan` Provisioning Prohibition to the Plan Grill Rule

**Type**: Content edit
**File**: `actions/plan/antigravity/guards/rules/plan-grill.md`

Add a guard clause: if the Q10 session concludes that infrastructure must be created, the agent
records the specification in `phase-6-operation.md` and **hands it to `/implement`**. It must never
create the repository, file, or symlink itself.

---

# W3 — `/operate` as Pure Execution (Decision D1)

## Step 11 — Rewrite `operate_action.md`

**Type**: Full file replacement
**File**: `actions/operate/operate_action.md`

The current file is 43 lines: intro, mermaid, commands table, checklist. Replace with a specification
matching the depth of `qualify_action.md`. Required section structure:

```
# Guard Specification: Operations & Delivery (/operate)

1. General Introduction & Core Philosophy
   1.1 Core Philosophy: Why /operate Executes and Does Not Design
2. Core Architectural Principles & Boundary Rules
   A. Action Preconditions & the Environment Entry Gate
   B. Pure Execution Mandate
   C. Filesystem Boundary Guard Rule
   D. Bounded Exception: Release Record & Ops Finding Proposals
   E. Environment Targeting & the Promotion Model
3. Directory Layout & Delivery Artifacts
4. Detailed Step-by-Step State Machine Design (Nodes O1–O7)
5. Commands Reference & Execution Modes
6. Release Record Template (RELEASE_RECORD.md)
7. Summary Checklist for AI Agents Executing /operate
```

### Content requirements per section

**§1.1 Core Philosophy** — `/operate` builds nothing it designed and designs nothing it builds. The
topology, gates, and health contracts come from `phase-6-operation.md`; the Dockerfiles, compose
files, and pipelines come from `/implement`. `/operate` runs them and reports.

**§2.A Preconditions & Entry Gate** — the gate is **per-environment**, read from
`phase-6-operation.md` §0. An environment with gate `none` requires no certification. An environment
with gate `certification: full` requires `QUALIFICATION_REPORT.md` to show `certification: full`; a
`provisional` run (from `/qualify --force-gate`) **may never** unlock it. Fail-closed.

**§2.B Pure Execution Mandate** — explicit prohibition list. `/operate` may not: edit a Dockerfile,
compose file, pipeline YAML, or deploy script; define or alter an environment; change an entry gate;
author or ratify a scenario; modify `TEST_STRATEGY.md` or any `phase-*.md`; write to any
`codebase-*/` repository. If an ops file is wrong, that is an `/implement` defect — loop back.

**§2.C Filesystem Boundary** — `/operate` writes only to
`agent-workspace/plans/<feature-name>/` (release record, ops findings) and `PROCESS_STATUS.md`.

**§2.D Bounded Exception** — mirror `/qualify`'s coverage-gap proposal exactly. `/operate` MAY author
an **ops finding** (`origin: operate`, `status: unratified`) recording something delivery revealed —
a base image needing a bump, a health timeout too aggressive, a missing config key. It MAY NOT act on
it. Findings are listed in `RELEASE_RECORD.md` and are input to the next `/plan` Phase 6 cycle. This
is the artifact that closes the Evolution Dialogue loop, which currently has no mechanism.

**§2.E Promotion Model** — build once, promote the same immutable digest. Include the **provenance
gate**: before promoting into any environment whose gate is `certification: full`, `/operate` MUST
verify the digest it is promoting is identical to the digest recorded in `QUALIFICATION_REPORT.md`.
A mismatch halts, fail-closed. Rationale to state explicitly: rebuilding per environment means
`/qualify` certified a different artifact than the one shipped, silently voiding certification.

**§4 State Machine** — seven nodes, following the `Q1..Q6` numbering idiom of `/qualify`:

| Node | Name | Behaviour |
|:---|:---|:---|
| **O1** | Target & Environment Resolution | Resolve `--env` and `--version`; load §0 topology from `phase-6-operation.md` |
| **O2** | Entry Gate & Provenance Gate | Fail-closed. Both gates evaluated before any build or push |
| **O3** | Image Build & Immutable Tagging | Build from `/implement`-authored Dockerfiles; tag + record digest |
| **O4** | Delivery / Promotion to Target Environment | Promote the digest; never rebuild |
| **O5** | Post-Deploy Health & Readiness Assertion | Execute §6 health contracts from `phase-6-operation.md` |
| **O6** | Release Record & Ops Finding Capture | Write `RELEASE_RECORD.md` |
| **O7** | PROCESS_STATUS Sync & Handoff | Row 6 → Done; datestamped Block 2 entry |

**§5 Commands** — preserve the five existing commands and add `--env <name>`:

| Command | Description |
|:---|:---|
| `/operate` | Interactive delivery; prompts for environment and version |
| `/operate --env <name>` | Target a specific environment defined in `phase-6-operation.md` §0 |
| `/operate --version <vX.Y.Z>` | Explicit version tag |
| `/operate --auto` | No confirmation pauses |
| `/operate --dry-run` | Simulate; evaluate gates and print the plan; no tags, no pushes |
| `/operate --deploy` | Trigger post-release deployment scripts/webhooks in `codebase-devops/` |

**§6 `RELEASE_RECORD.md` template** — must capture: feature, version, target environment, image
digest, gate results (entry + provenance), certification reference, health assertion results,
PR/merge reference, and an **Ops Findings** table (`origin: operate`, `status: unratified`).

## Step 12 — Update `/operate` Descriptions in the Overview Documents

**Type**: Content edits
**Files**:

| File | Site | Change |
|:---|:---|:---|
| `actions/summary.md` | §4 item 6 (~line 195) | Expand the 2-line purpose to match `/qualify`'s depth: pure execution, per-environment gates, provenance gate, authors nothing but the release record |
| `actions/summary.md` | Mindset table, `/operate` row (line 151) | Add "Executes delivery; designs and builds nothing" |
| `actions/user_guide.md` | Action 6 (line 67) | Expand from one bullet to match Action 5's structure |
| `actions/user_guide.md` | Mindset table (line 83) | Same clause as above |
| `README.md` | Mindset table (line 86) | Same clause as above |
| `README.md` | Actions list (line 133) | Reflect execution-only scope |

## Step 13 — Add the `/operate` Row to the Verification Integration Table

**Type**: Content edit
**File**: `actions/verification_taxonomy.md` §8 (line 322)

Currently: `/operate` reads `QUALIFICATION_REPORT.md`, writes `—`. Update the Writes column to
`RELEASE_RECORD.md` (ops findings only; no verification artifact). Add a sentence confirming
`/operate` never writes a scenario, never alters a `status` field, and never promotes to
`tests/regression/`.

---

# W4 — Consistency Sweep

## Step 14 — Fix the Stale `release/` Scaffold

**Type**: Content edit
**File**: `actions/summary.md` lines 74–77

The directory scaffold still shows `release/` containing `release_implementation_map.md`. Replace
with the actual `operate/` layout, matching the shape used for `qualify/`:

```text
└── operate/                            # [Tier 2] Operations & Delivery Subfolder
    ├── operate_action.md               # Detailed action specifications (execution only)
    └── antigravity/                    # [Tier 3] Antigravity-specific resources & guards
```

## Step 15 — Resolve the Row 6 Artifact Name Conflict

**Type**: Content edits
**Files**:
- `actions/qualify/antigravity/guards/templates/PROCESS_STATUS.md` line 24 — artifact is `release_notes.md`
- `actions/init/antigravity/guards/templates/PROCESS_STATUS.md` line 25 — focus is "Release Tag & Merge"
- `actions/process_handling.md` line 49 — focus is "Docker builds, PR creation & deployment"

Standardize all three on artifact `RELEASE_RECORD.md` and one focus string:
**"Image build, environment promotion & deployment"**.

## Step 16 — Fix the `Active Workflow` Enum

**Type**: Content edit
**File**: `actions/process_handling.md` line 16

`[init | process | plan | implement | qualify | release | idle]` → replace `release` with `operate`.

## Step 17 — Fix Stale `/release` in the Init Test Fixture

**Type**: Content edits
**File**: `actions/init/antigravity/scratch/run_init_tests.sh` lines 95 and 279

Both emit `| **6** | `/release` |` in the PROCESS_STATUS fixture. Change to `/operate` and align the
focus string with Step 15.

## Step 18 — Update `process_handling.md` Phase 6 Row

**Type**: Content edit
**File**: `actions/process_handling.md` line 46

Phase 6 focus reads "Dockerfiles, Compose & CI/CD". Broaden to
**"Environments, Dockerfiles, Compose, CI/CD & Promotion Policy"** to reflect the expanded template.

## Step 19 — Do NOT Touch

Explicitly out of scope for this plan:
- `restructure_map.md` — historical record of the prior migration; leave intact
- Every mermaid lifecycle diagram's node ordering (see **C3**)
- `actions/qualify/**` beyond the single line in Step 13
- Any `codebase-*` content (none exists in this repository)

---

## Step 20 — Verification Checklist

- [ ] **D0 answered** and the chosen reading applied consistently
- [ ] `grep -rn "provisioned during \`/plan\`\|Initialized during \`/plan\`" --include=*.md .` returns nothing
- [ ] `grep -rn "creates \`codebase-\*\` sub-repositories" --include=*.md .` returns nothing
- [ ] `grep -rni "/release" --include=*.md --include=*.sh . | grep -v restructure_map.md` returns nothing
- [ ] `grep -rn "release_notes.md" --include=*.md .` returns nothing
- [ ] `plan_action.md` §H is an allow-list; §J exists and mirrors §I
- [ ] `phase-6-operation.md` template contains all eight sections (§0–§7)
- [ ] `plan_questions.md` contains Q10.1–Q10.4 and **Q11 is still numbered Q11**
- [ ] `operate_action.md` contains Nodes O1–O7, both gates, and the `RELEASE_RECORD.md` template
- [ ] The `/operate` mindset row is identical across `README.md`, `summary.md`, `user_guide.md`
- [ ] Every markdown link introduced by this plan resolves
- [ ] No mermaid diagram node ordering was changed

---

## Execution Order Summary

```
D0   →  Confirm Reading A or B                      [BLOCKING]
W1   →  Steps 1–5    /plan write boundary
W2   →  Steps 6–10   Environment design capability
W3   →  Steps 11–13  /operate pure execution
W4   →  Steps 14–19  Consistency sweep
     →  Step 20      Verification checklist
```

> [!TIP]
> W1 must land before W2, because §J (Step 8) references the rewritten §H (Step 1).
> W2 must land before W3, because `operate_action.md` (Step 11) references
> `phase-6-operation.md` §0 and §6 (Step 6).
> W4 is independent and may be executed at any point after W3.
