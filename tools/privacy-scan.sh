#!/usr/bin/env bash
# Scan tracked files (and optionally history) for terms in a private denylist.
# Usage: BETTERPAPER_DENYLIST=/path/to/denylist.txt tools/privacy-scan.sh [--history]
# The denylist lives OUTSIDE the repository and is never committed.
set -u
DL="${BETTERPAPER_DENYLIST:-../betterpaper-private/denylist.txt}"
[ -r "$DL" ] || { echo "privacy-scan: denylist not found at $DL (set BETTERPAPER_DENYLIST)"; exit 2; }
fail=0
# path check: no tracked files in private locations outside examples/
bad=$(git ls-files | grep -E '(^|/)(drafts|reviews|reviewer-notes|anchors|worksheets|feedback|_private)/' | grep -v '^examples/' || true)
top=$(git ls-files | grep -E '^betterpaper/' || true)
[ -n "$bad$top" ] && { echo "privacy-scan: private-looking paths are tracked:"; echo "$bad$top"; fail=1; }
# content check on tracked files
hits=$(git ls-files -z | xargs -0 grep -n -i -E -f "$DL" -- 2>/dev/null | grep -v '^tools/privacy-scan.sh' || true)
[ -n "$hits" ] && { echo "privacy-scan: denylist terms found in tracked files:"; echo "$hits" | cut -c1-200; fail=1; }
if [ "${1:-}" = "--history" ]; then
  h=$(git log -p --all 2>/dev/null | grep -n -i -E -f "$DL" | cut -c1-160 | head -20 || true)
  [ -n "$h" ] && { echo "privacy-scan: denylist terms found in HISTORY (first 20):"; echo "$h"; fail=1; }
fi
[ $fail -eq 0 ] && echo "privacy-scan: clean"
exit $fail
