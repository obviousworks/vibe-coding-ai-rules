# Vibe Coding AI Rules

**The Ultimate AI Coding Ruleset for Windsurf, Cursor, GitHub Copilot, Claude Code, Cline, Codex & more**

> "Context is King. AI agents are only as good as the rules you give them."

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

Production-ready rules, templates, and best practices for AI-assisted development. One repository, all major AI IDEs covered.

---

## Quick Start: Pick Your IDE

| AI IDE | What to Copy | Config Format | Setup Guide |
|--------|-------------|---------------|-------------|
| **Cursor** | `ide-specific/cursor/` | `.cursor/rules/*.mdc` | [Setup](ide-specific/cursor/README.md) |
| **Windsurf** | `ide-specific/windsurf/` | `.windsurfrules` + `global_rules.md` | [Setup](ide-specific/windsurf/README.md) |
| **GitHub Copilot** | `ide-specific/github-copilot/` | `.github/copilot-instructions.md` | [Setup](ide-specific/github-copilot/README.md) |
| **Claude Code** | `ide-specific/claude-code/` | `CLAUDE.md` + `.claude/rules/` | [Setup](ide-specific/claude-code/README.md) |
| **Cline** | `ide-specific/cline/` | `.clinerules` or `.clinerules/` | [Setup](ide-specific/cline/README.md) |
| **Codex** | `ide-specific/codex/` | `AGENTS.md` | [Setup](ide-specific/codex/README.md) |
| **Universal** | `AGENTS.md` | Works everywhere | [Setup](templates/AGENTS.md) |

**Fastest approach**: Copy `AGENTS.md` to your project root and run `./scripts/symlink-setup.sh` to create symlinks for all IDEs at once.

## Universal: The AGENTS.md Standard

[AGENTS.md](https://agents.md) is the emerging universal standard for AI coding assistant configuration, backed by OpenAI, Google, Anthropic, Cursor, and Sourcegraph.

**One file, all IDEs:**
```bash
# Copy the template
cp templates/agent-template.md AGENTS.md
# Customize for your project, then:
./scripts/symlink-setup.sh
# Creates: .windsurfrules, .cursorrules, CLAUDE.md, .clinerules, .github/copilot-instructions.md
# Codex reads AGENTS.md natively — no symlink needed
```

IDEs that read AGENTS.md natively: Cursor, GitHub Copilot, Cline, Codex, Aider.

## What's Inside

```
vibe-coding-ai-rules/
├── README.md                          # You are here
├── AGENTS.md                          # Universal standard (copy to your project)
├── LICENSE                            # MIT License
├── CONTRIBUTING.md                    # How to contribute
│
├── docs/                              # Knowledge base
│   ├── best-practices.md             # Comprehensive agentic coding guide
│   ├── security-rules.md             # Security patterns for AI-generated code
│   ├── performance-rules.md          # Performance optimization patterns
│   ├── testing-rules.md              # Testing standards and patterns
│   ├── migration-guide.md            # Migrate between IDE configurations
│   ├── vibe-coding-overview.md       # Quick reference cheat sheet
│   └── ide-comparison.md             # Feature comparison of all 6 IDEs
│
├── templates/                         # Universal templates (tool-agnostic)
│   ├── AGENTS.md                     # Universal template
│   ├── agent-template.md             # Customizable template with placeholders
│   └── agent-example.md              # Real-world "FocusFlow" example
│
├── ide-specific/                      # One folder per IDE
│   ├── windsurf/                     # Windsurf config + examples
│   ├── cursor/                       # Cursor .mdc rules + examples
│   ├── github-copilot/               # Copilot instructions + examples
│   ├── claude-code/                  # CLAUDE.md + .claude/rules/ + examples
│   ├── cline/                        # .clinerules single + multi-file + examples
│   └── codex/                        # AGENTS.md + examples
│
├── prompts/                           # AI prompts for customization
│   ├── adapt-rules-prompt.txt        # Generate rules for ANY IDE from project info
│   └── project-analyzer-prompt.txt   # Analyze codebase and auto-generate rules
│
└── scripts/
    └── symlink-setup.sh              # Create IDE symlinks from AGENTS.md
```

## Deep Dives

| Topic | Description |
|-------|-------------|
| [Best Practices](docs/best-practices.md) | Context management, prompting, workflows, team collaboration |
| [Security Rules](docs/security-rules.md) | Input validation, injection prevention, auth, secrets management |
| [Performance Rules](docs/performance-rules.md) | Frontend, backend, database, caching optimization patterns |
| [Testing Rules](docs/testing-rules.md) | Test pyramid, patterns, mocking, coverage requirements |
| [IDE Comparison](docs/ide-comparison.md) | Feature matrix, cross-IDE compatibility, recommendations |
| [Migration Guide](docs/migration-guide.md) | Step-by-step migration between any two IDEs |
| [Vibe Coding Overview](docs/vibe-coding-overview.md) | One-page cheat sheet of core principles |

## Core Principles

These principles are embedded in all IDE-specific rule files:

| Principle | Abbr. | Description |
|-----------|-------|-------------|
| Problem Clarity First | PCF | Clarify intent before generating code. No code without clear requirements. |
| Simplicity First | SF | Choose the simplest viable solution. Complex patterns need justification. |
| Readability Priority | RP | Code must be immediately understandable by humans and AI. |
| Dependency Minimalism | DM | No new libraries without explicit request or compelling justification. |
| Security First | SecF | Validate all inputs, no secrets in code, defense in depth. |
| Test-Driven Thinking | TDT | Design all code to be testable from inception. |
| Token Efficiency | TE | Use file-scoped commands, reference docs, optimize context usage. |

## Customization

Two ways to generate rules for your project:

1. **AI Adaptation Prompt**: Fill in your project details and let AI generate IDE-specific configs
   ```
   Use: prompts/adapt-rules-prompt.txt
   ```

2. **Project Analyzer**: Point AI at your existing codebase to auto-generate rules
   ```
   Use: prompts/project-analyzer-prompt.txt
   ```

## IDE Support Matrix

| Tool | Config File | AGENTS.md | Multi-File | Glob Patterns |
|------|------------|-----------|------------|---------------|
| Cursor | `.cursor/rules/*.mdc` | Native | Yes | Yes (YAML) |
| Windsurf | `.windsurfrules` | Manual | No | No |
| GitHub Copilot | `.github/copilot-instructions.md` | Native | Yes | Yes (applyTo) |
| Claude Code | `CLAUDE.md` + `.claude/rules/` | Manual | Yes | No (dir-based) |
| Cline | `.clinerules` or `.clinerules/` | Native | Yes | Yes (YAML) |
| Codex | `AGENTS.md` | Native | Yes (dir-based) | No |

## Coming from the old Windsurf Global Rules?

If you've been using our original `global_rules.md` and `.windsurfrules` — they're still here, now as part of a much bigger toolkit. You'll find the original Windsurf rules as a ready-to-use example in [`ide-specific/windsurf/examples/`](ide-specific/windsurf/examples/), alongside new templates that work across all 6 IDEs.

For the thinking behind this approach, check out these articles:

- [Agent Harness: Warum 90% der KI-Agenten scheitern](https://www.obviousworks.ch/agent-harness-warum-90-der-ki-agenten-scheitern-und-wie-du-es-besser-machst/) — Why structure and guardrails matter more than the model
- [Masterprompt for AI Coding: Der ultimative System-Prompt](https://www.obviousworks.ch/masterprompt-fuer-ai-coding-der-ultimative-system-prompt/) — How to craft system prompts that actually guide AI agents

## Origin

This repository merges and supersedes content from two sources:
- **[vibe-coding-ai-rules](https://github.com/obviousworks/vibe-coding-ai-rules)** — Windsurf-focused global and project rules
- **[agentic-coding-rulebook](https://github.com/obviousworks/agentic-coding-rulebook)** — Universal AGENTS.md templates and best practices

The result: one comprehensive resource covering all major AI coding assistants.

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute:**
- Share production-ready rule examples
- Add support for new IDEs or frameworks
- Improve existing templates with real-world learnings
- Report issues or suggest enhancements

## License

[MIT](LICENSE) — Use freely in personal and commercial projects.

---

## Built by Obviousworks

This repo is maintained by [Obviousworks](https://www.obviousworks.ch) — we help dev teams ship better software with AI.

Everything in this repository reflects what we teach and implement with real teams: effective agent harness structures, production-grade rule systems, and development processes designed around AI from the ground up. In our [AI Developer Bootcamp](https://www.obviousworks.ch/schulungen/ai-developer-bootcamp/) we work hands-on with teams to build exactly this — from writing quality AI coding rules to setting up a complete agentic development workflow that actually scales.

If your team writes code with AI and wants to do it properly:

- [AI Developer Bootcamp — hands-on training for dev teams](https://www.obviousworks.ch/schulungen/ai-developer-bootcamp/)
- [Agent Harness: Why 90% of AI agents fail (and how to fix it)](https://www.obviousworks.ch/agent-harness-warum-90-der-ki-agenten-scheitern-und-wie-du-es-besser-machst/)
- [obviousworks.ch](https://www.obviousworks.ch)
