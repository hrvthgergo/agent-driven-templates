# Implementation Plan Structure Guide
# Activation: On Request (Triggered via @implementation-plan or when tasked with planning)

Whenever you are asked to create, update, or outline an implementation plan, you MUST follow this exact five-phase structural hierarchy. Do not skip sections, and do not change the order of execution.

## Phase 1: High-Level Project Understanding & Description
Provide a comprehensive overview to establish a shared state of understanding before touching any code.
- **Project Objective:** A clear, concise statement explaining the ultimate goal of the project.
- **General Description:** A breakdown of what the application does, who it is for, and the core problem it solves.
- **Architectural Overview:** A high-level view of how data flows through the system.

## Phase 2: Bottom-Up Element Summary & File System Layout
Summarize the elements of the project using a strict **Bottom-to-Top (Data/Backend to View/Frontend)** dependency approach. You must list components in this exact order:
1. **Data Layer & Core Logic:** Database schemas, data stores, utility functions, or underlying background scripts.
2. **API & Routing Layer:** Endpoints, request/response models, controllers, and backend server paths.
3. **Frontend Layer:** User interfaces, native browser interactions, views, and styling elements.
4. **Target File System Layout:** Provide a comprehensive ASCII directory tree showing exactly where every single file, hook, rule, or script will live in the workspace (using standard tree formatting branches).

## Phase 3: Exhaustive Deep-Dive Specifications
Analyze every single element identified in Phase 2 one by one. Go as deep as technically possible. For each element, you must provide:
- **Backend Elements:** Full business logic breakdown, error-handling strategies, dependencies, and explicit source file utilization (state exactly which scripts/modules are imported or modified).
- **Frontend Elements:** Detailed visual mockups or structural layouts using standard Markdown/text blocks. Detail semantic HTML positioning, native Vanilla JavaScript event listeners, and explicit CSS variable utilization.
- **Data Flow & Interoperability:** Trace the exact lifecycle of data as it moves from the specific backend file, through the API layer, down to the DOM elements.

## Phase 4: Step-by-Step Verification Plan
Outline a strict testing and validation matrix that mirrors the bottom-up implementation strategy. Do not consider a feature complete until it passes these three tiers:
1. **Isolated Backend/Logic Tests:** Explicitly state the execution commands (e.g., `go test ./...` or `python -m unittest`) and name the target test suites or mock inputs required to validate the core logic.
2. **API & Endpoint Integration Checks:** Detail the expected HTTP status codes, payload structures, and error states. Provide explicit `curl` commands or test scripts to verify response boundaries.
3. **Frontend & DOM Validation:** Detail the manual or automated assertions required to verify the user interface. State the expected console outputs, visual layout adjustments, and state mutations when a user interacts with the native JavaScript elements.

## Phase 5: Operational & Deployment Specification
Define the long-term lifecycle, configuration, and infrastructure layout. You must explicitly document:
1. **Containerization Architecture:** Complete multi-stage `Dockerfile` specifications for backend and frontend services. Provide a localized `docker-compose.yml` environment layout including healthchecks, volume mappings, and explicit networking policies.
2. **Orchestration & Kubernetes Settings:** Provide structural specifications for Kubernetes manifests—explicitly tracking `Deployment` specs, resource limits (CPU/Memory bounds), target `Service` mapping, and `ConfigMap` or `Secret` external environment layouts.
3. **Agentic Supervision & Telemetry:** Define exact programmatic instructions for runtime supervisor agents. Document automated monitoring conditions, expected health logs, and explicit self-healing operational steps (e.g., how the agent should automatically rotate logs or clear cache when constraints are met).
4. **Scheduled Tasks & Automation:** Outline internal and system-level cron structures, background execution workers, and automated continuous maintenance intervals.
