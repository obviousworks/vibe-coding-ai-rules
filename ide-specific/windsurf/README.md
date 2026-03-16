# Windsurf Configuration Guide

## Overview

Windsurf uses a two-tier rule system:
1. **Global Rules** (`global_rules.md`): Applied across ALL projects (max ~6000 characters)
2. **Project Rules** (`.windsurfrules`): Project-specific, placed in project root

## Setup

### Global Rules
1. Open Windsurf → Settings → AI Settings → Global Rules
2. Copy the content of `global_rules.md` into the text field
3. Save

### Project Rules
1. Copy `.windsurfrules` to your project root
2. The file is ready to use as-is with sensible defaults
3. Customize sections as needed for your project (tech stack, naming conventions, etc.)

## File Format

- Plain Markdown (no YAML frontmatter)
- Global rules: max ~6000 characters recommended
- Project rules: no hard limit, but keep concise for token efficiency
- Windsurf does NOT support multi-file rules or glob patterns
- XML-style tags (`<section>...</section>`) can help Windsurf parse sections

## Hierarchy

```
Global Rules (AI Settings)     ← Applied to ALL projects
  └── .windsurfrules           ← Project-specific, overrides global
```

## Files

| File | Description |
|------|-------------|
| `.windsurfrules` | Ready-to-use project ruleset with core principles, code style, security, testing, and workflow rules |
| `examples/global_rules.md` | Complete global rules example (FocusFlow project) |
| `examples/.windsurfrules-template` | Template version with `{{VARIABLE}}` placeholders for customization |

## Tips

- Keep global rules focused on universal principles (security, code style, workflow)
- Put project-specific details (tech stack, commands, structure) in `.windsurfrules`
- Use XML-style tags (`<section>...</section>`) to help Windsurf parse sections
- Windsurf also reads AGENTS.md if present, but not natively — use symlink for best results
- The template in `examples/.windsurfrules-template` can be used with the [AI adaptation prompt](../../prompts/adapt-rules-prompt.txt) for fully customized rules

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates a `.windsurfrules` symlink pointing to `AGENTS.md`.
