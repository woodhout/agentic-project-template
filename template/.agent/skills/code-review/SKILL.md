---
name: Code Review
description: Multi-model code review with artifact handoff protocol
---

# Code Review Skill

Perform thorough code reviews using single-pass or multi-model handoff patterns.

## When to Use This Skill

Use this skill when:

- User asks for a "code review" or "review my changes"
- Before merging significant changes
- When `/review` workflow is invoked
- For security-sensitive code changes

## Decision Tree

```
What type of review?
├── Self-review (single model)
│   └── Use checklist-based review
│
├── Multi-model review
│   └── Create handoff artifact for second model
│
└── PR review (existing PR)
    └── Fetch PR diff, provide inline feedback

Severity classification:
├── 🔴 Security → Flag immediately, block merge
├── 🟠 Bug → High priority, must fix
├── 🟡 Style → Low priority, suggest fix
└── 🟢 Enhancement → Optional improvement
```

## Review Checklist

For each file changed, verify:

### Correctness

- [ ] Logic is sound
- [ ] Edge cases handled
- [ ] Error handling present
- [ ] No obvious bugs

### Security

- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] SQL injection prevented
- [ ] XSS prevented (if frontend)

### Performance

- [ ] No N+1 queries
- [ ] Appropriate caching
- [ ] No memory leaks
- [ ] Async where appropriate

### Maintainability

- [ ] Code is readable
- [ ] Functions are focused
- [ ] Comments explain "why"
- [ ] Types are correct

### Tests

- [ ] Tests exist for new code
- [ ] Tests pass
- [ ] Edge cases tested
- [ ] Mocks are appropriate

## Multi-Model Handoff Protocol

When performing multi-model review:

### Step 1: Create Handoff Artifact

Create `.gemini/antigravity/brain/[conversation-id]/code-review-handoff.md`:

```markdown
# Code Review Handoff

## Context

- Files changed: [list]
- Purpose of changes: [description]
- Risk level: [low/medium/high]

## First Model Findings

### Issues Found

1. [Issue description] - [Severity]
   - File: [path]
   - Line: [number]
   - Recommendation: [fix]

### Questions for Second Model

1. [Question about design/approach]

## Files to Review

[Include relevant code snippets or full files]
```

### Step 2: Notify User

Inform user the handoff is ready and how to continue with second model.

### Step 3: Second Model Review

Second model should:

1. Read handoff artifact
2. Review from fresh perspective
3. Add findings to artifact
4. Provide final recommendation

## Single-Model Review Output

Format findings as:

```markdown
## Code Review Results

### Summary

- Files reviewed: X
- Issues found: X (🔴 X, 🟠 X, 🟡 X)
- Recommendation: [Approve / Request Changes / Needs Discussion]

### Findings

#### 🔴 Critical: [Title]

**File:** `path/to/file.py:123`
**Issue:** [Description]
**Fix:** [Recommendation]

#### 🟠 Bug: [Title]

...
```

## Common Patterns to Flag

| Pattern                    | Severity | Reason                 |
| -------------------------- | -------- | ---------------------- |
| `eval()`, `exec()`         | 🔴       | Code injection risk    |
| Hardcoded credentials      | 🔴       | Security               |
| Missing try/catch          | 🟠       | Error handling         |
| `# TODO` without issue     | 🟡       | Track in issue tracker |
| Magic numbers              | 🟡       | Use constants          |
| Long functions (>50 lines) | 🟡       | Split for readability  |
