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

---

## 🔀 Git Conventions

### Conventional Commits

Use standardized commit message prefixes for clear history:

| Prefix      | Use Case                                |
| ----------- | --------------------------------------- |
| `feat:`     | New feature or capability               |
| `fix:`      | Bug fix                                 |
| `docs:`     | Documentation only changes              |
| `refactor:` | Code change that neither fixes nor adds |
| `test:`     | Adding or updating tests                |
| `chore:`    | Maintenance tasks (deps, configs)       |
| `perf:`     | Performance improvement                 |
| `security:` | Security fix or enhancement             |

**Examples:**

- `feat: add user authentication endpoint`
- `fix: resolve null pointer in job parser`
- `docs: update API reference for v2 endpoints`

### Branch Naming

Use descriptive branch prefixes:

| Prefix      | Use Case               |
| ----------- | ---------------------- |
| `feature/`  | New features           |
| `fix/`      | Bug fixes              |
| `refactor/` | Code restructuring     |
| `docs/`     | Documentation updates  |
| `chore/`    | Maintenance and config |

**Examples:**

- `feature/user-authentication`
- `fix/null-pointer-job-parser`
- `docs/api-v2-reference`

---

## 🔄 Rollback & Recovery

### Git Recovery Commands

| Situation                          | Command                                         |
| ---------------------------------- | ----------------------------------------------- |
| Undo last commit (keep changes)    | `git reset --soft HEAD~1`                       |
| Undo last commit (discard changes) | `git reset --hard HEAD~1`                       |
| Restore specific file              | `git checkout HEAD -- path/to/file`             |
| Revert a pushed commit             | `git revert <commit-hash>`                      |
| Abandon branch, start fresh        | `git checkout main && git branch -D bad-branch` |

### When to Fix Forward vs. Abandon

**Fix Forward When:**

- Change is already pushed/merged
- Fix is straightforward (< 15 min)
- Others may have pulled the changes

**Abandon Branch When:**

- Approach is fundamentally wrong
- Would require extensive rework
- No one else has the changes

### Handling Stuck Commands

| Symptom                    | Action                                             |
| -------------------------- | -------------------------------------------------- |
| Command hangs > 60 seconds | Terminate with Ctrl+C or `send_command_input` tool |
| Test is flaky              | Run in isolation, check for async/timing issues    |
| Build stuck on install     | Check network, try `--verbose` flag                |
| Agent unresponsive         | Check token limits, start fresh session            |

### Recovery Skill

For complex recovery scenarios, invoke: `.agent/skills/recovery/SKILL.md`

---

## 🔒 Security Review Triggers

**Enhanced security review is required when:**

| Trigger                                | Why                                 |
| -------------------------------------- | ----------------------------------- |
| Adding new API endpoints               | Validate input, auth, rate limiting |
| Handling user-provided URLs            | SSRF, open redirect risks           |
| Modifying authentication/authorization | Core security boundary              |
| Adding environment variables           | Secrets exposure risk               |
| File upload functionality              | Path traversal, malicious content   |
| Database query construction            | Injection risks                     |

**Minimum checks for new endpoints:**

- [ ] Input validation (type, length, format)
- [ ] Authentication required?
- [ ] Authorization (who can access?)
- [ ] Rate limiting applied?
- [ ] No sensitive data in logs

---

## 📦 Dependency Version Management

### Version Tracking

All pinned tool versions are tracked in [`VERSIONS.md`](VERSIONS.md):

- Pre-commit hooks (ruff, mypy, detect-secrets)
- CLI tools (gh, jq, pre-commit)
- MCP server configurations

### Update Process

| Update Type | Process |
|-------------|---------|
| Security fix | Apply immediately, test, document |
| Minor/patch | Apply, test, update VERSIONS.md |
| Major version | Review changelog, test in branch, verify compatibility |

### Automated Updates

- **Dependabot** (`.github/dependabot.yml`) creates PRs for GitHub Actions and package updates
- **Jules `tool_version_auditor`** checks template tooling monthly
- **Jules `dependency_doctor`** checks runtime deps weekly

### Compatibility Guidelines

Before updating any tool:

1. Check changelog for breaking changes
2. Verify compatibility with related tools (see VERSIONS.md)
3. Test with `pre-commit run --all-files` and `pytest`
4. Update VERSIONS.md with new version and date

For complex updates, invoke: `.agent/skills/update-deps/SKILL.md`

---

## 💡 Project-Specific Considerations

> These patterns may apply depending on your project. Uncomment and customize as needed.

### Type Safety (Typed Languages)

<!-- Uncomment if using Python, TypeScript, or other typed languages:
**Rules:**
- All new code must have type hints
- Avoid `Any` type except at boundaries
- Run type checker before commits: `mypy src/` or `tsc --noEmit`
- Use `TypedDict` for structured dictionaries
-->

### Performance Budgets

<!-- Uncomment to set performance constraints:
| Metric                    | Budget          |
| ------------------------- | --------------- |
| API response time (p95)   | < 500ms         |
| Database queries/request  | ≤ 5             |
| Frontend bundle size      | < 500KB gzipped |
| LLM calls per request     | ≤ 2             |
-->

### Cost Controls

<!-- Uncomment if using paid APIs (LLM, cloud services):
**Rules:**
- Check daily spend before expensive operations
- Implement circuit breakers for runaway costs
- Cache expensive API responses where possible
-->
