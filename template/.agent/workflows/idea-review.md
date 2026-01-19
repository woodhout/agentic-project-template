---
description: Review and manage future project ideas from FUTURE_PROJECTS.md
---

# Project Idea Review Workflow

Review the `FUTURE_PROJECTS.md` list to refine ideas, prioritize them, or select one to start active development.

## Steps

1. **Read the Ideas List**
   - View the contents of `FUTURE_PROJECTS.md` in the repository root.

2. **Review Backlog Items**

   For each item marked `🆕 New Idea` or entering the backlog:
   - **Refine:** Ask the user if they want to add more details, reference links, or requirements.
   - **Prioritize:** Ask if this is something they want to work on soon.

3. **Select for Development**

   If the user selects an idea to start:
   1. **Mark as In Progress:** Update the status icon to `🏗️` in `FUTURE_PROJECTS.md`.
   2. **Guide to Gem:** Instruct the user: "Please go to the Gemini Gem and generate the seed files for '[Idea Title]'. When you are done and the seeds are ready, return here and run `/bootstrap`."
   3. **Stop:** End this workflow here. The user will continue with `/bootstrap` later.

4. **Maintenance**
   - Ask if any `✅ Completed` items should be moved to an archive section or deleted.
   - archive any `🗑️ Archived` items if they are cluttering the main list.

5. **Update and Save**
   - Apply all changes (status updates, notes, refinements) to `FUTURE_PROJECTS.md`.
