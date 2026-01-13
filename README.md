# Agentic Project Template

A comprehensive template for bootstrapping AI-assisted software projects, from ideation through implementation.

---

## Overview

This template provides everything you need to start a new software project with AI-first development practices:

1. **Ideation Phase** → Use Gemini Gems to collaboratively design your product
2. **Seed Files** → Export structured documents (PRD, Architecture, etc.)
3. **Bootstrap** → Automatically create a fully-configured GitHub repo
4. **Development** → AI agents build and maintain your code

```
┌─────────────────────────┐
│  Gemini Gems            │
│  (Technical Co-founder) │
│  (Product Manager)      │
└───────────┬─────────────┘
            │ Outputs seed files
            ▼
┌─────────────────────────┐
│  seeds/                 │
│  ├── docs/              │
│  │   ├── PRD.md         │
│  │   └── ARCHITECTURE.md│
│  └── BOOTSTRAP.json     │
└───────────┬─────────────┘
            │ /bootstrap workflow
            ▼
┌─────────────────────────┐
│  New GitHub Repo        │
│  ├── Agentic template   │
│  ├── Jules automation   │
│  └── Ready for coding   │
└─────────────────────────┘
```

---

## Quick Start

### Step 1: Start with a Gemini Gem

Choose the Gem that matches your technical comfort level:

| Gem                      | Best For                                                      | Link                                                                                      |
| ------------------------ | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| **Technical Co-Founder** | Developers, technical PMs who want to understand architecture | [Open Gem →](https://gemini.google.com/gem/1SokqHMaJsfZvArdCi8W8deL7qbL-jSlI?usp=sharing) |
| **Product Manager**      | Non-technical founders, business stakeholders                 | [Open Gem →](https://gemini.google.com/gem/1wYOPZFXbyJuQN6-F_MHuAc1vLg38acVQ?usp=sharing) |

### Step 2: Complete the Discovery Interview

The Gem will guide you through questions about:

- What problem you're solving
- Who it's for
- Technical preferences (if applicable)
- Timeline and budget constraints

### Step 3: Export Seed Files

When the Gem finishes, it generates these documents:

```
seeds/
├── docs/
│   ├── PROJECT_GUIDE.md      # Communication rules
│   ├── PRD.md                # Product requirements
│   ├── ARCHITECTURE.md       # Technical blueprint
│   ├── DECISION_LOG.md       # Why each choice was made
│   └── QUICK_REFERENCE.md    # Agent cheat sheet
└── BOOTSTRAP.json            # Machine-readable manifest
```

Save these to the `seeds/` folder in this project.

### Step 4: Bootstrap Your Project

In Antigravity IDE, run:

```
/bootstrap seeds/
```

This will:

1. Create a new GitHub repository
2. Copy the agentic template into it
3. Integrate your seed documents
4. Configure Jules automation
5. Push initial commit

### Step 5: Start Building

Open your new project in Antigravity and start coding with AI agents!

---

## What's Included

### Template Files (`template/`)

The complete agentic development infrastructure:

| Category         | Files                                                       |
| ---------------- | ----------------------------------------------------------- |
| **Core**         | AGENTS.md, QUICK_REFERENCE.md, README.md                    |
| **Pre-commit**   | .pre-commit-config.yaml, .secrets.baseline                  |
| **Global Rules** | .antigravity/GEMINI.md, scripts/sync-gemini-rules.sh        |
| **Workflows**    | 10 universal workflows (sync-start, sync-end, review, etc.) |
| **Jules**        | 12 automation prompts (sentinel, dependency-doctor, etc.)   |
| **Patterns**     | GCP.md, LLM_APPS.md, EXAMPLES.md                            |

### Gem Prompts (`gem-prompts/`)

The actual prompts used by the Gemini Gems:

- `technical-cofounder.md` — For technical users
- `non-technical-user.md` — For non-technical users

These are provided for reference. The linked Gems have these prompts pre-configured.

### Seeds Folder (`seeds/`)

Where you save the output from your Gem session. Start empty, fill after your Gem conversation.

---

## The Gems in Detail

### Technical Co-Founder Gem

**Best for:** Developers, engineers, technical product managers

**Experience:**

- You're treated as a technical peer
- Trade-offs are explained in detail
- You approve each major architectural decision
- Full visibility into the "why" behind choices

**Interview covers:**

- Problem space and scale
- Technical preferences and constraints
- Risk tolerance for new technology
- Performance vs. cost trade-offs

**Output style:**

- Detailed technical documentation
- API specs and data models
- Full rationale for each decision

[**Start Technical Co-Founder Session →**](https://gemini.google.com/gem/1SokqHMaJsfZvArdCi8W8deL7qbL-jSlI?usp=sharing)

---

### Product Manager (Non-Technical) Gem

**Best for:** Founders, business stakeholders, non-technical visionaries

**Experience:**

- No jargon — everything explained in plain English
- You focus on "what" — the Gem handles "how"
- Only consulted on decisions affecting cost, timeline, or UX
- Progress shown through mockups and demos

**Interview covers:**

- Your background and communication preferences
- The problem and who it's for
- Visual inspiration and style
- Budget and timeline constraints

**Output style:**

- Plain-English explanations
- "How It Works (Simple Version)" summaries
- Business-impact focused decision log

[**Start Product Manager Session →**](https://gemini.google.com/gem/1wYOPZFXbyJuQN6-F_MHuAc1vLg38acVQ?usp=sharing)

---

## Folder Structure

```
agentic-project-template/
├── README.md                 # This file
├── seeds/                    # Your Gem output goes here
│   └── .gitkeep
├── template/                 # The agentic development template
│   ├── AGENTS.md
│   ├── QUICK_REFERENCE.md
│   ├── .pre-commit-config.yaml
│   ├── .antigravity/
│   ├── .agent/
│   ├── .jules/
│   ├── patterns/
│   └── scripts/
└── gem-prompts/              # Reference: Gem prompt text
    ├── technical-cofounder.md
    └── non-technical-user.md
```

---

## Customization

### Adding New Patterns

Add cloud/framework-specific best practices to `template/patterns/`:

```markdown
# AWS.md

## Lambda Best Practices

...

## DynamoDB Patterns

...
```

These can be copied into `AGENTS.md` during bootstrap based on tech stack.

### Modifying Workflows

Edit workflows in `template/.agent/workflows/` to match your preferences.

### Updating Gem Prompts

Edit files in `gem-prompts/`, then update your Gemini Gems with the new text.

---

## Requirements

- **Antigravity IDE** — For running `/bootstrap` and AI-assisted development
- **GitHub Account** — For repository creation (via GitHub MCP)
- **Jules** — For automated maintenance (optional but recommended)

---

## License

MIT — Use freely for personal and commercial projects.
