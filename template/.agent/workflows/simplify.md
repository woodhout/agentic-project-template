---
description: post-implementation cleanup for dead code, duplication, and complexity
---

# Simplify Workflow

Invoke the `simplify` skill for code cleanup and refactoring.

## Quick Usage

```text
Simplify the codebase
```

Or target specific areas:

```text
Look for dead code in app/
Check for duplication in the routes
Reduce complexity in the handlers
```

## What the Skill Does

The `simplify` skill provides:

1. **Dead code detection** (unused imports, functions, variables)
2. **Duplication analysis** (copy-paste code, repeated patterns)
3. **Complexity metrics** (function length, nesting depth)
4. **Dependency audit** (unused packages)
5. **Refactoring patterns** (extract function, early return, constants)

See `.agent/skills/simplify/SKILL.md` for full details.
