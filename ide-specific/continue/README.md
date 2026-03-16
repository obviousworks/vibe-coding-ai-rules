# Continue.dev Configuration Guide

## Overview

Continue.dev is an open-source AI code assistant extension for VS Code and JetBrains. It reads rules from:
1. **Rule files**: `.continue/rules/*.md` with YAML frontmatter
2. **Model config**: `.continuerc.json` for model and provider settings
3. **AGENTS.md**: Can be referenced as a rule file

## Setup

1. Create `.continue/rules/` directory in your project root
2. Copy the rule files from this folder's `.continue/rules/` directory
3. Customize the rules for your project
4. Optionally create `.continuerc.json` for model configuration

## Rule File Format

Each rule file is a Markdown file with optional YAML frontmatter:

```markdown
---
name: Rule Name
globs: "**/*.tsx"
alwaysApply: true
---

# Rule Title

Your rules in Markdown here...
```

### Frontmatter Options

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Human-readable name for the rule |
| `globs` | string or string[] | File patterns that activate the rule |
| `alwaysApply` | boolean | If true, rule is active in every conversation |
| `regex` | string | Content pattern that activates the rule |

### Rule Types

| Type | Config | When Active |
|------|--------|-------------|
| Always | `alwaysApply: true` | Every conversation |
| Glob-Based | `globs: "pattern"` | When matching files are in context |
| Regex-Based | `regex: "pattern"` | When content matches the pattern |
| Manual | No activation fields | Only when explicitly referenced |

## File Structure

```
your-project/
├── .continue/
│   ├── rules/
│   │   ├── core-principles.md      # Always active
│   │   ├── code-style.md           # Always active
│   │   ├── security.md             # Always active
│   │   ├── testing.md              # Active for test files
│   │   └── workflow.md             # Always active
│   └── config.json                 # Model configuration (optional)
└── .continuerc.json                # Project-level model config (optional)
```

## Model Configuration

Create `.continuerc.json` in your project root to configure models:

```json
{
  "models": [
    {
      "title": "Claude Sonnet",
      "provider": "anthropic",
      "model": "claude-sonnet-4-20250514",
      "apiKey": "env:ANTHROPIC_API_KEY"
    }
  ]
}
```

## Tips

- Keep each rule file focused on one topic for clarity
- Use `alwaysApply: true` for rules that should apply universally
- Use `globs` to activate rules only for relevant file types (e.g., test files)
- Use `regex` to activate rules based on file content patterns
- Continue.dev supports multiple LLM backends: OpenAI, Anthropic, Ollama, and more

## Examples

See `.continue/rules/` in this directory for ready-to-use rule files covering core principles, code style, security, testing, and workflow.

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` in your project root. You can reference it from Continue.dev or use the individual rule files alongside other IDE configurations.
