# Cursor Configuration Guide

## Overview

Cursor supports multiple rule levels:
1. **User Rules**: Global settings in Cursor preferences
2. **Project Rules**: `.cursor/rules/*.mdc` files (recommended)
3. **Legacy**: `.cursorrules` single file in project root (still supported)
4. **AGENTS.md**: Read natively from project root

## Setup

### Recommended: Multi-File Rules (.mdc)
1. Create `.cursor/rules/` directory in your project root
2. Copy the `.mdc` files from this folder
3. Customize the content for your project

### Legacy: Single File
1. Copy `.cursorrules` to your project root
2. Customize for your project

## .mdc File Format

Each `.mdc` file has YAML frontmatter + Markdown body:

```
---
description: Human-readable description
globs: "**/*.tsx"
alwaysApply: true
---

# Rule Title
Your rules in Markdown here...
```

### Rule Types
| Type | Config | When Active |
|------|--------|-------------|
| Always-On | `alwaysApply: true` | Every conversation |
| Glob-Based | `globs: "pattern"` | When matching files are in context |
| Manual | No globs, no alwaysApply | Only when @-mentioned |

### Naming Convention
- `000-099`: Core rules (alwaysApply: true)
- `100-199`: Glob-based rules (file-type specific)
- `200-299`: Manual/workflow rules

## File Structure

```
your-project/
├── .cursor/
│   └── rules/
│       ├── 000-core-principles.mdc    # Always active
│       ├── 001-code-style.mdc         # Always active
│       ├── 002-security.mdc           # Always active
│       ├── 003-workflow.mdc           # Always active
│       ├── 100-testing.mdc            # Active for test files
│       ├── 101-react-patterns.mdc     # Active for .tsx/.jsx
│       └── 102-python-patterns.mdc    # Active for .py
└── .cursorrules                       # Legacy single-file (optional)
```

## Tips

- Keep each `.mdc` file focused on one topic (~500 tokens max)
- Use glob patterns to auto-activate rules for relevant files
- Cursor also reads AGENTS.md natively from project root
- Use `@ruleName` in chat to manually reference a rule

## Examples

See `examples/` for a complete FocusFlow project configuration.

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates a `.cursorrules` symlink pointing to `AGENTS.md`.
