# Aider Configuration Guide

## Overview

Aider is an open-source AI pair programming tool that runs in your terminal. It reads configuration from multiple sources:
1. **Config file**: `.aider.conf.yml` in project root or `~/.aider.conf.yml` globally
2. **Conventions file**: `.aider/conventions.md` for coding standards and rules
3. **AGENTS.md**: Read natively from project root
4. **Read flag**: Any file passed via `--read` is added as context

## Setup

### Recommended: Conventions File
1. Create `.aider/` directory in your project root
2. Copy `conventions.md` into `.aider/`
3. Customize the conventions for your project

### Config File
1. Copy `.aider.conf.yml` to your project root
2. Uncomment and customize settings for your project

### Using AGENTS.md
Aider reads `AGENTS.md` natively from your project root. If you already have an `AGENTS.md`, no additional setup is needed.

### Using --read Flag
Pass any file as read-only context:
```bash
aider --read path/to/rules.md
```

## Config File Format

`.aider.conf.yml` uses YAML with command-line option names as keys:

```yaml
# Select the LLM model
model: anthropic/claude-sonnet-4-20250514

# Auto-commit changes
auto-commits: true

# Run lint command after changes
lint-cmd: npm run lint

# Run tests after changes
test-cmd: npm test
```

See `.aider.conf.yml` in this directory for a complete example with all common options.

## Conventions File Format

`.aider/conventions.md` is a plain Markdown file containing your coding standards. Aider includes it automatically as context for every conversation.

## File Structure

```
your-project/
├── .aider/
│   └── conventions.md          # Coding standards and rules
├── .aider.conf.yml             # Aider configuration
└── AGENTS.md                   # Also read natively by Aider
```

## Tips

- Aider reads `AGENTS.md` natively — if you have one, Aider picks it up automatically
- Use `.aider/conventions.md` for Aider-specific coding standards
- Use `--read` to pass additional context files for specific tasks
- Keep conventions concise — Aider includes them in every conversation
- Aider supports multiple LLM backends: OpenAI, Anthropic, local models, and more

## Examples

See `conventions.md` for a ready-to-use conventions file with core principles, code style, security, testing, and workflow rules.

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` in your project root. Aider reads it natively alongside Cursor, Copilot, Codex, and Cline.
