---
name: Simplify
description: Dead code detection, complexity reduction, and refactoring guidance
---

# Simplify Skill

Identify and remove unnecessary complexity, dead code, and duplication.

## When to Use This Skill

Use this skill when:

- User asks to "simplify" or "clean up" code
- After completing a feature (post-implementation cleanup)
- When `/simplify` workflow is invoked
- Code review identifies complexity issues
- Technical debt has accumulated

## Decision Tree

```text
What to simplify?
│
├── Dead code
│   ├── Unused imports → Remove
│   ├── Unused functions → Verify not called, remove
│   ├── Commented code → Remove (it's in git)
│   └── Unreachable code → Remove
│
├── Duplication
│   ├── Copy-paste code → Extract to function
│   ├── Similar patterns → Create utility
│   └── Repeated strings → Create constants
│
├── Complexity
│   ├── Long functions (>50 lines) → Split
│   ├── Deep nesting (>3 levels) → Early returns
│   ├── Many parameters (>5) → Use object/dataclass
│   └── Complex conditionals → Extract to named function
│
└── Dependencies
    ├── Unused packages → Remove from requirements
    ├── Deprecated packages → Update or replace
    └── Overlapping packages → Consolidate
```

## Analysis Process

### Step 1: Dead Code Detection

**Python:**

```bash
# Find unused imports
ruff check --select F401 .

# Find unused variables
ruff check --select F841 .
```

**TypeScript/JavaScript:**

```bash
# Using eslint
npx eslint . --rule 'no-unused-vars: error'
```

**Manual checks:**

- Search for functions with no callers
- Look for files not imported anywhere
- Check for feature flags that are always on/off

### Step 2: Duplication Analysis

Look for:

- Functions with similar names
- Copy-pasted code blocks
- Repeated error handling patterns
- Similar API call patterns

### Step 3: Complexity Metrics

Evaluate:

- Function length (aim for <30 lines)
- Cyclomatic complexity (aim for <10)
- Nesting depth (aim for <3)
- Parameter count (aim for <5)

### Step 4: Dependency Audit

```bash
# Python - find unused
pip-autoremove --list

# Node - find unused
npx depcheck
```

## Refactoring Patterns

### Extract Function

```python
# Before
def process_order(order):
    # 20 lines of validation
    # 20 lines of processing
    # 20 lines of notification

# After
def process_order(order):
    validate_order(order)
    result = execute_order(order)
    notify_customer(order, result)
```

### Early Return

```python
# Before
def get_user(id):
    if id:
        user = db.find(id)
        if user:
            if user.active:
                return user

# After
def get_user(id):
    if not id:
        return None
    user = db.find(id)
    if not user or not user.active:
        return None
    return user
```

### Replace Magic Numbers

```python
# Before
if status == 3:
    ...

# After
STATUS_COMPLETED = 3
if status == STATUS_COMPLETED:
    ...
```

## Output Format

```markdown
## Simplification Report

### Summary

- Dead code found: X items
- Duplication found: X instances
- Complexity issues: X functions
- Unused dependencies: X packages

### Recommended Actions

#### High Priority

1. **Remove unused function `old_handler()`**
   - File: `app/handlers.py:45-67`
   - Reason: No callers found
2. **Extract duplicate validation**
   - Files: `routes/users.py`, `routes/orders.py`
   - Pattern: Email validation repeated 3 times
   - Action: Create `utils/validators.py`

#### Medium Priority

...

### Estimated Impact

- Lines removed: ~X
- Files affected: X
- Risk level: Low/Medium/High
```

## Safety Checks

Before removing anything:

1. **Search for dynamic calls**

   - `getattr()`, `eval()`, reflection
   - String-based imports

2. **Check test coverage**

   - Is the "dead" code tested?
   - Tests might be the only caller

3. **Check external references**

   - API endpoints
   - CLI commands
   - Scheduled jobs

4. **Verify with git**

   ```bash
   git log -p --all -S 'function_name' -- '*.py'
   ```
