---
name: plan
description: Interactive planning workflow for 6-phase blueprints and versioned implementation maps
---

# Plan Workflow

This workflow orchestrates the interactive planning process.

## Parameters
* `/plan`: Default interactive execution mode. Automatically detects active Git feature branch (or prompts for feature name) and targets `agent-workspace/plans/<feature-name>/`.
* `/plan --feature <feature_name>`: Explicitly specifies the target feature name.
* `/plan --auto`: Bypasses Node S5 acceptance gate.
* `/plan --dry-run`: Previews proposed phase blueprints without writing.

## Steps
1. **Node S1 (Check Preconditions & Feature Branch)**: Verifies workspace initialization (Agentic Environment `.agents/` and Folder-Based Control Plane `agent-workspace/`) and active feature branch.
2. **Node S2 (Initial Feature Understanding Summary)**: Synthesizes initial feature understanding and presents an Initial Feature Summary to the developer *before* Q&A begins.
3. **Node S3 (Interactive Q&A Session)**: Invokes the interview engine adhering to `rules/plan-grill.md`.
4. **Node S4 (Dynamic Blueprint Scaffolding & Impact Drafting)**: Invokes `skills/plan-generator/SKILL.md` to scaffold active `phase-*.md` documents, `phase_details/` subfolders, and `knowledge/research_report_<topic>.md` files inside `agent-workspace/plans/<feature-name>/`.
5. **Node S5 (Execution Acceptance Gate & Versioned Implementation Map Option)**: Synthesizes blueprint status for review. Presents an option to draft `implementation_map_v<version>.md`.
6. **Node S6 (PROCESS_STATUS.md Sync & Log Update)**: Synchronizes `agent-workspace/plans/<feature-name>/PROCESS_STATUS.md` matrix and appends daily history log.
7. **Node S7 (Planning Completed)**: Reports planning summary and instructions to proceed to `/implement`.
