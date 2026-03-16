#!/bin/bash
# Symlink Setup: Create IDE-specific files from a single AGENTS.md
#
# Usage: ./scripts/symlink-setup.sh
#
# This script creates symlinks from your AGENTS.md to all supported IDE formats.
# Run this in your PROJECT ROOT (where AGENTS.md lives).

set -e

if [ ! -f "AGENTS.md" ]; then
    echo "Error: AGENTS.md not found in current directory."
    echo "Please create AGENTS.md first, then run this script."
    echo ""
    echo "Quick start:"
    echo "  cp path/to/vibe-coding-ai-rules/templates/agent-template.md AGENTS.md"
    echo "  # Edit AGENTS.md for your project"
    echo "  ./scripts/symlink-setup.sh"
    exit 1
fi

echo "Creating symlinks from AGENTS.md..."
echo ""

# Windsurf
ln -sf AGENTS.md .windsurfrules
echo "  ✓ .windsurfrules → AGENTS.md"

# Cursor (legacy single-file)
ln -sf AGENTS.md .cursorrules
echo "  ✓ .cursorrules → AGENTS.md"

# Claude Code
ln -sf AGENTS.md CLAUDE.md
echo "  ✓ CLAUDE.md → AGENTS.md"

# Cline
ln -sf AGENTS.md .clinerules
echo "  ✓ .clinerules → AGENTS.md"

# Gemini CLI
ln -sf AGENTS.md GEMINI.md
echo "  ✓ GEMINI.md → AGENTS.md"

# GitHub Copilot (needs .github/ directory)
mkdir -p .github
ln -sf ../AGENTS.md .github/copilot-instructions.md
echo "  ✓ .github/copilot-instructions.md → AGENTS.md"

echo ""
echo "Done! All IDE-specific files now point to AGENTS.md."
echo "Edit AGENTS.md and all IDEs will use the same rules."
echo ""
echo "Supported IDEs:"
echo "  • Cursor      → reads .cursorrules + AGENTS.md natively"
echo "  • Windsurf    → reads .windsurfrules"
echo "  • Claude Code → reads CLAUDE.md"
echo "  • Cline       → reads .clinerules + AGENTS.md"
echo "  • Codex       → reads AGENTS.md natively (no symlink needed)"
echo "  • Zed AI      → reads AGENTS.md natively (no symlink needed)"
echo "  • Gemini CLI  → reads GEMINI.md + AGENTS.md"
echo "  • Aider       → reads AGENTS.md natively (no symlink needed)"
echo "  • Continue    → uses .continue/rules/ (copy rules manually)"
echo "  • GitHub Copilot → reads .github/copilot-instructions.md + AGENTS.md"
echo ""
echo "Tip: Add these symlinks to your .gitignore if you prefer"
echo "     to only track AGENTS.md in version control."
