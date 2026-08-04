# Agent-Driven Guards Framework

A comprehensive framework of **Guards** (Rules, Workflows, Skills, Hooks, Sidecars, and Process Status specifications) to guide AI agents through a disciplined, safe, and token-optimized software planning and development lifecycle using Google Antigravity.

---

## Key Components

All active specifications and operational playbooks are maintained under `fullstack_software_dev/`:

- **[Summary & Operational Lifecycle](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/summary.md)**: Central entry point detailing the 6 development workflows and lifecycle Mermaid diagram.
- **[Guard Process Handling Spec (`PROCESS_STATUS.md`)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_handling.md)**: Release and feature governance with a concise 2-block status matrix and daily execution history log.
- **[Multi-Repo & Docker Strategy Spec](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/multi_repo_architecture.md)**: Hybrid Docker containerization, symlink mapping, and dynamic layer expansion.
- **[Initialization Workflow (/init)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/init/init_workflow.md)**: Bootstrapping playbook, 3-block Q&A schema (`init_questions.md`), and directory layouts (`folder_structure.md`).
- **[Legacy Code & Docs Processing (/process-history)](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/process_history/process_history_workflow.md)**: Standalone workflow for deep historical code analysis, documentation review, and refactoring proposals.
- **[Grill Engine Gate](file:///Users/horvathgergo/Desktop/agent-driven-templates/fullstack_software_dev/grill_engine.md)**: Reusable Q&A engine design rules and state file formats (`GRILL_STATUS.md`).

---

## Directory Layout

```text
agent-driven-templates/
├── README.md
└── fullstack_software_dev/
    ├── summary.md                     # Central entry point & workflow sitemap
    ├── grill_engine.md                # Reusable Q&A Grill Engine specification
    ├── multi_repo_architecture.md     # Multi-repo symlinks & Hybrid Docker strategy
    ├── process_handling.md            # Guard Process Handling Spec (PROCESS_STATUS.md)
    ├── init/
    │   ├── init_workflow.md           # /init Bootstrapping workflow specification
    │   ├── init_questions.md          # 3-Block Q&A Grill schema
    │   ├── folder_structure.md        # Standard repository folder layout
    │   ├── init_implementation_map.md # /init Antigravity execution map & decision links
    │   └── guards/
    │       └── antigravity/           # Environment-specific Antigravity guards
    ├── process_history/
    │   ├── process_history_workflow.md# /process-history Brownfield workflow specification
    │   ├── process_history_questions.md# /process-history Q&A Grill schema
    │   └── antigravity/               # Antigravity implementation map & test specifications
    │       ├── process_history_implementation_map.md
    │       └── process_history_tests.md
    ├── plan/                          # Interactive Planning workflow (Planned)
    ├── implement/                     # Action Implementation workflow (Planned)
    ├── verify/                        # Automated Verification workflow (Planned)
    └── release/                       # Release & Operations workflow (Planned)
```
