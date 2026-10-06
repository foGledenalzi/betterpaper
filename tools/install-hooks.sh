#!/usr/bin/env bash
# Install the committed hooks into this clone: tools/install-hooks.sh
set -e
root="$(git rev-parse --show-toplevel)"
install -m 0755 "$root/tools/hooks/pre-push" "$root/.git/hooks/pre-push"
echo "installed pre-push hook (set BETTERPAPER_DENYLIST or keep the denylist at ../betterpaper-private/denylist.txt)"
