# Infographic Data Sets

_Comprehensive data sets describing the agentic development infrastructure. Each section provides the conceptual framework, key entities, relationships, and flow logic needed for a generative AI to create rich visual representations._

---

## 1. The Agentic Protocol: System Lifecycle

**Purpose:** Visualize the complete journey from strategic planning to autonomous maintenance.

### The Five Phases

**Phase 1: The Genesis (Origin of Intelligence)**
- **Primary Entity:** The Gemini Gem — a specialized AI system prompt acting as a "Strategic Architect."
- **Function:** Transforms high-level human requirements into structured project blueprints.
- **Outputs:** 
  - `BOOTSTRAP.json` — The DNA of the project (tech stack, hosting, AI personas, dependencies).
  - `docs/PRD.md` — Product Requirements Document defining the "What" and "Why."
  - `docs/ARCHITECTURE.md` — Technical blueprint defining the "How."
- **Conceptual Metaphor:** A glowing crystalline core emitting structured data streams; a "Source" or "Wellspring" of intelligence.

**Phase 2: The Hydration (Scaffold & Governance)**
- **Primary Entity:** The Bootstrap Skill — a procedure that merges template infrastructure with project intent.
- **Function:** Creates a fully-configured GitHub repository with pre-installed governance and tooling.
- **Key Components Created:**
  - `AGENTS.md` — The "Constitution" of the codebase; non-negotiable rules for all AI agents.
  - `VERSIONS.md` — The "State Ledger" tracking all pinned tool versions.
  - `QUICK_REFERENCE.md` — The "Map" of collections, routes, and environment variables.
  - `.agent/skills/` — Reusable procedural intelligence.
  - `.jules/prompts/` — Instructions for the autonomous maintenance agents.
- **Conceptual Metaphor:** Seeds being planted into a complex architectural scaffold; blueprints materializing into a structured repository.

**Phase 3: The Symbiosis (Human-AI Collaboration)**
- **Primary Entities:** Human Developer + AI Agent.
- **Function:** Collaborative development governed by shared rules and workflows.
- **The Collaboration Loop:**
  1. Human sets intent (feature request, bug fix, refactor).
  2. AI Agent reads `AGENTS.md` (Constitution) to understand constraints.
  3. Agent executes via Workflows (Entry Points) calling Skills (Procedures).
  4. Human reviews, approves, or iterates.
- **Governance Structures:**
  - Append-only logs (`CHANGELOG.md`, `COMPLIANCE_LOG.md`) — Immutable audit trail.
  - Structured intelligence — All LLM outputs via Pydantic schemas, no raw string parsing.
  - PR Hygiene — One concern per PR, rebase before merge.
- **Conceptual Metaphor:** Two interlocking gears labeled "Human Intuition" and "AI Protocol"; a bridge or handshake between organic and digital entities.

**Phase 4: The Night Shift (Autonomous Maintenance)**
- **Primary Entities:** GitHub Actions (Scheduler) + Jules API (Executor) + Sentinel Agents (Protectors).
- **Function:** Continuous, asynchronous maintenance without human intervention.
- **The Fire-and-Forget Pattern:**
  1. Cron schedule triggers GitHub Action.
  2. GHA reads prompt from `.jules/prompts/`.
  3. GHA triggers Jules API session and immediately exits (0 runner minutes).
  4. Jules Agent executes task in the background.
  5. Agent creates a Pull Request with the fix.
- **Maintenance Personas:**
  - Sentinel — Security vulnerability detection.
  - Dependency Doctor — Outdated/vulnerable package updates.
  - Code Formatter — Automated code style enforcement.
  - Dead Code Scanner — Unused code detection.
  - Test Guardian — Test coverage gap identification.
- **Conceptual Metaphor:** A night sky with robotic drones or sentinels patrolling lines of code; a moon icon representing the "off-hours" work.

**Phase 5: The Fortress (Production Readiness)**
- **Primary Entity:** The Deployed Application.
- **Function:** A secure, compliant, and stable system ready for end-users.
- **Security Layers:**
  - Pre-commit hooks (`ruff`, `mypy`, `detect-secrets`) — Local enforcement.
  - Compliance logs — Audit trail for security-related changes.
  - Sentinel monitoring — Ongoing vulnerability detection.
- **Conceptual Metaphor:** A secure, glowing server rack or cloud fortress protected by shields, locks, and compliance checkmarks.

### Key Relationships (Flow Logic)
```
Gemini Gem → Seeds → Bootstrap Skill → Repository
Repository → AGENTS.md → Governs → Human + AI Agents
Human + AI Agents → Develop → Codebase
GitHub Actions → Jules API → Maintains → Codebase
Codebase → Deploys → Production Fortress
```

---

## 2. The Developer Job Aid: Daily Operational Flow

**Purpose:** Visualize the human developer's daily workflow as a cyclical, repeatable process.

### The Four Quadrants of a Development Day

**Quadrant 1: The Wake-Up (Synchronization)**
- **Command:** `/sync-start`
- **Actions:**
  - Pull latest code from `origin/main`.
  - Update Python dependencies (`pip install -r requirements.txt`).
  - Update Node dependencies (`npm install`).
  - Verify IDE rules are synchronized.
  - Confirm pre-commit hooks are installed.
- **Key Artifact:** The synced local repository.
- **Conceptual Element:** A terminal window displaying synchronization commands; code streams flowing into a local machine icon.

**Quadrant 2: The Core (Governed Development)**
- **Governance Entity:** `AGENTS.md` (The Constitution).
- **Actions:**
  - Human sets intent; AI Agent reads the Constitution.
  - Collaborative coding: Human intuition + AI scale.
  - Continuous reference to `QUICK_REFERENCE.md` for architecture details.
- **Key Rules Enforced:**
  - Append-only logs — Never overwrite `CHANGELOG.md`.
  - Structured intelligence — Use `instructor` library for LLM outputs.
  - Idempotency — Check before regenerating artifacts.
- **Conceptual Element:** A human silhouette and an AI silhouette collaborating over a shared document labeled "AGENTS.md".

**Quadrant 3: The Audit (Safety & Verification)**
- **Commands:** `/test`, `/review`, automated Jules scans.
- **Actions:**
  - Run test suite (`pytest tests/ -m "not expensive"`).
  - Trigger multi-model code review (`/review` workflow).
  - Background scans by Sentinel, Dependency Doctor, etc.
- **Key Artifacts:** Test reports, code review summaries, automated PRs.
- **Conceptual Element:** A shield icon representing safety; checkmarks and a magnifying glass representing verification.

**Quadrant 4: The Hand-Off (Cleanup & Commit)**
- **Commands:** `/push`, `/sync-end`.
- **Actions:**
  - Format code (`ruff`, linting).
  - Update documentation (`CHANGELOG.md`, `QUICK_REFERENCE.md`).
  - Stage, commit, and push changes.
  - Final environment cleanup.
- **Key Artifact:** The merged Pull Request; the synced remote repository.
- **Conceptual Element:** A glowing envelope or PR icon being sent to a cloud; a "send" or "upload" motion.

**Emergency Path: The Recovery**
- **Command:** `/recover`
- **Trigger:** Stuck command, bad implementation, environment failure.
- **Actions:**
  - Terminate runaway processes.
  - Git reset/revert to last known good state.
  - Reinstall dependencies if corrupted.
- **Conceptual Element:** An "undo" arrow or a reset button; a safety net or parachute icon.

### Key Relationships (Cyclical Flow)
```
Start Session → /sync-start
  ↓
Develop → AGENTS.md Governance → Collaborative Coding
  ↓
Verify → /test, /review → Automated Scans
  ↓
Commit → /push, /sync-end
  ↓
(Next Day) → Repeat → /sync-start
  ↓
(If Error) → /recover → Return to Start Session
```

---

## 3. Architecture Decision Records: The Rationale

**Purpose:** Visualize the problem/solution pairs that justify the core infrastructure decisions.

### The Four Pillars of Architectural Logic

**Pillar 1: The Cost Problem (CI Runner Minutes)**
- **The Problem:** Traditional CI/CD workflows spend minutes waiting for third-party APIs. GitHub Actions runners bill for idle time.
- **The Insight:** Most of the "work" happens outside the runner; the runner is just a dispatcher.
- **The Solution:** Fire-and-Forget Pattern.
  - **Implementation:** GHA triggers the Jules API and exits immediately. Jules executes asynchronously on Google infrastructure.
  - **Result:** Near-zero GHA minutes for maintenance tasks.
- **Conceptual Element:** A fast-moving data packet (GHA) igniting a powerful background process (Jules) while the primary timeline remains clear and unburdened.

**Pillar 2: The Consistency Problem (AI Hallucinations)**
- **The Problem:** AI agents can "hallucinate" patterns or deviate from project conventions, especially over long sessions or with different models.
- **The Insight:** Scripts are efficient for machines but opaque to LLMs when debugging failures. LLMs need human-readable procedures.
- **The Solution:** Skill-Based Procedures.
  - **Implementation:** Complex tasks are defined in `.agent/skills/` as Markdown checklists and decision trees, not opaque scripts.
  - **Result:** Agents can "read their own manual" during failures, improving self-correction and observability.
- **Conceptual Element:** A "Split-Brain" comparison: one side shows a tangled pile of scripts (Problem), the other shows a clean, structured checklist hierarchy (Solution).

**Pillar 3: The Drift Problem (Tooling Versioning)**
- **The Problem:** Mixing development tools (linters, CLIs) with runtime libraries (web frameworks, databases) creates version conflicts and bloated environments.
- **The Insight:** "Agentic Environment" tools (pre-commit, MCP servers) have different update cadences and compatibility concerns than application code.
- **The Solution:** Environment Isolation.
  - **Implementation:** `VERSIONS.md` tracks the agentic tooling stack separately. `requirements.txt` / `package.json` manage runtime.
  - **Result:** Clearer upgrade paths; security scanners focus on runtime, while `tool_version_auditor` handles template tooling.
- **Conceptual Element:** Two separate, secure containers: one labeled "Agentic Tools" (the environment), the other labeled "Application Code" (the runtime).

**Pillar 4: The Erosion Problem (Protocol Decay)**
- **The Problem:** Over time, without strict enforcement, project conventions erode. New contributors (human or AI) may ignore established patterns.
- **The Insight:** AI agents need a "constitution" they are forced to read at the start of every session.
- **The Solution:** Non-Negotiable Governance.
  - **Implementation:** `AGENTS.md` contains "Critical Directives" that override any other instruction. It is loaded into context at the start of every agent session.
  - **Result:** Sustained project integrity across multiple shifts, different AI models, and new contributors.
- **Conceptual Element:** A foundational stone or constitution document; a "pillar" holding up the entire structure.

### Key Relationships (Problem → Solution → Outcome)
```
High CI Costs → Fire-and-Forget → Reduced GHA Minutes
AI Hallucinations → Skill-Based Procedures → Improved Self-Correction
Tooling Drift → Environment Isolation → Clearer Upgrade Paths
Protocol Erosion → Non-Negotiable Governance → Sustained Integrity
```
