# Jules Prompt Changelog

All notable changes to Jules prompts are documented here. This file is append-only (newest entries at TOP).

---

## 2026-01-12 - Context7 Librarian v1.0 (New Prompt)

**Prompt:** `context7_librarian.md`
**Changes:**

- Created new prompt for daily Context7 library registry synchronization
- Scans `requirements.txt` and `frontend/package.json` for dependencies
- Assesses libraries for "API-heavy" status (eligible for Context7 lookup)
- Updates `.agent/CONTEXT7_LIBS.md` with new/removed libraries
- Creates PR only when changes detected

**Rationale:** Automate maintenance of Context7-eligible library list to keep agent documentation lookups current without manual intervention.

**Schedule:** Daily at 6am CST

---

## 2026-01-06 - Dead Code Scanner v1.0 (New Prompt)

**Prompt:** `dead_code_scanner.md`
**Changes:**

- Created new prompt for weekly dead code detection
- Uses `vulture` and `ruff` for Python, ESLint for frontend
- Severity-based action (auto-remove high-confidence, create issue for uncertain)
- False positive awareness with conservative removal approach

**Rationale:** Reduce cognitive load and maintenance burden by removing unused code.

---

## 2026-01-06 - Code Formatter v1.0 (New Prompt)

**Prompt:** `code_formatter.md`
**Changes:**

- Created new prompt for weekly automated code formatting
- Runs `ruff format` + `ruff check --fix` for Python
- Runs `npm run lint -- --fix` and Prettier for frontend
- Creates single PR with all formatting changes

**Rationale:** Consistent code formatting reduces merge conflicts and cognitive load.

---

## 2025-12-26 - Test Guardian v2.0 (New Prompt)

**Prompt:** `test_guardian.md`
**Changes:**

- Created new prompt for maintaining test coverage
- Defines coverage targets per component (workers 80%, api 75%, etc.)
- Includes good/bad test pattern examples
- Runs after PRs merge to catch coverage regression

**Rationale:** Proactively maintain code quality as codebase grows.

---

## 2025-12-26 - Dependency Doctor v2.0 (New Prompt)

**Prompt:** `dependency_doctor.md`
**Changes:**

- Created new prompt for scanning vulnerable/outdated packages
- Runs `pip-audit` and `npm audit` commands
- Severity-based action guidelines (CRITICAL = immediate PR)
- Weekly schedule recommendation

**Rationale:** Complement Sentinel (code security) with dependency security.

---

## 2025-12-26 - Compliance Auditor v2.0 (New Prompt)

**Prompt:** `compliance_auditor.md`
**Changes:**

- Created new prompt for Glass Box principle and user edit integrity verification
- Checks that `confirmed_revisions` are never silently modified
- Verifies API endpoint documentation in `app/api/routes.py`
- Opens GitHub Issues (not PRs) for compliance violations
- Removed placeholder `scribe.md` (not a scheduled task)

**Rationale:** Scheduled task to ensure user trust and transparency principles are maintained.

---

## 2025-12-26 - Analytics Auditor v2.0 (New Prompt)

**Prompt:** `analytics_auditor.md`
**Changes:**

- Created new prompt for verifying telemetry on critical user actions
- Focuses on Job Submission, Strategy Confirmation, PDF Download events
- Specifically checks for `projectedMatchScore` logging in StrategyBoard
- Added **DATE HANDLING - CRITICAL** section
- Added **MANDATORY FILE REFERENCE** requirement

**Rationale:** Scheduled task to ensure critical user actions have proper analytics tracking.

---

## 2025-12-26 - Context Sync v2.0 (New Prompt)

**Prompt:** `context_sync.md`
**Changes:**

- Created new prompt for PROJECT_CONTEXT.md synchronization tasks
- Added **DATE HANDLING - CRITICAL** section
- Added **MANDATORY FILE REFERENCE** requirement
- Added **Comparison Checklist** for systematic verification
- Added **PR Checklist** with documentation-only constraint

**Rationale:** Scheduled task to keep PROJECT_CONTEXT.md aligned with actual codebase structure.

---

## 2025-12-26 - Bolt v2.0 (Complete Revision)

**Prompt:** `bolt.md`
**Changes:**

- Preserved ALL content from the complete original prompt
- Added **DATE HANDLING - CRITICAL** section at top (5-point verification checklist)
- Added **MANDATORY FILE REFERENCE** requirement for `AGENTS.md` and `.jules/rules.md`
- Added **PR Checklist** with explicit date verification as first item
- Improved markdown formatting (proper headers, code blocks, bullet lists)

**Rationale:** Consistent with Sentinel v2.0 improvements to prevent date errors and ensure AGENTS.md compliance.

---

## 2025-12-26 - Sentinel v2.0 (Complete Revision)

**Prompt:** `sentinel.md`
**Changes:**

- Preserved ALL content from the complete 181-line original prompt
- Added **DATE HANDLING - CRITICAL** section at top (5-point verification checklist)
- Added **MANDATORY FILE REFERENCE** requirement for `AGENTS.md` and `.jules/rules.md`
- Added **PR Checklist** with explicit date verification as first item
- Improved markdown formatting (proper headers, code blocks, bullet lists)

**Rationale:** Based on analysis of PR #78 issues where Jules used incorrect dates (February instead of December) and was not following AGENTS.md rules.

---

## 2025-12-26 - Initial Prompt Tracking System

**Prompts:** All
**Changes:**

- Created `.jules/prompts/` directory structure
- Added `README.md` documenting prompt management workflow
- Added this changelog for version tracking
- Migrated Sentinel, Bolt, and Scribe prompts to tracked files

**Rationale:** Enable version control and assessment of prompts when project changes occur.
