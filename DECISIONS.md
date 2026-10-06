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
- **D14: Theory-fiction is out of scope (2026-10-06).** Amends D13. The plugin grades argumentative and theoretical academic writing only. Consequences for the plan:
  - `rules.md`: the line "distinguish the genre (argument or theory-fiction)" becomes "grade as argumentative or theoretical academic writing; if the essay is something else, say so once and grade it as an argument, flagged as outside the tool's design".
  - `grade-bands.md`: no declared-mode rule and no experimental-genre handling.
  - `init` interview: genre options are argumentative research essay, theoretical or conceptual essay, or other (which triggers the out-of-scope warning).
  - Phase 7: a "stuck between genres" finding in an early review becomes a plain "choose one genre" step; for this tool the answer is always argument.
  - The rubric research gap about experimental writing no longer matters.

## Phase 1 sheet accepted (2026-10-06)
The user accepted all 22 recommended defaults in `docs/phases/phase-1-open-decisions.md` ("defaults are fine for now"). They are referred to as R1-R22. Summary:
- **R1** equal weights, editable in `RUBRIC.md` (supersedes the 25/25/20/10/10/10 default in D10; weights stay editable).
- **R2** `argument-reviewer` also owns Originality; `primary-text-reviewer` supplies unacknowledged precedents.
- **R3** Structure is kept, flagged "low confidence: not calibrated", within one notch of Argument unless two structure-specific findings justify more; no double counting.
- **R4** anchor grades are human-confirmed; tool-assigned grades are marked unconfirmed and cannot anchor.
- **R5** anchor count is a setting; seeded, recorded anchor order per reviewer; the draft under review is excluded.
- **R6** harsh default stays; a neutral-severity eval arm decides later.
- **R7** the plugin inherits the session model and records it in every report.
- **R8** the two-grade split fires per quotation only when it is attributed, a sense-bearing difference is shown, it is load-bearing, and it is unresolved; never on "unverified", "not found" or recall alone.
- **R9** the cap sets the overall "as submitted" grade to F; the Sources row shows a conditional value; the "alone" grade substitutes the conditional values.
- **R10** extra quotation flags: wrong-work attribution, near-verbatim without marks, marks around a non-quotation, secondary-summary match.
- **R11** a script confirms every excerpt a reviewer cites appears verbatim in the draft; failures are dropped or relabelled.
- **R12** report template with header block, draft-1 variant, fixed footer, conditional sections, previous grade on each grade line, and the word "alone".
- **R13** Correction section covers both a wrong earlier claim and a backfired suggestion.
- **R14** author status markers are stored as author claims and verified next round.
- **R15** two recurrence counters: drafts present and rounds flagged; labels are generated from stored counts.
- **R16** positioning flags only from context declared in `RUBRIC.md`; one inline sentence.
- **R17** categorical confidence with named reasons, labelled "uncalibrated", plus a human-check flag (top band, any cap, reviewer disagreement of a band or more).
- **R18** allow/deny matrix for the author's words, with a paste test.
- **R19** blank bracketed citation templates plus one unrelated filled example; never pre-filled from the author's works.
- **R20** the echo check runs first and its results reach the source-verifier and orchestrator before remedies are written.
- **R21** style-perturbation and injection fixtures ship in `evals/`.
- **R22** a human-graded gold set is built for the evals.

## Style rules settled by the supplied Manual and handbook excerpts (2026-10-06)
See `docs/research/phase-1/purdue-deck-verification.md` (addenda A and B). Notable: CMOS 18 notes name only the first of more than two authors; bibliography lists up to six (more than six: first three plus "et al."); DOIs are `https://doi.org/` links; block quotations are a soft 100-word rule; in notes-bibliography style a "quoted in" citation lists both original and secondary source; ancient works are cited by standard divisions with no page numbers.

## D15: Reference grades are tool-assigned (2026-10-06)
The user confirmed that the grades in the three real earlier reviews were Claude's own, not a human grader's. Consequences:
- Every anchor derived from them starts `unconfirmed` and cannot anchor a grade until the author or an instructor confirms or adjusts it (R4); a confirmation sheet is generated for that purpose.
- Grade descriptors tagged `[observed]` in `grade-bands.md` mean "seen in earlier unconfirmed reviews".
- The Phase 7 grade comparison measures self-consistency, not accuracy, until a human confirms the grades; the objective checks (quotation mismatches, recurring proofreading items) are unaffected.
- **Correction to the R1 rationale.** The statement that equal weights "reproduce all three real overall grades" only shows that equal weights match how the tool aggregated its own criterion grades. It is not evidence that equal weights match a human grader. R1 stays as accepted (equal weights, editable) and is tested in the gold-set evaluation once human grades exist.
