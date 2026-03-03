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
2. Customize the placeholders (marked with `{{...}}`)
3. Or use our [AI adaptation prompt](../../prompts/adapt-rules-prompt.txt) to generate rules automatically

## File Format

- Plain Markdown (no YAML frontmatter)
- Global rules: max ~6000 characters recommended
- Project rules: no hard limit, but keep concise for token efficiency
- Windsurf does NOT support multi-file rules or glob patterns

## Hierarchy

```
Global Rules (AI Settings)     ← Applied to ALL projects
  └── .windsurfrules           ← Project-specific, overrides global
```

## Tips

- Keep global rules focused on universal principles (security, code style, workflow)
- Put project-specific details (tech stack, commands, structure) in `.windsurfrules`
- Use XML-style tags (`<section>...</section>`) to help Windsurf parse sections
- Windsurf also reads AGENTS.md if present, but not natively — use symlink for best results

## Examples

See `examples/` for a complete FocusFlow project configuration (`.windsurfrules` + `global_rules.md`).

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates a `.windsurfrules` symlink pointing to `AGENTS.md`.
