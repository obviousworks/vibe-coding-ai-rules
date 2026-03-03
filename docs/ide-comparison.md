# AI IDE Comparison: Rules & Configuration

A detailed comparison of how the top AI coding IDEs handle rule configuration, context management, and customization.

## Feature Matrix

| Feature | Cursor | Windsurf | GitHub Copilot | Claude Code | Cline | Codex |
|---------|--------|----------|----------------|-------------|-------|-------|
| **Config file** | `.cursor/rules/*.mdc` | `.windsurfrules` | `.github/copilot-instructions.md` | `CLAUDE.md` | `.clinerules` | `AGENTS.md` |
| **Multi-file support** | ✅ (.mdc per rule) | ❌ (single file) | ✅ (.instructions.md) | ✅ (.claude/rules/) | ✅ (.clinerules/) | ✅ (dir-based) |
| **Glob/path filtering** | ✅ (globs in YAML) | ❌ | ✅ (applyTo) | ❌ (directory-based) | ✅ (YAML frontmatter) | ❌ |
| **Global rules** | ✅ (User Rules) | ✅ (global_rules.md) | ✅ (VS Code settings) | ✅ (~/.claude/CLAUDE.md) | ✅ (VS Code settings) | ✅ (~/.codex/AGENTS.md) |
| **AGENTS.md support** | ✅ native | ❌ (manual) | ✅ (detected) | ❌ (manual) | ✅ (reads it) | ✅ native |
| **Hierarchy levels** | User > Project > Rule | Global > Project | Repo > Directory | User > Project > Dir | Global > Workspace | Global > Project > Dir |
| **Format** | YAML frontmatter + MD | Plain Markdown | YAML frontmatter + MD | Plain Markdown | Plain MD / YAML+MD | Plain Markdown |
| **Max recommended size** | ~500 tokens per .mdc | ~6000 chars global | No hard limit | No hard limit | No hard limit | 32 KiB default |
| **Legacy file** | `.cursorrules` | - | - | - | - | - |

## How Each IDE Loads Rules

### Cursor
1. **User Rules**: Set in Cursor Settings → General → "Rules for AI"
2. **Project Rules (.mdc)**: Loaded from `.cursor/rules/` directory
   - `alwaysApply: true` → Always included in context
   - `globs: ["*.tsx"]` → Auto-activated when matching files are open
   - No flags → Only when explicitly @-mentioned
3. **Legacy (.cursorrules)**: Single file in project root, always loaded
4. **AGENTS.md**: Read natively from project root

**Loading order**: User Rules → .cursorrules → .cursor/rules/*.mdc (filtered by context)

### Windsurf
1. **Global Rules**: Configured in Windsurf Settings → AI Settings → Global Rules
   - Applied to ALL projects (max ~6000 characters)
2. **Project Rules (.windsurfrules)**: Single file in project root
   - Always loaded for the project
   - Plain Markdown format

**Loading order**: Global Rules → .windsurfrules

### GitHub Copilot
1. **Repository Instructions**: `.github/copilot-instructions.md` (always active)
2. **Path-specific**: `.github/instructions/*.instructions.md` with `applyTo` frontmatter
3. **AGENTS.md**: Detected and read from project root
4. **VS Code Settings**: `github.copilot.chat.codeGeneration.instructions` in settings.json

**Loading order**: VS Code Settings → Repository Instructions → Path-specific (filtered)

### Claude Code
1. **User-global**: `~/.claude/CLAUDE.md` (personal rules across all projects)
2. **Project root**: `./CLAUDE.md` (project-level rules)
3. **Modular rules**: `./.claude/rules/*.md` (topic-specific rules)
4. **Directory-specific**: `./subfolder/CLAUDE.md` (scoped overrides)

**Loading order**: User-global → Project CLAUDE.md → .claude/rules/ → Directory CLAUDE.md

**Key behavior**: CLAUDE.md content is treated as immutable system rules with higher priority than user chat input.

### Cline
1. **VS Code Settings**: Global rules in Cline extension settings
2. **Single file**: `.clinerules` in project root
3. **Multi-file**: `.clinerules/` folder with numbered Markdown files
4. **Cross-tool**: Also reads `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `AGENTS.md`

**Loading order**: VS Code Settings → .clinerules(/) → Cross-tool files (if present)

### OpenAI Codex
1. **Global scope**: `~/.codex/AGENTS.override.md` → `~/.codex/AGENTS.md`
2. **Project scope**: `AGENTS.md` from Git root down to current working directory
3. **Override**: `AGENTS.override.md` takes precedence at each level
4. **Config**: `~/.codex/config.toml` for discovery settings

**Loading order**: Global AGENTS.md → Project root AGENTS.md → Subdirectory AGENTS.md (concatenated)

## Cross-IDE Compatibility

Which IDE reads which file natively?

| File | Cursor | Windsurf | Copilot | Claude Code | Cline | Codex |
|------|--------|----------|---------|-------------|-------|-------|
| `AGENTS.md` | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ |
| `.cursorrules` | ✅ | ❌ | ❌ | ❌ | ✅ | ❌ |
| `.windsurfrules` | ❌ | ✅ | ❌ | ❌ | ✅ | ❌ |
| `CLAUDE.md` | ❌ | ❌ | ❌ | ✅ | ✅ | ❌ |
| `.clinerules` | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| `.github/copilot-instructions.md` | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ |
| `.cursor/rules/*.mdc` | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `.claude/rules/*.md` | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ |

**Key insight**: Cline is the most compatible, reading multiple formats natively. Using AGENTS.md gives you the broadest native support (Cursor, Copilot, Cline, Codex).

## Recommendations

### For Solo Developers
- **Using one IDE**: Use that IDE's native format for full feature support
- **Switching between IDEs**: Use AGENTS.md with symlinks

### For Teams (Mixed IDEs)
- **Best approach**: Maintain AGENTS.md as source of truth + symlinks
- **Advanced**: AGENTS.md for universal rules + IDE-specific files for advanced features

### For Open Source Projects
- **Must have**: AGENTS.md (broadest compatibility)
- **Nice to have**: `.github/copilot-instructions.md` (GitHub integration)
- **Optional**: `.cursor/rules/` for Cursor-specific features

### By Project Complexity
- **Simple projects**: Single AGENTS.md file is sufficient
- **Medium projects**: AGENTS.md + one IDE-specific config
- **Complex monorepos**: Hierarchical AGENTS.md + IDE-specific modular rules

---

**See also**: [Migration Guide](migration-guide.md) for step-by-step migration instructions between IDEs.
