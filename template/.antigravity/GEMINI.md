# Global IDE Rules

### Project Context Loading (MANDATORY)

Before starting ANY work in a clone of `[PROJECT_NAME]`,
ALWAYS read `AGENTS.md` first for critical project rules and architectural constraints.

### Quick Rules (Simple Tasks Only)

For quick answers or trivial changes, these core rules apply:

- **Append-only logs**: Never overwrite CHANGELOG.md, COMPLIANCE_LOG.md
- **File safety**: Don't delete files without asking
- **LLM outputs**: Use `instructor` library for structured output
- **Idempotency**: Check storage before regenerating artifacts
- **Tests before commit**: Run `pytest tests/ -m "not expensive"`
- **Log mistakes**: Add agent errors to AGENTS.md anti-patterns table

For complex tasks, read `AGENTS.md` for full architectural constraints.

### Append-Only Log Files

Files named CHANGELOG.md, COMPLIANCE_LOG.md, or similar audit logs must NEVER be overwritten.

- Prepend new entries for newest-first logs
- Append for oldest-first logs
  Always read existing content before writing.

### Documentation Hygiene

Before committing, update relevant documentation:

- CHANGELOG.md for any functional changes
- QUICK_REFERENCE.md if architecture changed
- Architecture docs if structure changed

### Dependency Sync

When adding a library dependency, immediately update the lockfile:

- Python: requirements.txt
- Node: package.json / package-lock.json

### File Deletion Safety

Do not delete existing files without explicit user confirmation.

### PR Hygiene

Before creating a PR:

1. Rebase on latest main: git fetch origin main && git rebase origin/main
2. Check for existing PRs to avoid duplicate work
3. Keep PRs focused - one concern per PR
