# Implementation Plan Structure Guide
# Activation: On Request (Triggered via @implementation-plan or when tasked with planning)

Whenever you are asked to create, update, or outline an implementation plan, you MUST follow this exact five-phase structural hierarchy. Do not skip sections, and do not change the order of execution. The architecture must clearly isolate the presentation layer from the functional machinery.

## Phase 1: High-Level Project Summary & Vision
This document serves as the absolute compass for the project's vision, goals, and initial execution roadmap.
- **Project Vision & Final Goal:** Clear statement explaining the ultimate objective and final state of the application.
- **Execution Roadmap:** High-level description of the logical milestones and steps required to fulfill the vision.
- **Planned Folder Structure:** An explicit ASCII tree design of the workspace. This layout must purposefully mirror the subsequent phases, organizing files into modular, cleanly segregated boundaries to keep planning and implementation separate.

## Phase 2: Product Layout & Appearance Specifications
This file collects all technical requirements, design laws, and structural constraints directly related to how the product looks and how the user interfaces function.
- **UI/UX Design Philosophy:** Statements guiding the behavior, responsiveness, and look of the interface.
- **HTML Structuring Rules:** Component layouts, semantic tag requirements, and DOM organization templates.
- **CSS Styling Laws:** Pure CSS design systems, global theme layout rules, custom properties (variables), and spacing grids.

## Phase 3: Core Engine Specifications
This file maps out the functional "machinery" operating behind the layout scene. It acts as the technical blueprint for background logic, data pipelines, and core automation workers.
- **Core Engine Mechanics:** Deep technical requirements for backend handlers, background service architectures (such as web scrapers, data parsers, or curation agents).
- **Data Flow & Pipelines:** Systematic tracing of ingestion cycles, internal object processing models, and memory/disk management.
- **Interoperability Trace:** The explicit contract mapping out exactly how the Engine sends/receives payloads to and from the Phase 2 Layout scene.

## Phase 4: Application Verification Plan
This file governs everything related to validating, testing, and confirming the health of the planned and implemented application.
- **Backend & Engine Testing:** Explicit shell execution commands, script parameters, and mock input sets to validate core processing logic.
- **API & Payload Assertions:** Expected status codes, layout verification criteria, and raw `curl` or execution sequences to test data transport boundaries.
- **UI & DOM Interaction Checks:** Target console assertions, expected browser state changes, and visual validation milestones.

## Phase 5: Operational & Deployment Layout
This file collects all design elements, configuration environments, and infrastructure laws required to run and maintain the live system.
- **Containerization Solutions:** Multi-stage `Dockerfile` specifications and local `docker-compose.yml` operational networking environments.
- **CI/CD Pipeline Architecture:** Step-by-step specifications for automated building, linting, and continuous delivery flows.
- **Scheduling & Trigger Systems:** Requirements for system-level or internal task schedules, event-driven cron triggers, background daemon lifecycles, and automated telemetry supervisors.
