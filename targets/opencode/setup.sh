#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST_DIR="${1:-.}"
echo "==> Setting up OpenCode TypeScript Guidelines in: $DEST_DIR"

mkdir -p "$DEST_DIR/.opencode/rules" "$DEST_DIR/.opencode/skills" "$DEST_DIR/.opencode/agents"

# Copy rules
cp -r "$REPO_ROOT/rules/"* "$DEST_DIR/.opencode/rules/"

# Copy skills
for skill in "$REPO_ROOT/skills/"*; do
    if [ -d "$skill" ]; then
        skill_name=$(basename "$skill")
        mkdir -p "$DEST_DIR/.opencode/skills/$skill_name"
        cp -r "$skill"/* "$DEST_DIR/.opencode/skills/$skill_name/"
    fi
done

# Copy custom agents
cp -r "$REPO_ROOT/agents/"* "$DEST_DIR/.opencode/agents/"

# Copy AGENTS.md inside .opencode/
cp "$REPO_ROOT/targets/opencode/AGENTS.md" "$DEST_DIR/.opencode/AGENTS.md"

echo " OpenCode environment configured successfully!"
