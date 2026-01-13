# Code Examples & Patterns

> Detailed examples referenced by `AGENTS.md`. Consult when implementing patterns.

---

## Append-Only Pattern

### Anti-Pattern (DO NOT DO THIS)

```python
# BAD - This overwrites the entire file!
write_file("CHANGELOG.md", new_entry)
```

### Correct Pattern

```python
# GOOD - Read existing, prepend new entry, write back
existing = read_file("CHANGELOG.md")
write_file("CHANGELOG.md", new_entry + "\n" + existing)
```

---

## Code Review Handoff Template

Create `.agent/PENDING_REVIEW.md` after completing code changes:

```markdown
## Goal

[What was the user asking for?]

## Approach

[Why did you solve it this way?]

## Files Changed

- `path/to/file.py`: [Brief description]
- `path/to/another.py`: [Brief description]

## Key Decisions

[Important tradeoffs, alternatives considered]
```

---

## Idempotency Check Pattern

```python
def process_expensive_operation(id: str) -> Result:
    cache_key = f"operations/{id}/result.json"

    # Always check cache first
    if storage.exists(cache_key):
        logger.info(f"Cache hit for {cache_key}")
        return storage.load(cache_key)

    # Process only if not cached
    result = expensive_operation(...)
    storage.save(cache_key, result)
    return result
```

---

## Error Handling Pattern

```python
try:
    result = await risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}", extra={"id": id, "operation": "risky"})
    # Update status so client knows what happened
    db.update(id, {"status": "failed", "error": str(e)})
    raise
```
