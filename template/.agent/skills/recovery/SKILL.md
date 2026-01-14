---
name: Recovery
description: Handle failures, rollbacks, and stuck situations
---

# Recovery Skill

Handle failures, rollbacks, and recovery from problematic states.

## When to Use This Skill

Invoke this skill when:

- A commit or merge introduced breaking changes
- A deployment failed or caused issues
- Commands are hanging or unresponsive
- Tests are flaky or failing unexpectedly
- Cloud resources are in inconsistent state

## Decision Tree

```text
Start
│
├─ Is it a git/code issue?
│  ├─ YES → Go to "Git Recovery"
│  └─ NO ↓
│
├─ Is a command stuck/hanging?
│  ├─ YES → Go to "Stuck Command Recovery"
│  └─ NO ↓
│
├─ Is it a deployment issue?
│  ├─ YES → Go to "Deployment Recovery"
│  └─ NO ↓
│
├─ Is it a flaky test?
│  ├─ YES → Go to "Flaky Test Diagnosis"
│  └─ NO ↓
│
└─ Is it a cloud resource issue?
   └─ YES → Go to "Cloud Resource Recovery"
```

---

## Git Recovery

### Undo Last Commit (Not Pushed)

```bash
# Keep changes staged
git reset --soft HEAD~1

# Discard changes entirely
git reset --hard HEAD~1
```

### Undo Last Commit (Already Pushed)

```bash
# Create a revert commit (safe for shared branches)
git revert HEAD
git push
```

### Restore Specific File

```bash
# Restore from last commit
git checkout HEAD -- path/to/file

# Restore from specific commit
git checkout <commit-hash> -- path/to/file
```

### Abandon Bad Branch

```bash
# Switch to main and delete bad branch
git checkout main
git branch -D bad-branch

# If remote exists, delete it too
git push origin --delete bad-branch
```

### Fix Forward vs. Abandon Decision

| Factor                       | Fix Forward | Abandon |
| ---------------------------- | ----------- | ------- |
| Already merged to main       | ✅          | ❌      |
| Fix is quick (< 15 min)      | ✅          | ❌      |
| Approach fundamentally wrong | ❌          | ✅      |
| Others have pulled changes   | ✅          | ❌      |
| Extensive rework needed      | ❌          | ✅      |

---

## Stuck Command Recovery

### Identify the Problem

1. Check if command is actually stuck (not just slow)
2. Look for network issues or resource constraints
3. Check for interactive prompts waiting for input

### Terminate Stuck Command

```bash
# If in terminal, press Ctrl+C

# If running in background, find and kill
ps aux | grep <command>
kill -9 <PID>
```

### For Agent Tool Calls

Use `send_command_input` tool with `Terminate: true` to kill hanging commands.

### Prevent Future Stalls

- Add timeouts to long-running operations
- Use `--no-interactive` flags where available
- Prefer async operations with status polling

---

## Deployment Recovery

### Immediate Rollback

```bash
# Cloud Run
gcloud run services update-traffic SERVICE --to-revisions=PREVIOUS_REVISION=100

# Check recent revisions
gcloud run revisions list --service=SERVICE
```

### Identify the Cause

1. Check deployment logs for errors
2. Compare deployed code with last working version
3. Check environment variables and secrets
4. Verify database migrations

### Post-Mortem Checklist

- [ ] Root cause identified
- [ ] Fix implemented and tested
- [ ] Anti-pattern documented in AGENTS.md
- [ ] Team notified if applicable

---

## Flaky Test Diagnosis

### Isolation Test

```bash
# Run suspicious test alone
pytest tests/test_flaky.py::test_name -v

# Run multiple times
for i in {1..10}; do pytest tests/test_flaky.py::test_name; done
```

### Common Causes

| Symptom                       | Likely Cause           | Fix                                   |
| ----------------------------- | ---------------------- | ------------------------------------- |
| Passes alone, fails in suite  | Shared state           | Add proper cleanup/fixtures           |
| Random timeouts               | Async timing           | Increase timeouts, use explicit waits |
| Works locally, fails in CI    | Environment difference | Check env vars, paths, timing         |
| Fails first run, passes after | Database/cache state   | Reset state in setup                  |

### Quick Fixes

```python
# Add retry for known flaky external calls
@pytest.mark.flaky(reruns=2, reruns_delay=1)
def test_external_api():
    ...

# Add explicit waits for async
await asyncio.wait_for(operation, timeout=10.0)
```

---

## Cloud Resource Recovery

### Check Resource State

```bash
# Firestore - list recent documents
# (Use console or admin SDK)

# GCS - check bucket contents
gsutil ls gs://bucket-name/path/

# Cloud Tasks - check queue
gcloud tasks queues describe QUEUE_NAME
```

### Common Issues

| Resource    | Problem               | Recovery                      |
| ----------- | --------------------- | ----------------------------- |
| Firestore   | Inconsistent state    | Manual correction via console |
| GCS         | Missing/corrupt files | Re-upload from source         |
| Cloud Tasks | Stuck tasks           | Purge queue, retry            |
| Cloud Run   | Bad revision          | Traffic rollback              |

### Reset to Known Good State

1. Identify last known good timestamp
2. Check if backups exist
3. Document what will be lost
4. Get user confirmation before destructive recovery

---

## Recovery Reporting

After completing recovery, document:

1. **What happened** — Brief description
2. **Root cause** — Why it occurred
3. **Resolution** — What fixed it
4. **Prevention** — Add anti-pattern to AGENTS.md if applicable
