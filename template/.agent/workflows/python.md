---
description: standard workflow for running Python commands in this project
---

# Python Development Workflow

**CRITICAL**: This project uses a Python virtual environment. Always follow these steps.

## Before Running ANY Python Command

// turbo-all
1. Activate the virtual environment:
   ```bash
   source .venv/bin/activate
   ```

2. Then run your Python commands (pytest, uvicorn, python scripts, etc.)

## Examples

**Running tests:**
```bash
source .venv/bin/activate && python -m pytest tests/ -v
```

**Starting the API server:**
```bash
source .venv/bin/activate && uvicorn app.main:app --reload --port 8000
```

**Running a Python script:**
```bash
source .venv/bin/activate && python verify_api.py
```

## Installing New Dependencies

1. Activate venv first
2. Install with pip
3. Update requirements.txt:
   ```bash
   source .venv/bin/activate && pip install <package> && pip freeze > requirements.txt
   ```
