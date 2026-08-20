---
name: plan-generator
description: Skill for generating 6-phase blueprints and implementation maps
---

# Plan Generator Skill

## Procedure: 6-Phase Blueprints
Deploy templates into `agent-workspace/plans/<feature-name>/`:
- `phase-1-summary.md` (Mandatory master governor)
- `phase-2-layout.md`
- `phase-3-data.md`
- `phase-4-engine.md`
- `phase-5-test.md`
- `phase-6-operation.md`

## Procedure: Phase Details
For complex features, scaffold `agent-workspace/plans/<feature-name>/phase_details/<element_name>/` and link to master governors.

## Procedure: Research Reports
Draft reports under `agent-workspace/plans/<feature-name>/knowledge/research_report_<topic>.md` and link inside `phase-*.md`.

## Procedure: Versioned Implementation Maps
Draft map under `agent-workspace/plans/<feature-name>/implementation_maps/implementation_map_v<version>.md` adhering to `implementation_map_taxonomy.md`.
