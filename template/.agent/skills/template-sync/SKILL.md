---
name: Template Sync
description: Synchronize template updates to downstream projects
---

# Template Sync Skill

Propagate template improvements to existing and new projects.

## When to Use This Skill

Invoke this skill when:

- Template has new skills, workflows, or patterns to propagate
- New IDE features (e.g., skills capability) need adoption
- Security fixes need distribution to all projects
- Starting a sync session with a downstream project

## Decision Tree

```text
Start
│
├─ Is this a new project?
│  ├─ YES → Go to "New Project Setup"
│  └─ NO ↓
│
├─ Does template have `.agent/workflows/universal/` but local has flat structure?
│  └─ YES → Invoke `migrate-workflow-dirs` skill first
│
├─ What are you syncing?
│  ├─ Everything → Go to "Full Sync"
│  ├─ Specific folder → Go to "Selective Sync"
│  └─ Single file → Go to "File Sync"
│
└─ Are there conflicts?
   └─ YES → Go to "Conflict Resolution"
```

> [!IMPORTANT]
> **Workflow Structure Migration**: If your project has flat workflow files in `.agent/workflows/*.md`
> but the template now uses subdirectories (`universal/`, `downstream-only/`), you must run the
> `migrate-workflow-dirs` skill before syncing workflows. This is a one-time migration.

---

## New Project Setup

### First-Time Setup (When Creating from Template)

1. **Bootstrap the project**

   ```bash
   # Clone template
   cp -r template/ new-project/
   cd new-project
   git init
   ```

2. **Add template remote for future syncs**

   ```bash
   git remote add template git@github.com:woodhout/agentic-project-template.git
   ```

3. **Create version tracking file**

   ```bash
   cat > TEMPLATE_VERSION << 'EOF'
   template: woodhout/agentic-project-template
   version: v1.0.0
   synced: $(date +%Y-%m-%d)
   EOF
   ```

4. **Customize project-specific files**
   - Update `AGENTS.md` project name and stack
   - Modify `QUICK_REFERENCE.md` for project specifics
   - Keep `.agent/` structure intact

---

## Full Sync

### When to Use

- Quarterly sync to catch all template improvements
- After major template updates

### Procedure

1. **Check current template version**

   ```bash
   cat TEMPLATE_VERSION
   ```

2. **Fetch latest template**

   ```bash
   git fetch template main
   ```

3. **Review what changed**

   ```bash
   # See all changed files since last sync
   git diff HEAD..template/main -- \
     template/.agent/skills/ \
     template/.agent/workflows/ \
     template/.jules/prompts/ \
     template/patterns/
   ```

4. **Sync safe directories** (usually no conflicts)

   ```bash
   # Skills - safe to overwrite
   cp -r template/.agent/skills/* .agent/skills/

   # Jules prompts - safe to overwrite
   cp -r template/.jules/prompts/* .jules/prompts/
   ```

5. **Review project-specific files** (may have customizations)

   ```bash
   # Show diff for AGENTS.md
   git diff HEAD..template/main -- template/AGENTS.md
   # Manually merge relevant sections
   ```

6. **Update version tracking**

   ```bash
   # Update TEMPLATE_VERSION date and commit
   TEMPLATE_COMMIT=$(git rev-parse --short template/main)
   sed -i '' "s/synced:.*/synced: $(date +%Y-%m-%d)/" TEMPLATE_VERSION
   sed -i '' "s/synced_commit:.*/synced_commit: $TEMPLATE_COMMIT/" TEMPLATE_VERSION
   # If synced_commit doesn't exist, add it after synced line
   grep -q "synced_commit:" TEMPLATE_VERSION || sed -i '' "/^synced:/a\\
   synced_commit: $TEMPLATE_COMMIT
   " TEMPLATE_VERSION
   ```

7. **Test and commit**

   ```bash
   pre-commit run --all-files
   pytest tests/ -m "not expensive"
   git add -A
   git commit -m "chore: sync template updates"
   ```

---

## Selective Sync

### When to Use Selective Sync

- Adopting specific new feature (e.g., new skill)
- Updating specific tooling category

### Sync by Category

| Category          | Safe to Overwrite          | Path                                                          |
| ----------------- | -------------------------- | ------------------------------------------------------------- |
| Skills            | ✅ Yes                     | `.agent/skills/`                                              |
| Workflows         | ⚠️ Check for customization | `.agent/workflows/`                                           |
| Jules prompts     | ✅ Yes                     | `.jules/prompts/`                                             |
| Patterns          | ✅ Yes                     | `patterns/`                                                   |
| GitHub templates  | ✅ Yes                     | `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` |
| Pre-commit config | ⚠️ Check versions          | `.pre-commit-config.yaml`                                     |
| AGENTS.md         | ❌ Merge manually          | `AGENTS.md`                                                   |

### Example: Sync Only Skills

```bash
# Fetch template
git fetch template main

# Show new/changed skills
git diff HEAD..template/main --stat -- template/.agent/skills/

# Copy all skills
cp -r template/.agent/skills/* .agent/skills/

# Or copy specific skill
cp -r template/.agent/skills/template-sync/ .agent/skills/
```

---

## File Sync

### Single File Update

```bash
# Preview changes
git show template/main:template/.pre-commit-config.yaml > /tmp/new-config
diff .pre-commit-config.yaml /tmp/new-config

# Apply if acceptable
cp /tmp/new-config .pre-commit-config.yaml
```

---

## Conflict Resolution

### Project-Specific Overrides

Some files have project-specific content that shouldn't be overwritten:

| File                      | Project-Specific Content            |
| ------------------------- | ----------------------------------- |
| `AGENTS.md`               | Project name, stack, custom rules   |
| `QUICK_REFERENCE.md`      | API routes, env vars                |
| `.pre-commit-config.yaml` | Additional hooks, version overrides |

### Merge Strategy

1. **Extract template changes**

   ```bash
   git show template/main:template/AGENTS.md > /tmp/template-agents.md
   ```

2. **Compare with project version**

   ```bash
   diff AGENTS.md /tmp/template-agents.md
   ```

3. **Manually merge relevant sections**
   - Add new sections from template
   - Keep project-specific customizations
   - Update shared sections if improved

4. **Document the merge**

   ```bash
   git commit -m "chore: merge AGENTS.md updates from template"
   ```

---

## Sync Categories in Changelog

When reading template CHANGELOG, look for sync indicators:

| Indicator            | Meaning                | Action               |
| -------------------- | ---------------------- | -------------------- |
| `[SYNC-REQUIRED]`    | Security, critical fix | Sync immediately     |
| `[SYNC-RECOMMENDED]` | New skill, workflow    | Sync when convenient |
| `[SYNC-OPTIONAL]`    | Docs, formatting       | Sync if desired      |

---

## Tracking Sync State

### TEMPLATE_VERSION File

Every project should have:

```yaml
template: woodhout/agentic-project-template
version: v1.0.0
synced: 2026-01-14
notes: |
  - Skipped workflow X (project uses custom version)
  - Using older ruff version for compatibility
```

### Checking for Updates

```bash
# Fetch template
git fetch template main

# Compare versions
git log --oneline TEMPLATE_VERSION..template/main -- template/
```

---

## Quarterly Sync Checklist

- [ ] Fetch template: `git fetch template main`
- [ ] Review changelog for sync indicators
- [ ] Sync skills directory
- [ ] Sync workflows (check customizations)
- [ ] Sync Jules prompts
- [ ] Review AGENTS.md diff
- [ ] Update TEMPLATE_VERSION
- [ ] Run tests
- [ ] Commit changes
