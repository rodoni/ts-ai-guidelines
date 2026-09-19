#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST_DIR="${1:-.}"
echo "==> Setting up Kilo Code TypeScript Guidelines in: $DEST_DIR"

mkdir -p "$DEST_DIR/.kilo/rules" "$DEST_DIR/.kilo/skills" "$DEST_DIR/.kilo/agents"

# Copy rules
cp -r "$REPO_ROOT/rules/"* "$DEST_DIR/.kilo/rules/"

# Copy skills
for skill in "$REPO_ROOT/skills/"*; do
    if [ -d "$skill" ]; then
        skill_name=$(basename "$skill")
        mkdir -p "$DEST_DIR/.kilo/skills/$skill_name"
        cp -r "$skill"/* "$DEST_DIR/.kilo/skills/$skill_name/"
    fi
done

# Copy custom agents
cp -r "$REPO_ROOT/agents/"* "$DEST_DIR/.kilo/agents/"

# Copy config and AGENTS.md inside .kilo/
cp "$REPO_ROOT/targets/kilocode/AGENTS.md" "$DEST_DIR/.kilo/AGENTS.md"
cp "$REPO_ROOT/targets/kilocode/kilo.jsonc" "$DEST_DIR/.kilo/kilo.jsonc"

echo " Kilo Code environment configured successfully!"
