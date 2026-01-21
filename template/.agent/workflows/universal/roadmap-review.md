---
scope: universal
description: review roadmap items ranked from easiest/least impactful to most difficult/most impactful
---
scope: universal

# Roadmap Review Workflow

Review unimplemented roadmap items with the user, presenting them in order from easiest to most difficult.

## Steps

1. **Read the roadmap file**

   - View the contents of `ROADMAP.md`

2. **Filter to unimplemented items**

   - Extract only items with status `🔴 Not Started` or `🟡 Pending`
   - Skip items marked `✅ Completed` or `✅ Implemented`

3. **Analyze and rank each item**
   For each unimplemented item, assess:

   - **Difficulty** (1-5): How complex is the implementation?
     - 1: Simple config/UI change, single file
     - 2: Moderate change, few files, no new dependencies
     - 3: Significant feature, multiple files, may need new patterns
     - 4: Complex feature, many files, new dependencies/infrastructure
     - 5: Major overhaul, architectural changes, cross-cutting concerns
   - **Impact** (1-5): How much of the codebase is affected?
     - 1: Isolated change, minimal testing needed
     - 2: Affects one component/layer
     - 3: Affects multiple components
     - 4: Affects frontend + backend, or adds new workflows
     - 5: System-wide changes, breaking changes possible

4. **Calculate combined score**

   - Score = (Difficulty + Impact) / 2
   - Lower scores = easier/less impactful (review first)
   - Higher scores = harder/more impactful (review last)

5. **Present to user in ranked order**
   Create a summary table with columns:
   | Rank | Item | Category | Difficulty | Impact | Score |

   Then provide **detailed context for each item**:

   - **Summary**: What this feature does (from ROADMAP.md)
   - **Current Status**: Priority level and any notes
   - **Why this ranking**: Brief explanation of difficulty/impact assessment
   - **Key requirements**: Main implementation points

   Walk through each item starting from the lowest score (easiest), asking:

   - "Would you like to implement this item?"
   - "Any questions or modifications to the scope?"
   - "Should we skip this for now?"

6. **For items the user wants to implement**

   - Create a task in `task.md`
   - Optionally create an `implementation_plan.md` for complex items
   - Mark the item as `[/]` in progress in the roadmap

7. **Update session notes**
   Document which items were reviewed and decisions made.
