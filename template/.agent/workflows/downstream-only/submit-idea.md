---
description: submit a new project idea to the template for future bootstrapping
scope: downstream-only
---

# Submit Idea Workflow

Submit a new project idea from this downstream project to the template's idea queue.

## When to Use

- You have an idea for a NEW project (not a feature for this current project)
- The idea should be reviewed and potentially bootstrapped from the template

## Steps

### 1. Capture the Idea

Ask the user for:

- **Title:** Short name for the project
- **Description:** What problem does it solve? Why is it valuable?
- **Tech Stack:** (optional) Suggested technologies

### 2. Submit via GitHub Issue

// turbo

```bash
gh issue create --repo woodhout/agentic-project-template \
  --title "idea: [title] from [project-name]" \
  --body "**Source:** [project name]

**Title:** [idea title]

**Description:**
[What this project would do and why it's valuable]

**Suggested Tech Stack:** (optional)
[Any initial thoughts on implementation]" \
  --label "idea-submission"
```

### 3. Confirm Submission

Report back to the user:

- Issue URL created
- "The idea will be reviewed via `/idea-review` in the template project"

## Example

```bash
gh issue create --repo woodhout/agentic-project-template \
  --title "idea: Recipe Manager from resume-tailoring" \
  --body "**Source:** resume-tailoring-agentic-system

**Title:** Recipe Manager

**Description:**
A personal recipe manager that uses AI to suggest meal plans based on dietary preferences and available ingredients.

**Suggested Tech Stack:** (optional)
Python, FastAPI, React, OpenAI for meal suggestions" \
  --label "idea-submission"
```
