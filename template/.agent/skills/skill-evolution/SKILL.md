---
name: Skill Evolution
description: Identify opportunities to create new skills based on recurring patterns
---

# Skill Evolution

Continuously improve the project by identifying and creating reusable skills.

## When to Use This Skill

Invoke this skill:

- During `/sync-end` workflow (periodic review)
- When you notice yourself repeating a complex multi-step process
- When user asks "what could be automated?"
- After completing a significant feature

## What Makes a Good Skill Candidate?

A pattern should become a skill when it has **3+ of these characteristics**:

| Characteristic      | Example                           |
| ------------------- | --------------------------------- |
| **Repeated**        | Done more than 2-3 times          |
| **Multi-step**      | 5+ distinct steps                 |
| **Decision points** | "If X, do Y, else do Z"           |
| **Error-prone**     | Easy to forget steps              |
| **Scriptable**      | Could benefit from helper scripts |
| **Context-heavy**   | Needs project-specific knowledge  |

## Skill Discovery Process

### 1. Review Recent Work

Look at the last 5-10 tasks completed:

- What patterns emerged?
- What took multiple attempts to get right?
- What required looking up documentation repeatedly?

### 2. Check Anti-Patterns Table

Review `AGENTS.md` anti-patterns:

- Are there recurring mistakes?
- Could a skill prevent these?

### 3. Analyze Workflows

Review `.agent/workflows/`:

- Are any workflows getting complex?
- Should they become skills with decision trees?

### 4. Propose Skill

When you identify a candidate, propose to the user:

```markdown
## Skill Opportunity Identified

**Name:** [Suggested skill name]
**Trigger:** When user says "[phrases]" or "[situation]"
**Steps:** [Brief outline]
**Value:** [Why this saves time/prevents errors]

Would you like me to create this skill?
```

### 5. Create Skill Structure

If approved:

```bash
mkdir -p .agent/skills/[skill-name]
```

Create `SKILL.md` with:

- YAML frontmatter (name, description)
- When to use
- Decision tree (if applicable)
- Step-by-step process
- Common issues

## Skill Naming Conventions

| Pattern      | Example                                 |
| ------------ | --------------------------------------- |
| Action-based | `deploy-production`, `run-tests`        |
| Domain-based | `database-migration`, `api-integration` |
| Tool-based   | `docker-compose`, `terraform-apply`     |

## Example: Identifying a Skill

**Observation:** "I've run the same 8 commands to set up a new API endpoint 4 times now."

**Skill proposal:**

```markdown
## Skill Opportunity: API Scaffold

**Trigger:** "create endpoint", "add API route", "new endpoint"
**Steps:**

1. Create route file in `app/routes/`
2. Add Pydantic models in `app/models/`
3. Register route in `app/main.py`
4. Add tests in `tests/routes/`
5. Update QUICK_REFERENCE.md
6. Update OpenAPI docs

**Value:** Ensures consistency, prevents forgotten steps
```

## Skill Lifecycle

```text
Observation → Proposal → User Approval → Creation → Usage → Refinement
                                                          ↓
                                              (Add to anti-patterns if issues)
```

## Integration with /sync-end

Add to `/sync-end` workflow:

```markdown
## Skill Review (Optional)

If significant work was done this session:

- Review for skill opportunities
- Propose any identified patterns
- Update existing skills if refinements discovered
```

---

## Tool Evolution Check

During skill evolution review, also check for tool opportunities:

### CLI Assessment

When new dependencies were added this session:

1. **Does it have a CLI?** → Add to `.agent/TOOLS.md`
2. **Is it needed for development?** → Add to `first-time-setup` skill
3. **Universal or project-specific?** → Choose appropriate documentation location

### MCP Assessment

When a new service or API was integrated:

1. **Is there an MCP server?** → Check [MCP Registry](https://github.com/modelcontextprotocol/servers)
2. **Worth the tool budget?** → Count tools, compare to CLI alternative
3. **If adding:** → Update `.antigravity/mcp_config.template.json` with allowlist

### Tool Report

When proposing skill opportunities, also include:

```markdown
## Tool Opportunities

**New CLIs detected:**

- [tool]: [install command]

**MCP candidates:**

- [server]: [# tools] — [purpose]

**Recommendation:** [Add to TOOLS.md / Add MCP / Use CLI]
```
