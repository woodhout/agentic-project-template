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

### ✅ Explicit First-Time Setup Logic

**Priority:** High
**Category:** Infrastructure/Automation

First-time setup logic now uses a machine-specific marker file (`.agent/.setup-complete`) to distinguish between initial setup and recurring synchronization.

> Implemented in `sync-start.md`, `first-time-setup/SKILL.md`, and `bootstrap/SKILL.md`.

---

### ✅ Template vs. Downstream Workflow Differentiation

**Priority:** Medium
**Category:** Process/Workflow

Workflows are now organized by scope into subdirectories (`universal/`, `template-only/`, `downstream-only/`) with metadata tags. Bootstrap filters out template-only workflows.

> Implemented in `.agent/workflows/` directory structure, `bootstrap/SKILL.md`, and new `/submit-idea` workflow.

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

### 🔴 Periodic Health Checks & Tech Assessments

**Priority:** Medium
**Category:** Process/Maintenance

Establish a process for periodic project health checks and technical assessments to ensure long-term maintainability and architectural soundness.

**Key Requirements:**

- **Health Check Protocol:** Define a checklist for documentation freshness, file hygiene, and compliance consistency (see `resume-tailoring-agentic-system/docs/health_check.md` for reference).
- **Tech Stack Assessment:** Periodic review of frameworks, databases, and infrastructure against evolving requirements.
- **LLM Architecture Review:** Assessment of models used, orchestration patterns, and model sources (OpenRouter vs Direct) to optimize for cost/performance.
- **Output:** Standardized report templates for these finding.

---

### 🔴 Agent Context & Skill Alignment Review

**Priority:** Medium
**Category:** Process/Maintenance

Reassess all template agent contexts (e.g., `AGENTS.md`), workflows, and skill definitions to ensure they align with the expanded skill set added since project inception.

**Key Requirements:**

- **Holistic Review:** Analyze `AGENTS.md` rules against current `tools` and `.agent/skills/`.
- **Optimization:** Identify redundant prompts or missing instructions for new capabilities (e.g., new MCP servers).
- **Skill Integration:** Ensure core agent context explicitly knows when/how to use newer skills (e.g., Playwright, Browser Automation) effectively.

---

### 🔴 Agent-Optimized Repository Architecture

**Priority:** High
**Category:** Process/Workflow

Implement a hierarchical documentation strategy to optimize the workflow for Gemini and Claude agents, ensuring consistent logic and minimal token waste.

**Key Requirements:**

- **Core File Concepts:** Implement `README.md`, `AGENTS.md`, and `CLAUDE.md` with clear objectives.
- **Hierarchical Placement:** Establish root and sub-directory level context files.
- **Unified Standards:** Symlink `AGENTS.md` to `CLAUDE.md`.
- **Reference:** See [`reference/agent-optimized-architecture.md`](reference/agent-optimized-architecture.md) for detailed architecture and implementation benefits.

---

### 🔴 Centralized Idea Queue & Bootstrapping

**Priority:** Medium
**Category:** Process/Workflow

Implement a centralized mechanism for downstream projects to submit future project ideas, and a workflow to review and promote these ideas into new project repositories via the Bootstrap skill.

**Key Requirements:**

- **Idea Ingestion:** Standard mechanism (Issues or central file) to capture ideas from downstream.
- **Review Workflow:** Extensions to `/idea-review` or new workflow to triage these external ideas.
- **Promotion Action:** Ability to trigger `Bootstrap New Project` skill directly from an accepted idea, pre-filling context.

---

### 🔴 Template Sync: Detect New Remote Projects

**Priority:** Medium
**Category:** Process/Workflow

Enhance `/sync-start` (specifically for the template project) to detect projects that may have been bootstrapped on other machines.

**Key Requirements:**

- **Scope:** Template project only.
- **Detection:** Query GitHub for repositories that are not present locally.
- **Filter:** Identify projects that are relevant (e.g., match template patterns or generally new repos).
- **Interactive Prompt:** Ask user if they want to clone these missing projects to the current machine.

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

### ✅ Opportunistic Error Fixing

**Priority:** Medium
**Category:** Developer Experience

When agents encounter unrelated linting, mypy, or other static analysis errors, they should use judgment to fix them.

> Already implemented in `AGENTS.md` Section 7 (lines 74-79).

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

### 🔴 Stitch by Google MCP & Skill

**Priority:** High
**Category:** Tooling/Skills

Integrate the Stitch by Google MCP server to enable UI generation and design capabilities, and implement the corresponding Agent Skill.

**Key Requirements:**

- **Manual MCP Logic:**
  - The server is remote: `https://stitch.googleapis.com/mcp`
  - Requires headers: `Authorization: Bearer <TOKEN>` and `X-Goog-User-Project: <PROJECT_ID>`
  - Environment variables: `STITCH_ACCESS_TOKEN`, `STITCH_PROJECT_ID`
- **Prerequisites:**
  - Active GCP Project
  - Enable service: `gcloud beta services mcp enable stitch.googleapis.com`
  - Auth: `gcloud auth login` and `gcloud auth application-default print-access-token` for token generation
- **Skill Implementation:**
  - Create a new skill in `.agent/skills/` that encapsulates the usage of this MCP
  - Follow guidance at `https://stitch.withgoogle.com/docs/mcp/guide/` and `https://stitch.withgoogle.com/docs/mcp/reference/`

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

### 🔴 Deep Research: Antigravity IDE Best Practices

**Priority:** High
**Category:** Research/Docs

Conduct a deep research analysis to identify the latest best practices for leveraging the Antigravity IDE for agentic coding, specifically tailored to bridge the gap between novice developers and experienced software engineers.

**Key Requirements:**

- **Focus Area:** Project scaffolding and architectural setup.
- **Goal:** Enable a novice developer to setup a project that mirrors the standards and structure of an experienced SWE.
- **Deliverable:** A comprehensive guide or set of "Gold Standard" templates/practices.

---

### 🔴 Deep Research: Agentic System Architectures

**Priority:** High
**Category:** Research/Docs

Conduct a deep research analysis on the latest agentic system architecture patterns, variations, and decision frameworks.

**Key Requirements:**

- **Scope:** Investigate various architecture patterns (e.g., multi-agent tiers, hierarchical planning, swarms).
- **Analysis:** Provide a comparative guide on "when to use" specific architectures based on project complexity and requirements.
- **Deliverable:** A reference document or matrix for selecting the right agentic architecture.

---

### 🔴 Tool & Dependency Feature Tracking

**Priority:** Medium
**Category:** Tooling/Maintenance

Research and implement a mechanism to proactively identify new features shipping with updates to project tools and dependencies (CLIs, packages, frameworks).

**Key Requirements:**

- **Goal:** Ensure the project continuously evolves by leveraging new capabilities in its stack.
- **Mechanism:** A system (automated or workflow-based) to bubble up "What's New" for critical dependencies.
- **Benefit Analysis:** For each major update, prompt for consideration of any benefits to utilizing the new features.

---

### 🔴 Deep Research: Multi-Environment Architecture

**Priority:** Medium
**Category:** Research/Architecture

Conduct a deep research analysis for best practices on multi-environment architecture specifically for non-commercial applications.

**Key Requirements:**

- **Context:** Non-commercial / Personal / Open Source projects.
- **Decision Framework:** Define criteria for when to introduce distinct environments (e.g., Test, QA, Sandbox) vs. keeping a simpler dev/prod split.
- **Deliverable:** A guide on scaling environment complexity only when necessary.

---

### 🔴 Conflict-Free Automated Changelog Updates

**Priority:** Medium
**Category:** Maintenance/Automation

Research options to modify Jules scheduled tasks to document their changes in a way that avoids merge conflicts (e.g., appending to a queue or using fragment files) rather than editing the main `CHANGELOG.md` directly in the PR.

**Key Requirements:**

- **Context:** Concurrent PRs from automated agents (Jules) often conflict on `CHANGELOG.md` because they start from the same base version.
- **Research:** Evaluate patterns like changelog fragments (e.g., `towncrier`, `changelog-d`) or distinct append-only logs that are consolidated later.
- **Outcome:** A recommendation and implementation plan for ensuring automated tasks can document changes without blocking each other at merge time.

---

### 🔴 Standardized Workflow Step Documentation

**Priority:** Medium
**Category:** Documentation

Create a standard document (or template) for each workflow defined in the project that outlines the specific steps the workflow takes as a clear task list.

**Key Requirements:**

- **Step-by-Step Breakdown:** Each workflow should have a corresponding human-readable list of actions it performs.
- **Standardization:** Define a consistent format for these descriptions (e.g., a "Steps" section in the workflow definition or a companion markdown file).
- **Goal:** Allow users to understand exactly what a workflow does (e.g., "Sync Start") without parsing the implementation code.

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
