# Developer Job Aid: Agentic Workflow

## 🚀 Daily Development Flow

Always use these workflows to maintain environmental synchronization.

| Goal | Command | What it does |
|------|---------|--------------|
| **Start Session** | `/sync-start` | Pulls main, updates deps, checks IDE rules |
| **Commit Changes**| `/push` | Formats code, updates docs, pushes to origin |
| **End Session**   | `/sync-end` | Final doc refresh, commits, and cleanup |
| **Code Review**   | `/review` | Triggers multi-model review of your changes |

---

## 🛠️ Essential "Agentic" Commands

### Jules Maintenance (GHA)
Trigger a background maintenance task manually:
```bash
gh workflow run jules-schedule.yml -f task=[sentinel|dependency_doctor|code_formatter]
```

### Secrets Management
Add a new secret (like `JULES_API_KEY`) to the repository:
```bash
gh secret set JULES_API_KEY
```

### Dependency Audit
Check for outdated or vulnerable tools/packages:
```bash
/update-deps
```

---

## 📋 The "Constitution" (AGENTS.md) Checklist

When the AI agent performs work, ensure it follows these **Critical Rules**:

1. **Idempotency**: Did it check GCS/Firestore before generating/processing?
2. **Append-Only**: Did it preserve the `CHANGELOG.md` and `COMPLIANCE_LOG.md` history?
3. **Structured Intelligence**: Did it use `instructor` models instead of raw string parsing?
4. **Docs Hygiene**: Did it update `QUICK_REFERENCE.md` if the architecture changed?

---

## 🚥 Safety & Recovery

| Situation | Action |
|-----------|--------|
| **Stuck Command** | `Ctrl + C` or `/recover` workflow |
| **Bad Implementation** | `git reset --hard HEAD~1` (or use `/recover`) |
| **Linting Errors** | `/format` workflow |
| **Security Alert** | Run Jules `sentinel` task immediately |

---

## 🆕 New Project Onboarding (5 Minutes)

1. **Clone**: `git clone [repo-url]`
2. **Initialize**: Run the `/sync-start` workflow.
3. **Secrets**: Set your `JULES_API_KEY` via `gh secret set`.
4. **Verify**: Run `pytest` to ensure the foundation is solid.
