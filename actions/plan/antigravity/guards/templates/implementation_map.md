# Implementation Map: [Feature Name] (v[version])

This document defines the actionable, step-by-step implementation roadmap for scaffolding code and tests during `/implement`.

---

## Block 1: Release Version & Plan Context
* **Target Release Version**: `v[version]`
* **Feature Plan Reference**: `agent-workspace/plans/[feature]/phase-1-summary.md`
* **Test Delta Reference**: `agent-workspace/plans/[feature]/phase-5-test.md`
* **Operations Design Reference**: `agent-workspace/plans/[feature]/phase-6-operation.md`
* **Scenarios in Scope**: `SC-[feature]-001`, `SC-[feature]-002`

---

## Block 2: Micro-Architecture Summary & Scope Boundary
* **Target Layers**: `codebase-layout`, `codebase-engine`, `codebase-qualify`, `codebase-devops`
* **Implementation Boundaries**: [Strict boundaries of what is included and excluded in this release.]

---

## Block 3: Pre-Implementation Checklist
- [ ] Dependencies and package managers configured.
- [ ] Docker daemon active and accessible.
- [ ] Database migration baseline established.

---

## Block 4: Step-by-Step Implementation Roadmap

### Step 1: [Step Title]
* **Requirement**: [Describe specific requirement from phase blueprints]
* **Prerequisites**: [Prerequisite files or setup]
* **Actions**:
  1. [Action 1]
  2. [Action 2]
* **Verification**: [Command or test to execute and prove correctness]

---

## Block 5: Post-Implementation Verification & Qualification Handoff
* Run solution tests across modified components.
* Update `agent-workspace/plans/[feature]/PROCESS_STATUS.md` and hand off to `/qualify`.
