---
name: Bootstrap New Project
description: Create a fully-configured GitHub repository from Gem seed files
---

# Bootstrap Skill

Create a new project from Gemini Gem seed files with full agentic infrastructure.

## When to Use This Skill

Use this skill when:

- User has completed a Gem session and has seed files in `seeds/`
- User wants to create a new GitHub repository with agentic infrastructure
- User says "bootstrap", "create project", or "start new project"

## Prerequisites

Before starting, verify:

1. `seeds/BOOTSTRAP.json` exists
2. `seeds/docs/` contains PRD.md, ARCHITECTURE.md, etc.
3. GitHub MCP server is connected

If prerequisites are missing, guide the user to complete their Gem session first.

## Decision Tree

```
Is BOOTSTRAP.json present?
├── No → Instruct user to complete Gem session
└── Yes → Parse manifest
         │
         ├── Is tech_stack.backend defined?
         │   ├── Contains "python" → Apply Python patterns
         │   └── Contains "node" → Apply Node patterns
         │
         ├── Is hosting "gcp"?
         │   └── Yes → Include patterns/GCP.md
         │
         └── Are ai_models defined?
             └── Yes → Include patterns/LLM_APPS.md
```

## Step-by-Step Process

### 1. Parse BOOTSTRAP.json

```bash
cat seeds/BOOTSTRAP.json
```

Extract:

- `project_name` → GitHub repo name and local folder
- `description` → Repo description
- `tech_stack` → Pattern selection
- `github_visibility` → public or private

### 2. Create Project Directory

```bash
PROJECT_NAME="[from manifest]"
mkdir -p ~/dev/personal/$PROJECT_NAME
```

### 3. Copy Template Files

```bash
cp -r template/* ~/dev/personal/$PROJECT_NAME/
cp -r template/.* ~/dev/personal/$PROJECT_NAME/ 2>/dev/null || true
```

### 4. Integrate Seed Documents

```bash
mkdir -p ~/dev/personal/$PROJECT_NAME/docs
cp -r seeds/docs/* ~/dev/personal/$PROJECT_NAME/docs/
cp seeds/BOOTSTRAP.json ~/dev/personal/$PROJECT_NAME/
```

### 5. Customize Template

Update these files with project-specific values:

| File                     | Replacement                     |
| ------------------------ | ------------------------------- |
| `.antigravity/GEMINI.md` | Replace `[PROJECT_NAME]`        |
| `AGENTS.md`              | Fill project name, add patterns |
| `QUICK_REFERENCE.md`     | Merge seed content if present   |

**Pattern application logic:**

- If `tech_stack.hosting` contains "gcp" → Append `patterns/GCP.md` to AGENTS.md
- If `ai_models` is non-empty → Append `patterns/LLM_APPS.md` to AGENTS.md

### 6. Initialize Git

```bash
cd ~/dev/personal/$PROJECT_NAME
git init
git add -A
git commit -m "feat: initial project scaffold from agentic template"
```

### 7. Create GitHub Repository

Use GitHub MCP:

```
mcp_github_create_repository(
    name="[project_name]",
    description="[description from manifest]",
    private=[true if github_visibility is "private"]
)
```

### 8. Push to GitHub

```bash
git remote add origin git@github.com:[username]/[project_name].git
git push -u origin main
```

### 9. Run Jules Setup Skill

After pushing, invoke the `jules-setup` skill to configure automation.

### 9b. Create Suggested Skills

If `suggested_skills` array exists in BOOTSTRAP.json:

For each skill in the array:

```bash
mkdir -p ~/dev/personal/$PROJECT_NAME/.agent/skills/[skill-name]
```

Create `SKILL.md` using the skill definition:

```markdown
---
name: [name from suggested_skills]
description: [description from suggested_skills]
---

# [Name] Skill

[Description]

## When to Use This Skill

[trigger from suggested_skills]

## Step-by-Step Process

[steps from suggested_skills, expanded into detailed instructions]
```

Commit the new skills:

```bash
git add .agent/skills/
git commit -m "feat: add project-specific skills from bootstrap"
git push
```

### 10. Generate Initial Task List

Create `task.md` based on PRD Work Breakdown Structure:

```markdown
# task.md

## Phase 1: Foundation

- [ ] Set up development environment
- [ ] Create basic application structure
- [ ] [Items from PRD]

## Phase 2: Core Features

- [ ] [Feature 1 from PRD]
      ...
```

Commit and push task.md.

### 11. Report Completion

Notify user with:

- GitHub repository URL
- Local project path
- Jules configuration status (from jules-setup skill)
- Project-specific skills created
- Next steps

## Output Artifacts

After successful bootstrap:

- New GitHub repository created
- Local project at `~/dev/personal/[project_name]/`
- Jules automation configured
- Initial task list ready

## Common Issues

| Issue             | Solution                                  |
| ----------------- | ----------------------------------------- |
| GitHub auth fails | Check `GITHUB_PERSONAL_ACCESS_TOKEN`      |
| Seeds missing     | Guide user back to Gem session            |
| Name conflict     | Check if repo exists, suggest alternative |
