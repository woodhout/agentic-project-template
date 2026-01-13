# LLM Application Best Practices

> Copy relevant sections into your `AGENTS.md` when building LLM-powered applications.

---

## Structured Output with Instructor

**Rule:** Use the `instructor` library for ALL LLM outputs. Never parse raw JSON strings.

```python
import instructor
from pydantic import BaseModel

class JobAnalysis(BaseModel):
    company: str
    role: str
    requirements: list[str]
    match_score: float

client = instructor.from_openai(OpenAI())
result = client.chat.completions.create(
    model="gpt-4",
    response_model=JobAnalysis,
    messages=[{"role": "user", "content": job_description}]
)
# result is a validated Pydantic model, not raw JSON
```

---

## Idempotency for LLM Calls

**Context:** LLM calls are expensive. Avoid regenerating existing artifacts.

```python
def generate_resume(job_id: str) -> str:
    artifact_path = f"jobs/{job_id}/resume.docx"

    # Check cache first
    if storage.exists(artifact_path):
        logger.info(f"Resume exists at {artifact_path}. Skipping generation.")
        return storage.get_url(artifact_path)

    # Generate only if not cached
    resume = llm.generate(...)
    storage.upload(artifact_path, resume)
    return storage.get_url(artifact_path)
```

---

## Cost Tracking

**Rule:** Track LLM costs per request for budget monitoring:

```python
def track_llm_call(model: str, tokens_in: int, tokens_out: int):
    cost = calculate_cost(model, tokens_in, tokens_out)
    db.increment_daily_cost(cost)
    telemetry.track("llm_call", {
        "model": model,
        "tokens_in": tokens_in,
        "tokens_out": tokens_out,
        "cost_usd": cost
    })
```

---

## Graceful Degradation

**Rule:** If primary model fails, fall back to cheaper/simpler option:

```python
try:
    result = await llm.generate_with_claude_sonnet(prompt)
except RateLimitError:
    logger.warning("Claude rate limited, falling back to Gemini")
    result = await llm.generate_with_gemini_flash(prompt)
```

---

## Retry Logic

**Rule:** Use exponential backoff for LLM API calls:

```python
@retry(
    stop=stop_after_attempt(3),
    wait=wait_exponential(multiplier=1, min=2, max=10),
    retry=retry_if_exception_type(RateLimitError)
)
async def generate_with_retry(prompt: str) -> str:
    return await llm.generate(prompt)
```
