---
name: First-Time Setup
description: New machine or environment onboarding
---

# First-Time Setup Skill

Complete environment setup for a new machine or fresh clone.

## When to Use This Skill

Use this skill when:

- `sync-start` detects missing environment
- User says "set up environment" or "first time setup"
- `.venv/` directory is missing
- Pre-commit hooks are not installed
- After cloning the repository for the first time

## Detection Logic

This skill should be invoked if ANY of these are true:

```
Environment check:
├── Python venv missing?
│   └── Test: [ ! -d ".venv" ] && [ ! -d "venv" ]
│
├── Dependencies not installed?
│   └── Test: pip list shows missing packages
│
├── Pre-commit not installed?
│   └── Test: [ ! -f ".git/hooks/pre-commit" ]
│
├── GEMINI.md not synced?
│   └── Test: [ ! -L ~/.gemini/GEMINI.md ]
│
└── Node modules missing? (if frontend exists)
    └── Test: [ -f "package.json" ] && [ ! -d "node_modules" ]
```

## Step-by-Step Setup

### 1. Check Prerequisites

```bash
# Python version
python3 --version  # Should be 3.11+

# Node version (if frontend)
node --version  # Should be 18+

# Git configured
git config user.email
git config user.name
```

### 2. Create Python Virtual Environment

```bash
python3 -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
```

### 3. Install Python Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt

# If dev dependencies exist
pip install -r requirements-dev.txt 2>/dev/null || true
```

### 4. Install Frontend Dependencies (if applicable)

```bash
if [ -f "package.json" ]; then
    npm install
fi

if [ -f "frontend/package.json" ]; then
    cd frontend && npm install && cd ..
fi
```

### 5. Sync Global IDE Rules

```bash
chmod +x scripts/sync-gemini-rules.sh
./scripts/sync-gemini-rules.sh
```

### 6. Install Pre-commit Hooks

```bash
pip install pre-commit
pre-commit install
```

### 7. Create Secrets Baseline (if needed)

```bash
if [ ! -f ".secrets.baseline" ]; then
    pip install detect-secrets
    detect-secrets scan > .secrets.baseline
fi
```

### 8. Set Up Environment Variables

Check for required environment variables:

```bash
# Check .env.example or .env.template
if [ -f ".env.example" ]; then
    echo "Copy .env.example to .env and fill in values:"
    cat .env.example
fi
```

Required variables typically include:

- `GOOGLE_CLOUD_PROJECT`
- `GITHUB_PERSONAL_ACCESS_TOKEN`
- API keys for external services

### 9. Verify MCP Servers

Check that MCP servers are configured:

```bash
# List expected MCP servers
cat .agent/IDE_CONFIG.md | grep -A 20 "MCP Servers"
```

Verify each is working:

- GitHub MCP: `gh auth status`
- Context7: Test with a library lookup
- Playwright: Browser should be installed

### 10. Run Initial Tests

```bash
# Activate venv first
source .venv/bin/activate

# Run tests
pytest tests/ -v --tb=short
```

### 11. Verify Setup Complete

Checklist:

- [ ] `.venv/` exists and activated
- [ ] `pip list` shows all dependencies
- [ ] `.git/hooks/pre-commit` exists
- [ ] `~/.gemini/GEMINI.md` is symlinked
- [ ] `.env` file exists (if required)
- [ ] Tests pass

## Output

After setup, report:

```markdown
## First-Time Setup Complete

### Environment

- Python: 3.12.1
- Node: 20.10.0 (if applicable)
- venv: ✅ Created

### Dependencies

- Python packages: 47 installed
- npm packages: 234 installed (if applicable)

### Hooks

- Pre-commit: ✅ Installed
- detect-secrets: ✅ Configured

### IDE

- GEMINI.md: ✅ Synced

### Tests

- Result: ✅ All passing (or ⚠️ X failures)

### Next Steps

1. Review `.env` configuration
2. Run `/sync-start` to begin development
```

## Common Issues

| Issue                       | Solution                                       |
| --------------------------- | ---------------------------------------------- |
| Python version mismatch     | Use pyenv to install correct version           |
| pip install fails           | Check for C compiler (gcc/clang)               |
| Pre-commit fails on install | Update pre-commit: `pip install -U pre-commit` |
| Tests fail on fresh setup   | Check for missing env vars or services         |
