# Agent-Optimized Repository Architecture

To optimize the Antigravity IDE and Claude Code workflow for your "Autonomous Job Application Agent" and future projects, implement this hierarchical documentation strategy. This structure ensures that both Gemini and Claude agents operate with high autonomy, consistent logic, and minimal token waste.

## I. Core File Concepts

### README.md (The Architect's Vision)

- **Objective:** Defines the "What" and "Why."
- **Rationale:** Provides high-level business logic and installation steps. While primarily for humans, agents use this to understand the project’s intent before diving into code.

### AGENTS.md (The Operational Manual)

- **Objective:** Defines the "How" for Gemini and Antigravity agents.
- **Rationale:** Contains technical constraints, library preferences (e.g., Playwright vs. Selenium), and "rules of engagement" (e.g., "Always run linting before committing").

### CLAUDE.md (The Extension Configuration)

- **Objective:** Tailors the environment for the Claude Code extension.
- **Rationale:** Claude specifically scans for this file to identify valid terminal commands, test runners, and build scripts.

## II. Hierarchical Placement & Versioning

### Root Level (`/`)

Place the "Master" versions of all three files here. These govern the entire repository and define global standards (e.g., TypeScript, Prettier config).

### Sub-Directory Level (`/backend`, `/frontend`)

Place "Secondary" `AGENTS.md` or `README.md` files in specific modules.

- **Benefit:** Provides domain-specific context. An agent working in the backend won't be "polluted" by frontend UI constraints, and vice versa.
- **Versioning:** All files must be committed to Git. This ensures that when you switch between your 2019 MacBook Pro and Pixel 9 Pro XL, the agents have a persistent, version-controlled source of truth.

## III. Implementation Roadmap & Benefits

### Unified Standards

Create a single source of truth for coding style. Use a Symlink (`ln -s AGENTS.md CLAUDE.md`) so that updating one file updates the context for all agents simultaneously.

### Constraint Enforcement

Explicitly list "Do Not" rules (e.g., "Do not use deprecated libraries") to prevent agents from introducing technical debt.

### Autonomous Testing

Include a "Verification" section in `AGENTS.md` that instructs agents to run specific test suites after every code change.

### Efficiency

Reduces the need for long, repetitive system prompts. The agents "onboard" themselves by reading the local Markdown files, saving time and compute resources.
