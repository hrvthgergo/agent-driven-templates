# Guard Specification: Interactive Q&A Engine ("Grill Guard")

This specification defines the reusable, stateful interactive questioning engine (inspired by Antigravity's `/grill-me` workflow) to be used across all workflow commands. It is a general-purpose component linked from the [Central Summary](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md) of the Guards Framework.

---

## 1. Core Architecture: How it Works

The Grill Engine operates as a gatekeeper at the start of any workflow step. Instead of making assumptions, the agent runs a sequential, chunked Q&A session.

```
[Start Workflow] ──> [Check State File]
                           │
                 Is Q&A Complete?
                 /        \
              (No)        (Yes)
              /              \
     [Load Q&A Schema]   [Execute Main Workflow]
            │
   [Ask 1-2 Questions]
            │
    [Record Answer]
            │
  [Save to State File]
            │
   (Loop until done)
```

---

## 2. Key Components

### A. Question Schemas (`.agents/rules/questions/`)
Each workflow step has a predefined set of questions stored as Markdown or JSON templates:
- [init_questions.md](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_questions.md): Project description, stack choices, container needs, and remote Git settings.
- `plan_phase_2_questions.md`: UI colors, fonts, layout boundaries.
- `plan_phase_3_questions.md`: DB types, data flow endpoints, third-party APIs.
- `implement_questions.md`: Micro-architectural choices, refactoring paths.

### B. State File (`.agents/plans/GRILL_STATUS.md`)
Tracks the current state of the interview to ensure the command is **iterable** and **recallable**:
```markdown
# Q&A State Tracker: /init

- [x] Project Name & Goal (Answered: "Guards Framework")
- [/] Technology Stack (Active: Waiting for user response)
- [ ] Docker Setup
```
If the session is interrupted, the agent reads this file and resumes exactly at the active question.

### C. The Skill (`.agents/skills/grill_engine/SKILL.md`)
Provides the agent with the guidelines for running the Q&A:
- **Rule of 2**: Ask a maximum of 2 questions per message to avoid cognitive overload.
- **Provide Options & Defaults**: Always list common recommendations first (e.g. `(Recommended) Pure CSS`, `TailwindCSS`).
- **Autosave**: Write answers immediately to `GRILL_STATUS.md` on every user message.

---

## 3. Workflow-Specific Question Examples

### 1. In `/init` (Project Bootstrapping)
To build the foundation of the project, `/init` grills the user on:
1. **Core Aim**: *"What is the primary goal of this application?"*
2. **Interface Choice**: *"Will this be a Web App, CLI, API service, or library?"*
3. **Tech Stack**: *"Which programming languages and frameworks should we initialize?"*
4. **Docker Base**: *"Should the development environment be built on a standard Python/Node base image, or do you have specific image needs?"*

### 2. In `/plan` (Blueprint Creation)
To populate the 5 planning phases, `/plan` runs mini-grill sessions:
- **Phase 2 (Layout)**: Ask about color themes, responsive breakpoints, CSS files structure.
- **Phase 3 (Engine)**: Ask about data persistence (SQL, NoSQL, or local files), schemas, and external APIs.
- **Phase 4 (Verification)**: Ask about testing tools (e.g., pytest, vitest) and how to mock external calls.

### 3. In `/implement` (Phase Implementation Maps)
Before drafting the specific `implementation-map.md`, `/implement` confirms:
1. **Starting Point**: *"Which module or file would you like to implement first?"*
2. **Design Patterns**: *"Should we use a repository pattern for DB operations, or simple data access functions?"*

---

## 4. Implementation Steps in the Workflows

To execute this, the `.agents/workflows/*.md` playbooks will follow this logic:
1. Check if `.agents/plans/GRILL_STATUS.md` exists. If not, create it from `.agents/rules/questions/<workflow>_questions.md`.
2. Find the first unchecked item in `GRILL_STATUS.md`.
3. Present the question to the user with options and wait for input.
4. On user response:
   - Save the answer in `GRILL_STATUS.md`.
   - Check the box.
   - Recurse until all questions are checked.
5. Proceed to the core action (scaffolding, plan drafting, or code generation).
