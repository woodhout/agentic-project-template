# Architecture Decisions (ADRs)

![Architecture Decision Records: The Rationale](architecture_decisions.png)

This document records the engineering rationales for the core design choices in this agentic infrastructure.

---

## ADR 1: Fire-and-Forget Automation Pattern

**Context**: Scheduled maintenance tasks (formatting, security scans) can take several minutes to run. Standard GitHub Actions runners cost minutes even if simply waiting for a third-party API.

**Decision**: Implement a "Fire-and-Forget" pattern via the Jules API.
- **Implementation**: GHA triggers the Jules API session and immediately exits (0-1 minute spend). Jules executes the brunt of the work on Google’s specialized infrastructure.
- **Result**: Drastically reduced GHA costs while maintaining high-frequency maintenance.

---

## ADR 2: Skill-Based Procedure (vs. Scripts)

**Context**: Traditional CI/CD and automation rely on complex Bash or Python scripts. While efficient for machines, they are difficult for LLMs to "reason" about when failures occur.

**Decision**: Define complex procedures as Markdown-based "Skills" in `.agent/skills/`.
- **Implementation**: Skills use decision trees, prerequisites, and checklists in human-readable (and LLM-readable) markdown.
- **Result**: Agents can "read their own manual" during failures, leading to higher self-correction rates and better observability for human reviewers.

---

## ADR 3: Environment vs. Runtime Dependency Split

**Context**: Projects often mix development tools (linting, deployment CLIs) with runtime libraries. This leads to bloated containers and version conflicts.

**Decision**: Separate tracked tool versions in `VERSIONS.md` and enforce them via `AGENTS.md`.
- **Implementation**: `requirements.txt` / `package.json` manage runtime, while `VERSIONS.md` manages the "Agentic Environment."
- **Result**: Clearer upgrade paths and simplified audit logs. Security scanners can focus on the runtime surface area while `tool_version_auditor` handles the template tooling.

---

## ADR 4: The "Constitution" Governance (AGENTS.md)

**Context**: AI agents are prone to "hallucinating" patterns or drifting away from established project conventions over time.

**Decision**: Make `AGENTS.md` a mandatory, non-negotiable instruction set.
- **Implementation**: The file contains "Critical Directives" that the agent must read at the start of every session.
- **Result**: Sustained project integrity across multiple shifts and multiple different AI models.
