# Downstream Projects

Projects created from or synced with this template. This registry helps track the scope of template changes and facilitates batch updates.

---

## Active Projects

| Project | Repository | Type | Last Sync | Notes |
|---------|------------|------|-----------|-------|
| education-news-reader-app | [woodhout/education-news-reader-app](https://github.com/woodhout/education-news-reader-app) | Full Bootstrap | 2026-01-14 | RSS-based education news reader |
| resume-tailoring-agentic-system | [woodhout/resume-tailoring-agentic-system](https://github.com/woodhout/resume-tailoring-agentic-system) | Merge Sync | 2026-01-14 | Resume optimization with LLM |
| pokedex-manager | [woodhout/pokedex-manager](https://github.com/woodhout/pokedex-manager) | Full Bootstrap | 2026-01-14 | FastAPI + React Pokemon manager |

---

## Sync Types

| Type | Description |
|------|-------------|
| **Full Bootstrap** | New project created entirely from template (no prior `.agent/`) |
| **Merge Sync** | Existing project with selective template integration |
| **Selective Sync** | Only specific files/skills updated |

---

## Adding a New Project

When bootstrapping a new project from this template:

1. Run the `bootstrap` skill to create the project
2. Add an entry to this table with:
   - Project name and GitHub link
   - Sync type
   - Current date
   - Brief description
3. Commit this change to the template

---

## Batch Update Command

To sync a specific file to all downstream projects:

```bash
for repo in education-news-reader-app resume-tailoring-agentic-system pokedex-manager; do
  cp template/[path/to/file] ~/dev/personal/$repo/[path/to/file]
  (cd ~/dev/personal/$repo && git add -A && git commit -m "chore: sync from template" && git push)
done
```

---

_Last updated: 2026-01-14_
