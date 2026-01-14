# VERSIONS.md - Tool Version Tracking

> Central reference for all pinned tool and dependency versions in this template.
> Update this file when bumping versions. See AGENTS.md for update guidance.

---

## Version Policy

| Strategy | When to Use | Example |
|----------|-------------|---------|
| **Exact pin** | Critical tools, security-sensitive | `ruff==0.8.0` |
| **Range** | Flexible deps, auto-update safe | `pydantic>=2.0` |
| **Latest** | Development-only, non-critical | `@latest` |

---

## Pre-Commit Hooks

Source: `.pre-commit-config.yaml`

| Tool | Current Version | Last Updated | Notes |
|------|-----------------|--------------|-------|
| ruff-pre-commit | v0.8.0 | 2026-01-14 | Linting + formatting |
| mirrors-mypy | v1.13.0 | 2026-01-14 | Type checking (strict) |
| detect-secrets | v1.5.0 | 2026-01-14 | Secret scanning |

### Compatibility Notes

- **ruff** and **mypy** can be updated independently
- **pydantic** version in mypy deps must match project pydantic version

---

## CLI Tools

| Tool | Min Version | Purpose | Install |
|------|-------------|---------|---------|
| gh | 2.0+ | GitHub CLI | `brew install gh` |
| jq | 1.6+ | JSON processing | `brew install jq` |
| pre-commit | 3.0+ | Git hooks | `pip install pre-commit` |
| ruff | 0.8+ | Python linting | `pip install ruff` |

---

## MCP Servers

Source: `.antigravity/mcp_config.json` (when configured)

| Server | Tools Enabled | Notes |
|--------|---------------|-------|
| github-mcp-server | ~25 allowlisted | Repository + PR operations |
| playwright | ~15 allowlisted | Browser automation |
| markitdown | 1 | Document conversion |
| context7 | 2 | Documentation lookup |

**Tool Budget:** ~50 total tools (for context efficiency)

---

## Update Checklist

When updating any version:

1. [ ] Check changelog for breaking changes
2. [ ] Update version in source file (`.pre-commit-config.yaml`, etc.)
3. [ ] Update this VERSIONS.md with new version and date
4. [ ] Run tests: `pytest tests/ -m "not expensive"`
5. [ ] Run pre-commit: `pre-commit run --all-files`
6. [ ] Commit with: `chore(deps): update [tool] to vX.Y.Z`

---

## Quarterly Audit Schedule

| Quarter | Focus |
|---------|-------|
| Q1 (Jan) | Pre-commit hooks, CLI tools |
| Q2 (Apr) | MCP servers, major version bumps |
| Q3 (Jul) | Security audit, vulnerability scan |
| Q4 (Oct) | Full compatibility review |

For complex updates, invoke: `.agent/skills/update-deps/SKILL.md`
