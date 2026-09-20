#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

CMD="${1:-help}"

usage() {
    cat <<EOF
Usage: ./sync.sh <command|target> [args...]

Available targets (Deploy):
  antigravity [dest]  Deploy to Antigravity (.agents/{skills,rules,agents,AGENTS.md})
  opencode    [dest]  Deploy to OpenCode (.opencode/{rules,skills,agents,AGENTS.md})
  kilocode    [dest]  Deploy to Kilo Code (.kilo/{rules,skills,agents,AGENTS.md} & kilo.jsonc)
  cursor      [dest]  Deploy to Cursor (.cursor/rules/*.mdc, .cursor/{skills,agents})
  claude      [dest]  Deploy to Claude Code (.claude/{rules,skills,agents} & CLAUDE.md)
  copilot     [dest]  Deploy to GitHub Copilot (.github/copilot-instructions.md)
  all         [dest]  Deploy to all targets simultaneously

Utility commands:
  clean <target> [dest] Remove generated guideline files only; preserve user files
  verify                Run automated rule linting and link integrity checks
  find <keyword>        Search rules by keyword
  query <rule-id>       Display full rule content
  list                  List all available atomic rules
  help                  Show this help message

Examples:
  ./sync.sh antigravity
  ./sync.sh cursor /path/to/my-ts-project
  ./sync.sh find union
  ./sync.sh query t-discriminated-unions
  ./sync.sh verify
  ./sync.sh clean antigravity /path/to/my-ts-project
EOF
}

clean_target() {
    local target="$1"
    local dest="${2:-.}"

    clean_guideline_tree() {
        local root="$1"
        local rule
        local skill
        local agent

        for rule in "$REPO_ROOT/rules/"*.md; do
            rm -f "$root/rules/$(basename "$rule")"
        done
        for skill in "$REPO_ROOT/skills/"*; do
            [ -d "$skill" ] || continue
            rm -f "$root/skills/$(basename "$skill")/SKILL.md"
            rmdir "$root/skills/$(basename "$skill")" 2>/dev/null || true
        done
        for agent in "$REPO_ROOT/agents/"*.md; do
            rm -f "$root/agents/$(basename "$agent")"
        done
        rmdir "$root/rules" "$root/skills" "$root/agents" 2>/dev/null || true
        rmdir "$root" 2>/dev/null || true
    }

    remove_matching_file() {
        local generated="$1"
        local installed="$2"
        if [ -f "$installed" ] && cmp -s "$generated" "$installed"; then
            rm -f "$installed"
        fi
    }

    case "$target" in
        antigravity)
            clean_guideline_tree "$dest/.agents"
            remove_matching_file "$REPO_ROOT/targets/antigravity/AGENTS.md" "$dest/.agents/AGENTS.md"
            echo " Removed generated Antigravity guideline files; preserved unrelated files"
            ;;
        opencode)
            clean_guideline_tree "$dest/.opencode"
            remove_matching_file "$REPO_ROOT/targets/opencode/AGENTS.md" "$dest/.opencode/AGENTS.md"
            echo " Removed generated OpenCode guideline files; preserved unrelated files"
            ;;
        kilocode)
            clean_guideline_tree "$dest/.kilo"
            remove_matching_file "$REPO_ROOT/targets/kilocode/AGENTS.md" "$dest/.kilo/AGENTS.md"
            remove_matching_file "$REPO_ROOT/targets/kilocode/kilo.jsonc" "$dest/.kilo/kilo.jsonc"
            echo " Removed generated Kilo guideline files; preserved unrelated files"
            ;;
        cursor)
            for rule in "$REPO_ROOT/rules/"*.md; do
                rm -f "$dest/.cursor/rules/$(basename "$rule" .md).mdc"
            done
            clean_guideline_tree "$dest/.cursor"
            echo " Removed generated Cursor guideline files; preserved unrelated files"
            ;;
        claude)
            clean_guideline_tree "$dest/.claude"
            echo " Removed generated Claude guideline files; preserved CLAUDE.md and unrelated files"
            ;;
        copilot)
            echo " Preserved $dest/.github/copilot-instructions.md; clean cannot safely remove appended user content"
            ;;
        all)
            clean_target antigravity "$dest"
            clean_target opencode "$dest"
            clean_target kilocode "$dest"
            clean_target cursor "$dest"
            clean_target claude "$dest"
            clean_target copilot "$dest"
            echo " Cleaned generated guideline files in $dest without deleting unrelated files"
            ;;
        *)
            echo "Unknown target to clean: $target"
            exit 1
            ;;
    esac
}

find_rules() {
    local query="${1:-}"
    if [ -z "$query" ]; then
        echo "Error: please provide a search term. Example: ./sync.sh find union"
        exit 1
    fi
    echo "==> Searching rules matching: '$query'"
    for f in "$REPO_ROOT/rules/"*.md; do
        rule_name=$(basename "$f" .md)
        if grep -qi "$query" "$f"; then
            desc=$(grep -m 1 '^>' "$f" | sed 's/^>[[:space:]]*//' || echo "")
            printf "  \033[1;32m%-26s\033[0m %s\n" "$rule_name" "$desc"
        fi
    done
}

query_rule() {
    local rule_name="${1:-}"
    if [ -z "$rule_name" ]; then
        echo "Error: please specify a rule name. Example: ./sync.sh query t-no-any"
        exit 1
    fi
    # Strip extension if passed
    rule_name="${rule_name%.md}"
    local target="$REPO_ROOT/rules/${rule_name}.md"
    if [ -f "$target" ]; then
        cat "$target"
    else
        echo "Error: Rule '$rule_name' not found in $REPO_ROOT/rules/"
        exit 1
    fi
}

list_rules() {
    echo "==> Available TypeScript AI Atomic Rules:"
    for f in "$REPO_ROOT/rules/"*.md; do
        rule_name=$(basename "$f" .md)
        desc=$(grep -m 1 '^>' "$f" | sed 's/^>[[:space:]]*//' || echo "")
        printf "  \033[1;36m%-26s\033[0m %s\n" "$rule_name" "$desc"
    done
}

case "$CMD" in
    antigravity)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/antigravity/setup.sh" "$DEST"
        ;;
    opencode)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/opencode/setup.sh" "$DEST"
        ;;
    kilocode)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/kilocode/setup.sh" "$DEST"
        ;;
    cursor)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/cursor/setup.sh" "$DEST"
        ;;
    claude)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/claude/setup.sh" "$DEST"
        ;;
    copilot)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/copilot/setup.sh" "$DEST"
        ;;
    all)
        DEST="${2:-.}"
        bash "$REPO_ROOT/targets/antigravity/setup.sh" "$DEST"
        bash "$REPO_ROOT/targets/opencode/setup.sh" "$DEST"
        bash "$REPO_ROOT/targets/kilocode/setup.sh" "$DEST"
        bash "$REPO_ROOT/targets/cursor/setup.sh" "$DEST"
        bash "$REPO_ROOT/targets/claude/setup.sh" "$DEST"
        bash "$REPO_ROOT/targets/copilot/setup.sh" "$DEST"
        echo " All targets synchronized successfully in $DEST!"
        ;;
    clean)
        TARGET_TO_CLEAN="${2:-all}"
        DEST="${3:-.}"
        clean_target "$TARGET_TO_CLEAN" "$DEST"
        ;;
    verify)
        python3 "$REPO_ROOT/scripts/verify.py"
        ;;
    find|search)
        find_rules "${2:-}"
        ;;
    query|cat|get)
        query_rule "${2:-}"
        ;;
    list)
        list_rules
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo "Unknown command or target: $CMD"
        usage
        exit 1
        ;;
esac
