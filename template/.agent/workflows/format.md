---
description: auto-format code after changes using ruff (Python) and eslint (frontend)
---

# Format Workflow

Auto-format code for consistency. Run after making changes or before commits.

// turbo-all

## Python Formatting

1. Format Python code with ruff:

   ```bash
   source .venv/bin/activate && ruff format app/ tests/ *.py
   ```

2. Fix linting issues automatically:

   ```bash
   source .venv/bin/activate && ruff check --fix app/ tests/ *.py
   ```

## Frontend Formatting

3. Format and fix frontend code:

   ```bash
   cd frontend && npm run lint -- --fix
   ```

## Verification

4. Check for any remaining issues:

   ```bash
   source .venv/bin/activate && ruff check app/ tests/ *.py
   ```

## Notes

- Run this workflow before creating PRs for cleaner diffs
- Jules can run this weekly as an automated formatting PR
- Ruff handles both formatting (like Black) and linting (like Flake8)
