# Template Lessons Queue

> Improvements proposed from downstream projects. Review during template maintenance.

## How to Use This File

1. **Downstream projects** add entries via the `/template-feedback` workflow
2. **Template maintainer** reviews entries and decides: Accept, Reject, or Defer
3. **Accepted changes** are implemented, then entry moved to "Resolved" section
4. **Synced projects** receive the improvements via normal template-sync

---

## Pending Lessons

<!-- Add new lessons at the top of this section -->

_No pending lessons._

---

## Evaluation Criteria

When reviewing lessons, consider:

| Criteria | Question |
|----------|----------|
| **Universal** | Does this apply to all/most projects? |
| **Impactful** | Will this prevent errors or save time? |
| **Breaking** | Does this require downstream migration? |
| **Testable** | Can we verify the improvement? |

---

## Resolved

<!-- Move resolved entries here with resolution notes -->

### 2026-01-14: Prefer CLI over MCP for verbose APIs ✅

**Source:** resume-tailoring-agentic-system
**Category:** Skill
**Affected:** `.agent/skills/pr-triage/SKILL.md`

**Problem:**
The initial MCP API response truncated 6+ PRs due to verbose JSON.

**Resolution:**
Updated pr-triage skill to recommend `gh pr list` CLI as the primary approach,
with a tip explaining when to use CLI vs MCP. MCP is still available for actions
and when full object data is needed.
