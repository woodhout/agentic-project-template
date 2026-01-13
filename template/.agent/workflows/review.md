---
description: multi-model code review via artifact handoff
---

# Code Review Workflow

Multi-model code review using the Review Handoff protocol.

## Best Practice

Start this workflow in a **NEW conversation** with a **different model**
than the one that wrote the code.

Example: If code was written in Claude Opus 4.5, review with Gemini 3 Pro.

## Steps

1. **Read the handoff artifact**:

   ```bash
   cat .agent/PENDING_REVIEW.md
   ```

2. **Review the changes**:

   ```bash
   git diff main
   ```

   Or for staged changes:

   ```bash
   git diff --cached
   ```

3. **Analyze against stated goals**:

   - Does the implementation match the stated goal?
   - Are there security vulnerabilities?
   - Are there performance issues?
   - Are best practices followed?
   - Is error handling robust?
   - Are there edge cases not covered?

4. **Check for common anti-patterns**:

   - Review the anti-pattern table in AGENTS.md
   - Check for append-only file violations
   - Verify dependency sync (requirements.txt, package.json)

5. **Create review report**:

   Create `.agent/REVIEW_REPORT.md` with findings:

   ```markdown
   # Code Review Report

   **Reviewer Model**: [Your model name]
   **Date**: [YYYY-MM-DD]
   **Reviewed Changes**: [Brief description]

   ## Summary

   [Overall assessment]

   ## Issues Found

   ### Critical

   - [Issue 1]

   ### Medium

   - [Issue 2]

   ### Minor

   - [Issue 3]

   ## Recommendations

   - [Suggestion 1]
   - [Suggestion 2]

   ## Approval Status

   - [ ] Approved - Ready to merge
   - [ ] Approved with minor changes
   - [ ] Requires changes before approval
   ```

6. **Clean up handoff artifact**:

   After review is complete and addressed:

   ```bash
   rm .agent/PENDING_REVIEW.md
   ```

## Notes

- Reviewer agents should focus on finding issues, not justifying
  the original implementation
- Leverage the different model's strengths (e.g., Gemini for analysis,
  Claude for implementation quality)
