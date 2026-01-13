---
description: run the complete pytest test suite
---

# Test Workflow

// turbo-all

1. Run all tests with verbose output:

   ```bash
   source .venv/bin/activate && python -m pytest tests/ -v
   ```

2. **Visual Evidence**:
   - If running browser/UI tests (e.g., via Playwright), capture screenshots of
     critical states or failure sessions.
   - Embed images/recordings in `walkthrough.md`.

## Running Expensive Tests (Deep Research API)

By default, tests marked `@pytest.mark.expensive` are **included** in the standard run.
To run **ONLY** expensive tests (careful - these cost $1-5 per test):

```bash
source .venv/bin/activate && python -m pytest tests/ -m expensive -v
```

To **skip** expensive tests:

```bash
source .venv/bin/activate && python -m pytest tests/ -m "not expensive" -v
```

## Optional: Run with Coverage

```bash
source .venv/bin/activate && python -m pytest tests/ -v --cov=app --cov-report=term-missing
```

## Optional: Run Specific Test File

```bash
source .venv/bin/activate && python -m pytest tests/test_<name>.py -v
```
