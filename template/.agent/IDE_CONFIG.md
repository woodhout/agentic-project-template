# IDE Configuration

> Multi-machine synchronization and expected IDE setup.

---

## Global IDE Rules

**Source of Truth:** `.antigravity/GEMINI.md`

Run `./scripts/sync-gemini-rules.sh` to symlink to global location (`~/.gemini/GEMINI.md`).

---

## Expected Workflows

| Workflow          | Description                                       |
| ----------------- | ------------------------------------------------- |
| `/sync-start`     | Start development session (sync deps, MCP, rules) |
| `/sync-end`       | End session (docs, commit, push)                  |
| `/format`         | Auto-format code (ruff, eslint)                   |
| `/push`           | Commit and push changes                           |
| `/test`           | Run test suite                                    |
| `/review`         | Multi-model code review handoff                   |
| `/simplify`       | Post-implementation cleanup                       |
| `/pr-review`      | Check open PRs, summarize impact                  |
| `/roadmap-review` | Review roadmap priorities                         |
| `/python`         | Run Python commands in venv                       |

**Project-specific:** See `.agent/WORKFLOW_PATTERNS.md` for examples to customize.

---

## MCP Servers

**Config Template:** `.antigravity/mcp_config.template.json`
**Tool Reference:** `.agent/TOOLS.md`

### Included Servers (~48 tools)

| Server              | Tools | Purpose                            |
| ------------------- | ----- | ---------------------------------- |
| `github-mcp-server` | ~25   | PRs, issues, repos, code search    |
| `playwright`        | ~15   | Browser automation                 |
| `markitdown`        | 1     | Document reading (PDF, DOCX, etc.) |
| `context7`          | 2     | Documentation lookup               |

### Tool Budget

**Target: ~50 tools.** Each MCP tool consumes context tokens. Stay under budget to ensure fast responses and clear tool selection.

### Adding New MCP Servers

Before adding a new MCP server:

1. **Check if CLI suffices** — Many operations work fine via command line
2. **Count the tools** — How many does it add? Can you use an allowlist?
3. **Update config** — Edit `.antigravity/mcp_config.template.json`
4. **Document here** — Add to the table above

### GitHub MCP

Requires `GITHUB_PERSONAL_ACCESS_TOKEN` environment variable with scopes:

- `repo` (full control of repositories)
- `read:org` (read organization data)

---

## Jules Configuration

Automated tasks via [jules.google](https://jules.google):

| Task               | Schedule   | Prompt                                 |
| ------------------ | ---------- | -------------------------------------- |
| Sentinel           | Continuous | `.jules/prompts/sentinel.md`           |
| Dependency Doctor  | Weekly     | `.jules/prompts/dependency_doctor.md`  |
| Dead Code Scanner  | Weekly     | `.jules/prompts/dead_code_scanner.md`  |
| Code Formatter     | Weekly     | `.jules/prompts/code_formatter.md`     |
| Test Guardian      | Weekly     | `.jules/prompts/test_guardian.md`      |
| Context Sync       | Weekly     | `.jules/prompts/context_sync.md`       |
| Compliance Auditor | Weekly     | `.jules/prompts/compliance_auditor.md` |

---

## Pre-Commit Hooks

Configured in `.pre-commit-config.yaml`:

| Hook             | Purpose              | Strictness          |
| ---------------- | -------------------- | ------------------- |
| `ruff`           | Python linting + fix | Auto-fix            |
| `ruff-format`    | Python formatting    | Automatic           |
| `mypy`           | Type checking        | **Strict**          |
| `detect-secrets` | Secret detection     | Fail on new secrets |

Install: `pre-commit install`
Run manually: `pre-commit run --all-files`

---

## VS Code Configuration

**Settings:** `.vscode/settings.json`
**Extensions:** `.vscode/extensions.json`

### Formatters

| File Type        | Formatter | Linter                |
| ---------------- | --------- | --------------------- |
| Markdown (`.md`) | Prettier  | markdownlint          |
| Python (`.py`)   | Ruff      | Ruff                  |
| JSON/JSONC       | Prettier  | —                     |
| YAML             | Prettier  | YAML extension schema |

> **Note:** `markdownlint` is for **linting** (style warnings), not formatting. Use **Prettier** as the default formatter for Markdown files.

### Recommended Extensions

| Extension                        | Purpose                 |
| -------------------------------- | ----------------------- |
| `esbenp.prettier-vscode`         | Format MD, JSON, YAML   |
| `DavidAnson.vscode-markdownlint` | Markdown linting        |
| `charliermarsh.ruff`             | Python format + lint    |
| `ms-python.python`               | Python language support |
| `redhat.vscode-yaml`             | YAML validation         |
| `eamodio.gitlens`                | Git blame and history   |
| `EditorConfig.EditorConfig`      | Cross-editor settings   |

---

## Environment Setup

Ensure these are configured on each machine:

1. **Python environment**: Match `.python-version`
2. **Node.js**: Match `.nvmrc` or `package.json` engines
3. **Git hooks**: Run `pre-commit install`
4. **Global rules**: Run `./scripts/sync-gemini-rules.sh`
5. **MCP servers**: Refresh after pulling config changes
