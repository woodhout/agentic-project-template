---
description: end a development session with doc updates, cleanup, and push
---

# Sync End Workflow

This workflow ensures your work is documented, committed, pushed, and local processes are cleaned up before ending a session.

## Steps

// turbo-all

1. **Stop local servers**:

   - Shutdown backend: `pkill -f uvicorn` or `control+c` in the terminal.
   - Shutdown frontend: `pkill -f "next-render"` or `control+c`.
   - Verify no rogue processes: `ps aux | grep -E "uvicorn|next"`

2. **Sync MCP Config Changes (if needed)**:

   If you modified MCP servers during this session:

   - Edit `.antigravity/mcp_config.template.json` (not the local generated config)
   - Template uses `__VENV_PYTHON__` placeholder for machine-specific Python paths
   - Commit the template changes so other machines get the update

3. **Documentation Refresh**:

   - Update [CHANGELOG.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/CHANGELOG.md) with a summary of today's work.
   - Update [QUICK_REFERENCE.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/QUICK_REFERENCE.md) if architecture, API, or models changed.
   - Update [COMPLIANCE_LOG.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/COMPLIANCE_LOG.md) if security or dependency changes were made.
   - Check if [DEVELOPMENT.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/DEVELOPMENT.md) needs updates.
   - **If agent errors occurred**, add to [AGENTS.md Section 16](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/AGENTS.md) anti-patterns table.

4. **Commit and Push**:

   - Stage changes: `git add .`
   - Review changes: `git status`
   - Commit: `git commit -m "feat: session sync - [brief description]"`
   - Push: `git push origin main`

5. **Optional: Redeploy**:

   - If changes affect the production API, run the `/deploy` workflow.

6. **Final Check**:
   - Ensure all files are saved and artifacts are synchronized.
