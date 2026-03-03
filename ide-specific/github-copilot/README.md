# GitHub Copilot Configuration Guide

## Overview

GitHub Copilot reads instructions from:
1. **Main Instructions**: `.github/copilot-instructions.md` — always active
2. **Path-Specific Instructions**: `.github/instructions/*.instructions.md` — with `applyTo` patterns
3. **AGENTS.md**: Detected natively from project root

## Setup

1. Create `.github/` directory in your project root
2. Copy `copilot-instructions.md` into `.github/`
3. Copy the `instructions/` folder into `.github/`
4. Customize the content for your project

## .instructions.md File Format

Each instruction file uses YAML frontmatter with `applyTo`:

```yaml
---
applyTo: "**/*.tsx"
---

Your instructions in Markdown here...
```

### Key Points
- `applyTo`: Glob pattern for automatic activation
- If no `applyTo`: Instructions are always active
- Copilot also detects AGENTS.md in your project root
- Use `/init` in Copilot Chat to auto-generate instructions from your project

## File Structure

```
your-project/
├── .github/
│   ├── copilot-instructions.md           # Main instructions (always active)
│   └── instructions/
│       ├── code-style.instructions.md    # All files
│       ├── security.instructions.md      # All files
│       ├── testing.instructions.md       # Test files only
│       ├── react.instructions.md         # .tsx/.jsx only
│       └── python.instructions.md        # .py only
└── AGENTS.md                             # Also read by Copilot
```

## Tips

- Keep main `copilot-instructions.md` focused on project overview and core rules
- Use `instructions/` folder for topic-specific and file-type-specific rules
- Copilot reads AGENTS.md natively — you can use that as your single source of truth
- The `/init` command can bootstrap instructions from your existing codebase

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates `.github/copilot-instructions.md` as a symlink to `AGENTS.md`.
