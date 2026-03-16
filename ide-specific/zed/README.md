# Zed AI Configuration Guide

## Overview

Zed is a fast, native code editor with built-in AI assistant capabilities including inline AI assist, an AI panel, and terminal AI. Zed reads rule files from your project root by scanning for multiple formats in a defined priority order.

## Rule File Priority

Zed checks for rule files in this order (first match wins):

1. `.rules` — Zed-native format (recommended)
2. `.cursorrules` — Cursor legacy format
3. `.windsurfrules` — Windsurf format
4. `.clinerules` — Cline format
5. `.github/copilot-instructions.md` — GitHub Copilot format
6. `AGENTS.md` — Universal standard
7. `CLAUDE.md` — Claude Code format
8. `GEMINI.md` — Gemini CLI format

Zed stops at the first file it finds. This makes Zed the most format-compatible editor on the market — it works with any existing AI rule file without conversion.

## Setup

### Recommended: Use AGENTS.md
1. Copy `AGENTS.md` to your project root (broadest cross-IDE compatibility)
2. Zed will pick it up automatically
3. No symlinks or conversion needed

### Alternative: Zed-Native .rules File
1. Copy `.rules` from this folder to your project root
2. Customize for your project
3. This takes highest priority if multiple rule files exist

## File Format

- Plain Markdown (no YAML frontmatter, no special syntax)
- No multi-file support — single file only
- No glob patterns or path filtering
- Keep concise for token efficiency

## File Structure

```
your-project/
├── .rules                          # Zed-native (highest priority)
├── AGENTS.md                       # Universal standard (also detected)
└── ...
```

## Tips

- Since Zed uses first-match-wins, having a `.rules` file will shadow all other rule files
- If your team uses mixed IDEs, prefer `AGENTS.md` — Zed reads it natively, and it works with Cursor, Copilot, Cline, and Codex too
- Only create `.rules` if you need Zed-specific rules that differ from your `AGENTS.md`
- Zed does not support hierarchical or directory-scoped rules

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

Zed reads `AGENTS.md` natively — no symlinks needed. If you maintain a single `AGENTS.md` as your source of truth, Zed will use it automatically alongside Cursor, Copilot, Cline, and Codex.

If you prefer the Zed-native `.rules` format, you can create a symlink:
```bash
ln -sf AGENTS.md .rules
```
