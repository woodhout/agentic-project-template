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

### 🔴 Explicit First-Time Setup Logic

**Priority:** High
**Category:** Infrastructure/Automation

Distinguish clearly between first-time setup actions (bootstrap) vs. recurring synchronization (`sync-start`, `template-sync`) to prevent redundant configuration steps in downstream projects.

**Key Requirements:**

- Audit `bootstrap`, `sync-start`, and `template-sync` workflows
- Ensure idempotent behavior for recurring syncs
- Verify that "first-time" logic only runs once or when explicitly requested

---

### 🔴 Template vs. Downstream Workflow Differentiation

**Priority:** Medium
**Category:** Process/Workflow

Analyze and categorize workflows to distinguish those applicable to the template project itself versus those intended for downstream bootstrapped projects.

**Key Requirements:**

- Review all `.agent/workflows`
- Tag or separate workflows relevant only to the template maintenance
- Ensure downstream projects only receive/inherit relevant workflows
- Update documentation to reflect the distinction

---

### 🔴 Downstream Idea Capture & Feedback Loop

**Priority:** Medium
**Category:** Process/Workflow

Create a mechanism for downstream projects to easily capture new project ideas and feed them back into the template project's `FUTURE_PROJECTS.md` or a dedicated queue for consideration.

**Key Requirements:**

- "Submit Idea" workflow/skill in downstream projects
- Centralized queue or inbox in the template project (e.g., `TEMPLATE_IDEAS_QUEUE.md`)
- Review process to promote ideas to `FUTURE_PROJECTS.md`

---

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
- **Design Inspiration:** See `reference/20260116_183359.jpg` for expected structure and visual style.

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

### 🔴 Playwright MCP Browser Skill

**Priority:** High
**Category:** Tooling/Skills

Create a skill for the agent to use Playwright via MCP for local browser automation to access the browser and take screenshots and recordings of any findings.

**Key Requirements:**

- Enable persistent browser access via Playwright MCP
- Mechanisms for taking screenshots and recordings of tests/settings
- Documentation for agent usage patterns

---

### 🔴 Exploration Skill

**Priority:** High
**Category:** Tooling/Skills

Create a skill that leverages the Playwright MCP browser skill to autonomously "use" the target application. The agent should actively look for opportunities, enhancements, and new feature ideas during usage.

**Key Requirements:**

- Leverage Playwright MCP for navigation and interaction
- Analyze UI/UX and functionality for improvements
- **Roadmap Review Queue**: Create a mechanism/queue (file or workflow) to capture these suggestions for later review
- Log all findings to the Roadmap Review Queue

---

### 🔴 Task Kickoff & Pre-Planning Workflow

**Priority:** High
**Category:** Process/Workflow

Establish a standard workflow/skill for the "Kickoff" phase that occurs _after_ selecting roadmap items (via `/roadmap-review`) but _before_ drafting the `implementation_plan.md`.

**Key Requirements:**

- **Analysis Phase**: Agent must review selected items and advise on:
  - Research needs (libraries, patterns, existing code context)
  - Potential architectural concerns or risks
  - Suggestions for implementation approaches
  - Key decisions required from the user
- **Collaboration Loop**: Iterate with the user on these findings.
- **Transition Criteria**: Only proceed to draft `implementation_plan.md` and `task.md` once the user confirms readiness based on the analysis.

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
