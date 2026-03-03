# OpenAI Codex Configuration Guide

## Overview

OpenAI Codex reads instructions from `AGENTS.md` files placed in your repository. Codex discovers these files automatically and builds an instruction chain at the start of each session.

## Discovery Order

Codex reads files in this precedence:

1. **Global scope**: `~/.codex/AGENTS.override.md` → `~/.codex/AGENTS.md`
2. **Project scope**: From Git root down to current working directory, in each directory:
   - `AGENTS.override.md` → `AGENTS.md` → fallback filenames

Files closer to your working directory appear later in the prompt and override earlier guidance.

## Setup

1. Copy `AGENTS.md` to your project root
2. Customize for your project
3. Optionally create directory-specific `AGENTS.md` files for subsections

## File Format

- Plain Markdown (no YAML frontmatter, no special syntax)
- Max 32 KiB by default (`project_doc_max_bytes` in `config.toml`)
- Standard Markdown headers, bullet points, and code blocks
- Clear, actionable instructions work best

## Configuration

Customize discovery via `~/.codex/config.toml`:

```toml
# Additional filenames to check (besides AGENTS.md)
project_doc_fallback_filenames = ["TEAM_GUIDE.md", ".agents.md"]

# Max bytes to read from instruction files
project_doc_max_bytes = 65536

# Custom project root markers (default: [".git"])
project_root_markers = [".git"]
```

## File Structure

```
your-project/
├── AGENTS.md                    # Project-level instructions
├── AGENTS.override.md           # Temporary overrides (optional)
├── apps/
│   └── web/
│       └── AGENTS.md            # Directory-specific instructions
└── services/
    └── api/
        └── AGENTS.md            # Service-specific instructions
```

## Global Defaults

Create persistent defaults for all repositories:

```
~/.codex/
├── AGENTS.md                    # Global defaults for all repos
└── AGENTS.override.md           # Temporary global override
```

## Tips

- Codex uses the same `AGENTS.md` format as Cursor and Copilot — one file works across tools
- Keep instructions actionable: "Always run `npm test` after modifying files"
- Use directory-scoped files to avoid bloating the root `AGENTS.md`
- `AGENTS.override.md` takes precedence — useful for temporary project-specific overrides

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

Codex natively reads `AGENTS.md` from project root — no symlinks needed. The same `AGENTS.md` works with Cursor, Copilot, and Cline out of the box.
