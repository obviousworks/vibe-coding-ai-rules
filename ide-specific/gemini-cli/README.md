# Google Gemini CLI Configuration Guide

## Overview

Google Gemini CLI is Google's command-line coding agent. It reads instructions from `GEMINI.md` files placed in your repository, using a hierarchical discovery model similar to Claude Code's `CLAUDE.md`.

## Discovery Order

Gemini CLI checks for instruction files in this order:

1. **`GEMINI.md`** — Primary configuration file (recommended)
2. **`AGENTS.md`** — Universal standard (also supported)

Files closer to your working directory take precedence over those in parent directories.

## Setup

1. Copy `GEMINI.md` to your project root
2. Customize for your project
3. Optionally create directory-specific `GEMINI.md` files for subsections

## File Format

- Plain Markdown (no YAML frontmatter, no special syntax)
- Standard Markdown headers, bullet points, and code blocks
- Clear, actionable instructions work best
- Keep concise for token efficiency

## Hierarchy

Gemini CLI supports hierarchical configuration — place `GEMINI.md` files in subdirectories to provide scoped instructions:

```
your-project/
├── GEMINI.md                       # Project-level instructions
├── apps/
│   └── web/
│       └── GEMINI.md               # Frontend-specific instructions
├── services/
│   └── api/
│       └── GEMINI.md               # API-specific instructions
└── packages/
    └── shared/
        └── GEMINI.md               # Shared library instructions
```

Files in subdirectories augment (and can override) the root-level instructions when working within that directory.

## Tips

- Keep the root `GEMINI.md` focused on universal project rules
- Use subdirectory `GEMINI.md` files for context-specific guidance (e.g., frontend vs. backend)
- Gemini CLI also reads `AGENTS.md` — if your team uses mixed tools, maintain `AGENTS.md` as the source of truth
- Keep instructions actionable: "Always run `npm test` after modifying files"

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

Gemini CLI reads `AGENTS.md` natively — no symlinks needed. To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates symlinks for IDEs that need them. Gemini CLI, Cursor, Copilot, Cline, and Codex will all read `AGENTS.md` directly.

If you prefer the Gemini-native format, you can create a symlink:
```bash
ln -sf AGENTS.md GEMINI.md
```
