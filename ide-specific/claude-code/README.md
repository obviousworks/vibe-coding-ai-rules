# Claude Code Configuration Guide

## Overview

Claude Code reads instructions hierarchically:
1. `~/.claude/CLAUDE.md` — User-global (highest personal priority)
2. `./CLAUDE.md` — Project root (highest project priority)
3. `./.claude/rules/*.md` — Modular project rules
4. `./subfolder/CLAUDE.md` — Directory-specific (overrides parent)

## Key Behavior

- CLAUDE.md content is treated as **immutable system rules**
- Higher priority than user prompts
- Claude Code follows these instructions more strictly than chat input
- Keep directives concise — every line is treated as a strong directive

## Setup

1. Copy `CLAUDE.md` to your project root
2. Copy `.claude/rules/` to your project root
3. Customize for your project

## File Format

- Pure Markdown (no YAML frontmatter)
- No glob patterns (use directory-based CLAUDE.md files for scoping)
- Keep concise: aim for 800–1500 tokens in CLAUDE.md
- Use `.claude/rules/*.md` for detailed topic-specific rules

## Hierarchy

```
~/.claude/CLAUDE.md              ← User-global rules
├── ./CLAUDE.md                  ← Project root (main config)
├── ./.claude/rules/*.md         ← Modular project rules
└── ./subfolder/CLAUDE.md        ← Directory-specific overrides
```

## Tips

- CLAUDE.md should be MORE CONCISE than other IDE configs
- Use `.claude/rules/` for detailed rules that don't need to be in every prompt
- Put "non-negotiable" rules in CLAUDE.md, detailed guidelines in `.claude/rules/`
- Claude Code does not read AGENTS.md natively — use symlink if needed

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates a `CLAUDE.md` symlink pointing to `AGENTS.md`.
