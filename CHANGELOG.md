# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added `template/ROADMAP.md` — Template for tracking planned features with status legend and format guide.
- Added GitHub templates (`.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`) to `template-sync` skill scope.
- Added 🔴 Automate Bootstrap from Gem Seeds to roadmap (High Priority).
- Expanded `template/ROADMAP.md` with additional planned features:
  - Autonomous Manual Test Execution policy (Antigravity extension + recording)
  - Browser-Based Deep Research Skill for enhanced planning context
  - Guidance on Opportunistic Lint and Type Error Fixes
  - Jules Agent for Deprecation Warning Detection in installed packages
- Created `template/scripts/sync-mcp-config.sh` to automate MCP server configuration synchronization with automatic GitHub token substitution.
- Updated `template/.agent/IDE_CONFIG.md` to include MCP sync in the environment setup checklist.
- Added new directives to `template/AGENTS.md`:
  - Section 6: Autonomous Manual Test Execution
  - Section 7: Opportunistic Error Fixing
  - Deprecation Scanning (Jules) section
  - `deep-research` skill reference in Skills Architecture table
- Bumped `template/TEMPLATE_VERSION` to v1.1.0.

### Changed

- Enhanced `pr-triage` skill with user approval checkpoint (Step 3) before taking any actions.
- Enhanced `pr-triage` skill with finalize step (Step 6) to commit and push local changes made during review.
- Expanded Jules schedule to include all 11 agents by default (was 5). New schedule runs between midnight-1 AM CST:
  - Daily: Sentinel
  - Weekly: Code Formatter, Dependency Doctor, Analytics Auditor, Dead Code Scanner, Context7 Librarian, Compliance Auditor, Test Guardian, Context Sync
  - Monthly: Tool Version Auditor
  - Manual: Bolt (performance optimization)
- Improved `/sync-start` workflow PR guidance—now specifies when to run `/pr-review` (security PRs, stale PRs, or when user has time to act).
- Integrated `/template-sync` into `/sync-start`—downstream projects now automatically check for and apply template updates during session start.
- Added untracked critical files check to `/sync-start`—warns if `scripts/`, `.antigravity/`, `frontend/`, or `tests/` are not committed.
- Executed `/sync-end` workflow to document and wrap up the session.
- Verified server shutdown and process cleanup.

### Fixed

- Fixed 34 markdown linting issues (MD040, MD031, MD029, MD025, MD041) across documentation, skills, and workflows.
- Added language specifiers (`text`, `bash`, `python`) to all fenced code blocks.
- Fixed blank lines around fences, ordered list numbering, and duplicate headings.

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
