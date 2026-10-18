#!/usr/bin/env bash
# Claude Code Team Kit installer.
# Copies the kit's skills (and starter files) into a target repository.
# Never overwrites existing files unless --force is given.
#
# Usage: ./install.sh <target-repo> [--force]
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET=""
FORCE=0

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    -h|--help)
      sed -n '2,7p' "$0"; exit 0 ;;
    *) TARGET="$arg" ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 <target-repo> [--force]" >&2
  exit 1
fi
if [[ ! -d "$TARGET" ]]; then
  echo "Target '$TARGET' is not a directory." >&2
  exit 1
fi
TARGET="$(cd "$TARGET" && pwd)"

copied=0; skipped=0

copy_file() { # src dest
  local src="$1" dest="$2"
  if [[ -e "$dest" && $FORCE -eq 0 ]]; then
    echo "  skip   ${dest#"$TARGET"/} (exists; use --force to overwrite)"
    skipped=$((skipped+1))
    return
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  echo "  add    ${dest#"$TARGET"/}"
  copied=$((copied+1))
}

copy_tree() { # src-dir dest-dir
  local src="$1" dest="$2"
  [[ -d "$src" ]] || return 0
  while IFS= read -r -d '' f; do
    copy_file "$f" "$dest/${f#"$src"/}"
  done < <(find "$src" -type f -print0)
}

echo "Installing Claude Code Team Kit into $TARGET"
copy_tree "$KIT_DIR/.claude/skills" "$TARGET/.claude/skills"
copy_file "$KIT_DIR/.claude/settings.json" "$TARGET/.claude/settings.json"
copy_file "$KIT_DIR/CLAUDE.md" "$TARGET/CLAUDE.md"

echo
echo "Done: $copied added, $skipped skipped."
echo "Next: fill in the <placeholders> in CLAUDE.md, then start 'claude' in the repo and type '/'."
