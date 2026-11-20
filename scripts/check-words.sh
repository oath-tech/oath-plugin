#!/usr/bin/env bash
# Fails if this repo holds a word that must never be public.
#
#   scripts/check-words.sh [folder]   checks every file in the folder, and its file names
#   scripts/check-words.sh --stdin    checks the text on standard input (a pull request's
#                                     title, body or commit messages)
#
# Generic patterns are below. A longer list (names, test clients) is kept private and is
# passed in OATH_BLOCKED_WORDS, one extended regex per line. Set OATH_REQUIRE_PRIVATE=1 to
# fail when that list is missing.
#
# A hit prints the file, the line number and the pattern's number. It never prints the
# pattern or the line: the log of a public run must not show the private list.
set -euo pipefail

builtin=$(cat <<'P'
vercel\.app
TX[- ]?[0-9]+
clickup\.com
localhost
ngrok
(^|[^a-z])preview([^a-z]|$)
(^|[^a-z])staging([^a-z]|$)
@@[A-Z_]+@@
P
)

fail() { echo "check-words: FAILED: $*"; exit 1; }

private=$(printf '%s' "${OATH_BLOCKED_WORDS:-}" | tr -d '\r')
if [ -z "$(printf '%s' "$private" | tr -d '[:space:]')" ]; then
  private=""
  if [ "${OATH_REQUIRE_PRIVATE:-0}" = 1 ]; then
    fail "the private list is empty, and this run requires it"
  fi
  echo "check-words: no private list, generic patterns only"
fi

patterns=()
while IFS= read -r p; do
  [ -n "$p" ] && patterns+=("$p")
done <<< "$builtin"$'\n'"$private"

# Every pattern must be a valid expression. grep exits 2 on a bad one, which must never
# read as "no hit".
n=0
for p in "${patterns[@]}"; do
  n=$((n + 1))
  rc=0
  printf '' | grep -qiE -- "$p" || rc=$?
  [ "$rc" -le 1 ] || fail "pattern $n is not a valid expression"
done

# The check must be able to find a word it knows. If this fails, the check is broken.
printf 'see app.vercel.app\n' | grep -qiE -- "${patterns[0]}" \
  || fail "the self-test found nothing"

work=""
cleanup() { [ -n "$work" ] && rm -rf "$work"; return 0; }
trap cleanup EXIT

if [ "${1:-}" = "--stdin" ]; then
  work=$(mktemp -d)
  cat > "$work/text"
  root="$work"
  self=""
else
  root="${1:-.}"
  self="$root/scripts/check-words.sh"
fi

# A link could point outside the repo, and its target is not checked.
links=$(find "$root" -type l -not -path '*/.git/*' | sed "s|^$root/||")
[ -z "$links" ] || { echo "$links" | sed 's/^/  /'; fail "links are not allowed"; }

files=()
while IFS= read -r f; do
  [ "$f" = "$self" ] && continue
  files+=("$f")
done < <(find "$root" -type f -not -path '*/.git/*' | LC_ALL=C sort)

found=0

# Only plain UTF-8 text is allowed, apart from the icon. Another encoding, or a
# character nobody can see, would hide a word from the patterns.
for f in "${files[@]}"; do
  rel="${f#"$root"/}"
  [ "$rel" = "plugin/icon.png" ] && continue
  if ! iconv -f UTF-8 -t UTF-8 "$f" > /dev/null 2>&1; then
    echo "  $rel: not UTF-8 text"; found=1; continue
  fi
  if [ "$(LC_ALL=C tr -d '\000' < "$f" | wc -c)" != "$(wc -c < "$f")" ]; then
    echo "  $rel: holds a NUL byte"; found=1; continue
  fi
  if ! perl -CSD -ne 'exit 1 if /[\x{200B}-\x{200D}\x{2060}\x{FEFF}]/' "$f"; then
    echo "  $rel: holds a character that cannot be seen"; found=1
  fi
done

names=$(printf '%s\n' "${files[@]}" | sed "s|^$root/||")
n=0
for p in "${patterns[@]}"; do
  n=$((n + 1))
  rc=0
  hits=$(grep -HnaiE -- "$p" "${files[@]}" 2>/dev/null) || rc=$?
  [ "$rc" -le 1 ] || fail "pattern $n could not be run"
  if [ -n "$hits" ]; then
    echo "Blocked word, pattern $n:"
    echo "$hits" | cut -d: -f1,2 | sed "s|^$root/||; s/^/  /"
    found=1
  fi
  if echo "$names" | grep -qiE -- "$p"; then
    echo "Blocked word, pattern $n, in a file name"
    found=1
  fi
done

[ "$found" = 0 ] || fail "see above"
echo "check-words: clean"
