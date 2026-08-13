# Agent-Driven Guards Framework

A universal, environment-agnostic platform of **Guards**—structured execution gates, process controls, workflow boundaries, and verification assertions—designed to guide AI agents through a disciplined, safe, and token-optimized software planning and development lifecycle.

---

## Core Philosophy: Universal Framework vs. Target Implementations

The **Guards Framework** intentionally separates high-level architectural design intent, workflow governance, and process control from runtime-specific execution engines:

- **Universal Guard Platform**: Overarching workflow specifications (such as Interactive Planning, Verification Gates, Process Status Handling, and Multi-Repository Architecture) are defined generically to ensure safety, predictability, and quality across any AI development environment.
- **Platform-Specific Implementations**: Abstract guard concepts and execution maps are mapped to concrete native primitives within target AI agent environments:
  - **Google Antigravity**: Serves as a primary reference implementation, realizing guard specifications through native platform primitives such as *Rules, Workflows, Skills, Hooks, Sidecars, and Process Status specifications*.
  - **Other Agent Environments** (e.g., OpenAI Codex, Claude Code, or custom agent loops): Adapt the universal guard specifications using their respective native prompt schemas, custom tool protocols, or platform capabilities.

---

## Key Components

All active specifications and operational playbooks are maintained under `fullstack_software_dev/`:

- **[Summary & Operational Lifecycle](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md)**: Central entry point detailing the 3-tier structure, 6 development workflows, and lifecycle Mermaid diagram.
- **[End-User Guide & Operational Manual](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/user_guide.md)**: Conceptual summary, workflow principles, and operational manual for developers and AI agents.
- **[Guard Process Handling Spec (`PROCESS_STATUS.md`)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md)**: Release and feature governance with a concise 2-block status matrix and daily execution history log.
- **[Multi-Repo & Docker Strategy Spec](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md)**: Hybrid Docker containerization, symlink mapping, and dynamic layer expansion.
- **[Standard Folder Structure Spec](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/folder_structure.md)**: Standard project folder layout, pure control plane architecture, and sub-repo symlink definitions.
- **[Initialization Workflow (/init)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md)**: Bootstrapping playbook, 3-block Q&A schema (`init_questions.md`), and initialization execution maps.
- **[Legacy Code & Docs Processing (/process)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process/process_workflow.md)**: Standalone workflow for deep historical code analysis, documentation review, and refactoring proposals.
- **[Grill Engine Gate](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md)**: Reusable Q&A engine design rules and state file formats (`GRILL_STATUS.md`).
- **[Language-Specific Code Graph Taxonomy](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/code_graph_taxonomy.md)**: Universal node and connection rules for Python, Go, and JavaScript.

---

## Directory Layout

```text
agent-driven-templates/
├── README.md                          # Repository overview & framework philosophy
└── fullstack_software_dev/
    ├── summary.md                     # Central entry point, 3-tier structure & workflow sitemap
    ├── user_guide.md                  # End-User Guide & Operational Manual
    ├── folder_structure.md            # Standard repository folder layout
    ├── grill_engine.md                # Reusable Q&A Grill Engine specification
    ├── multi_repo_architecture.md     # Multi-repo symlinks & Hybrid Docker strategy
    ├── process_handling.md            # Guard Process Handling Spec (PROCESS_STATUS.md)
    ├── code_graph_taxonomy.md         # Language-Specific Code Graph Taxonomy (Python, Go, JS)
    ├── init/                          # [Tier 2] Initialization Workflow Subfolder
    │   ├── init_workflow.md           # /init Bootstrapping workflow specification
    │   ├── init_questions.md          # 3-Block Q&A Grill schema
    │   └── antigravity/               # [Tier 3] Antigravity reference implementation
    │       ├── init_implementation_map.md # Antigravity execution map & decision links
    │       ├── init_tests.md          # Greenfield & brownfield verification test suite
    │       └── guards/                # Antigravity native primitives (rules, skills, hooks)
    ├── process/                       # [Tier 2] Legacy Processing Workflow Subfolder
    │   ├── process_workflow.md        # /process Brownfield workflow specification
    │   ├── process_questions.md       # /process Q&A Grill schema
    │   └── antigravity/               # [Tier 3] Antigravity reference implementation
    │       ├── process_implementation_map.md
    │       └── process_tests.md
    ├── plan/                          # Interactive Planning workflow (Planned)
    ├── implement/                     # Action Implementation workflow (Planned)
    ├── verify/                        # Automated Verification workflow (Planned)
    └── release/                       # Release & Operations workflow (Planned)
```

