#!/usr/bin/env bash
# Scan the repository for private material.
# Usage: tools/privacy-scan.sh [--history] [--range <rev-range>] [--allow <file>]
#   --history        also scan every commit message and diff on all refs
#   --range <r>      also scan commit messages and diffs in this range (used by the pre-push hook)
#   --allow <file>   fixed strings (one per line) accepted as known history; keep this file OUTSIDE the repo
# The denylist (regular expressions, one per line) lives outside the repository:
#   BETTERPAPER_DENYLIST=/path/to/denylist.txt   (default ../betterpaper-private/denylist.txt)
set -u
DL="${BETTERPAPER_DENYLIST:-../betterpaper-private/denylist.txt}"
[ -r "$DL" ] || { echo "privacy-scan: denylist not found at $DL (set BETTERPAPER_DENYLIST)"; exit 2; }
HIST=0; RANGE=""; ALLOW=""
while [ $# -gt 0 ]; do
  case "$1" in
    --history) HIST=1;;
    --range) shift; RANGE="${1:-}";;
    --allow) shift; ALLOW="${1:-}";;
  esac; shift
done
fail=0
filter() { if [ -n "$ALLOW" ] && [ -r "$ALLOW" ]; then grep -v -F -f "$ALLOW"; else cat; fi; }

# 1. path checks: private-looking paths must not be tracked (the plugin demo is the only exception)
bad=$(git ls-files | grep -E '(^|/)(drafts|reviews|reviewer-notes|anchors|worksheets|feedback|_private)/' | grep -v '^plugins/betterpaper/demo/' || true)
top=$(git ls-files | grep -E '^betterpaper/' || true)
ws=$(git ls-files | grep -E '(^|/)(RUBRIC|STATE|SOURCES)\.md$' | grep -v -E '^plugins/betterpaper/(skills/init/templates|demo)/' || true)
[ -n "$bad$top$ws" ] && { echo "privacy-scan: private-looking paths are tracked:"; echo "$bad$top$ws"; fail=1; }

# 2. evals fixtures must be marked synthetic or public-domain
for f in $(git ls-files 'evals/**/fixtures/*' 2>/dev/null); do
  head -n 1 "$f" | grep -q 'SYNTHETIC / PUBLIC-DOMAIN' || { echo "privacy-scan: eval fixture lacks the SYNTHETIC / PUBLIC-DOMAIN header: $f"; fail=1; }
done

# 3. content: tracked files
hits=$(git ls-files -z | xargs -0 grep -n -i -E -f "$DL" -- 2>/dev/null | grep -v '^tools/privacy-scan.sh' | filter || true)
[ -n "$hits" ] && { echo "privacy-scan: denylist terms found in tracked files:"; echo "$hits" | cut -c1-200; fail=1; }

# 4. content: commit messages and diffs
scan_log() { git log -p --format='%H %B' "$@" 2>/dev/null | grep -n -i -E -f "$DL" | filter | cut -c1-160 | head -20; }
if [ -n "$RANGE" ]; then
  h=$(scan_log $RANGE || true)
  [ -n "$h" ] && { echo "privacy-scan: denylist terms found in the pushed range $RANGE:"; echo "$h"; fail=1; }
fi
if [ "$HIST" = 1 ]; then
  h=$(scan_log --all || true)
  [ -n "$h" ] && { echo "privacy-scan: denylist terms found in HISTORY (first 20, after allowlist):"; echo "$h"; fail=1; }
fi
[ $fail -eq 0 ] && echo "privacy-scan: clean"
exit $fail
