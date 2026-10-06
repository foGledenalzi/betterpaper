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

## Working process (set 2026-10-06)
- Every main phase runs three subphases in order: **Q&A** (decisions recorded in `docs/phases/phase-N-discussion.md`), **agentic research** (notes in `docs/research/phase-N/`), then **build** (the plan's tasks and Verify checks).
- Git: commit and push to `main` at the end of each phase, once its Verify checks pass.

## Plan changes from Phase 1 Q&A
- **D7: Sixth criterion.** The rubric gains "Structure and organisation" (six criteria). It is reviewed by `argument-reviewer`, so the panel stays at five agents.
- **D8: Citation styles.** Chicago notes-bibliography stays the default, and MLA 9 and Chicago author-date are added: `chicago-notes.md`, `chicago-author-date.md`, `mla.md`. The mechanics reviewer loads the file for the style named in `RUBRIC.md`.
- **D9: Calibration cues** in the public `grade-bands.md` are subject-neutral. Essay-specific cues live only in private anchors (Phase 7).
- **D10: Overall grade.** A weighted average of the six criterion grades, rounded to the nearest step, with weights editable in `RUBRIC.md`. Default weights: primary texts 25, argument 25, sources 20, structure 10, originality 10, mechanics 10. Only the quotation-integrity rule may cap the result, and it is reported as a second grade ("as submitted" versus "on the writing and argument").
- **D11: Padding.** Phrase-level filler (the filler list) counts under Mechanics; paragraph-level padding counts under Structure.
- **D12: Phase 1 timing.** The Phase 1 build waits for the user's CMOS 18 and MLA 9 source material, so unconfirmed style rules (`[U]`) can be cleared before writing. If none arrives, the files ship with `[S]`/`[U]` tags and the reviewer flags `[U]` items as "check your style guide", never as errors.
- **D13: Target venue and genre (2026-10-06).** Post-graduate academic university level. Essays lean argumentative with research, plus general theory. Consequences: default harshness stays "harsh"; the default rubric targets argumentative research writing (the weakest-supported case is theory-fiction, which the rubric agent found no validated rubric for, so it is handled by a declared-mode rule rather than its own bands); research and source use carry full weight; Chicago notes-bibliography remains the default citation style, with MLA and Chicago author-date available.
