---
description: submit lessons learned from this project back to the template
---

# Template Feedback Workflow

Submit improvements discovered in downstream projects back to the template via GitHub Issues.

## When to Use

- Discovered a better approach than what the template provides
- Found a bug or limitation in a template workflow/skill
- Identified a pattern that should be universalized

## Steps

### 1. Formulate the Lesson

Capture these elements:

- **Problem:** What went wrong or could be improved?
- **Proposed Fix:** Specific change to template file(s)
- **Rationale:** Why is this better?

### 2. Submit via GitHub Issue

// turbo

```bash
gh issue create --repo woodhout/agentic-project-template \
  --title "lesson: [brief title] from [project-name]" \
  --body "**Source:** [project name]
**Category:** Workflow | Skill | Pattern | Config | Docs
**Affected:** [file path(s)]

**Problem:**
[What happened or what limitation was discovered]

**Proposed Fix:**
[Specific change recommendation]

**Rationale:**
[Why this improves the template]" \
  --label "lesson-submission"
```

**Note:** No local template clone required. The template maintainer will review via `/review-lessons`.

## Example

```bash
gh issue create --repo woodhout/agentic-project-template \
  --title "lesson: Add --delete-branch to pr-triage from resume-tailoring" \
  --body "**Source:** resume-tailoring-agentic-system
**Category:** Skill
**Affected:** \`.agent/skills/pr-triage/SKILL.md\`

**Problem:**
When closing PRs (not merging), remote branches were left behind.

**Proposed Fix:**
\`\`\`diff
-gh pr close [PR_NUMBER] --comment \"Closing: [reason]\"
+gh pr close [PR_NUMBER] --delete-branch --comment \"Closing: [reason]\"
\`\`\`

**Rationale:**
Bot-created PRs don't need branch preservation. Prevents stale branch accumulation." \
  --label "lesson-submission"
```
