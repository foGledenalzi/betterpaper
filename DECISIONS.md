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
The user confirmed that the grades in the earlier reviews they supplied were assigned by Claude, not by a human grader. Consequences:
- Every anchor derived from them starts `unconfirmed` and cannot anchor a grade until the author or an instructor confirms or adjusts it (R4); a confirmation sheet is generated for that purpose.
- Grade descriptors tagged `[observed]` in `grade-bands.md` mean "seen in earlier unconfirmed reviews".
- A later grade comparison against those reviews measures self-consistency, not accuracy, until a human confirms the grades; objective checks (quotation mismatches, recurring proofreading items) are unaffected.
- **Correction to the R1 rationale.** Agreement between equal weights and the tool's earlier overall grades only shows that equal weights match how the tool aggregated its own criterion grades. It is not evidence that equal weights match a human grader. R1 stays as accepted (equal weights, editable) and is tested in the gold-set evaluation once human grades exist.

## Provisional decisions A1-A22 (assistant defaults, 2026-10-06)
Made while resolving the adversarial plan review. They fill gaps the accepted decisions left open; the user can override any of them. Detail is in `docs/design/method-digest.md`.
- **A1** A *band* is a letter grade spanning its plus and minus steps; a *step* is one rung of the 12-step scale; the top band is the A range. "Notch" is retired.
- **A2** Weights are relative integers (default 1 each), exact arithmetic; round to the nearest step; an exact tie goes to the lower step under harsh and the higher under neutral.
- **A3** Harsh and neutral differ in two rules only: tie direction, and evidence for B+ or above (harsh: two verified strengths; neutral: one). Stored in `RUBRIC.md` and the report header; the severity eval swaps only this block.
- **A4** Reviewer waves: wave 1 in parallel (source-verifier, primary-text-reviewer, mechanics-reviewer, voice-echo-reviewer); wave 2 argument-reviewer, given the verified ledger and precedent register but no other reviewer's findings or grades.
- **A5** Disagreement signal: the orchestrator's holistic cross-check differs from the weighted grade by a letter band, or two runs differ by a letter band. Repeat the relevant reviewers once when the mean is within 0.05 of a tie point or in the top band.
- **A6** Anchors: `anchor_count` default 4 (provisional, tested by an eval arm), spanning the scale with at least one top-band and one low-band anchor where confirmed ones exist; seed in `RUBRIC.md`; per-reviewer order from seed and reviewer name, logged in `STATE.md`; the draft under review and near-duplicates excluded; layout `anchors/draft-N/{text.md, ANCHOR.md}`; `ANCHOR.md` carries per-criterion grades and both overall series, and the "alone" series anchors the band; the grade step appends the new draft as an unconfirmed anchor.
- **A7** With no confirmed anchors: rubric-only grading, confidence forced low ("no confirmed anchors"), an "unanchored" banner, and the human-check flag.
- **A8** Reviewers never see earlier grades or author claims; they receive a stripped tracker extract; only the orchestrator compares drafts.
- **A9** The source-verifier owns the citation ledger and all citation-form checks, loading the style file selected by `RUBRIC.md`; the mechanics-reviewer is prose-level only (amends D8).
- **A10** The echo check is a pre-review stage in Map, run once, with its output passed to source-verifier, primary-text-reviewer and voice-echo-reviewer; imported reviews and third-party feedback live in `feedback/`.
- **A11** Refinement of R8: the four-condition integrity test with an evidence standard, normalisation, a non-trigger list and an event log (see the digest).
- **A12** Severity key tiers 0-5; rank by residual damage to the thesis.
- **A13** Target grade: the next letter band above the "alone" grade; under a cap the target is the "alone" grade; no target in the top band.
- **A14** Author markers arrive via an optional `--markers <annotated previous report>`, parsed as claims only.
- **A15** Quick mode: orchestrator grades inline; precheck, echo, cited-span and filler checks run; "Integrity test not run" banner; never caps.
- **A16** Reports render as Markdown with fixed headings, about 250-270 lines, verdict 3-4 sentences of 35-60 words.
- **A17** The real gold set is private (outside the repo); `evals/gold-set/` holds only a format spec and synthetic fixtures; consent is required for others' drafts; target at least 20 drafts with at least 3 near the top band (minimum useful 10); results are recorded as aggregates only.
- **A18** `eval_metrics.py` is added; Phase 6 splits into define and run; arms: anchor count, anchor order, guess-then-reveal, panel versus single, holistic cross-check, severity, style perturbation, injection, quick versus full.
- **A19** The demo essay ships inside the plugin (`plugins/betterpaper/demo/`); evals live at the repo root and need a clone to run (amends R21).
- **A20** Paths use `${CLAUDE_PLUGIN_ROOT}`.
- **A21** `voice-echo-reviewer` has `Read, Grep` only; no agent has Bash; web queries contain only attributed quotations or public work details.
- **A22** Privacy: denylist outside the repo; `tools/privacy-scan.sh` in the Verify steps and as a pre-push hook; shipped reference, skill and agent files contain no D, R or A codes; `DECISIONS.md` is development-only.
