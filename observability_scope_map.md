# Guards Framework: Observability Scope Map

This document defines the complete, ordered execution plan that adds **monitoring and observability
design** to the framework, recording one scope decision:

> **D1** — Observability is a **Type B concern**: it lives entirely in `phase-6-operation.md` §6 as
> delivery-time contracts designed by `/plan`, built by `/implement`, and asserted by `/operate`.
> No `SC-*` scenario ever carries monitoring behaviour, and no new test tier is introduced.

All steps execute in the order listed. Steps are grouped into three workstreams; **W1 must complete
before W2.** No modifications to any file or folder outside this plan.

**No blocking decisions remain.** This plan is ready to execute end to end.

> [!NOTE]
> Like `operations_scope_map.md` before it, this is a transient execution document. Delete it once
> executed and verified.

---

## Scope Restriction — Antigravity Resources Are Out of Bounds

**This plan may modify only** general framework documents (`README.md`, and Tier 1 / Tier 2 files
under `actions/`). **It may NOT modify anything matching `*/antigravity/*`.**

As with the operations scope map, this has one structural consequence: the `phase-6-operation.md`
*template file* lives only under `actions/plan/antigravity/guards/templates/`. The broadened §6
structure is therefore specified in **`plan_action.md` (Tier 2)** as the universal content contract.
Deferred antigravity work is catalogued at the end.

---

## D1 — RESOLVED: Observability Is a Type B Concern

Two kinds of monitoring assertion were considered. The user selected **Type B only**.

| | Type A *(rejected)* | **Type B (chosen)** |
|:---|:---|:---|
| Example | "`payment_failure_total` increments on auth failure" | "5xx rate > 5% over 5m routes to `#oncall-payments`" |
| Nature | Deterministic code behaviour | Environment-bound, time-windowed |
| Home | `SC-*` scenario, new `observability` tier | `phase-6-operation.md` §6 contract |
| Gated by | `/qualify` coverage gate | `/operate` Node O5, fail-closed |

Choosing Type B keeps observability **entirely inside the operations trinity** — `/plan` designs,
`/implement` builds, `/operate` executes — and leaves the verification trinity untouched.

---

## Accepted Consequences (not open questions)

**C1 — No `observability` test tier is introduced.** `TEST_STRATEGY.md` §1 is unchanged, and
`verification_taxonomy.md` requires **no modification whatsoever**. The five verification artifacts
and their owners stand exactly as they are.

**C2 — Monitoring correctness is not covered by the `/qualify` coverage gate.** It is asserted at
`/operate` Node O5 instead. This is later in the pipeline, but it remains **fail-closed and
pre-production**: `/operate --env test` targets a `gate: none` environment and runs O5
unconditionally, so an instrumentation defect surfaces before any `certification: full` environment
is ever reached. The trade-off is deliberate — it avoids polluting the coverage gate with scenarios
that cannot be proven deterministically.

**C3 — §6 is broadened, not split.** The eight-section content contract keeps its section count. A
health check *is* a monitoring signal; splitting "health" from "observability" would create an
artificial boundary that does not survive scrutiny. §6 is renamed and given three explicit blocks.

**C4 — This fills an existing gap.** The Q10.1–Q10.4 sub-questions added by the operations scope map
map to §0, §1–§2, §3, and §4–§5 respectively. **No grill question currently populates §6 at all** —
health contracts are consumed by `/operate` but designed by nothing. Q10.5 closes that hole as well
as adding monitoring.

---

# W1 — Observability Design Capability (`/plan`)

## Step 1 — Broaden the §6 Content Contract in `plan_action.md`

**Type**: Content replacement (one table row + one following note)
**File**: `actions/plan/plan_action.md`, in the *Phase 6 Content Contract* subsection under §3

**Current row:**

```
| **6** | **Health & Readiness Contracts** | Check · endpoint/command · expected · timeout. These become `/operate`'s post-deploy assertions |
```

**Replace with:**

```
| **6** | **Observability & Health Contracts** | Three blocks — 6a signals & instrumentation, 6b monitoring tooling & endpoints, 6c health, readiness & alert contracts. These become `/operate`'s post-deploy assertions |
```

Immediately below the table, add a subsection titled **"§6 Block Structure"** specifying the three
blocks:

| Block | Content | Consumed by |
|:---|:---|:---|
| **6a. Signals & Instrumentation Contract** | Signal name · type (`metric` / `log` / `trace`) · source layer · emitted-when. Declares **what must be emitted**; the emission code is `/implement`'s | `/implement` builds; `/operate` asserts presence |
| **6b. Monitoring Tooling & Endpoints** | Which tool (Prometheus, Datadog, CloudWatch, …) · scrape/ingest endpoint · per environment. Subject to the **First-Definer Rule**, exactly like §0 environments | `/implement` configures in `codebase-devops/` |
| **6c. Health, Readiness & Alert Contracts** | Check · endpoint/command · expected · timeout · **soak duration** (optional). Alert rule · condition · window · routing target | `/operate` asserts at Node O5 |

Add three boundary notes:

1. **Declares, never implements.** §6 records signal names, thresholds, and routing *targets*. It
   never contains instrumentation code, a dashboard definition, an alert-rule YAML, or a collector
   config. Those are code, written by `/implement` into `codebase-<layer>/` and `codebase-devops/`.
2. **Credentials split from targets.** A routing *target* (`#oncall-payments`, an email alias) is
   declared in §6c. The *credential* that reaches it (a PagerDuty integration key, a webhook secret)
   is declared in **§3** under the names-only rule, and never held in either section.
3. **The Type B guard.** If proving an assertion requires a real time window or live traffic, it
   belongs here as a §6c contract. Observability contracts are **never** authored as `SC-*`
   scenarios and never carry a scenario identifier — the coverage gate does not govern them.

## Step 2 — Add `Q10.5: Observability & Monitoring Design` to `plan_questions.md`

**Type**: New sub-question + preamble update
**File**: `actions/plan/plan_questions.md` (`### Q10` block)

> [!WARNING]
> **Do NOT renumber Q11.** Add `Q10.5` as a fifth sub-question under the existing Q10 heading.
> Introduce no new top-level question numbers.

**2a. Update the Q10 preamble.** It currently reads *"four sub-questions (Q10.1–Q10.4)"* with the
pairing *"Q10.1 + Q10.2 in one turn, Q10.3 + Q10.4 in the next."* Change to **five sub-questions
(Q10.1–Q10.5)**, paired as: Q10.1 + Q10.2, then Q10.3 + Q10.4, then Q10.5.

**2b. Author Q10.5**, following the existing sub-question schema exactly (**Goal**,
**Auto-Detection Scanning Rule**, **Reframed Grill Prompt** with 3 numbered options where the third
is "Other / Free-text", **Boundary**, **Resulting Action**):

- **Goal**: Declare what the system must emit, which tool observes it, and what conditions
  constitute unhealthy.
- **Auto-Detection**: Read prior cycles' `phase-6-operation.md` §6b for already-declared tooling
  (First-Definer Rule). For brownfield, read `resource/` for any monitoring stack `/process`
  discovered.
- **Prompt** (neutral, no `[Recommended]` labels):
  > **What observability and monitoring contracts does this feature require?**
  > 1. No new observability contracts (existing health checks and monitoring suffice)
  > 2. New signals, health checks, or alert conditions required (specify signal names, monitoring tool, thresholds, soak windows, and routing targets)
  > 3. Other / Free-text (Describe observability and monitoring requirements)
- **Boundary**: Declares **what** must be emitted and **what** constitutes unhealthy — never the
  emission code, dashboard definition, alert-rule YAML, or collector config. Observability contracts
  are never authored as `SC-*` scenarios.
- **Resulting Action**: Populates `phase-6-operation.md` §6 (blocks 6a, 6b, 6c).

## Step 3 — Extend `/implement` §J Scope Note

**Type**: Content addition (one clause)
**File**: `actions/implement/implement_action.md`, §3 J (*Repository & Infrastructure Provisioning Authority*)

`/implement` already holds `[C] / [W]` over `codebase-devops/` and every `codebase-<layer>/`, so no
new authority is granted. Add one explicit clause naming observability artifacts as `/implement`
deliverables, so the boundary is not ambiguous at execution time:

> **Observability artifacts.** Instrumentation code (metric emission, trace spans, health endpoints)
> is written into `codebase-<layer>/`; monitoring infrastructure (collector configuration, alert
> rules, dashboards-as-code) is written into `codebase-devops/`. Both realize the contracts declared
> in `phase-6-operation.md` §6; `/implement` authors neither the signal list nor the thresholds.

---

# W2 — Observability Execution (`/operate`)

## Step 4 — Extend the Pure Execution Mandate Prohibition List

**Type**: Content addition (one bullet)
**File**: `actions/operate/operate_action.md`, §2 B (*Pure Execution Mandate*)

Add to the never-list:

> - Edit a dashboard definition, alert rule, or collector configuration.

Confirm the existing closing clause still reads correctly: if a monitoring artifact is wrong, that is
an `/implement` defect — `/operate` reports it and loops back.

## Step 5 — Extend Node O4 to Apply Monitoring Configuration

**Type**: Content addition (one clause)
**File**: `actions/operate/operate_action.md`, `#### Step 4: Delivery / Promotion to Target Environment (Node O4)`

Add that promotion applies the target environment's declared configuration, **including the
monitoring configuration `/implement` wrote into `codebase-devops/`**, per `phase-6-operation.md`
§6b. Do not restructure the node; one clause is sufficient.

## Step 6 — Rename and Extend Node O5

**Type**: Content edits across 5 sites
**File**: `actions/operate/operate_action.md`

Node **ID** `O5` is unchanged; only its descriptive name and body change.

| Site | Current | Change to |
|:---|:---|:---|
| Intro mermaid (§1, `Operate[...]` box) | "4. Health Assertion & Walkthrough Record" | "4. Observability & Health Assertion & Walkthrough Record" |
| §4 mermaid node | `O5[Node O5: Post-Deploy Health & Readiness Assertion<br/>Execute Section 6 health contracts]` | `O5[Node O5: Post-Deploy Observability & Health Assertion<br/>Execute Section 6 contracts: signals, health, alerts]` |
| §4 mermaid edge | `O5 -->|Health Check Failed| O5_Halt` | `O5 -->|Assertion Failed| O5_Halt` |
| Step 5 heading | `#### Step 5: Post-Deploy Health & Readiness Assertion (Node O5)` | `#### Step 5: Post-Deploy Observability & Health Assertion (Node O5)` |
| Step 5 description | "Executes every check declared in `phase-6-operation.md` §6 (Health & Readiness Contracts)…" | Rewrite per below |

**Step 5 description must state that O5 asserts three things**, halting fail-closed on any failure:

1. **Signal presence** — every signal declared in §6a is being emitted and is reachable at the §6b
   endpoint for this environment.
2. **Health & readiness** — every check in §6c passes within its timeout, and holds for its **soak
   duration** where one is declared.
3. **Alert registration** — every alert rule in §6c is registered with the monitoring tool and
   resolves to its declared routing target.

Add an explicit note: O5 runs **unconditionally on every delivery**, including to `gate: none`
environments. This is what makes an instrumentation defect surface before any `certification: full`
environment is reached (**C2**).

## Step 7 — Extend the `WALKTHROUGH.md` Template

**Type**: Content edits
**File**: `actions/operate/operate_action.md`, §6 (*Walkthrough Record Template*)

- Rename `## 3. Health & Readiness Assertion Results` → `## 3. Observability & Health Assertion Results`.
- Replace the single results table with three, one per O5 assertion class:

```markdown
### 3a. Signal Presence
| Signal | Type | Endpoint | Result |
| :--- | :--- | :--- | :--- |

### 3b. Health & Readiness
| Check | Expected | Soak | Result |
| :--- | :--- | :--- | :--- |

### 3c. Alert Registration
| Alert Rule | Routing Target | Registered |
| :--- | :--- | :--- |
```

Leave the **Ops Findings** table (§5 of the template) unchanged — an observability finding is an
ordinary ops finding (`origin: operate`, `status: unratified`) and needs no separate channel.

## Step 8 — Update the `/operate` Summary Checklist

**Type**: Content edit
**File**: `actions/operate/operate_action.md`, §7

Replace the single health-contract checklist item with:

```markdown
- [ ] Apply the target environment's monitoring configuration during promotion (§6b).
- [ ] Assert all three §6 contract classes at Node O5 — signal presence, health & readiness (including soak windows), and alert registration. Halt fail-closed on any failure.
- [ ] Do NOT edit a dashboard, alert rule, or collector config. A wrong monitoring artifact is an `/implement` defect.
```

---

# W3 — Consistency Sweep

## Step 9 — Broaden the Phase 6 Row in `process_handling.md`

**Type**: Content edit
**File**: `actions/process_handling.md`, Block 1 matrix, row `3.6 Phase 6: Operations`

Currently: *"Environments, Dockerfiles, Compose, CI/CD & Promotion Policy"*. Add observability:
**"Environments, Dockerfiles, Compose, CI/CD, Promotion Policy & Observability"**.

## Step 10 — Update the `/plan` Operations-Authority Clause (3 files)

**Type**: Content edits
**Files**: `README.md` · `actions/summary.md` · `actions/user_guide.md` (the `/plan` mindset rows)

Each currently ends the operations clause with *"…pipeline topology, and promotion policy."* Append
observability so the design authority is stated completely:
**"…pipeline topology, promotion policy, and observability contracts."**

Apply the identical edit to `plan_action.md` §J item 1, which enumerates the same list.

## Step 11 — Do NOT Touch

Explicitly out of scope:
- **Anything matching `*/antigravity/*`** — see Scope Restriction
- **`actions/verification_taxonomy.md`** — Type B introduces no test tier and no scenario (**C1**)
- **`agent-workspace/tests/TEST_STRATEGY.md` schema** (`verification_taxonomy.md` §4.1) — unchanged
- Every mermaid **lifecycle** diagram's node ordering (the O5 node *name* change in
  `operate_action.md` §4 is a label edit, not a reordering)
- `actions/directory_handling_roles.md` — monitoring artifacts live in `codebase-devops/` and
  `codebase-<layer>/`, both already covered; no new row is warranted
- `actions/qualify/qualify_action.md` — `/qualify` gains no observability role

---

## Step 12 — Verification Checklist

- [ ] `git diff --name-only` contains **no path matching `*/antigravity/*`**
- [ ] `git diff --name-only` does **not** contain `actions/verification_taxonomy.md`
- [ ] `grep -rn "observability" --include=*.md actions/ | grep -i "tier\|SC-"` returns nothing — no test tier, no scenario identifier
- [ ] `plan_action.md` §6 row reads **Observability & Health Contracts** and the §6 Block Structure subsection documents blocks 6a/6b/6c
- [ ] `plan_action.md` still documents **exactly eight** sections (§0–§7)
- [ ] `plan_questions.md` contains Q10.1–Q10.5, the preamble says five sub-questions with the updated pairing, and **Q11 is still numbered Q11**
- [ ] `operate_action.md` contains **Nodes O1–O7, unrenumbered**; O5 is renamed but its ID is intact
- [ ] `operate_action.md` §2.B prohibits editing dashboards, alert rules, and collector configs
- [ ] `operate_action.md` §6 template has sub-tables 3a/3b/3c
- [ ] The `/plan` operations-authority clause is identical across `README.md`, `summary.md`, `user_guide.md`, and `plan_action.md` §J
- [ ] Every markdown link introduced by this plan resolves

---

## Deferred Antigravity Sync Backlog

| File | Required change | Driven by |
|:---|:---|:---|
| `plan/antigravity/guards/templates/phase-6-operation.md` | Broaden §6 into blocks 6a/6b/6c per the Tier 2 contract | Step 1 |
| `plan/antigravity/guards/workflows/plan.md` | Add Q10.5 to the Q10 bullet | Step 2 |
| `plan/antigravity/plan_tests.md` | Add a Q10.5 test row asserting §6 is populated | Step 2 |
| `plan/antigravity/plan_implementation_map.md` | Update the Q10 entry to name Q10.5 | Step 2 |
| `operate/antigravity/**` | **Still does not exist.** When built, its Node O5 must assert all three §6 contract classes | Steps 6–8 |

---

## Execution Order Summary

```
W1   →  Steps 1–3     Observability design capability   (/plan, /implement)
W2   →  Steps 4–8     Observability execution           (/operate)
W3   →  Steps 9–11    Consistency sweep
     →  Step 12       Verification checklist
```

> [!TIP]
> W1 must land before W2, because `operate_action.md` Node O5 (Step 6) references the §6 block
> structure defined in `plan_action.md` (Step 1). W3 is independent and may run at any point after W2.
