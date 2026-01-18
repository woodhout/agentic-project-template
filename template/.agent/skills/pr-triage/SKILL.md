---
name: PR Triage
description: Review open PRs and recommend action (merge, rebase, close)
---

# PR Triage Skill

Efficiently triage open pull requests and recommend appropriate actions.

## When to Use This Skill

Use this skill when:

- User asks to "review PRs" or "check open PRs"
- When `/pr-review` workflow is invoked
- During regular maintenance cycles
- When Jules creates PRs that need review

## Decision Tree

```text
For each open PR:
│
├── Is CI passing?
│   ├── Yes → Continue to review
│   └── No → Diagnose failure
│       ├── Flaky test → Re-run CI
│       ├── Real failure → Request fixes
│       └── Infra issue → Flag for investigation
│
├── Are there merge conflicts?
│   ├── Yes → Recommend rebase
│   │   └── If author unresponsive → Offer to rebase
│   └── No → Continue
│
├── Is PR stale (>7 days no activity)?
│   ├── Yes → Ping author or close
│   └── No → Continue
│
├── Is it a draft?
│   ├── Yes → Skip unless explicitly requested
│   └── No → Continue
│
├── Review content
│   ├── Automated (Jules/Dependabot)
│   │   ├── Security fix → Priority merge
│   │   ├── Dependency update → Review changelog, merge
│   │   └── Code cleanup → Quick review, merge
│   └── Manual PR
│       └── Full code review (invoke code-review skill)
│
└── Final recommendation
    ├── ✅ Merge — Ready, approved, CI passing
    ├── 🔄 Rebase — Has conflicts
    ├── ⏸️ Wait — Needs author response
    ├── ❌ Close — Stale, superseded, or abandoned
    └── 👀 Review — Needs detailed review
```

## Process

### Step 1: Fetch Open PRs

> [!TIP]
> **Prefer CLI over MCP for listing PRs.** The `gh` CLI returns compact output, while
> GitHub MCP returns verbose JSON that can truncate context when there are 6+ PRs.

```bash
# Preferred: CLI (compact output)
gh pr list --state open --json number,title,author,createdAt,updatedAt,mergeable,statusCheckRollup
```

Use GitHub MCP only when you need to perform actions (merge, comment, etc.) or
when there are few PRs and you need the full object data:

```python
mcp_github_list_pull_requests(
    owner="[owner]",
    repo="[repo]",
    state="open"
)
```

### Step 2: Categorize PRs

| Category         | Criteria                            | Action                   |
| ---------------- | ----------------------------------- | ------------------------ |
| **Auto-merge**   | Bot PR, passing CI, no conflicts    | Merge                    |
| **Quick review** | Small diff (<100 lines), passing CI | Brief review → merge     |
| **Full review**  | Large diff, new feature             | Invoke code-review skill |
| **Blocked**      | Failing CI, conflicts, stale        | Diagnose and resolve     |

### Step 3: Present Summary and Wait for Approval

> [!IMPORTANT]
> **Always pause for user review before taking any actions.** Present the triage
> summary and recommended actions, then wait for explicit user approval before
> merging, closing, or modifying any PRs.

Generate the summary report (see Output Format below) and present it to the user.
Use `notify_user` with `BlockedOnUser=true` to request approval:

```text
I've analyzed [X] open PRs. Here's my triage summary:

[Summary table]

Recommended actions:
1. Merge #123 (bot PR, CI passing)
2. Request review for #124 (large feature)
3. Close #125 (stale, 14+ days)

Shall I proceed with these actions?
```

**Only proceed to Step 4 after receiving explicit user approval.**

### Step 4: For Each PR

**Check CI Status:**

```bash
gh pr checks [PR_NUMBER]
```

**Check for conflicts:**

```bash
gh pr view [PR_NUMBER] --json mergeable
```

**Review diff:**

```bash
gh pr diff [PR_NUMBER]
```

### Step 5: Take Action

**Merge:**

```bash
gh pr merge [PR_NUMBER] --squash --delete-branch
```

**Rebase:**

```bash
gh pr checkout [PR_NUMBER]
git fetch origin main
git rebase origin/main
git push --force-with-lease
```

**Close:**

```bash
gh pr close [PR_NUMBER] --delete-branch --comment "Closing: [reason]"
```

**Request changes:**

```bash
gh pr review [PR_NUMBER] --request-changes --body "[feedback]"
```

## Output Format

```markdown
## PR Triage Report

**Repository:** [owner/repo]
**Date:** [YYYY-MM-DD]
**Open PRs:** X

### Action Summary

| PR   | Title         | Author      | Age | Action            |
| ---- | ------------- | ----------- | --- | ----------------- |
| #123 | Fix typo      | @jules      | 2d  | ✅ Merged         |
| #124 | Add feature   | @dev        | 5d  | 👀 Needs review   |
| #125 | Update deps   | @dependabot | 1d  | ✅ Merged         |
| #126 | WIP: Refactor | @dev        | 14d | ❌ Closed (stale) |

### Details

#### PR #124: Add feature

- **Status:** Needs review
- **CI:** ✅ Passing
- **Conflicts:** None
- **Size:** +450/-120
- **Recommendation:** Invoke code-review skill for detailed analysis

### Next Steps

1. [Action item 1]
2. [Action item 2]
```

## Handling Jules PRs

Jules-created PRs have specific patterns:

| PR Type           | Identification                               | Action                           |
| ----------------- | -------------------------------------------- | -------------------------------- |
| Dependency update | Title contains "deps" or "dependency"        | Review changelog, merge if minor |
| Dead code removal | Title contains "dead code" or "unused"       | Verify removals, merge           |
| Formatting        | Title contains "format" or "lint"            | Quick verify, merge              |
| Security fix      | Title contains "security" or "vulnerability" | Priority review and merge        |

## Common Issues

| Issue                       | Solution                          |
| --------------------------- | --------------------------------- |
| Merge conflicts on Jules PR | Rebase on main, re-push           |
| CI failing on valid code    | Check if test is flaky, re-run    |
| PR superseded by another    | Close older PR with reference     |
| Author unresponsive         | Comment ping, close after 14 days |

### Step 6: Finalize Local Changes

> [!IMPORTANT]
> **Always commit local changes before completing.** If any local edits were made
> during the review process (docstring fixes, CHANGELOG updates, etc.), commit and
> push them before finishing.

Check for uncommitted changes:

```bash
git status
```

If there are local changes:

```bash
git add -A
git commit -m "chore: pr-review remediation

- [List changes made during review]"
git push origin main
```

Confirm clean state before completing:

```bash
git status
# Should show: nothing to commit, working tree clean
```
