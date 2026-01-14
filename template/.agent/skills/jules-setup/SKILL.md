---
name: Jules Setup
description: Configure Jules automation for a repository via browser automation
---

# Jules Setup Skill

Configure Jules scheduled tasks for automated code maintenance.

## When to Use This Skill

Use this skill when:

- A new repository has been created and needs Jules automation
- User asks to "set up Jules" or "configure automation"
- After running the `bootstrap` skill
- When `.jules/prompts/` exists but Jules hasn't been configured

## Prerequisites

1. Repository exists on GitHub
2. `.jules/prompts/` folder exists with prompt files
3. User is authenticated to jules.google (or can authenticate)

## Decision Tree

```text
Does .jules/prompts/ exist?
├── No → Skip Jules setup, notify user
└── Yes → Proceed with setup
         │
         How many prompts to configure?
         ├── All (recommended for new projects)
         └── Selective (user chooses)

         Is this a new repo or existing?
         ├── New → Create all scheduled tasks
         └── Existing → Check for existing tasks first
```

## Available Prompts

| Prompt                  | Purpose                     | Recommended Schedule |
| ----------------------- | --------------------------- | -------------------- |
| `sentinel.md`           | Real-time PR monitoring     | Continuous           |
| `bolt.md`               | PR action executor          | Continuous           |
| `dependency_doctor.md`  | Security/version updates    | Weekly (Sunday)      |
| `dead_code_scanner.md`  | Unused code detection       | Weekly (Monday)      |
| `code_formatter.md`     | Auto-formatting             | Weekly (Tuesday)     |
| `test_guardian.md`      | Coverage gap finder         | Weekly (Wednesday)   |
| `context_sync.md`       | Documentation drift         | Weekly (Thursday)    |
| `compliance_auditor.md` | Security compliance         | Weekly (Friday)      |
| `analytics_auditor.md`  | Telemetry check (optional)  | Weekly               |
| `context7_librarian.md` | Library registry (optional) | Weekly               |

## Step-by-Step Process

### 1. Navigate to Jules

Open browser and navigate to:

```text
https://jules.google
```

### 2. Add Repository

1. Look for "Add Repository" or "Connect Repo" button
2. Search for the repository name
3. Select and connect

### 3. Create Scheduled Tasks

For each prompt in `.jules/prompts/`:

1. Click "New Task" or "Create Scheduled Task"
2. Set task name (e.g., "Dependency Doctor")
3. Paste prompt content from the corresponding `.md` file
4. Set schedule according to the table above
5. Save task

### 4. Configure Sentinel (Special Case)

Sentinel runs continuously, not on a schedule:

1. Find "Continuous Monitoring" or "Real-time" option
2. Enable for the repository
3. Paste `sentinel.md` prompt

### 5. Verify Configuration

After setup, verify:

- All tasks appear in the dashboard
- Schedules are correct
- Repository is connected

### 6. Take Screenshot

Capture proof of configuration for documentation.

### 7. Update Project Documentation

Add to the project's CHANGELOG.md:

```markdown
### Jules Automation Configured

- Sentinel: Continuous PR monitoring
- Dependency Doctor: Weekly (Sunday)
- [etc.]
```

## Browser Automation Steps

When automating via Playwright:

```javascript
// Navigate to Jules
await page.goto("https://jules.google");

// Wait for dashboard to load
await page.waitForSelector('[data-testid="dashboard"]');

// Click Add Repository
await page.click('button:has-text("Add Repository")');

// Search for repo
await page.fill('input[placeholder="Search repositories"]', repoName);

// Select repo from results
await page.click(`text="${repoName}"`);

// For each prompt, create task...
```

## Common Issues

| Issue                    | Solution                               |
| ------------------------ | -------------------------------------- |
| Can't find repo          | Ensure GitHub is connected to Jules    |
| Schedule options missing | Check Jules subscription tier          |
| Prompt too long          | Summarize or split into multiple tasks |
| Authentication required  | Prompt user to log in via browser      |

## Minimal Setup (Quick Start)

If user wants minimal setup, configure only:

1. Sentinel (continuous)
2. Dependency Doctor (weekly)
3. Code Formatter (weekly)

These three provide core value with minimal noise.
