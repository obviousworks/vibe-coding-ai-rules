# Migration Guide: AI IDE Rule Configurations

How to migrate your AI coding rules between different IDEs and configuration formats.

## Overview

Different AI IDEs use different file formats for their configuration. This guide helps you:
- Migrate from one IDE to another
- Support multiple IDEs simultaneously
- Use the universal AGENTS.md standard as a single source of truth

## Quick Migration Matrix

| From \ To | Cursor | Windsurf | GitHub Copilot | Claude Code | Cline | Codex |
|-----------|--------|----------|----------------|-------------|-------|-------|
| **Cursor** | - | Copy content | Reformat YAML | Remove frontmatter | Copy as-is | Remove frontmatter |
| **Windsurf** | Add YAML frontmatter | - | Add applyTo | Copy as-is | Copy as-is | Copy as-is |
| **GitHub Copilot** | Convert applyTo to globs | Remove applyTo | - | Remove frontmatter | Copy as-is | Remove frontmatter |
| **Claude Code** | Add YAML frontmatter | Copy as-is | Add applyTo | - | Copy as-is | Copy as-is |
| **Cline** | Add YAML frontmatter | Copy as-is | Add applyTo | Copy as-is | - | Copy as-is |
| **Codex** | Add YAML frontmatter | Copy as-is | Add applyTo | Copy as-is | Copy as-is | - |

## Strategy 1: Universal AGENTS.md (Recommended)

The simplest approach is to maintain a single AGENTS.md file and create symlinks:

```bash
# Create your universal configuration
cp templates/agent-template.md AGENTS.md
# Customize AGENTS.md for your project

# Create symlinks for all IDEs
ln -sf AGENTS.md .windsurfrules      # Windsurf
ln -sf AGENTS.md .cursorrules        # Cursor (legacy)
ln -sf AGENTS.md CLAUDE.md           # Claude Code
ln -sf AGENTS.md .clinerules         # Cline
# Codex reads AGENTS.md natively — no symlink needed

# GitHub Copilot (needs .github/ directory)
mkdir -p .github
ln -sf ../AGENTS.md .github/copilot-instructions.md
```

**Pros:**
- Single source of truth
- Edit once, all IDEs updated
- No content drift between formats

**Cons:**
- Cannot use IDE-specific features (globs, YAML frontmatter)
- One-size-fits-all format

## Strategy 2: IDE-Optimized Files

Use each IDE's native format for maximum capability:

### Cursor: Multi-File .mdc Rules
```
.cursor/rules/
├── 000-core-principles.mdc   # alwaysApply: true
├── 001-code-style.mdc        # alwaysApply: true
├── 002-security.mdc          # alwaysApply: true
├── 100-testing.mdc           # globs: ["**/*.test.*"]
└── 101-react-patterns.mdc    # globs: ["**/*.tsx"]
```

### Windsurf: Two-Tier System
```
global_rules.md    → Windsurf Settings → AI Settings
.windsurfrules     → Project root
```

### GitHub Copilot: Instructions with applyTo
```
.github/
├── copilot-instructions.md          # Always active
└── instructions/
    ├── testing.instructions.md      # applyTo: "**/*.test.*"
    └── react.instructions.md        # applyTo: "**/*.tsx"
```

### Claude Code: CLAUDE.md Hierarchy
```
CLAUDE.md              → Project root (highest priority)
.claude/rules/*.md     → Modular rules
subfolder/CLAUDE.md    → Directory-specific overrides
```

### Cline: Numbered Files
```
.clinerules/
├── 01-core-principles.md
├── 02-code-style.md
├── 03-security.md
└── 04-testing.md
```

### Codex: AGENTS.md
```
AGENTS.md              → Project root (read natively)
subfolder/AGENTS.md    → Directory-specific overrides
~/.codex/AGENTS.md     → Global defaults
```

## Migrating: Step by Step

### From Windsurf to Cursor

1. **Take your `.windsurfrules` content**
2. **Split into separate .mdc files** by topic (core, style, security, testing)
3. **Add YAML frontmatter** to each file:
   ```yaml
   ---
   description: Core coding principles
   alwaysApply: true
   ---
   ```
4. **For file-specific rules**, add glob patterns:
   ```yaml
   ---
   description: React patterns
   globs: ["**/*.tsx", "**/*.jsx"]
   alwaysApply: false
   ---
   ```
5. **Place files** in `.cursor/rules/` directory

### From Cursor to Windsurf

1. **Combine all .mdc file contents** into one document
2. **Remove YAML frontmatter** from each section
3. **Organize with Markdown headers** instead of separate files
4. **Save as `.windsurfrules`** in project root
5. **Move global rules** to Windsurf Settings → AI Settings

### From Any IDE to GitHub Copilot

1. **Create `.github/` directory**
2. **Main rules** → `.github/copilot-instructions.md`
3. **File-specific rules** → `.github/instructions/[topic].instructions.md`
4. **Add `applyTo` frontmatter** for file-type-specific rules:
   ```yaml
   ---
   applyTo: "**/*.tsx,**/*.jsx"
   ---
   ```

### From Any IDE to Claude Code

1. **Create `CLAUDE.md`** in project root with core rules
2. **Create `.claude/rules/`** directory for modular rules
3. **Keep rules concise** - Claude Code treats every line as a strong directive
4. **No YAML frontmatter** needed - pure Markdown
5. **Use directory-based CLAUDE.md** for scoped rules instead of globs

### From Any IDE to Cline

1. **Create `.clinerules/`** directory
2. **Split rules into numbered files** (01-, 02-, etc.)
3. **Pure Markdown** format (no frontmatter needed)
4. **Cline also reads** .cursorrules, CLAUDE.md, .windsurfrules, AGENTS.md

## Supporting Multiple IDEs Simultaneously

Add these files to `.gitignore` (the symlink targets):
```gitignore
# Don't need to track symlinks if using AGENTS.md approach
# .cursorrules
# .clinerules
# .rules
# CLAUDE.md
```

Or commit all files for teams using different IDEs:
```
project-root/
├── AGENTS.md                        # Universal (Cursor, Codex, Aider)
├── .windsurfrules → AGENTS.md       # Windsurf
├── .cursorrules → AGENTS.md         # Cursor legacy
├── CLAUDE.md → AGENTS.md            # Claude Code
├── .clinerules → AGENTS.md          # Cline
│                                    # Codex reads AGENTS.md natively
├── .github/
│   └── copilot-instructions.md → ../AGENTS.md  # GitHub Copilot
├── .cursor/rules/                   # Cursor advanced (optional)
│   ├── 000-core.mdc
│   └── 100-testing.mdc
└── .claude/rules/                   # Claude Code modular (optional)
    ├── security.md
    └── testing.md
```

## Format Comparison

| Feature | Cursor .mdc | Windsurf | Copilot | Claude Code | Cline | Codex |
|---------|------------|----------|---------|-------------|-------|-----|
| YAML frontmatter | Required | No | Optional | No | Optional | No |
| Glob patterns | ✅ `globs:` | ❌ | ✅ `applyTo:` | ❌ | ✅ `globs:` | ❌ |
| Multi-file | ✅ `.cursor/rules/` | ❌ | ✅ `instructions/` | ✅ `.claude/rules/` | ✅ `.clinerules/` | ❌ |
| Hierarchy | User > Project > Rule | Global > Project | Repo > Dir | User > Project > Dir | Global > Workspace | User > Project |
| Max size | ~500 tokens/file | ~6000 chars global | No limit | No limit | No limit | No limit |

## Tips for Smooth Migration

1. **Start with AGENTS.md**: Get your content right in one place first
2. **Test incrementally**: Migrate one IDE at a time
3. **Verify behavior**: Ask AI a standard question to verify rules are loaded
4. **Keep content synced**: If using separate files, sync content regularly
5. **Use symlinks**: Simplest way to support multiple IDEs from one source

---

**Need help?** Use our [adaptation prompt](../prompts/adapt-rules-prompt.txt) to generate IDE-specific configurations from your AGENTS.md.
