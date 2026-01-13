# Quick Reference

> Agent cheat sheet. Fill in your project specifics.

---

## Architecture Overview

<!-- Describe your high-level architecture here -->

```
[Client] → [API Gateway] → [Backend Services] → [Database/Storage]
```

---

## Collections / Database

| Collection               | Purpose       |
| ------------------------ | ------------- |
| `users`                  | User accounts |
| `[add your collections]` |               |

---

## API Routes

### Public

| Method         | Route     | Purpose      |
| -------------- | --------- | ------------ |
| `GET`          | `/health` | Health check |
| `[add routes]` |           |              |

### Internal

| Method                  | Route | Purpose |
| ----------------------- | ----- | ------- |
| `[add internal routes]` |       |         |

---

## Environment Variables

| Variable          | Required | Description                |
| ----------------- | -------- | -------------------------- |
| `DATABASE_URL`    | Yes      | Database connection string |
| `API_KEY`         | Yes      | API authentication key     |
| `[add your vars]` |          |                            |

---

## Key Files

| File              | Purpose                 |
| ----------------- | ----------------------- |
| `app/main.py`     | Application entry point |
| `app/routes.py`   | API route definitions   |
| `[add key files]` |                         |

---

## Status Enum (if applicable)

```python
class Status(str, Enum):
    PENDING = "pending"
    PROCESSING = "processing"
    COMPLETED = "completed"
    FAILED = "failed"
```

---

## Cloud Resources

| Resource | Name            | Notes |
| -------- | --------------- | ----- |
| Database | `[name]`        |       |
| Storage  | `[bucket]`      |       |
| Service  | `[service-url]` |       |

---

## AI Models (if applicable)

| Use Case     | Model               | Notes        |
| ------------ | ------------------- | ------------ |
| Extraction   | `gemini-2.0-flash`  | Fast, cheap  |
| Generation   | `claude-sonnet-4-0` | High quality |
| [add models] |                     |              |

---

_Last updated: YYYY-MM-DD_
