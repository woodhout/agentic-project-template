---
description: check for open PRs and issues (from Jules or others), summarize impact, and recommend action
---

# PR & Issue Review Workflow

This workflow checks for open Pull Requests and Issues, summarizes their impact, and awaits user input before taking action.

## Pre-Computed Context

// turbo
Run these commands first to gather context before analysis:

```bash
# Current branch and status
git branch --show-current && git status --short

# Open PRs with details (JSON for parsing)
gh pr list --state open --json number,title,author,headRefName,baseRefName,isDraft,mergeable --limit 20

# Open Issues (especially Compliance-labeled ones from Jules agents)
gh issue list --state open --json number,title,labels,author,createdAt --limit 20

# Recent commits on main (for context on what's been merged)
git log origin/main -5 --oneline
```

## Steps

### Pull Request Review

1. **Review pre-computed context** from above commands:

   - Use `mcp_github-mcp-server_list_pull_requests` with owner and repo
   - Filter by state: "open"

2. **For each PR, analyze**:

   - Title and description
   - Files changed (use `pull_request_read` with method `get_files`)
   - Diff summary (use `pull_request_read` with method `get_diff`)

3. **Summarize impact**:

   - What components are affected (backend, frontend, docs)?
   - Are there breaking changes?
   - Are there dependency updates?
   - Is documentation included?

4. **Recommend action**:

   - ✅ **Merge**: Clean, tested, no conflicts
   - 🔍 **Review needed**: Complex changes requiring inspection
   - ⚠️ **Caution**: Breaking changes or large scope
   - ❌ **Decline**: Duplicate or conflicts with other work

### Issue Review

5. **Check for open issues**:

   - Use `mcp_github-mcp-server_list_issues` with owner and repo, state: "OPEN"
   - Pay special attention to issues with labels: `Compliance`, `Security`, `Bug`
   - These may be raised by Jules agents (Compliance Auditor, Sentinel) requiring action

6. **For each issue, summarize**:

   - What action is needed?
   - Is there a related PR that addresses it?
   - Priority: Critical > High > Medium > Low

### Action & Cleanup

7. **Await user input** before:

   - Merging PRs
   - Requesting changes
   - Closing PRs or Issues

8. **Cleanup (Post-Merge)**:

   - After merging, check for and prune stale remote branches:

     ```bash
     git fetch --prune origin && git branch -r --merged origin/main | grep -v "origin/main" | sed 's/origin\///' | xargs -I {} git push origin --delete {}
     ```

## Important Notes

- Always check for CHANGELOG.md conflicts when multiple PRs are open
- Verify test status before recommending merge
- For Jules PRs, check if similar work exists locally to avoid duplicates
- Compliance Auditor creates Issues (not PRs) for violations — these need manual remediation
