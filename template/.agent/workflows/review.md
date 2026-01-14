---
description: perform multi-model code review with artifact handoff
---

# Review Workflow

Invoke the `code-review` skill for comprehensive code reviews.

## Quick Usage

For a simple self-review:

```
Review my recent changes
```

For multi-model handoff:

```
Perform a multi-model code review of [files/PR]
```

## What the Skill Does

The `code-review` skill provides:

1. **Review type selection** (self, multi-model, PR)
2. **Severity classification** (🔴 Security → 🟢 Enhancement)
3. **Comprehensive checklist** (correctness, security, performance, tests)
4. **Multi-model handoff protocol** with artifact template

See `.agent/skills/code-review/SKILL.md` for full details.
