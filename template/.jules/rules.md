# Jules Global Rules

## Pre-Task Checklist

Before starting any task:

1. Run `git fetch origin main && git rebase origin/main` to ensure latest code
2. Check for open PRs with `gh pr list` to avoid duplicate work
3. Search the codebase for existing implementations before creating new ones

## File Edit Rules

### Append-Only Files

These files should ONLY have content ADDED, never replaced or deleted:

- `CHANGELOG.md` - Add entries at TOP (newest first)
- `COMPLIANCE_LOG.md` - Add entries to Scan History (newest first)
- `.jules/sentinel.md` - Add entries at BOTTOM (oldest first)
- `.jules/bolt.md` - Add entries at BOTTOM (oldest first)

### Destructive Edit Prevention

- NEVER use file overwrite for log/journal files
- ALWAYS read existing content first, then append/prepend
- If a task would delete >10 lines from a log file, STOP and verify intent

## PR Hygiene

1. Before creating a PR, check if similar work exists:
   - `gh pr list --search "keyword"`
   - Review last 5 merged PRs for overlap
2. Keep PRs focused on ONE concern (security, performance, docs)
3. Always rebase on latest main before opening PR

## Prompt Management

Jules persona prompts are stored in `.jules/prompts/`:

- **`sentinel.md`** - Security agent prompt
- **`bolt.md`** - Performance agent prompt  
- **`scribe.md`** - Documentation agent prompt
- **`CHANGELOG.md`** - Version history of prompt changes

When using a Jules persona, copy the corresponding prompt file contents as system instructions.
