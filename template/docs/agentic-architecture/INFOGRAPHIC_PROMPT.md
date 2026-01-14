# Infographic Data Sets

_The following data sets describes the core information and functional relationships within our agentic infrastructure. This "raw data" can be provided to a generative AI to construct visualizations._

---

## 1. System Lifecycle Data (The Protocol)
**Correlated Doc:** `THE_AGENTIC_PROTOCOL.md`

**Core Data Points:**
- **Source**: Gemini Gem (Generative Intelligence).
- **Primary Outputs**: `BOOTSTRAP.json` (Manifest) and `docs/` (Intent docs: PRD, Architecture).
- **Process**: Scaffold Hydration (Merging template governance with project intent).
- **Governance Layers**: `AGENTS.md` (Rules), `VERSIONS.md` (State), `QUICK_REFERENCE.md` (Maps).
- **Operational Loop**: Workflows (Entry) → Skills (Procedures) → Decisions (Execution) → Verification (Check).
- **The Maintenance Loop**: GitHub Actions (Scheduler) → Jules API (Asynchronous Execution) → Automating Pull Requests (Remediation).

---

## 2. Developer Workflow Data (The Daily Flow)
**Correlated Doc:** `DEVELOPER_JOB_AID.md`

**Core Data Points:**
- **Step 1: Synchronize**: Command `/sync-start` triggers environment check and code pull.
- **Step 2: Develop**: Collaborative coding governed by the `AGENTS.md` constitution (Append-only logs, structured intelligence).
- **Step 3: Audit**: Continuous safety checks via `/test`, `/review`, and Jules automated scanning.
- **Step 4: Cleanup & Commit**: Commands `/push` and `/sync-end` ensure documentation (Changelog, QuickRef) is final and code is pushed.
- **Emergency Ops**: The `/recover` path for rollbacks and process resets.

---

## 3. Architecture Logic Data (The Rationale)
**Correlated Doc:** `ARCHITECTURE_DECISIONS.md`

**Core Data Points:**
- **Problem: High CI costs** → **Solution: Fire-and-Forget Pattern** (GHA triggers API then exits).
- **Problem: AI Hallucinations** → **Solution: Procedure-based Skills** (Standardized markdown checklists vs opaque scripts).
- **Problem: Tooling Drift** → **Solution: Environment Isolation** (Tracking tools in `VERSIONS.md` separately from runtime dependencies).
- **Problem: Protocol Erosion** → **Solution: Non-Negotiable Governance** (Enforced `AGENTS.md` instructions).
- **Technical Relationships**: 
    - Dependency: Template → Downstream Project.
    - Lifecycle: Planning → Execution → Verification → Maintenance.

