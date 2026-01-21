---
description: update documentation, commit, and push changes
scope: universal
---

# Push Workflow

This workflow ensures that documentation is updated and code is formatted before pushing changes to the remote repository.

## Steps

1. **Documentation Updates**:
   - [ ] Update [CHANGELOG.md](file:///Users/ty/dev/personal/resume-tailoring-agentic-system/CHANGELOG.md) with a summary of your changes.
   - [ ] If you made dependency changes, ensure `requirements.txt` (Python) and/or `package.json` (Node) are updated.

2. **Format Code (Optional)**:
   - Run the `/format` workflow to ensure code style compliance.
     // turbo
   - `ruff format .`

3. **Commit and Push**:
   - Stage changes: `git add .`
   - Review status: `git status`
   - Commit: `git commit -m "feat: [brief description]"`
   - Push: `git push origin main`
