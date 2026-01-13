# AGENTS.md - System Instructions for AI Agents

**Project:** [YOUR PROJECT NAME]  
**Stack:** [e.g., Python 3.11+, Node.js, FastAPI, etc.]

> 📋 **Quick Reference:** See [`QUICK_REFERENCE.md`](QUICK_REFERENCE.md) for collections, API routes, env vars.  
> 🔧 **IDE Setup:** See [`.agent/IDE_CONFIG.md`](.agent/IDE_CONFIG.md) for multi-machine sync.  
> 📚 **Patterns:** See [`patterns/`](patterns/) for cloud/framework-specific best practices.

---

## ⚠️ CRITICAL DIRECTIVES (NON-NEGOTIABLE)

### 1. Documentation Hygiene (MANDATORY PRE-COMMIT CHECKLIST)

**Before EVERY commit, you MUST:**

0. **Run tests**: `pytest tests/ -m "not expensive"` (must pass)

1. **Update `CHANGELOG.md`** — Add entry for ANY:

   - New features or API endpoints
   - Performance improvements
   - Security fixes
   - Breaking changes
   - Bug fixes

2. **Update `QUICK_REFERENCE.md`** — If:

   - New API endpoints added
   - Architecture changes
   - New dependencies or tools added

3. **Update `COMPLIANCE_LOG.md`** — If:
   - Security changes made
   - Compliance scans performed

### 2. Structured Intelligence (No String Parsing)

- **Tooling:** Use the `instructor` library for ALL LLM outputs.
- **Rule:** Never ask the LLM for raw JSON strings. Define a Pydantic model and use `client.chat.completions.create(..., response_model=MySchema)`.

### 3. Log Files Are APPEND-ONLY

The following files are **append-only logs**. NEVER replace their contents:

| File                 | Append Strategy                                     |
| -------------------- | --------------------------------------------------- |
| `CHANGELOG.md`       | Add new entry at TOP of file (newest first)         |
| `COMPLIANCE_LOG.md`  | Add new entry to appropriate section (newest first) |
| `.jules/sentinel.md` | Add new entry at BOTTOM (oldest first)              |

**Pattern:** See [`patterns/EXAMPLES.md`](patterns/EXAMPLES.md#append-only-pattern)

### 4. PR Hygiene (Preventing Duplicate/Conflicting Work)

Before creating a PR:

1. **Rebase on latest main**: `git fetch origin main && git rebase origin/main`
2. **Check for existing PRs**: `gh pr list --search "keyword"` to avoid duplicate work
3. **Keep PRs focused**: One concern per PR (security, performance, docs—not all three)

### 5. Error Handling & Graceful Degradation

- If an external service fails, attempt fallback before crashing
- Log errors with context (IDs, operation, timestamp)
- Mark operations as `failed` with clear error messages

---

## 📂 Directory Structure Convention

<!-- Customize for your project -->

- `src/` or `app/`: Main application code
- `tests/`: Test files
- `docs/`: Documentation
- `.agent/workflows/`: Agentic workflows
- `.jules/prompts/`: Jules automation prompts
- `patterns/`: Cloud/framework-specific best practices

---

## 🛠️ Project-Specific Rules

<!-- Add your project-specific constraints here -->
<!-- See patterns/ for common patterns to copy -->

---

## 📝 Known Anti-Patterns

> Error-driven documentation. Add entries when agent mistakes are observed.
> Rationale: "Anytime we see the agent do something incorrectly we add it to the docs so it knows not to do it next time." — Compounding improvement over time.

| Date       | Description                        | Fix                    | Prevention Rule         |
| ---------- | ---------------------------------- | ---------------------- | ----------------------- |
| YYYY-MM-DD | Example: Agent overwrote changelog | Documented append rule | See Rule 3: APPEND-ONLY |
