# Tools Reference

> CLIs, MCP servers, and guidance for tool evolution.

---

## Universal CLIs

Required for all projects using this template:

| CLI          | Purpose           | Install                  |
| ------------ | ----------------- | ------------------------ |
| `gh`         | GitHub operations | `brew install gh`        |
| `jq`         | JSON processing   | `brew install jq`        |
| `pre-commit` | Git hooks         | `pip install pre-commit` |
| `ruff`       | Python linting    | `pip install ruff`       |

### Verify Installation

```bash
gh --version
jq --version
pre-commit --version
ruff --version
```

---

## Stack-Specific CLIs

Install based on your project's tech stack:

### Cloud Platforms

| Stack | CLI      | Install                                                  | Verify             |
| ----- | -------- | -------------------------------------------------------- | ------------------ |
| GCP   | `gcloud` | [Install SDK](https://cloud.google.com/sdk/docs/install) | `gcloud --version` |
| AWS   | `aws`    | `brew install awscli`                                    | `aws --version`    |
| Azure | `az`     | `brew install azure-cli`                                 | `az --version`     |

### Containers

| Stack      | CLI       | Install                              | Verify                     |
| ---------- | --------- | ------------------------------------ | -------------------------- |
| Docker     | `docker`  | [Docker Desktop](https://docker.com) | `docker --version`         |
| Kubernetes | `kubectl` | `brew install kubectl`               | `kubectl version --client` |

### Databases

| Stack      | CLI         | Install                   | Verify                |
| ---------- | ----------- | ------------------------- | --------------------- |
| PostgreSQL | `psql`      | `brew install postgresql` | `psql --version`      |
| Redis      | `redis-cli` | `brew install redis`      | `redis-cli --version` |

### AI/ML

| Stack     | CLI        | Install | Verify |
| --------- | ---------- | ------- | ------ |
| Anthropic | (API only) | —       | —      |
| OpenAI    | (API only) | —       | —      |

---

## MCP Servers

Base configuration in `.antigravity/mcp_config.template.json`.

### Included Servers (~48 tools)

| Server              | Tools | Purpose                         |
| ------------------- | ----- | ------------------------------- |
| `github-mcp-server` | ~25   | PRs, issues, repos, code search |
| `playwright`        | ~15   | Browser automation              |
| `markitdown`        | 1     | Document conversion (PDF, DOCX) |
| `context7`          | 2     | Documentation lookup            |

### Tool Budget

**Target: ~50 tools**

Each MCP tool consumes context tokens. Limiting to ~50 ensures:

- Faster agent response times
- Less confusion about which tool to use
- Room for project-specific additions

---

## Tool Evolution

When adopting new dependencies or services, ask:

### CLI Assessment

1. **Does this tool have a CLI?**

   - Check: `<tool> --help` or search `<tool> CLI`
   - Example: Firebase → `firebase-tools`

2. **Should it be in `first-time-setup`?**

   - YES if: Required for development
   - NO if: Optional or production-only

3. **Add to this file?**
   - Update Stack-Specific section if broadly useful
   - Add to project's SETUP.md if project-specific

### MCP Assessment

1. **Is there an MCP server?**

   - Check: [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
   - Search: `mcp server <tool>`

2. **Is it worth the tool budget?**

   - How often will we use it?
   - How many tools does it add?
   - Can the CLI accomplish the same thing?

3. **Update config if adding:**
   - Edit `.antigravity/mcp_config.template.json`
   - Add only the tools you'll actually use (allowlist)
   - Document in IDE_CONFIG.md

### Evolution Triggers

Consider tool updates when:

- Adding a new cloud service
- Integrating a new API with frequent operations
- Finding yourself running the same CLI commands repeatedly
- Discovering a task that would be easier with browser automation

---

## Verification Checklist

Before committing tool changes:

- [ ] CLI install commands tested
- [ ] MCP config is valid JSON
- [ ] Tool count stays under budget (~50)
- [ ] `first-time-setup` skill updated if new universal CLI
- [ ] `IDE_CONFIG.md` updated if new MCP server
