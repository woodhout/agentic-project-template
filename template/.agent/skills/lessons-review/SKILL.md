---
name: Lessons Review
description: Process pending lesson submissions from downstream projects
---

# Lessons Review Skill

Review and resolve lesson submissions from downstream projects via GitHub Issues.

## When to Use

- Template maintainer reviewing pending lessons
- After `/sync-start` indicates pending lessons exist
- Periodic template maintenance

## Prerequisites

- Running in `agentic-project-template` repository
- `gh` CLI authenticated with repo access

## Process

### 1. Fetch Pending Lessons

```bash
gh issue list --repo woodhout/agentic-project-template \
  --label "lesson-submission" \
  --state open \
  --json number,title,body,createdAt \
  --jq '.[] | "Issue #\(.number): \(.title)\nCreated: \(.createdAt)\n\(.body)\n---"'
```

### 2. For Each Lesson, Evaluate Against Criteria

| Criteria | Question |
|----------|----------|
| **Universal** | Does this apply to all/most projects? |
| **Impactful** | Will this prevent errors or save time? |
| **Breaking** | Does this require downstream migration? |
| **Testable** | Can we verify the improvement? |

### 3. Decide: Accept, Reject, or Defer

**Accept:**

1. Implement the proposed fix in the affected template file(s)
2. Commit with atomic message: `lesson: [title] (#ISSUE_NUMBER)`
3. Close the issue with acceptance note:

   ```bash
   gh issue close [NUMBER] --comment "Accepted and implemented in commit [SHA]. Will sync to downstream projects."
   ```

**Reject:**

1. Close the issue with explanation:

   ```bash
   gh issue close [NUMBER] --comment "Rejected: [reason - e.g., too project-specific, breaks existing patterns]"
   ```

**Defer:**

1. Add comment explaining deferral:

   ```bash
   gh issue comment [NUMBER] --body "Deferred: [reason - e.g., needs more discussion, waiting for related changes]"
   ```

2. Optionally add a label: `gh issue edit [NUMBER] --add-label "deferred"`

### 4. Record in LESSONS_QUEUE.md (Optional)

For accepted lessons, optionally add to the "Resolved" section of `template/LESSONS_QUEUE.md` for historical record.

## Tips

- Process lessons one at a time with atomic commits
- If accepting requires significant work, consider creating a branch and PR
- Link related issues if multiple lessons address the same area
