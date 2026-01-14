---
description: check for open PRs and issues, summarize impact, and recommend action
---

# PR Review Workflow

Invoke the `pr-triage` skill to review and manage open pull requests.

## Quick Usage

```
Review open PRs
```

Or be specific:

```
Check PRs from Jules
Triage all open pull requests
Merge safe PRs
```

## What the Skill Does

The `pr-triage` skill provides:

1. **PR categorization** (auto-merge, quick review, full review, blocked)
2. **CI status checking** (passing, failing, flaky)
3. **Conflict detection** and rebase recommendations
4. **Staleness handling** (ping author, close abandoned)
5. **Action execution** (merge, rebase, close, request changes)

See `.agent/skills/pr-triage/SKILL.md` for full details.
