---
description: Handle failures, rollbacks, and stuck commands
---

# /recover Workflow

Follow these steps when you are stuck or need to rollback changes:

1. **Invoke the Skill**
   View the recovery skill for the decision tree and procedures:
   `view_file .agent/skills/recovery/SKILL.md`

2. **Determine Strategy**
   - **Fix Forward**: For minor, recent failures
   - **Rollback**: To last known good state
   - **Reset**: To main/pushed state if completely stuck

3. **Execute Recovery**
   Follow the commands in the skill:
   - Git reset/revert
   - Environment cleanup
   - Process termination

4. **Document Failure**
   Add any new failure patterns to `AGENTS.md` in the "Known Anti-Patterns" section.
