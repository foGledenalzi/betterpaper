# Phase 2 build notes (2026-10-19)

Built: `references/tracker-rules.md`, `references/web-links.md` (the fourth style, `links`), the five workspace templates, the `init` skill with `references/interview.md`, and the fictional demo workspace (`plugins/betterpaper/demo/`, 28 files). The design documents for the demo are `docs/design/demo-spec.md` (with an embedded mechanical checker) and the answer key shipped as `demo/ANSWER-KEY.md`.

## Verification done
- The demo-spec checker passes: every planted string, quotation ID, opener, absence rule, draft and anchor size, near-duplicate coverage, and all twelve cases of `grades-cases.json` recomputed with exact fractions.
- `init` was dry-run with the installed CLI in throwaway folders (about 20 model runs): the demo install copies all 28 manifest paths byte for byte; a second run stops without overwriting; `--defaults` writes a RUBRIC with all template keys; the slug rules reject bad slugs without writing; `--confirm` on the demo reports 28 already applied. Seven defects in the skill text were found and fixed (compound commands needing approval, notice formatting, Bash writes, a stopped run printing the notice, a Read grant lapsing after the interview reply, template harmonising, a file count slip).
- Hard-rule greps (decision codes, doc references, URLs, non-ASCII outside the two Chicago files' page-range dashes), `claude plugin validate` and `tools/privacy-scan.sh` pass.

## Open points (none blocks Phase 3)
- Not tested: Windows and PowerShell, the question tool (absent in non-interactive runs; only the numbered-chat fallback ran), real interactive permission prompts, `--confirm` with rows that actually change, a path that is a file, an interrupted install, and the genre-other warning.
- `human_adjusted` (ANCHOR.md key) and `human-adjusted` (STATE.md column) are two spellings of one concept; scripts read ANCHOR.md only.
- A QID collision gets a `-2` or `-3` suffix (tracker-rules section 7), so a QID format check must allow it; `extract_quotes.py` must implement the normalisation order of that section exactly.
- `web-links.md` makes a fetched negative never support the integrity cap, which is stricter than the general rule; the demo does not exercise the `links` style.
- The date of the demo's `CONFIRM.md` rows is later than today; they are invented dates.
- Owner action still pending: save one real Medium post and one real Substack post (paywalled or script-rendered) from a browser after it loads and report whether the saved file holds the article text; `import_draft.py` is finalised after that.
