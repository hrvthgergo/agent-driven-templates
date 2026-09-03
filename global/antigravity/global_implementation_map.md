# Implementation Map: Global Governance Utilities (Antigravity Environment)

This document defines the step-by-step implementation plan for creating the concrete **Global Guard Utilities** within **Google Antigravity**. It details the planned actions and technical rationale, explicitly linking back to [global_governor.md](../../global_governor.md) and mapping them directly to Antigravity's native primitives.

---

## 1. Overview & Objectives

The objective of this module is to provide shared, deterministic, OS-level utilities that enforce the 5-W Global Governor across all actions and playbooks. These utilities eliminate agent omission and drift by turning procedural requirements into executable shell scripts.

### Role of this Implementation Map vs. Universal Design Baselines
* **Universal Design & Architectural Baselines (Platform-Agnostic)**: [global_governor.md](../../global_governor.md), [process_handling.md](../../actions/process_handling.md), and [directory_handling_roles.md](../../actions/directory_handling_roles.md) define the platform-agnostic laws (Who, What, When, Where, Why) that govern all agents.
* **Antigravity Implementation Guideline**: This document (`global_implementation_map.md`) is the concrete execution roadmap detailing how our agent implements those baselines within **Google Antigravity** using its native environment primitives:
  * **Scripts (`guards/scripts/`)**: Shared deterministic utilities (`sync-process-status.sh`, `verify-action-handoff.sh`) invoked by workflows, playbooks, and git hooks.
  * **Hooks (`guards/hooks/`)**: Interceptor shell scripts enforcing repository-wide safety invariants.

---

## 2. Documented Design Decision & Antigravity Primitive Matrix

| Design Decision / Principle | Documented Source File | Antigravity Native Primitive | Applied Guard Path |
| :--- | :--- | :--- | :--- |
| **Atomic State Synchronization** | [global_governor.md Law III](../../global_governor.md#3-when-process-sequencing) | Script Primitive | `guards/scripts/sync-process-status.sh` |
| **Immutable Traceability Logging** | [global_governor.md Law V](../../global_governor.md#5-why-grounding--traceability) & [process_handling.md](../../actions/process_handling.md) | Script Primitive | `guards/scripts/sync-process-status.sh` |
| **Playbook Handoff Gatekeeper** | [global_governor.md Law III](../../global_governor.md#3-when-process-sequencing) | Script Primitive | `guards/scripts/verify-action-handoff.sh` |
| **OS-Level Territorial Gatekeeper** | [global_governor.md Law IV](../../global_governor.md#4-where-territorial-directory-locks) & [directory_handling_roles.md](../../actions/directory_handling_roles.md) | Hook Primitive | `actions/init/antigravity/guards/hooks/agy-gatekeeper.sh` |

---

## 3. Implementation Plan Schema & Task Sequence

### Block 1: Target Files & Scaffolding Checklist
- [ ] `[NEW]` `global/antigravity/guards/scripts/sync-process-status.sh` - Deterministic status updater and history logger.
- [ ] `[NEW]` `global/antigravity/guards/scripts/verify-action-handoff.sh` - Inter-action playbook handoff gatekeeper.

---

### Block 2: Step-by-Step Task Sequence

#### Step 1: Scaffold Guard Script Directory Tree
1. **Actions Taken**:
   - Initialize `global/antigravity/guards/scripts/`.
2. **Verification Fulfilled**:
   - Directory existence confirmed.

#### Step 2: Implement Deterministic Status Synchronization Tool (`sync-process-status.sh`)
1. **Requirement Fulfilled**:
   - [global_governor.md Law III & Law V](../../global_governor.md) (Atomic state transitions, Block 1 token updates, Block 2 daily history logging).
2. **Actions Taken**:
   - `[NEW]` `global/antigravity/guards/scripts/sync-process-status.sh`:
     - CLI flags: `--workflow <name>`, `--sub-process <id>`, `--status <not_started|in_progress|done|not_in_scope>`, `--log "<message>"`.
     - Automatically locates active `PROCESS_STATUS.md`.
     - Updates status token (`[ ]`, `[>]`, `[x]`, `[-]`) and updates `Last Updated` date to current date.
     - Appends formatted datestamped entry to Block 2 (`- **[HH:MM] <Workflow/Sub-process>**: <log message>`).
     - Executes `git add` on the status file so changes are immediately staged.
3. **Verification Fulfilled**:
   - Validated against test cases in `global_tests.md` Suite 1.

#### Step 3: Implement Playbook Inter-Action Handoff Gatekeeper (`verify-action-handoff.sh`)
1. **Requirement Fulfilled**:
   - [global_governor.md Law III](../../global_governor.md) (Sequential constraints, fail-closed handoff gating).
2. **Actions Taken**:
   - `[NEW]` `global/antigravity/guards/scripts/verify-action-handoff.sh`:
     - CLI flags: `--completed-action <name>`, `--next-action <name>`.
     - Inspects `PROCESS_STATUS.md` on disk: verifies that `--completed-action` has status `[x] Done` (or `[-] Not In Scope`).
     - Verifies that Block 2 contains a corresponding event log entry.
     - Exits with `0` on success; exits with `1` and prints high-visibility violation banner on failure.
3. **Verification Fulfilled**:
   - Validated against test cases in `global_tests.md` Suite 2.

#### Step 4: Verification & Executable Permissions
1. **Actions Taken**:
   - Ensure `chmod +x` on all shell scripts.
   - Run test suite defined in `global_tests.md`.

---

## 4. Acceptance Criteria & Consent Gate
- `sync-process-status.sh` and `verify-action-handoff.sh` executable and syntax-clean.
- Status synchronization updates Block 1 and appends to Block 2 deterministically.
- Handoff gate halts fail-closed if completed action is not marked `[x] Done`.
- All tests in `global_tests.md` pass.
