---
description: start a development session with full sync and dependency check
---

# Sync Start Workflow

This workflow ensures your local environment is synchronized with the remote repository and all dependencies are up to date.

## Steps

// turbo-all

### 0. First-Time Setup Check

**If any of these are true, invoke the `first-time-setup` skill:**

- `.venv/` directory doesn't exist
- Pre-commit hooks not installed (`.git/hooks/pre-commit` missing)
- `~/.gemini/GEMINI.md` symlink doesn't exist

The skill will handle complete environment setup before continuing.

---

1. **Pull latest changes**:

   ```bash
   git pull origin main
   ```

   If there are conflicts, resolve them before proceeding.

2. **Check for open Pull Requests**:

   ```bash
   gh pr list --state open
   ```

   **If PRs are found:**
   - Review the list and note any that need attention
   - Consider running `/pr-review` for a detailed triage
   - Prioritize security-related PRs (from Sentinel, Dependency Doctor)

   **If no PRs found:** Continue to next step.

3. **Sync Python dependencies**:

   ```bash
   source .venv/bin/activate && pip install -r requirements.txt
   ```

   Check for any version pinning changes in `requirements.txt`.

4. **Sync Frontend dependencies**:

   ```bash
   npm install --prefix frontend
   ```

5. **Sync MCP Configuration**:

   Run the MCP sync script to generate machine-specific config:

   ```bash
   ./scripts/sync-mcp-config.sh
   ```

   After running, refresh MCP servers: Agent panel → three dots → MCP Servers → Manage → **Refresh**

6. **Sync Global IDE Rules**:

   Ensure GEMINI.md global rules are symlinked from the repo:

   ```bash
   ./scripts/sync-gemini-rules.sh
   ```

   This creates a symlink from `~/.gemini/GEMINI.md` → `.antigravity/GEMINI.md` in the repo.
   Changes made anywhere will be tracked in git and synced via `git pull`.

// turbo 7. **Install Pre-Commit Hooks** (if not already installed):

```bash
pre-commit install
```

This enables automatic code quality checks before every commit.

8. **Review MCP Servers (if needed)**:

   - The canonical config (`.antigravity/mcp_config.json`) includes:
     - `github-mcp-server` (25 tools, see `IDE_CONFIG.md` for list)
     - `playwright` (browser automation)
     - `markitdown` (document reading)
   - For full setup instructions, see [SETUP.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/SETUP.md#2-mcp-servers-model-context-protocol)

9. **Review IDE configuration**:

   - Check [.agent/IDE_CONFIG.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/.agent/IDE_CONFIG.md) for any new global rules or extensions.

10. **Verify Environment**:

   - Ensure `.python-version` matches your local environment.
   - Verify any necessary environment variables (e.g., `GITHUB_PERSONAL_ACCESS_TOKEN`) are set.
