---
description: submit lessons learned from this project back to the template
---

# Template Feedback Workflow

Submit improvements discovered in downstream projects back to the template.

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

### 2. Navigate to Template

```bash
# turbo
cd ~/dev/personal/agentic-project-template/template
```

### 3. Add Entry to LESSONS_QUEUE.md

Prepend a new entry at the top of the "Pending Lessons" section:

```markdown
### YYYY-MM-DD: [Brief title]

**Source:** [project name]
**Category:** Workflow | Skill | Pattern | Config | Docs
**Affected:** [file path(s)]

**Problem:**
[What happened or what limitation was discovered]

**Proposed Fix:**
[Specific change recommendation]

**Rationale:**
[Why this improves the template]
```

### 4. Commit the Entry

```bash
git add LESSONS_QUEUE.md
git commit -m "lesson: [brief title] from [project-name]"
git push origin main
```

### 5. (Optional) Create Issue for Complex Changes

For lessons requiring significant work:

```bash
gh issue create \
  --title "Template improvement: [title]" \
  --body "See LESSONS_QUEUE.md entry from YYYY-MM-DD" \
  --label "template-improvement"
```

## Example Entry

```markdown
### 2026-01-14: Prefer CLI over MCP for verbose APIs

**Source:** resume-tailoring-agentic-system
**Category:** Workflow
**Affected:** `.agent/workflows/pr-review.md`

**Problem:**
The initial MCP API response truncated 6+ PRs due to verbose JSON.

**Proposed Fix:**
`/pr-review` should use `gh pr list` CLI which returns minimal output.

**Rationale:**
CLI tools provide concise output optimized for terminal use, while MCP/API
responses include full JSON payloads that can exceed context windows.
```
