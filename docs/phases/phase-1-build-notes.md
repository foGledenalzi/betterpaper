# Phase 1 build notes (2026-10-06)

Eleven reference files were written under `plugins/betterpaper/skills/grade/references/` by seven writers, audited (the style files against the research notes and the supplied excerpts) and cross-checked for consistency. `tracker-rules.md` remains a placeholder for Phase 2. Every file is under 200 lines, carries no decision codes, uses invented examples only and passes `tools/privacy-scan.sh`. Worked grade arithmetic in `adjudication-examples.md` was computed twice with independent exact-fraction scripts; `compute_grade.py` (Phase 4) must reproduce it.

## Conventions chosen by the build (decision A56)
See `DECISIONS.md` A56. The user can override any of them.

## Open style points (need a source or a human decision; none blocks the build)
Each is handled conservatively in the shipped files (minor weight, `[U]`, or never flagged).
- **Chicago notes.** A short note at first citation when a bibliography exists, and bibliography entries that no note cites, are now `[U]` style choices. Row 1 (parenthetical source in a notes essay) is minor when it replaces notes. Row 29 keeps "two abbreviations for one work"; "one abbreviation for two works" was dropped as inferred. Rows 14 and 15 (`p.` before a locator, mixed elided and full page ranges) rest on the Manual's examples, not a stated rule; they stay minor. Newsletter posts stay `[U]` although one research addendum would allow `[S]`.
- **MLA 9.** E3 (`&` between two authors) is `[S]`. E23 (a list entry names the translation or edition behind divisions) and the Months row are supported by examples, not an explicit sentence. C3 (city of publication) is never flagged although the Handbook may state the rule outright. E26 flags a capitalised season once as minor. U2 names the Stephanus and Bekker systems as systems, not as cited works.
- **Unconfirmed list** (addendum C6 of `docs/research/phase-1/purdue-deck-verification.md`): two-edition (A/B) and academy-edition (`Ak.`) numbering for modern classics, author-date handling of ancient works, newsletter posts as a named category, MLA translator-first entries, AI-content citation in MLA, the Chicago `ibid.` and short-form sections.

## Decisions needed from the design owners (interim fixes are in the files)
- The primary-text-reviewer's own audit labels (FIT-FAIL, SPLICED, CONTEXT, DEPARTURE-DECLARED, DEPARTURE-UNDECLARED) have no tier in the closed defect-code table; the Phase 3 brief must map each to a closed code or the finding is not ranked.
- Only two descriptors carry `[observed]`; retag after the private analysis if it supports more.
- Band placement for B, C and D descriptors and the severity-1 placement of Command of primary texts at D are the writers' reading; evidence at the low end of the scale is thin.
- Whether verified strengths combine across two repeat runs as the lower count (chosen) or another way.
- Thresholds (30% unverified share, 0.05-point window, 13 tenths dispersion) are provisional and uncalibrated.

## Build incident
Subagent Write calls were refused for paths beginning `report-`; the three report files were drafted by the consistency reviewer, returned as text and written by the orchestrator. Phase 3 subagents that must write files with that prefix should do so through the orchestrator.
