# Antigravity IDE Capabilities

> Reference for what the Antigravity IDE can do. Consult when planning complex tasks.

---

## Core Capabilities

### Workspace & Context Management

- **Session Memory**: Agent maintains context within a single session
- **Artifact System**: `task.md`, `implementation_plan.md`, `walkthrough.md` for structured work
- **Task Boundaries**: Clear separation between planning, execution, verification phases

### File Operations

- Read, write, edit files with line-level precision
- Multi-file edits in parallel when changes are independent
- Safe file deletion (requires confirmation)

### Terminal Commands

- Run shell commands with output capture
- Background command execution with status monitoring
- Interactive command input (stdin)

### Browser Automation

- Navigate, click, type, screenshot via Playwright MCP
- Form filling, file uploads
- Console and network request inspection

### GitHub Integration

- PR creation, review, merge
- Issue management
- Code search across repositories
- Branch and tag management

---

## Workflow Annotations

| Annotation     | Effect                                     |
| -------------- | ------------------------------------------ |
| `// turbo`     | Auto-run the next command without approval |
| `// turbo-all` | Auto-run ALL commands in workflow          |

---

## Cross-Session Memory

Antigravity does NOT have persistent memory across sessions. Use:

1. **Artifacts**: `task.md`, `walkthrough.md` for session handoff
2. **CHANGELOG.md**: What was done
3. **AGENTS.md anti-patterns**: Mistakes to avoid

---

## MCP Server Tools

### GitHub (`github-mcp-server`)

- Repository operations (create, fork, branches)
- Pull request lifecycle
- Issue management
- Code and user search

### Playwright (`playwright`)

- Browser navigation and interaction
- Screenshots and recordings
- Form handling

### MarkItDown (`markitdown`)

- Convert PDF, DOCX, PPTX, XLSX to Markdown
- Image OCR
- Web page content extraction

### Context7 (`context7`)

- Library documentation lookup
- Code example search

---

## Task Modes

| Mode             | Purpose                                      |
| ---------------- | -------------------------------------------- |
| **PLANNING**     | Research, design, create implementation plan |
| **EXECUTION**    | Write code, make changes                     |
| **VERIFICATION** | Test, validate, document proof of work       |

---

## Long-Running Tasks

For autonomous execution without permission prompts:

1. Use workflows with `// turbo-all` annotation
2. Use verification scripts that run automatically
3. Use Jules for background async tasks

---

## Best Practices

1. **Plan before executing**: Create `implementation_plan.md` for complex changes
2. **Verify after changes**: Always test and capture proof of work
3. **Document mistakes**: Add to anti-patterns table for continuous improvement
4. **Batch related work**: Multiple edits to same file in single operation
