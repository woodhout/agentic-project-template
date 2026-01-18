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

2. **Sync from template** (if `TEMPLATE_VERSION` exists):

   ```bash
   git fetch template main 2>/dev/null || echo "Template remote not configured"
   ```

   **If template remote exists:**
   - Check for updates: `git log --oneline $(grep synced TEMPLATE_VERSION | cut -d: -f2 | tr -d ' ')..template/main -- template/`
   - If updates found, run `/template-sync` to apply (skill handles skipping inapplicable items)
   - If no updates, continue

   **If no `TEMPLATE_VERSION` file:** Skip this step (project not using template sync).

3. **Check for open Pull Requests**:

   ```bash
   gh pr list --state open
   ```

   **If PRs are found:**
   - List them briefly (title, author, age)
   - **Run `/pr-review` if:**
     - Security-related PRs exist (Sentinel, Dependabot)
     - PRs are stale (>7 days old)
     - User has time to act on them now
   - Otherwise, note them for later and continue

   **If no PRs found:** Continue to next step.

4. **Check for Pending Lessons** (template repo only):

   If working in `agentic-project-template`:

   ```bash
   gh issue list --repo woodhout/agentic-project-template \
     --label "lesson-submission" --state open \
     --json number --jq 'length'
   ```

   **If pending count > 0:**
   - Note: "You have N pending lesson(s) to review"
   - Suggest running `/review-lessons` after sync completes

   **If 0 pending or not in template repo:** Continue to next step.

5. **Sync Python dependencies**:

   ```bash
   source .venv/bin/activate && pip install -r requirements.txt
   ```

   Check for any version pinning changes in `requirements.txt`.

6. **Sync Frontend dependencies**:

   ```bash
   npm install --prefix frontend
   ```

7. **Sync MCP Configuration**:

   Run the MCP sync script to generate machine-specific config:

   ```bash
   ./scripts/sync-mcp-config.sh
   ```

   After running, refresh MCP servers: Agent panel → three dots → MCP Servers → Manage → **Refresh**

8. **Sync Global IDE Rules**:

   Ensure GEMINI.md global rules are symlinked from the repo:

   ```bash
   ./scripts/sync-gemini-rules.sh
   ```

   This creates a symlink from `~/.gemini/GEMINI.md` → `.antigravity/GEMINI.md` in the repo.
   Changes made anywhere will be tracked in git and synced via `git pull`.

// turbo 9. **Install Pre-Commit Hooks** (if not already installed):

```bash
source .venv/bin/activate && pre-commit install
```

This enables automatic code quality checks before every commit.

10. **Review MCP Servers (if needed)**:
    - The canonical config (`.antigravity/mcp_config.json`) includes:
      - `github-mcp-server` (25 tools, see `IDE_CONFIG.md` for list)
      - `playwright` (browser automation)
      - `markitdown` (document reading)
    - For full setup instructions, see [SETUP.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/SETUP.md#2-mcp-servers-model-context-protocol)

11. **Review IDE configuration**:
    - Check [.agent/IDE_CONFIG.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/.agent/IDE_CONFIG.md) for any new global rules or extensions.

12. **Verify Environment**:
    - Ensure `.python-version` matches your local environment.
    - Verify any necessary environment variables (e.g., `GITHUB_PERSONAL_ACCESS_TOKEN`) are set.

13. **Check for Untracked Critical Files**:

```bash
git status --porcelain | grep -E '^\?\? (scripts/|\.antigravity/|frontend/|tests/)' || true
```

**If untracked critical directories are found:**

- Warn that `scripts/`, `.antigravity/`, `frontend/`, or `tests/` are not tracked
- Recommend running `/push` to commit infrastructure files
- These directories should typically be in version control

**If no untracked critical files:** Environment is fully synchronized ✅
