#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNTIME="$HERE/.runtime"
COMMIT="199360cc6687a7857b54dd188d4922b09e466a4b"
if [[ -f "$RUNTIME/bin/archify.mjs" ]]; then exit 0; fi
command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone --filter=blob:none --no-checkout https://github.com/tt-a1i/archify.git "$TMP/repo"
git -C "$TMP/repo" checkout --detach "$COMMIT"
rm -rf "$RUNTIME"
cp -R "$TMP/repo/archify" "$RUNTIME"
printf '%s\n' "$COMMIT" > "$RUNTIME/.upstream-commit"
