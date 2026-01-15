# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added `template/ROADMAP.md` — Template for tracking planned features with status legend and format guide.

### Changed
- Improved `/sync-start` workflow PR guidance—now specifies when to run `/pr-review` (security PRs, stale PRs, or when user has time to act).
- Integrated `/template-sync` into `/sync-start`—downstream projects now automatically check for and apply template updates during session start.
- Added untracked critical files check to `/sync-start`—warns if `scripts/`, `.antigravity/`, `frontend/`, or `tests/` are not committed.

### Added
- Created `template/scripts/sync-mcp-config.sh` to automate MCP server configuration synchronization with automatic GitHub token substitution.
- Updated `template/.agent/IDE_CONFIG.md` to include MCP sync in the environment setup checklist.

### Fixed

- Fixed 34 markdown linting issues (MD040, MD031, MD029, MD025, MD041) across documentation, skills, and workflows.
- Added language specifiers (`text`, `bash`, `python`) to all fenced code blocks.
- Fixed blank lines around fences, ordered list numbering, and duplicate headings.

### Added

- Added dependency version management infrastructure:
  - `.github/dependabot.yml` — Automated dependency update PRs
  - `VERSIONS.md` — Central tracking for pinned tool versions
  - `.jules/prompts/tool_version_auditor.md` — Jules prompt for template tooling updates
  - `.agent/skills/update-deps/SKILL.md` — Interactive skill for complex update scenarios
- Added "Dependency Version Management" section to AGENTS.md
- Added template sync infrastructure:
  - `.agent/skills/template-sync/SKILL.md` — Skill for propagating updates to downstream projects
  - `.agent/workflows/template-sync.md` — Workflow to invoke sync skill
  - `TEMPLATE_VERSION` — Version tracking file for downstream projects
- Added Jules GitHub Actions scheduler:
  - `.github/workflows/jules-schedule.yml` — Fire-and-forget pattern for automated Jules tasks via API
  - Updated `.jules/prompts/README.md` with schedule table and manual trigger commands
  - Updated `first-time-setup` skill with Jules automation setup (Step 12)
- Enhanced template integrity and auditing:
  - Add `/update-deps` and `/recover` workflows
  - Add "Skills Architecture" section to `AGENTS.md`
  - Update `QUICK_REFERENCE.md` with version tracking files and API key
  - Clean up obsolete `jules-setup` skill
  - Update `bootstrap` skill for new automation setup flow

- Added `/bootstrap` workflow to automate project creation from Gem seed files.
- Added comprehensive agentic development infrastructure in `template/`.
- Added technical and non-technical Gemini Gem prompts in `gem-prompts/`.
- Initialized project scaffolding with support for Jules automation.
