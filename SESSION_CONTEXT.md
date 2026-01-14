# Agentic Project Template - Session Context Handoff

> Use this to seed a new conversation in the `agentic-project-template` workspace.

---

## Project Overview

**Repo:** `woodhout/agentic-project-template` (GitHub)
**Purpose:** A standalone template for bootstrapping new projects with full agentic development infrastructure.

The template provides:

- AGENTS.md with critical directives
- 10 workflows (sync-start, sync-end, format, push, test, review, simplify, pr-review, roadmap-review, python)
- 9 skills (bootstrap, jules-setup, skill-evolution, code-review, simplify, pr-triage, first-time-setup, debug-tests, recovery)
- Gem prompts for Gemini (technical-cofounder, non-technical-user)
- Jules automation prompts (12 scheduled tasks)
- Pre-commit hooks (ruff, mypy, detect-secrets)
- MCP config template with curated tool allowlists (~48 tools)

---

## Recent Work Completed

### Skills Created

| Skill              | Purpose                                |
| ------------------ | -------------------------------------- |
| `bootstrap`        | Create project from Gem seed files     |
| `jules-setup`      | Configure Jules via browser automation |
| `skill-evolution`  | Discover new skill opportunities       |
| `code-review`      | Multi-model review with handoff        |
| `simplify`         | Dead code detection                    |
| `pr-triage`        | Review and manage PRs                  |
| `first-time-setup` | New environment onboarding             |
| `debug-tests`      | Test failure diagnosis                 |
| `recovery`         | Rollback, stuck commands, failures     |
| `update-deps`      | Dependency updates with compatibility  |
| `template-sync`    | Propagate updates to downstream projects |

### CLI & MCP Guidance (Just Added)

- **`TOOLS.md`** — Universal CLIs (gh, jules, jq, pre-commit, ruff), stack-specific CLIs, evolution guidance
- **`mcp_config.template.json`** — Curated ~48 tools:
  - github-mcp-server: ~25 tools (allowlisted)
  - playwright: ~15 tools (allowlisted)
  - markitdown: 1 tool
  - context7: 2 tools
- **Tool budget:** ~50 tools target for context efficiency
- **Evolution guidance:** When/how to add new CLIs or MCPs

### AGENTS.md Sections Added

- Git Conventions (conventional commits, branch naming)
- Rollback & Recovery (git commands, fix-forward guidance)
- Security Review Triggers
- Project-Specific Considerations (type safety, performance budgets as templates)

### GitHub Templates Added

- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/bug_report.md`
- `.github/ISSUE_TEMPLATE/feature_request.md`

---

## Key Design Decisions

1. **Skills > Workflows for complexity** — Complex multi-step processes with decision trees go in skills
2. **Hybrid pattern** — Simple workflows invoke skills for the heavy lifting
3. **Tool budget ~50** — Keep MCP tools limited for context efficiency
4. **Evolution guidance** — Built-in checks for adding new tools over time
5. **Universal vs project-specific** — TOOLS.md distinguishes what all projects need vs stack-specific

---

## Related: Resume-Tailoring Project

The template was extracted from `resume-tailoring-agentic-system`. That project has:

- 8 skills (same as template minus bootstrap/jules-setup)
- Project-specific `deploy` and `verify` skills
- All the same workflows

---

### Dependency Version Management (Just Added)

- **`VERSIONS.md`** — Central tracking for pinned tool versions
- **`.github/dependabot.yml`** — Automated update PRs (GitHub Actions, pip, npm)
- **`.jules/prompts/tool_version_auditor.md`** — Monthly template tooling audit
- **`.agent/skills/update-deps/SKILL.md`** — Interactive guidance for complex updates
- **AGENTS.md section** — Update process and compatibility guidelines

---

## Pending/Future Considerations

1. **Template README** — May need updates as features evolve
2. **Gem prompts** — Include BOOTSTRAP.json schema with suggested_skills
3. **Bootstrap skill** — Creates GitHub repo, applies template, configures Jules
4. **Jules-setup skill** — Browser automation for jules.google

