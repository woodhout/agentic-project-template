---
name: Update Dependencies
description: Manage dependency updates with compatibility checks and rollback guidance
---

# Update Dependencies Skill

Interactive guidance for updating tools and dependencies with compatibility safeguards.

## When to Use This Skill

Invoke this skill when:

- Updating multiple related dependencies at once
- A major version bump is available
- Compatibility concerns between tools
- An update broke something and needs rollback
- Propagating template updates to downstream projects

## Decision Tree

```text
Start
│
├─ What type of update?
│  ├─ Security fix → Go to "Security Update"
│  ├─ Major version → Go to "Major Version Update"
│  ├─ Minor/patch → Go to "Routine Update"
│  └─ Multiple tools → Go to "Batch Update"
│
├─ Did update break something?
│  └─ YES → Go to "Rollback Procedure"
│
└─ Propagating to projects?
   └─ YES → Go to "Template Propagation"
```

---

## Security Update

### Priority: IMMEDIATE

1. **Identify the vulnerability**
   ```bash
   # For Python
   pip-audit
   
   # For Node
   npm audit
   ```

2. **Check if fix is available**
   - Look for patched version in advisory
   - Check if upgrade is compatible with current stack

3. **Apply the fix**
   ```bash
   # Update specific package
   pip install package==X.Y.Z
   
   # Regenerate lock file
   pip freeze > requirements.txt
   ```

4. **Test immediately**
   ```bash
   pytest tests/ -m "not expensive"
   pre-commit run --all-files
   ```

5. **Document**
   - Update CHANGELOG.md (security section)
   - Update VERSIONS.md if template tool

---

## Major Version Update

### Priority: PLANNED

Major versions often have breaking changes. Follow this process:

1. **Review changelog thoroughly**
   - Note all breaking changes
   - Identify migration steps required

2. **Check compatibility matrix**
   | Tool Being Updated | Check Compatibility With |
   |--------------------|--------------------------|
   | ruff | mypy, pre-commit |
   | mypy | pydantic version, ruff |
   | pydantic | mypy, fastapi |
   | Next.js | React, Node version |

3. **Create isolated test branch**
   ```bash
   git checkout -b test/update-[tool]-[version]
   ```

4. **Apply update and test**
   ```bash
   # Update the tool
   # Run full test suite
   pytest tests/
   
   # Run pre-commit on all files
   pre-commit run --all-files
   
   # Build if applicable
   npm run build
   ```

5. **If tests pass** → Merge to main
   **If tests fail** → Document issues, consider waiting or fixing forward

---

## Routine Update

### Priority: LOW

For minor and patch updates:

1. **Check for notable changes**
   - Quick changelog review
   - Look for deprecation warnings

2. **Apply update**
   ```bash
   # Update version in config file
   # Run tests
   pytest tests/ -m "not expensive"
   ```

3. **Update tracking files**
   - VERSIONS.md (if template tool)
   - requirements.txt / package.json

4. **Commit with conventional message**
   ```bash
   git commit -m "chore(deps): update [tool] to vX.Y.Z"
   ```

---

## Batch Update

### When updating multiple related tools

1. **Group by compatibility**
   - Update tightly-coupled tools together
   - Example: ruff + ruff-format as one batch

2. **Order by dependency**
   - Update base tools first
   - Then dependent tools

3. **Test after each batch**
   - Don't accumulate multiple batches without testing

4. **One PR per batch**
   - Easier to identify which update caused issues

---

## Rollback Procedure

### If an update broke something

1. **Identify the breaking update**
   ```bash
   git log --oneline -10  # Find the update commit
   ```

2. **Quick rollback option**
   ```bash
   # Revert the commit
   git revert <commit-hash>
   
   # Or restore specific file
   git checkout HEAD~1 -- requirements.txt
   git checkout HEAD~1 -- .pre-commit-config.yaml
   ```

3. **Reinstall previous version**
   ```bash
   pip install package==OLD_VERSION
   pre-commit install
   ```

4. **Document the issue**
   - Add to AGENTS.md anti-patterns if applicable
   - Note in VERSIONS.md compatibility section

5. **Plan fix-forward**
   - Open issue to track proper resolution
   - Research migration path

---

## Template Propagation

### Pushing template updates to downstream projects

1. **Update template first**
   - All version changes in template repo
   - Full testing in template context

2. **Document migration steps**
   - Add to CHANGELOG.md
   - Note any breaking changes

3. **For each downstream project**
   ```bash
   # Copy updated files
   cp template/.pre-commit-config.yaml project/
   cp template/VERSIONS.md project/
   
   # Test in project context
   cd project
   pre-commit run --all-files
   pytest tests/
   ```

4. **Handle project-specific conflicts**
   - Project may have custom versions
   - Merge carefully, don't blindly overwrite

---

## Version Compatibility Reference

### Known Good Combinations

| ruff | mypy | pydantic | Python |
|------|------|----------|--------|
| 0.8.x | 1.13.x | 2.x | 3.11+ |
| 0.7.x | 1.12.x | 2.x | 3.10+ |

### Common Incompatibilities

| Combination | Issue | Solution |
|-------------|-------|----------|
| mypy + pydantic mismatch | Type errors | Match pydantic version in mypy deps |
| Old ruff + new Python | Syntax errors | Update ruff first |
| Major Next.js + old React | Build failures | Update React with Next.js |

---

## Checklist

After any update:

- [ ] Tests pass
- [ ] Pre-commit runs clean
- [ ] VERSIONS.md updated (if template tool)
- [ ] CHANGELOG.md updated
- [ ] Commit message follows conventional format
