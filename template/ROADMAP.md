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

### 🔴 Automated UI Testing with Browser Recording

**Priority:** High
**Category:** Quality/Testing

Enforce automated testing for new features that change the UI and/or logic surfaced in the UI using Antigravity and Chrome.

**Key Requirements:**

- Browser agent using Antigravity + local Chrome browser
- Record video session of successful test run
- Video artifact saved as proof of test execution
- Integration with CI/CD pipeline for automated verification

---

### 🔴 Standard User-Facing Documentation

**Priority:** High
**Category:** Documentation

Define standard user-facing documentation that should be generated and kept up-to-date.

**Key Requirements:**

- Establish documentation templates and structure
- Automate documentation updates during development workflows
- Ensure documentation stays in sync with code changes

---

### 🔴 Autonomous Manual Test Execution

**Priority:** High
**Category:** Quality/Testing

Direct agents to autonomously perform any tests that would otherwise be suggested as "manual tests" by the developer.

**Key Requirements:**

- Always use antigravity chrome browser extension using the browser subagent
- Record either a successful test or record the last unsuccessful before exiting testing

---

### 🔴 Browser-Based Deep Research Skill

**Priority:** Medium
**Category:** Research/Planning

Create a skill for using local browser automation to conduct deep research when additional information would help inform planning or expand options.

**Key Requirements:**

- Use antigravity chrome browser extension via browser subagent
- Automate searches, page navigation, and information extraction
- Synthesize findings into actionable context for planning phases

---

### 🔴 Opportunistic Error Fixing

**Priority:** Medium
**Category:** Developer Experience

When agents encounter unrelated linting, mypy, or other static analysis errors, they should use judgment to fix them.

**Key Requirements:**

- Agents should note unrelated errors observed during execution
- Fix errors opportunistically without disrupting the primary task
- Document fixes in the commit or changelog as appropriate

---

### 🔴 Jules Deprecation Scanner

**Priority:** Medium
**Category:** Maintenance/Automation

Add a standard Jules agent to scan project code for deprecation warnings from installed packages.

**Key Requirements:**

- Run pytest with deprecation warnings enabled
- Parse and categorize deprecation warnings by package/module
- Report which dependencies are causing warnings and suggest upgrades

---

### ✅ Conventional Commits

**Priority:** Low
**Category:** Documentation

Adopt standardized commit message prefixes (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`).

**Benefits:**

- Enables auto-changelog generation
- Clearer git history
- Supports semantic versioning

---

### ✅ Branch Naming Convention

**Priority:** Low
**Category:** Documentation

Define standard branch prefixes: `feature/`, `fix/`, `refactor/`, `docs/`.

**Benefits:**

- Improves repository organization
- Makes PRs scannable at a glance
- Enables branch-based CI rules

---

### ✅ Type Safety Mandate

**Priority:** Low
**Category:** Documentation

Add explicit rule requiring type hints on all new code and avoiding `Any`.

**Benefits:**

- Catches bugs at development time
- Improves IDE support and autocomplete
- Makes code self-documenting

---

### ✅ PR & Issue Templates

**Priority:** Low
**Category:** Documentation

Add `.github/PULL_REQUEST_TEMPLATE.md` and issue templates for consistent bug/feature reporting.

---

## 🔒 Recovery & Safety

### ✅ Rollback & Recovery Guidance

**Priority:** Medium
**Category:** Documentation

Add AGENTS.md section on recovering from agent mistakes.

---

### ✅ Security Review Trigger Rules

**Priority:** Medium
**Category:** Documentation

Document when enhanced security review is required.

---

### ✅ Code Review Checklist

**Priority:** Medium
**Category:** Documentation

Add structured checklist to `/review` workflow.
