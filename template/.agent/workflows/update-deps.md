---
description: Update project dependencies with safety checks and documentation updates
---

# /update-deps Workflow

Follow these steps to update project dependencies (Python, Node, or Tools):

1. **Invoke the Skill**
   View the dependency update skill for the decision tree and procedures:
   `view_file .agent/skills/update-deps/SKILL.md`

2. **Categorize Update**
   Decide if this is:
   - Security update (highest priority)
   - Minor/Patch update (routine)
   - Major version bump (requires careful testing)

3. **Execute Update**
   Follow the specific procedures in the skill for your component type.

4. **Verify & Document**
   - Run tests
   - Update `VERSIONS.md` (for tools)
   - Update `CHANGELOG.md`
   - Create PR

// turbo
5. Update VERSIONS.md if tool version changed
