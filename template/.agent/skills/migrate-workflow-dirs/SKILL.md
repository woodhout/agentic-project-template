---
name: Migrate Workflow Directories
description: One-time migration from flat workflow structure to scoped directories
self-deleting: true
---

# Migrate Workflow Directories

> ⚠️ **One-time migration skill** — Deletes itself after successful completion.

Migrate from the old flat `.agent/workflows/` structure to the new scoped directory structure (`universal/`, `downstream-only/`).

## When to Use

This skill is invoked automatically by `/template-sync` when it detects:

- Template has `.agent/workflows/universal/` directory
- Local project still has flat workflow files in `.agent/workflows/`

## Prerequisites

Before running, verify:

1. You're in a downstream project (not the template itself)
2. `TEMPLATE_VERSION` file exists
3. Template remote is configured

## Migration Steps

### 1. Backup Current State (Optional)

```bash
cp -r .agent/workflows/ .agent/workflows.backup/
```

### 2. Fetch Latest Template

```bash
git fetch template main
```

### 3. Remove Old Flat Workflow Files

```bash
# List files that will be removed (flat structure)
ls .agent/workflows/*.md 2>/dev/null

# Remove old flat workflow files
rm -f .agent/workflows/format.md
rm -f .agent/workflows/pr-review.md
rm -f .agent/workflows/push.md
rm -f .agent/workflows/python.md
rm -f .agent/workflows/recover.md
rm -f .agent/workflows/review.md
rm -f .agent/workflows/roadmap-review.md
rm -f .agent/workflows/simplify.md
rm -f .agent/workflows/sync-end.md
rm -f .agent/workflows/sync-start.md
rm -f .agent/workflows/test.md
rm -f .agent/workflows/update-deps.md
rm -f .agent/workflows/template-feedback.md
rm -f .agent/workflows/template-sync.md
rm -f .agent/workflows/idea-review.md
rm -f .agent/workflows/review-lessons.md
```

### 4. Copy New Directory Structure

```bash
# Copy universal workflows
cp -r template/.agent/workflows/universal/ .agent/workflows/

# Copy downstream-only workflows (skip template-only)
cp -r template/.agent/workflows/downstream-only/ .agent/workflows/
```

### 5. Verify Migration

Run this checklist before proceeding:

- [ ] `.agent/workflows/universal/` directory exists
- [ ] `.agent/workflows/downstream-only/` directory exists
- [ ] `.agent/workflows/universal/sync-start.md` exists
- [ ] `.agent/workflows/downstream-only/template-sync.md` exists
- [ ] `.agent/workflows/downstream-only/submit-idea.md` exists (new)
- [ ] No `.md` files remain in `.agent/workflows/` root (except this skill's link)
- [ ] Old backup can be deleted: `rm -rf .agent/workflows.backup/`

**Verification command:**

```bash
# Should show only directories, no .md files in root
ls -la .agent/workflows/
```

### 6. Commit Migration

```bash
git add .agent/workflows/
git commit -m "chore: migrate workflows to scoped directory structure"
```

### 7. Delete This Skill

**Only after ALL verification checks pass:**

```bash
rm -rf .agent/skills/migrate-workflow-dirs/
git add -A
git commit -m "chore: remove one-time migration skill"
```

## Rollback

If something goes wrong:

```bash
rm -rf .agent/workflows/universal/ .agent/workflows/downstream-only/
mv .agent/workflows.backup/* .agent/workflows/
rmdir .agent/workflows.backup/
```
