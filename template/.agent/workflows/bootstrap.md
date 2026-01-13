---
description: bootstrap a new project from Gem seed files
---

# Bootstrap New Project

Create a fully-configured GitHub repository from Gem session outputs.

## Prerequisites

- Seed files saved in `seeds/` folder (from Gem session)
- GitHub MCP server connected
- `BOOTSTRAP.json` present in seeds folder

## Workflow

1. **Verify Seed Files**:

   Check that required files exist:

   ```bash
   ls seeds/
   # Expected: BOOTSTRAP.json, docs/
   ls seeds/docs/
   # Expected: PRD.md, ARCHITECTURE.md, PROJECT_GUIDE.md, etc.
   ```

   If missing, instruct user to complete Gem session first.

2. **Parse BOOTSTRAP.json**:

   Read the manifest to extract:

   - `project_name` — Used for GitHub repo and local folder
   - `tech_stack` — Determines which patterns to apply
   - `patterns` — Explicit pattern files to include
   - `github_visibility` — public or private

3. **Create Project Directory**:

   ```bash
   PROJECT_NAME=$(cat seeds/BOOTSTRAP.json | jq -r '.project_name')
   mkdir -p ~/dev/personal/$PROJECT_NAME
   ```

4. **Copy Template Files**:

   ```bash
   cp -r template/* ~/dev/personal/$PROJECT_NAME/
   cp -r template/.* ~/dev/personal/$PROJECT_NAME/ 2>/dev/null || true
   ```

5. **Integrate Seed Documents**:

   ```bash
   mkdir -p ~/dev/personal/$PROJECT_NAME/docs
   cp -r seeds/docs/* ~/dev/personal/$PROJECT_NAME/docs/
   cp seeds/BOOTSTRAP.json ~/dev/personal/$PROJECT_NAME/
   ```

6. **Customize Template Files**:

   Update placeholders in key files:

   - `.antigravity/GEMINI.md`: Replace `[PROJECT_NAME]` with actual name
   - `AGENTS.md`: Fill in project name and stack
   - `QUICK_REFERENCE.md`: Merge content from seeds/docs/QUICK_REFERENCE.md if present

   Apply relevant patterns from `patterns/` to `AGENTS.md` based on `tech_stack`:

   - If backend contains "python" or "fastapi" → include Python patterns
   - If hosting contains "gcp" → include patterns/GCP.md content
   - If ai_models present → include patterns/LLM_APPS.md content

7. **Initialize Git Repository**:

   ```bash
   cd ~/dev/personal/$PROJECT_NAME
   git init
   git add -A
   git commit -m "feat: initial project scaffold from agentic template

   Bootstrapped from Gem session with:
   - PRD and architecture documents
   - Agentic development infrastructure
   - Jules automation configured
   - Pre-commit hooks ready"
   ```

8. **Create GitHub Repository**:

   Use GitHub MCP to create the repository:

   ```
   mcp_github_create_repository(
       name=$PROJECT_NAME,
       description=[from BOOTSTRAP.json description],
       private=[based on github_visibility]
   )
   ```

9. **Push to GitHub**:

   ```bash
   git remote add origin git@github.com:$GITHUB_USERNAME/$PROJECT_NAME.git
   git push -u origin main
   ```

10. **Configure Jules** (Browser Automation):

    Open [jules.google](https://jules.google) and:

    1. Navigate to repository connection
    2. Add the new repository
    3. Create scheduled tasks for key prompts:
       - Sentinel (continuous)
       - Dependency Doctor (weekly)
       - Dead Code Scanner (weekly)
       - Code Formatter (weekly)

    Take screenshot as proof of configuration.

11. **Generate Initial Task List**:

    Based on the PRD Work Breakdown Structure, create `task.md`:

    ```markdown
    # task.md

    ## Phase 1: Foundation

    - [ ] Set up development environment
    - [ ] Create basic application structure
    - [ ] Configure database connection

    ## Phase 2: Core Features

    - [ ] [Feature 1 from PRD]
    - [ ] [Feature 2 from PRD]
          ...
    ```

    Commit and push task.md.

12. **Report Completion**:

    Notify user with:

    - GitHub repository URL
    - Local project path
    - Jules configuration status
    - Initial task list summary
    - Next steps to begin development

## Output

A fully-configured GitHub repository with:

- All agentic infrastructure (workflows, Jules prompts, pre-commit)
- Seed documents in `docs/`
- Project-specific rules applied to AGENTS.md
- Initial task list ready for development
- Jules automation configured

## Next Steps After Bootstrap

1. Open the new project in Antigravity IDE
2. Run `/sync-start` to verify environment
3. Begin implementing tasks from `task.md`
