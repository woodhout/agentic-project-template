# Jules Prompts Directory

This directory contains the system prompts for each Jules persona. Each prompt is stored as a separate markdown file for version tracking and easy modification.

## Available Personas

| Persona                   | File                                               | Purpose                                        |
| ------------------------- | -------------------------------------------------- | ---------------------------------------------- |
| **Sentinel** 🛡️           | [`sentinel.md`](./sentinel.md)                     | Security-focused agent for vulnerability fixes |
| **Bolt** ⚡               | [`bolt.md`](./bolt.md)                             | Performance optimization agent                 |
| **Context Sync** 📋       | [`context_sync.md`](./context_sync.md)             | Keep PROJECT_CONTEXT.md aligned with codebase  |
| **Analytics** 📊          | [`analytics_auditor.md`](./analytics_auditor.md)   | Verify telemetry on critical user actions      |
| **Compliance** ⚖️         | [`compliance_auditor.md`](./compliance_auditor.md) | User edit integrity & Glass Box verification   |
| **Dependency Doctor** 💊  | [`dependency_doctor.md`](./dependency_doctor.md)   | Scan for vulnerable/outdated packages          |
| **Test Guardian** 🧪      | [`test_guardian.md`](./test_guardian.md)           | Maintain test coverage, identify gaps          |
| **Code Formatter** 🎨     | [`code_formatter.md`](./code_formatter.md)         | Weekly automated code formatting PR            |
| **Dead Code Scanner** 🧹  | [`dead_code_scanner.md`](./dead_code_scanner.md)   | Weekly dead code detection and cleanup         |
| **Context7 Librarian** 📚 | [`context7_librarian.md`](./context7_librarian.md) | Daily Context7 library registry sync           |

## Automation via GitHub Actions

Prompts are automatically scheduled via `.github/workflows/jules-schedule.yml`:

| Task | Schedule | Cron |
|------|----------|------|
| Sentinel (security) | Daily 6 AM UTC | `0 6 * * *` |
| Code Formatter | Sunday 7 AM UTC | `0 7 * * 0` |
| Dependency Doctor | Monday 6 AM UTC | `0 6 * * 1` |
| Dead Code Scanner | Wednesday 6 AM UTC | `0 6 * * 3` |
| Test Guardian | Friday 6 AM UTC | `0 6 * * 5` |

**Fire and Forget Pattern:** GitHub Actions triggers Jules CLI and exits immediately. Jules executes asynchronously.

### Manual Trigger

```bash
gh workflow run jules-schedule.yml -f task=sentinel
```

### Required Secret

Generate an API key at [jules.google.com/settings#api](https://jules.google.com/settings#api) and add as repository secret:

```bash
gh secret set JULES_API_KEY
```

This uses your Google AI Pro subscription.

## Updating Prompts

1. **Edit the prompt file** directly with your changes
2. **Update `CHANGELOG.md`** with an entry describing what changed and why
3. **Test the changes** by running Jules with the updated prompt
4. **Commit** both the prompt change and changelog entry together

## Version History

See [`CHANGELOG.md`](./CHANGELOG.md) in this directory for the full history of prompt changes.

