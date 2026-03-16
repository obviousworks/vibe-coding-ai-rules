# Contributing to Vibe Coding AI Rules

Thank you for your interest in contributing! This project aims to be the definitive resource for AI coding assistant configurations across all major IDEs.

## How to Contribute

### Adding or Improving Rules

1. **Fork** the repository
2. **Create a feature branch**: `feature/improve-security-rules`
3. **Make your changes** following the guidelines below
4. **Submit a Pull Request** with a clear description

### Content Sync Requirement

**Important**: When modifying rule content, ensure consistency across ALL IDE formats. The same core rules should be reflected in:

- `ide-specific/cursor/.cursor/rules/*.mdc`
- `ide-specific/windsurf/.windsurfrules`
- `ide-specific/github-copilot/.github/instructions/*.instructions.md`
- `ide-specific/claude-code/CLAUDE.md` + `.claude/rules/*.md`
- `ide-specific/cline/.clinerules/`
- `ide-specific/codex/AGENTS.md`
- `ide-specific/zed/.rules`
- `ide-specific/gemini-cli/GEMINI.md`
- `ide-specific/aider/conventions.md`
- `ide-specific/continue/.continue/rules/*.md`

Only the **format** differs per IDE — the **content and rules** should be equivalent.

### Adding Support for a New IDE

1. Create a new directory: `ide-specific/[ide-name]/`
2. Add a `README.md` with setup instructions
3. Create template files in the IDE's native format
4. Add an example using the FocusFlow project
5. Update `docs/ide-comparison.md` with the new IDE
6. Update `docs/migration-guide.md` with migration paths
7. Update the root `README.md` quick-start table

### Improving Documentation

- Fix typos, improve clarity, add examples
- Keep docs concise and actionable
- Link between related documents
- Use consistent formatting

## Guidelines

### Rule Quality Standards

Rules should be:
- **Specific**: "Use TypeScript strict mode" not "follow best practices"
- **Actionable**: Clear enough for an AI agent to follow
- **Justified**: Include rationale for non-obvious rules
- **Tested**: Verified to work with the target IDE

### File Naming

- Use kebab-case for file names: `security-rules.md`
- Cursor .mdc files: numbered prefix `000-topic-name.mdc`
- Cline files: numbered prefix `01-topic-name.md`

### Commit Messages

Use conventional commit format:
```
type(scope): description

Types: feat, fix, docs, style, refactor, test, chore
Scopes: cursor, windsurf, copilot, claude-code, cline, codex, zed, gemini-cli, aider, continue, docs, templates
```

Examples:
- `feat(cursor): add Python patterns rule file`
- `fix(docs): correct IDE comparison table`
- `docs(readme): update quick-start instructions`

## Pull Request Template

```markdown
## What Changed
- [Brief description of changes]

## IDE Formats Updated
- [ ] Cursor (.mdc)
- [ ] Windsurf (.windsurfrules)
- [ ] GitHub Copilot (.instructions.md)
- [ ] Claude Code (CLAUDE.md / .claude/rules/)
- [ ] Cline (.clinerules/)
- [ ] Codex (AGENTS.md)
- [ ] Zed AI (.rules)
- [ ] Gemini CLI (GEMINI.md)
- [ ] Aider (conventions.md)
- [ ] Continue.dev (.continue/rules/)
- [ ] Templates (AGENTS.md, agent-template.md)

## Testing
- [ ] Verified format is valid for target IDE
- [ ] Content is consistent across all updated formats
- [ ] Links work correctly
- [ ] Examples are complete and accurate
```

## Questions?

Open an [issue](https://github.com/obviousworks/vibe-coding-ai-rules/issues) or start a [discussion](https://github.com/obviousworks/vibe-coding-ai-rules/discussions).
