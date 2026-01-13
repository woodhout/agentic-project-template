# Sentinel Journal

## 2025-12-15 - Unsecured Internal Worker Endpoints

**Vulnerability:** Unauthenticated access to `/workers/*` endpoints.
**Learning:** Cloud Run services are public by default. Internal endpoints intended for Cloud Tasks were exposed to the public internet because the app lacked verification of the `X-CloudTasks-QueueName` header (which Cloud Tasks strips from external requests).
**Prevention:** Always validate `X-CloudTasks-QueueName` (or similar infrastructure headers) on internal worker routes. Do not assume "internal" routes are hidden.

## 2025-12-11 - Module-level instantiation complicates testing

**Vulnerability:** Information Leakage in API error handling (Fixed).
**Learning:** `FirestoreClient` is instantiated at module level in `app/api/routes.py`, causing `app.main` import to fail in tests if GCP credentials are missing, even if the DB isn't used.
**Prevention:** Avoid module-level side effects (like database connections) or ensure they are lazily initialized. For now, tests must patch `google.cloud.firestore.AsyncClient` *before* importing `app.main`.

## 2025-12-12 - Validation at the Model Layer

**Vulnerability:** SSRF (Server-Side Request Forgery) in `JobRequest`.
**Learning:** `JobRequest.url` was unvalidated string, allowing `file://`, `localhost`, and private IPs. Async worker processing made this hard to detect at runtime.
**Prevention:** Added `ipaddress.is_global` check in a Pydantic `field_validator`. This blocks private/local IPs early at the API boundary (422 error), protecting backend workers.

## 2025-12-18 - Securing Cloud Tasks Endpoints

**Vulnerability:** Unauthenticated access to internal worker endpoints (`/workers/research`, `/workers/generation`).
**Learning:** These endpoints were public FastAPI routes without any checks, relying solely on obscurity. Cloud Tasks does not automatically secure the target URL unless configured; and the app must verify the request source.
**Prevention:** Enforced `X-CloudTasks-QueueName` header check via a reusable dependency (`verify_cloud_tasks`) and enforced strict Pydantic schemas for payloads.

## 2025-12-13 - Internal API Endpoint Validation Gap

**Vulnerability:** SSRF Bypass in `/workers/research`.
**Learning:** While `JobRequest` (public API) validated URLs, the internal worker endpoint `/workers/research` accepted raw dictionaries, bypassing validation. Attackers could hit the worker endpoint directly to access internal resources.
**Prevention:** Enforce the same Pydantic model validation (`JobRequest` or equivalent `ResearchWorkerPayload`) on internal/worker endpoints as on public endpoints.

## 2025-12-20 - SSRF Bypass via DNS Rebinding and Metadata Hostnames

**Vulnerability:** Incomplete SSRF protection in `validate_safe_url`.
**Learning:** `ipaddress.is_global` check only validates IP strings. It allowed `metadata.google.internal` (hostname) and `169.254.169.254.nip.io` (DNS alias), which resolve to restricted services/IPs. Pydantic validators run synchronously, tempting developers to skip expensive DNS checks.
**Prevention:** Explicitly block known metadata hostnames AND perform DNS resolution (`socket.gethostbyname`) to validate the underlying IP address, not just the input string.

## 2025-12-26 - DoS Vulnerability in Chat and Strategy Endpoints

**Vulnerability:** Lack of input length validation on `ChatRequest.history` and `ConfirmStrategyRequest.requirements` allowed potential DoS attacks via memory exhaustion or processing delays.
**Learning:** Pydantic models need explicit `max_length` or `max_items` constraints on List fields, not just descriptions.
**Prevention:** Use `Field(..., max_length=N)` for all List fields in API schemas.

## 2025-12-25 - Destructive Changelog Edit (PR #61)

**Vulnerability:** Accidental deletion of 150+ lines of changelog history.
**Learning:** A PR claiming to "verify analytics" actually replaced the entire CHANGELOG.md with a single entry, deleting all historical records. The PR had +0 additions and -152 deletions on a log file—a clear red flag.
**Prevention:**

1. Log files (CHANGELOG.md, COMPLIANCE_LOG.md) are APPEND-ONLY
2. Before modifying any file with >100 lines, verify that net deletions are intentional
3. Always read existing content before writing to log files
4. See `.jules/rules.md` for detailed file edit rules

## 2025-12-27 - TTLCache Reset Pitfall in Rate Limiting

**Vulnerability:** Incorrect implementation of Rate Limiter using `cachetools.TTLCache` caused accumulation of counts over time instead of a window reset.
**Learning:** `cachetools.TTLCache` resets the TTL for a key every time the key is accessed/updated. This makes it unsuitable for "requests per minute" limiting if the key is static (e.g., just IP), as continuous activity extends the TTL indefinitely.
**Prevention:** Use a "Fixed Window" approach where the key explicitly includes the time window (e.g., `key = f"{ip}:{time.time() // 60}"`), ensuring counters reset automatically when the window changes.
## 2025-12-31 - Missing Rate Limits on Expensive Read Endpoints

**Vulnerability:** Denial of Service (DoS) and Resource Exhaustion via `GET /jobs/{app_id}/description`.
**Learning:** Read-only endpoints (`GET`) are often assumed to be safe, but those triggering GCS downloads or heavy database queries are prime targets for cost-exhaustion attacks. Attackers can enumerate UUIDs or replay valid IDs to spike cloud bills.
**Prevention:** Apply rate limiting to ALL external-facing endpoints, not just state-changing (`POST`) ones. Use dependency injection to enforce limits consistently across route groups.

## 2026-01-05 - Missing Permissions-Policy Header

**Vulnerability:** Lack of `Permissions-Policy` header.
**Learning:** Even if an API doesn't use sensitive browser features (camera, mic, payment), default browser behavior often allows them in iframes or subcontexts. Explicitly disabling them via headers reduces the attack surface if the API is ever consumed in a compromised frontend context.
**Prevention:** Always set `Permissions-Policy: geolocation=(), camera=(), microphone=(), usb=(), payment=()` to adhere to the principle of least privilege.

## 2026-01-06 - Denial of Service via Unbounded URL Length

**Vulnerability:** Unbounded input length for `url` fields in API requests.
**Learning:** Pydantic `str` fields do not enforce length limits by default. Massive payloads (e.g., 100MB string) could potentially crash the server during validation or parsing, or bypass downstream regex checks if they time out (ReDoS).
**Prevention:** Always add `max_length` constraints to string fields that accept user input, especially URLs or free text.

## 2026-01-09 - Denial of Service via Unbounded List Items

**Vulnerability:** Pydantic `Field(max_length=N)` on a List field only limits the list size, not the size of items within it. Attackers could send a list of 100 items where each item is 10MB, bypassing validation and causing memory exhaustion.
**Learning:** Nested validation is critical. For `List[str]`, explicit validators are needed to check the length of *each string* in the list.
**Prevention:** Use `@field_validator` to iterate and validate item constraints, or use strict nested types like `List[Annotated[str, StringConstraints(max_length=...)]]`.
