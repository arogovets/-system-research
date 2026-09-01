#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUPPORT="$HERE/.upstream-support"
COMMIT="1dd0fccf46fc3c9855c4a0c313a0c57fe4319883"
if [[ -d "$SUPPORT/references" && -d "$SUPPORT/assets" ]]; then exit 0; fi
command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone --filter=blob:none --no-checkout https://github.com/K-Dense-AI/scientific-agent-skills.git "$TMP/repo"
git -C "$TMP/repo" checkout --detach "$COMMIT"
SRC="$TMP/repo/skills/scientific-slides"
rm -rf "$SUPPORT"; mkdir -p "$SUPPORT"
cp -R "$SRC/references" "$SRC/assets" "$SRC/scripts" "$SUPPORT/"
printf '%s\n' "$COMMIT" > "$SUPPORT/.upstream-commit"
