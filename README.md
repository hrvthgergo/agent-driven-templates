# agent-driven-templates
collection of rules, skills and workflows for agent driven development

# Antigravity 2.0 5-Phase Planning Framework

This repository contains the global rules and automated workflows required to standardize and execute our **5-Phase Interactive Planning Assembly Line** within Google Antigravity 2.0,

## What is Included
- **`@implementation-plan` Rule:** Enforces a rigid 5-Phase layout structure (Summary, Layout, Specs, Verification, Operations) across all new blueprints.
- **`/plan` Workflow:** An automated, state-tracking playbook that builds the planning folders, scaffolds files, tracks progress via `PLAN_STATUS.md`, and guides you phase-by-phase.

## Quick Installation (macOS)

To install this framework globally on your Mac so that **every new project** automatically inherits these features, open your terminal and run this single installer command block:

```bash
# 1. Clone the repository templates
git clone [https://github.com/YOUR_GITHUB_USERNAME/antigravity-planning-template.git](https://github.com/YOUR_GITHUB_USERNAME/antigravity-planning-template.git) /tmp/ag-template

# 2. Ensure global configuration directories exist
mkdir -p ~/.agents/rules ~/.agents/workflows

# 3. Copy files to your global environment
cp /tmp/ag-template/rules/implementation-plan.md ~/.agents/rules/
cp /tmp/ag-template/workflows/planning-line.md ~/.agents/workflows/

# 4. Clean up temporary files
rm -rf /tmp/ag-template

echo "Installation complete! Open Antigravity 2.0 and type /plan to start."
```
