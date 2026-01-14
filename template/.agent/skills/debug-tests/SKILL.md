---
name: Debug Tests
description: Systematic test failure diagnosis
---

# Debug Tests Skill

Systematically diagnose and fix test failures.

## When to Use This Skill

Use this skill when:

- `pytest` or test runner reports failures
- `/test` workflow encounters errors
- User asks to "fix tests" or "debug test failures"
- CI pipeline fails on tests

## Decision Tree

```
Test failure type?
│
├── Import Error
│   ├── Module not found → Check dependencies, venv active
│   ├── Circular import → Review import structure
│   └── Syntax error → Fix syntax in source file
│
├── Assertion Error
│   ├── Expected vs actual mismatch → Analyze values
│   │   ├── Logic bug → Fix source code
│   │   ├── Test outdated → Update test expectations
│   │   └── Data issue → Check fixtures/mocks
│   └── Type mismatch → Check type coercion
│
├── Fixture Error
│   ├── Fixture not found → Check fixture scope/imports
│   ├── Fixture setup fails → Debug fixture code
│   └── Fixture teardown fails → Check cleanup logic
│
├── Timeout
│   ├── Infinite loop → Add breakpoint, trace execution
│   ├── Slow external call → Mock the call
│   └── Deadlock → Check async/threading
│
├── Connection Error
│   ├── Database → Check connection string, is DB running?
│   ├── External API → Should be mocked in tests
│   └── File not found → Check paths, working directory
│
└── Flaky Test
    ├── Race condition → Add proper synchronization
    ├── Time-dependent → Mock time/dates
    └── Order-dependent → Use proper isolation
```

## Diagnosis Process

### Step 1: Run Tests with Verbose Output

```bash
# Run failing test with maximum verbosity
pytest tests/path/to/test.py::test_function -vvv --tb=long

# Show local variables in traceback
pytest tests/ -l --tb=long

# Stop on first failure for focused debugging
pytest tests/ -x --tb=long
```

### Step 2: Identify Failure Type

Read the traceback bottom-up:

1. **Last line:** The actual error
2. **Middle:** The call stack
3. **Top:** Where the test started

### Step 3: Apply Fix Based on Type

#### Import Errors

```bash
# Check if module exists
python -c "import module_name"

# Check venv is active
which python

# Reinstall dependencies
pip install -r requirements.txt
```

#### Assertion Errors

```python
# Add debugging output
def test_something():
    result = function_under_test()
    print(f"DEBUG: result = {result}")
    print(f"DEBUG: type = {type(result)}")
    assert result == expected
```

Or use pytest's built-in:

```bash
pytest tests/ --capture=no  # Show print statements
```

#### Fixture Errors

Check fixture is properly defined:

```python
# conftest.py
import pytest

@pytest.fixture
def my_fixture():
    # Setup
    resource = create_resource()
    yield resource
    # Teardown
    resource.cleanup()
```

#### Timeout Issues

```bash
# Run with timeout visibility
pytest tests/ --timeout=10 --timeout_method=thread

# Add breakpoint
def test_slow_thing():
    import pdb; pdb.set_trace()  # or breakpoint()
    result = slow_function()
```

#### Connection Errors

Ensure tests use mocks:

```python
from unittest.mock import patch

@patch('module.external_api_call')
def test_with_mock(mock_api):
    mock_api.return_value = {'status': 'ok'}
    result = function_that_calls_api()
    assert result == expected
```

### Step 4: Flaky Test Detection

```bash
# Run test multiple times
pytest tests/path/to/test.py --count=10

# Run tests in random order
pytest tests/ --random-order

# Run tests in parallel (finds isolation issues)
pytest tests/ -n auto
```

## Common Fixes

| Symptom                           | Likely Cause               | Fix                                         |
| --------------------------------- | -------------------------- | ------------------------------------------- |
| `ModuleNotFoundError`             | venv not active            | `source .venv/bin/activate`                 |
| `AssertionError: None != ...`     | Function not returning     | Add return statement                        |
| `fixture 'x' not found`           | Missing import             | Add `from conftest import x` or check scope |
| `TimeoutError`                    | Infinite loop/slow code    | Mock slow dependencies                      |
| `ConnectionRefusedError`          | Trying to hit real service | Use mocks                                   |
| Test passes alone, fails in suite | Shared state pollution     | Isolate fixtures                            |

## Output Format

````markdown
## Test Debug Report

### Failure Summary

- Total tests: 45
- Passed: 42
- Failed: 3

### Failures Analyzed

#### 1. test_user_creation

**Error Type:** AssertionError
**File:** `tests/test_users.py:45`
**Cause:** Function returns None instead of User object
**Fix:** Added return statement in `create_user()`
**Status:** ✅ Fixed

#### 2. test_api_call

**Error Type:** ConnectionError
**File:** `tests/test_api.py:23`
**Cause:** Test hitting real API instead of mock
**Fix:** Added `@patch` decorator
**Status:** ✅ Fixed

#### 3. test_concurrent_access

**Error Type:** Flaky (passes 8/10 times)
**File:** `tests/test_concurrent.py:67`
**Cause:** Race condition in shared resource
**Fix:** Added proper locking
**Status:** ✅ Fixed

### Verification

```bash
pytest tests/ -v
# All 45 tests passing
```
````

```

## Prevention Tips

1. **Always mock external dependencies**
2. **Use fixtures for test isolation**
3. **Run tests in random order periodically**
4. **Set timeouts on potentially slow tests**
5. **Use `pytest-xdist` to catch isolation issues**
```
