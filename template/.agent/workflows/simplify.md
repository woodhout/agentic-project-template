---
description: post-implementation cleanup for dead code, duplication, and complexity
---

# Simplify Workflow

Review and clean up code after feature implementation. Focus on maintainability.

## Pre-Check

// turbo
List recently changed files for targeted review:

```bash
git diff --name-only HEAD~5 | grep -E '\.(py|tsx?|jsx?)$' | head -20
```

## Python Cleanup

### 1. Find Unused Code

```bash
source .venv/bin/activate && pip install vulture --quiet && vulture app/ --min-confidence 80
```

### 2. Check Complexity

```bash
source .venv/bin/activate && pip install radon --quiet && radon cc app/ -a -s --min C
```

### 3. Review for Issues

Check changed files for:

- [ ] Unused imports, functions, variables
- [ ] Repeated code patterns → extract to helpers
- [ ] Long functions (>50 lines) → break into smaller units
- [ ] Deep nesting (>3 levels) → flatten with early returns
- [ ] Unclear variable/function names → rename for clarity

## Frontend Cleanup

### 4. Find Unused Exports

```bash
cd frontend && npx knip --include exports
```

### 5. Review Components

Check for:

- [ ] Unused props or state
- [ ] Components that can be split
- [ ] Repeated JSX patterns → extract components
- [ ] Inline styles → move to CSS

## Notes

- Run after completing a feature, before final PR review
- Focus on files you changed, not entire codebase
- Jules can run weekly dead code scan and create cleanup issues
