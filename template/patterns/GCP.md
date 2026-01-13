# GCP Best Practices for AI Agents

> Copy relevant sections into your `AGENTS.md` when using Google Cloud Platform.

---

## Cloud Tasks Idempotency

**Context:** Cloud Tasks may retry failed requests. Workers must be idempotent.

**Rule:** Before performing expensive operations (LLM generation, scraping), ALWAYS check Cloud Storage (GCS) for existing artifacts.

```python
if storage.exists(artifact_path):
    logger.info(f"Artifact {artifact_path} exists. Skipping generation.")
    return storage.load(artifact_path)
```

---

## Ephemeral Filesystem

**Context:** Cloud Run containers are stateless. The local disk is temporary.

**Rule:** NEVER rely on local file persistence between requests.

**Workflow:** Generate to `/tmp` → Upload to GCS → Delete local file → Return GCS URI.

---

## State Machine Pattern (Firestore)

**Context:** Long workflows pause for user input.

**Rule:** Workers do NOT return data to the client. They update **Firestore Status** (e.g., `waiting_for_user`, `complete`). The client polls Firestore for updates.

---

## Cost Controls

**Rule:** Wrap expensive API calls in budget checks:

```python
class CostLimiter:
    def is_over_budget(self) -> bool:
        today_cost = self.get_today_cost()
        return today_cost >= self.daily_limit

    def check_or_fail(self):
        if self.is_over_budget():
            raise BudgetExhaustedError("Daily budget exceeded")
```

**Deep Research Protection:**

```python
if not settings.ALLOW_DEEP_RESEARCH_SPEND:
    logger.warning("Deep Research blocked. Set ALLOW_DEEP_RESEARCH_SPEND=true")
    return fallback_to_fast_research()
```

---

## Service Account Configuration

**Rule:** Never hardcode service account emails or Cloud Run URLs.

```python
# settings.py
SERVICE_ACCOUNT_EMAIL: str  # Required, no default
CLOUD_RUN_SERVICE_URL: str  # Required in production
```

---

## Firestore Optimization

**Rule:** Use field masking when fetching large documents:

```python
# Only fetch needed fields
doc = db.collection("jobs").document(id).get(field_paths=["status", "company"])
```
