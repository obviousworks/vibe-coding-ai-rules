# Cline Configuration Guide

## Overview

Cline reads rules from:
1. **VS Code Settings**: Global rules in Cline extension settings
2. **Single file**: `.clinerules` in project root
3. **Multi-file**: `.clinerules/` folder with numbered Markdown files
4. **Cross-tool**: Also reads `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `AGENTS.md`

## Setup

### Option A: Single File
1. Copy `.clinerules` to your project root
2. Customize for your project

### Option B: Multi-File (Recommended)
1. Copy the `.clinerules-dir/` folder to your project root
2. **Rename** it to `.clinerules/` (it's stored as `.clinerules-dir/` in this repo to avoid naming conflicts)
3. Customize each file for your project

> **Note**: In this repository, the multi-file variant is stored as `.clinerules-dir/` because `.clinerules` also exists as a single file. When copying to your project, use only ONE approach and name it `.clinerules` (either as file or folder).

## File Format

- Plain Markdown files
- Numeric prefixes control loading order (01-, 02-, etc.)
- Optional YAML frontmatter for conditional activation:

```yaml
---
globs: "**/*.tsx"
---
```

## File Structure

### Single File
```
your-project/
└── .clinerules              # All rules in one file
```

### Multi-File (Recommended)
```
your-project/
└── .clinerules/
    ├── 01-core-principles.md
    ├── 02-code-style.md
    ├── 03-security.md
    ├── 04-workflow.md
    └── 05-testing.md
```

## Tips

- Cline reads many other IDE config files natively — you may not need a separate `.clinerules`
- Numeric prefixes ensure consistent loading order
- Use YAML frontmatter with globs for file-type-specific rules
- Keep each file focused on one topic

## Examples

See `examples/` for a complete FocusFlow project configuration (both single-file and multi-file variants).

## Cross-IDE Compatibility

To use the same rules across IDEs, create an `AGENTS.md` and run:
```bash
../../scripts/symlink-setup.sh
```
This creates a `.clinerules` symlink pointing to `AGENTS.md`.
