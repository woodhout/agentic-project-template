## 2026-01-01 - Controlled Input Performance Pattern
**Learning:** When rendering a list of controlled inputs where the parent component handles state (e.g. `RequirementRow` updating `StrategyPage`), typing performance degrades linearly with the complexity of the parent render tree. Specifically, bubbling every keystroke to the parent causes the entire parent (and all siblings, unless memoized) to re-render.
**Action:** Use a "Local State + Sync + Debounce" pattern for these inputs.
1. Maintain `localValue` state in the child.
2. `onChange` updates only `localValue`.
3. `useEffect` with debounce calls the parent `onEdit`.
4. `useEffect` syncs prop updates to `localValue` to handle external changes (with safeguards to avoid race conditions with debounce).
This reduced the parent re-render rate from 1 per keypress to 1 per 500ms of continuous typing.

## 2026-01-12 - Visibility-Aware Polling
**Learning:** Polling intervals (e.g., `setInterval` for status checks) continue running even when the tab is backgrounded, consuming server resources (Firestore reads) and client CPU.
**Action:** Wrap polling logic with `document.hidden` checks.
1. In the polling tick function, return early if `document.hidden`.
2. Add a `visibilitychange` listener to trigger an immediate fetch when the user returns (`!document.hidden`).
3. This creates a "pause on background, resume on focus" behavior with zero dependency cost.
