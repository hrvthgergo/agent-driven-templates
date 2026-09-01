---
name: operate-deliver
description: Operations & Delivery skill for executing image builds, tracking digests, and asserting health contracts without authoring authority.
---

# Skill: `operate-deliver`

This skill provides the execution utilities for the `/operate` workflow. It is explicitly restricted from modifying source code, Dockerfiles, compose YAML, or infrastructure definitions.

## 1. Build & Digest Checking Procedures
- **Compute Source State**: Calculate a deterministic hash representing the current state of `codebase-<layer>/` directories to be built.
- **Digest History Matching**: Parse `WALKTHROUGH.md` files to find a prior build whose source state exactly matches the current state.
- **Image Re-Tagging**: Retrieve the `sha256` digest of a matched previous build and apply the new `--version` tag to it (without rebuilding).
- **Fresh Image Build**: Execute `docker build` (or equivalent) using the *existing* Dockerfiles provided by `/implement`. Record the resulting `sha256` digest.
- **Digest Verification**: Compare the computed source digest against the certified digest found in `QUALIFICATION_REPORT.md` for the Provenance Gate.

## 2. Promotion & Deployment Procedures
- **Push Immutable Image**: Push the tagged digest to the environment's container registry.
- **Execute Post-Delivery Hook**: Invoke the deployment or notification script specifically identified in `phase-6-operation.md` §5 for the target environment.

## 3. Health Assertion Evaluators (Node O5)
- **Signal Presence Check**: Verify that metrics, logs, or traces defined in `phase-6-operation.md` §6a are actively reaching the endpoint specified in §6b.
- **Health & Readiness Ping**: Execute curl or HTTP checks against defined health endpoints. Respect the **soak duration** (e.g., maintaining 200 OK continuously for 30 seconds).
- **Alert Registration Scan**: Query the monitoring provider to ensure the alerts defined in §6c are registered and route to the correct target.
- **Ops Finding Generation**: If any health assertion fails or times out, immediately yield an ops finding payload (`origin: operate, status: unratified`) back to the workflow, triggering an execution halt.
