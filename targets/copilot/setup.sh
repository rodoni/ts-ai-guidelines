#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST_DIR="${1:-.}"
echo "==> Setting up GitHub Copilot TypeScript Guidelines in: $DEST_DIR"

mkdir -p "$DEST_DIR/.github"

if [ ! -f "$DEST_DIR/.github/copilot-instructions.md" ]; then
    cp "$REPO_ROOT/targets/copilot/copilot-instructions.md" "$DEST_DIR/.github/copilot-instructions.md"
    echo " Created $DEST_DIR/.github/copilot-instructions.md"
else
    if ! grep -q "GitHub Copilot TypeScript Guidelines" "$DEST_DIR/.github/copilot-instructions.md"; then
        echo "" >> "$DEST_DIR/.github/copilot-instructions.md"
        cat "$REPO_ROOT/targets/copilot/copilot-instructions.md" >> "$DEST_DIR/.github/copilot-instructions.md"
        echo " Appended TypeScript AI Guidelines to existing $DEST_DIR/.github/copilot-instructions.md"
    else
        echo "ℹ️  Existing $DEST_DIR/.github/copilot-instructions.md already includes TypeScript AI Guidelines"
    fi
fi

echo " GitHub Copilot environment configured successfully!"
