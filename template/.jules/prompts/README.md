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

## Usage

When configuring a Jules task, copy the contents of the appropriate prompt file as the system instructions.

## Updating Prompts

1. **Edit the prompt file** directly with your changes
2. **Update `CHANGELOG.md`** with an entry describing what changed and why
3. **Test the changes** by running Jules with the updated prompt
4. **Commit** both the prompt change and changelog entry together

## Version History

See [`CHANGELOG.md`](./CHANGELOG.md) in this directory for the full history of prompt changes.
