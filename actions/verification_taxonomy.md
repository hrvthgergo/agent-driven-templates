# Guard Specification: Verification Taxonomy & Scenario Identity

This document defines the **identity layer** of the Guards Framework: the stable identifiers,
schemas, and lifecycle rules that make verification traceable from requirement to verdict. It is a
Tier 1 General Specification linked from [summary.md](./summary.md).

---

## 1. Overview & Core Philosophy

The framework's guards are, without exception, **traceability assertions**: *does every ratified
scenario have a harness*, *does every implemented step cite a requirement*, *does every requirement
have a verification*. An assertion of this kind can only be checked if its subject can be addressed.

This specification exists to make verification artifacts addressable. Before it, the framework had
containers (folders, blueprints, matrices) but no identifiers — every reference was prose, and prose
cannot be checked mechanically. **A guard that cannot address its subject cannot enforce anything.**

### The Five Verification Artifacts

Testing decomposes into five artifacts with distinct lifetimes and exactly one owning action each:

| # | Artifact | Owner | Lifetime | Location |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **Test Strategy** | `/plan` | Project-durable | `agent-workspace/tests/TEST_STRATEGY.md` |
| 2 | **Verification Scope (delta)** | `/plan` | Per feature | `plans/<feature>/phase-5-test.md` |
| 3 | **Scenarios** | `/plan` | Accumulating | `agent-workspace/tests/scenarios/` |
| 4 | **Harness Code** | `/implement` | Per layer, versioned | `codebase-qualify/src/`, `codebase-*/tests/` |
| 5 | **Execution & Verdict** | `/qualify` | Per run | `QUALIFICATION_REPORT.md` |

No action may author an artifact it does not own. `/qualify` holds a single narrow exception,
defined in Section 6.3.

---

## 2. Section 1 — Scenario Identity

### 2.1 Identifier Format

Every scenario carries a stable identifier:

```
SC-<feature-slug>-<nnn>
```

- `SC-` — fixed literal prefix.
- `<feature-slug>` — lowercase alphanumeric with hyphens; matches the feature scope directory name under `agent-workspace/plans/`.
- `<nnn>` — three-digit zero-padded ordinal, unique within the feature slug, assigned in creation order.

**Normative regex:**

```
^SC-[a-z0-9]+(-[a-z0-9]+)*-[0-9]{3}$
```

Examples: `SC-discount-codes-004`, `SC-user-auth-001`, `SC-checkout-031`.

### 2.2 Assignment Authority

Scenario IDs are assigned **only** by `/plan`. No other action may mint an identifier, with the
single exception in Section 6.3.

### 2.3 Immutability Rule

An assigned identifier is permanent:

1. IDs are **never reused**. A retired scenario's ID is not reissued to a new scenario.
2. IDs are **never renumbered**. Gaps in the ordinal sequence are expected and acceptable.
3. A scenario's **meaning may be refined** but not replaced. If the behaviour under test changes
   materially, the original is set to `status: retired` and a new ID is minted.

Immutability is what allows a qualification report from `v1.0.0` to remain interpretable against a
scenario catalogue at `v3.0.0`.

---

## 3. Section 2 — Scenario Frontmatter Schema

Each scenario is a single Markdown file under `agent-workspace/tests/scenarios/`, named after its
identifier (e.g. `SC-discount-codes-004.md`), opening with YAML frontmatter:

```yaml
---
id: SC-discount-codes-004
origin: plan | qualify
status: ratified | unratified | retired
tier: unit | integration | e2e | contract | regression
feature: discount-codes
created: YYYY-MM-DD
---
```

### 3.1 Field Definitions

| Field | Required | Meaning |
| :--- | :--- | :--- |
| `id` | Yes | The immutable identifier per Section 2.1. Must match the filename stem. |
| `origin` | Yes | Which action authored it. `plan` = designed. `qualify` = discovered during execution (Section 6.3). |
| `status` | Yes | Ratification state per Section 7. Only `ratified` scenarios are binding. |
| `tier` | Yes | Which testing tier proves it. Must be a tier declared in `TEST_STRATEGY.md`. |
| `feature` | Yes | Feature scope slug. Must match the `<feature-slug>` segment of `id`. |
| `created` | Yes | ISO date of first authoring. Never modified. |
| `supersedes` | No | ID of a `retired` scenario this replaces. |

### 3.2 Body Structure

The body states the behaviour in given/when/then form. It describes **what must be true**, never
**how it is proven** — mechanism belongs to the harness (artifact 4), not the scenario.

```markdown
# SC-discount-codes-004 — Two codes cannot stack

**Given** a cart with a valid discount code already applied
**When** a second valid discount code is submitted
**Then** the second code is rejected, the first remains applied, and the cart total is unchanged
```

---

## 4. Section 3 — `TEST_STRATEGY.md` Schema

`agent-workspace/tests/TEST_STRATEGY.md` is a **project-durable** document. It is authored on the
first `/plan` cycle and amended thereafter only via `/plan --test-strategy`.

It answers *how this project proves things*. It never answers *what this feature must prove* — that
is `phase-5-test.md` (artifact 2). Feature planning **references** the strategy; it does not restate
it.

### 4.1 Required Sections

| Section | Content |
| :--- | :--- |
| **1. Tiers In Use** | Which of `unit`, `integration`, `e2e`, `contract`, `regression` this project employs, and what each proves. A tier not declared here may not be used as a scenario `tier` value. |
| **2. Tooling Per Layer** | The test runner, assertion library, and fixture mechanism for each `codebase-*` layer. |
| **3. Coverage Thresholds** | Minimum coverage per tier, and whether the threshold is advisory or blocking. |
| **4. Mocking & Fixture Policy** | What may be mocked, what must be exercised for real, and where fixtures live. |
| **5. Defect Severity Taxonomy** | The severity levels `/qualify` may assign, and which of them block a release. |
| **6. Definition of Certified** | The explicit, enumerable conditions under which `/qualify` may certify a release. |

### 4.2 Amendment Rule

A feature that requires a tier, tool, or policy the strategy does not contain triggers a **strategy
amendment before feature planning proceeds**. The amendment is made once, project-wide, and all
subsequent features inherit it. Per-feature deviation from the strategy is not permitted.

---

## 5. Section 4 — Harness Citation Grammar

Every test in `codebase-qualify/src/` and `codebase-*/tests/` that satisfies a scenario MUST declare
which scenario it satisfies.

### 5.1 The Canonical Token

The citation is a single invariant token:

```
@scenario SC-<feature-slug>-<nnn>
```

**Normative regex:**

```
@scenario[[:space:]]+SC-[a-z0-9]+(-[a-z0-9]+)*-[0-9]{3}
```

The token is **language-invariant**. Host languages wrap it in whatever construct is idiomatic, but
the token itself never varies — this is what allows the coverage gate (Section 6) to be a single
grep regardless of stack.

### 5.2 Placement Rule

The token MUST appear within the test's own declaration block — its decorator list, annotation
block, docstring, or the comment lines immediately preceding its definition. It MUST NOT appear in
file-level headers, imports, or unrelated comments, since placement is what binds the citation to a
specific test rather than a file.

### 5.3 Per-Language Forms

| Language family | Idiomatic wrapper | Example |
| :--- | :--- | :--- |
| Python | Decorator or docstring | `@scenario("SC-discount-codes-004")` or `"""@scenario SC-discount-codes-004"""` |
| JavaScript / TypeScript | Preceding line comment | `// @scenario SC-discount-codes-004` |
| Go | Preceding line comment | `// @scenario SC-discount-codes-004` |
| Java / Kotlin | Annotation or Javadoc | `@Scenario("SC-discount-codes-004")` or `/** @scenario SC-discount-codes-004 */` |
| **Any other language** | **Fallback** | The token in a comment on the line immediately preceding the test definition. |

The fallback is always available. A language whose tooling cannot express a decorator or annotation
is never a reason to omit the citation.

### 5.4 Cardinality

- One test MAY cite multiple scenarios (repeat the token, once per ID).
- One scenario MAY be cited by multiple tests across tiers.
- A test citing **no** scenario is permitted — exploratory and infrastructure tests are not required
  to trace. Such tests do not contribute to gate satisfaction.

---

## 6. Section 5 — Coverage Gate Contract

The coverage gate is the framework's first fail-closed guard. It executes as **Node Q1 of
`/qualify`**, ahead of environment boot.

> [!NOTE]
> This section is a **contract specification**. It defines behaviour precisely enough to be
> implemented without further design input. The implementation itself is a platform-tier
> (Tier 3) concern and is out of scope for this specification.

### 6.1 Inputs

| # | Input | Source |
| :--- | :--- | :--- |
| 1 | **Scenario IDs in scope** | The scenario ID list declared in `plans/<feature>/phase-5-test.md`. |
| 2 | **Ratification status** | The `status` field of each corresponding file in `agent-workspace/tests/scenarios/`. |
| 3 | **Implemented citations** | All `@scenario` tokens found across `codebase-qualify/src/` and `codebase-*/tests/`, per Section 5. |

### 6.2 Computation

```
scope      := IDs listed in phase-5-test.md
ratified   := { id in scope : scenarios/<id>.md has status == ratified }
implemented:= { id : an @scenario token citing id exists in a harness file }
missing    := ratified \ implemented
```

### 6.3 Exit Semantics

| Condition | Result |
| :--- | :--- |
| `missing` is empty | **Pass.** `/qualify` proceeds to environment boot. |
| `missing` is non-empty | **Fail closed.** `/qualify` halts before boot. Every missing ID is reported with its scenario title. No tests are executed and no verdict is rendered. |

Three rules govern interpretation:

1. A scenario with `status: unratified` is **excluded** from `ratified` and therefore never causes
   failure. Unratified scenarios are proposals, not obligations.
2. A scenario with `status: retired` is excluded identically.
3. Gate failure is **not a test failure**. It reports that a planned proof was never built. It is
   attributed to `/implement`, not to the code under test.

### 6.4 Override Path

Exactly one override exists: `/qualify --force-gate "<justification>"`.

It permits execution to proceed with a non-empty `missing` set, and carries three mandatory
consequences:

1. The justification string is recorded verbatim in `QUALIFICATION_REPORT.md`.
2. Every ID in `missing` is listed in the report under **Unproven Scope**.
3. The resulting run is marked `certification: provisional`. A provisional run **may not** unlock
   `/release`.

No second override exists. There is no configuration flag that disables the gate.

---

## 7. Section 6 — Ratification Lifecycle

### 7.1 States

```
                  /plan --ratify (adopt)
   unratified ──────────────────────────────> ratified
        │                                          │
        │ /plan --ratify (reject)                  │ /plan (behaviour replaced)
        v                                          v
     removed                                    retired
```

| State | Meaning | Binding on `/qualify`? |
| :--- | :--- | :--- |
| `unratified` | Proposed but not adopted into any verification scope. | No |
| `ratified` | Adopted. Part of the binding criteria for its feature scope. | **Yes** |
| `retired` | Superseded or no longer applicable. Retained for historical interpretation. | No |

### 7.2 Transition Authority

State transitions are performed **only** by `/plan`, via `/plan --ratify`. No other action may
change a scenario's `status` field.

### 7.3 The `/qualify` Proposal Exception

`/qualify` may author a scenario when execution reveals behaviour no existing scenario covers. This
is the single exception to Section 2.2, and it is bounded:

**Permitted:**
- Author a new scenario file with `origin: qualify` and `status: unratified`.
- Assign it the next free ordinal in the feature slug.
- List it in `QUALIFICATION_REPORT.md` under **Coverage Gap Proposals**.

**Prohibited:**
- Setting `status: ratified` on any scenario, including its own.
- Certifying a release against an unratified scenario.
- Authoring or amending `TEST_STRATEGY.md`.
- Authoring or modifying harness code.

### 7.4 Defect Versus Coverage Gap

These are distinct findings with distinct authorities, and conflating them is what collapses the
`/qualify` persona:

| Finding | Definition | `/qualify` authority |
| :--- | :--- | :--- |
| **Defect** | Observed behaviour contradicts a ratified scenario, or is self-evidently broken. | **Full.** Report it, attribute it to a layer, and block the release. No ratification required. A bug is a bug. |
| **Coverage gap** | Behaviour is untested because no criterion was ever written for it. | **Proposal only.** Author an unratified scenario; may not certify against it; may not block on it alone. |

`/qualify` therefore retains complete power to stop a bad release. What it does not hold is the
power to expand the certification bar and then render judgment against its own expansion.

---

## 8. Lifecycle Integration Summary

| Action | Reads | Writes |
| :--- | :--- | :--- |
| **`/init`** | `TEST_STRATEGY.md` (existence assertion only) | — |
| **`/process`** | Legacy test assets | `plans/<feature>/resource/existing_coverage.md` |
| **`/plan`** | `existing_coverage.md`, prior `QUALIFICATION_REPORT.md` | `TEST_STRATEGY.md`, `phase-5-test.md`, `tests/scenarios/*.md`, ratification transitions |
| **`/implement`** | `phase-5-test.md`, `tests/scenarios/*.md` | Harness code bearing `@scenario` citations |
| **`/qualify`** | All of the above | `QUALIFICATION_REPORT.md`, `qualification_log.json`, unratified proposals, regression promotions |
| **`/release`** | `QUALIFICATION_REPORT.md` (certification state) | — |
