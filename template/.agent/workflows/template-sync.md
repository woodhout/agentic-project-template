---
description: sync updates from agentic-project-template to this project
---

# Template Sync Workflow

Synchronize updates from the upstream agentic-project-template.

## Prerequisites

- Template remote configured: `git remote add template git@github.com:woodhout/agentic-project-template.git`
- `TEMPLATE_VERSION` file exists in project root

---

## Steps

1. Fetch latest template
```bash
git fetch template main
```

2. Check what changed since last sync
```bash
# View high-level changes
git log --oneline $(cat TEMPLATE_VERSION | grep synced | cut -d: -f2 | tr -d ' ')..template/main -- template/
```

3. Invoke the template-sync skill for guided sync
```text
Read and follow: .agent/skills/template-sync/SKILL.md
```

4. After sync, update TEMPLATE_VERSION with today's date

5. Test and commit
```bash
pre-commit run --all-files
pytest tests/ -m "not expensive"
git add -A
git commit -m "chore: sync template updates"
```
