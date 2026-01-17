# Roadmap

> Track planned features and improvements for this project.

## Status Legend

| Icon | Status      |
| ---- | ----------- |
| 🔴   | Not Started |
| 🟡   | In Progress |
| ✅   | Completed   |

---

## Planned Items

### 🔴 Automate Bootstrap from Gem Seeds

**Priority:** High
**Category:** Infrastructure/Automation

Research and implement a process to automatically create project scaffolding and run setup using output files from a Gemini Gem as seed data.

**Key Requirements:**
- Define standard Gem output format for seeding
- Update `bootstrap` skill to parse Gem-generated files
- Automate repository initialization and initial `sync-start`

---

### ✅ Conventional Commits

**Priority:** Low
**Category:** Documentation

Adopt standardized commit message prefixes (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`).

**Benefits:**

- Enables auto-changelog generation
- Clearer git history
- Supports semantic versioning

**Key Requirements:**

- Add commit format rules to AGENTS.md
- Optionally add commit-msg hook for enforcement

---

### ✅ Branch Naming Convention

**Priority:** Low
**Category:** Documentation

Define standard branch prefixes: `feature/`, `fix/`, `refactor/`, `docs/`.

**Benefits:**

- Improves repository organization
- Makes PRs scannable at a glance
- Enables branch-based CI rules

**Key Requirements:**

- Document convention in AGENTS.md or CONTRIBUTING.md

---

### ✅ Type Safety Mandate

**Priority:** Low
**Category:** Documentation

Add explicit rule requiring type hints on all new code and avoiding `Any`.

**Benefits:**

- Catches bugs at development time
- Improves IDE support and autocomplete
- Makes code self-documenting

**Key Requirements:**

- Add type safety rules to AGENTS.md
- Configure mypy or equivalent in pre-commit hooks

---

### ✅ PR & Issue Templates

**Priority:** Low
**Category:** Documentation

Add `.github/PULL_REQUEST_TEMPLATE.md` and issue templates for consistent bug/feature reporting.

**Benefits:**

- Standardizes bug reports with required sections
- Ensures PRs include context and testing notes
- Reduces back-and-forth in reviews

**Key Requirements:**

- Create PR template with description, testing, and checklist sections
- Create issue templates for bugs and feature requests

---

## 🔒 Recovery & Safety

### ✅ Rollback & Recovery Guidance

**Priority:** Medium
**Category:** Documentation

Add AGENTS.md section on recovering from agent mistakes.

**Topics to Cover:**

- Git rollback commands (`git reset`, `git checkout`, `git revert`)
- When to abandon branch vs fix forward
- Database/storage recovery patterns
- How to handle stuck/hanging commands

---

### ✅ Security Review Trigger Rules

**Priority:** Medium
**Category:** Documentation

Document when enhanced security review is required.

**Triggers:**

- Adding new API endpoints (input validation)
- Handling user-provided URLs (SSRF check)
- Modifying authentication/authorization
- Adding environment variables with secrets

---

### ✅ Code Review Checklist

**Priority:** Medium
**Category:** Documentation

Add structured checklist to `/review` workflow.

**Checklist Items:**

- [ ] No hardcoded secrets/URLs
- [ ] Input validation on new endpoints
- [ ] Tests added for new functionality
- [ ] Documentation updated
- [ ] No console.log/print in production code
