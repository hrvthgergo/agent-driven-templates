---
name: plan-grill
description: Neutral Q&A Grill Rule Guard
---

# Plan Grill Rules

## Unchangeable Baselines
1. **Baseline 1 (Initial Summary Start)**: Mandates presenting Initial Summary (Node S2) prior to asking Q1.
2. **Baseline 2 (Feature Sandbox)**: Restricts all write/edit operations strictly to `agent-workspace/plans/<feature-name>/`.
3. **Baseline 3 (Embedded Decisions)**: Forbids creating a separate `decisions/` subfolder; enforces documenting choices directly inside `phase-*.md` files.
4. **Baseline 4 (Implementation Map Sandbox Guard)**: Forbids code execution or source file editing in `src/` or `codebase-*/` during `/plan`.
5. **Baseline 5 (Versioned Implementation Map Naming)**: Mandates naming implementation maps after software release versions (`implementation_map_v<version>.md`).

## Prompting Laws
- Neutral choices only.
- Free-text option on every question.
- No `[Recommended]` tags.

## Questionnaire Schema
Follow Q1-Q11 exactly as defined in `actions/plan/plan_questions.md`.
