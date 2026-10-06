# DECISIONS

Recorded at the start of Phase 0 (2026-10-06).

| # | Decision | Answer |
|---|---|---|
| D1 | Plugin and repo name | `betterpaper` |
| D2 | Default grading mode | Full panel (5 reviewers); `--quick` runs a single pass |
| D3 | Light Notes-proofreading skill | Included (`proof-note`) |
| D4 | Where essay workspaces live | `betterpaper/` in the folder Claude Code is run from (the plan's default was `vetting/`) |
| D5 | Licence | MIT |
| D6 | Repo visibility | Public, with no drafts, reviews or state ever committed |

Other choices
- Repo owner: `foGledenalzi`.
- Plugin author name: `foGledenalzi`.
- Because D1 and D4 differ from the plan, every `essay-vetting` in the build plan reads `betterpaper`, and every `vetting/<slug>/` reads `betterpaper/<slug>/`. Commands are `/betterpaper:init`, `/betterpaper:grade`, `/betterpaper:proof-note`.
- The `.gitignore` rule for workspaces is anchored (`/betterpaper/`) so it cannot hide the plugin folder `plugins/betterpaper/`.
