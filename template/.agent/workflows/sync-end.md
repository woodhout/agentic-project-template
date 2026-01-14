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

3. **Skill Evolution Check**:

   Invoke the `skill-evolution` skill to review this session:

   - Were there recurring multi-step patterns?
   - Any workflows that became complex?
   - Opportunities for new skills?

   If skill opportunities are identified, propose them to the user.

4. **Template Feedback (if applicable)**:

   If you discovered that a template workflow, skill, or pattern could be improved:

   - Run `/template-feedback` workflow to add the lesson to `LESSONS_QUEUE.md`
   - This captures improvements for review and potential sync to all projects

5. **Documentation Refresh**:

   - Update CHANGELOG.md with a summary of today's work.
   - Update QUICK_REFERENCE.md if architecture, API, or models changed.
   - Update COMPLIANCE_LOG.md if security or dependency changes were made.
   - **If agent errors occurred**, add to AGENTS.md anti-patterns table.

6. **Commit and Push**:

   - Stage changes: `git add .`
   - Review changes: `git status`
   - Commit: `git commit -m "feat: session sync - [brief description]"`
   - Push: `git push origin main`

7. **Optional: Redeploy**:

   - If changes affect the production API, run the `/deploy` workflow (if available).

8. **Final Check**:
   - Ensure all files are saved and artifacts are synchronized.
