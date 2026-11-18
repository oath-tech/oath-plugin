#!/usr/bin/env bash
# Fails if a file in this repo holds a word that must never be public.
# Generic patterns are below. A longer list (names, test clients) is kept private and is
# passed in OATH_BLOCKED_WORDS, one extended regex per line.
set -euo pipefail
root="${1:-.}"
patterns=$(cat <<'P'
vercel\.app
TX-[0-9]+
clickup\.com
localhost
ngrok
(^|[^a-z])preview([^a-z]|$)
(^|[^a-z])staging([^a-z]|$)
@@[A-Z_]+@@
P
)
if [ -n "${OATH_BLOCKED_WORDS:-}" ]; then
  patterns="$patterns"$'\n'"$OATH_BLOCKED_WORDS"
fi
found=0
while IFS= read -r p; do
  [ -z "$p" ] && continue
  if hits=$(grep -rniE --exclude-dir=.git --exclude=check-words.sh -- "$p" "$root"); then
    echo "Blocked word ($p):"; echo "$hits" | sed 's/^/  /'; found=1
  fi
done <<< "$patterns"
if [ "$found" = 1 ]; then echo "check-words: FAILED"; exit 1; fi
echo "check-words: clean"
