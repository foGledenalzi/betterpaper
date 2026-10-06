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

## D16: Git history exposure accepted (2026-10-06)
The repo is public. Early commits (before 2026-10-06 remediation) contain an example grade pair, one line of review wording and a few anecdotal statements derived from private reviews. The current tree is clean (`tools/privacy-scan.sh`). The user decided to leave history as it is ("not a huge deal"), so there is no rewrite, no force-push and no switch to private. Consequences: the Phase 8 history scan (`tools/privacy-scan.sh --history`) is expected to report only those known early lines; any other hit, and any new leak in the tree, still blocks release.

## Provisional decisions A23-A40 (assistant defaults from plan-review round 2, 2026-10-06)
Fill gaps and amend earlier provisional decisions; the user can override any of them. Detail: `docs/design/method-digest.md` and `docs/design/file-contracts.md`.
- **A23 (amends A8).** Reviewers never see the essay's own grade history, tracker verification status, the previous report's grade lines or author claim text. Anchors carry their confirmed grades by design. The source-verifier receives only a list of QIDs to re-verify (author-marked rows included, marker text withheld).
- **A24 (amends R2).** The argument-reviewer proposes uncredited-precedent candidates with a residual-contribution clause; the primary-text-reviewer reports characterisation findings and may nominate candidates; the source-verifier verifies and registers all of them in a follow-up pass. An uncredited precedent is charged to Use of sources (the failure to credit) and to Originality only for the delta, never both for the same fault. Unverified candidates are registered UNVERIFIED, listed as "check this against <named thing>", and have no grade effect.
- **A25.** Pipeline step 3b: after wave 1, run the cited-span check on wave-1 output, merge the source-verifier's ledger block into `SOURCES.md`, send wave-1 precedent candidates to a short second source-verifier call, and build wave-2 input. After wave 2, one single-purpose source-verifier pass verifies wave-2 candidates.
- **A26 (amends A3).** One harsh threshold: two verified strengths for **B+ or above** (neutral: one). A *verified strength* is a reviewer-listed positive, tagged to a descriptor in the grade bands, with a draft quote of 15 words or fewer that passes the cited-span check and is not contradicted by a problem on the same passage. The orchestrator counts them; `compute_grade.py` takes a `verified_strengths` count per criterion and limits a criterion with too few to the highest step below B+.
- **A27.** Reviewer return format: columns ID, Severity tier, Criterion, Locator (paragraph number plus first words), Draft quote (15 words or fewer), Problem, Impact on thesis (one clause), Evidence / how checked, Label, Fix direction; blocks for Tracker rows (ID, proposed status, evidence, re-read yes/no), Strengths (at most 3 per criterion owned), and a conditional-grade clause on the source-verifier's grade line; named optional blocks per agent. The cited-span check covers the Draft quote column only. Reviewer IDs are reviewer-local; the orchestrator maps them to tracker IDs. Untrusted-data delimiters carry a per-run random nonce.
- **A28 (amends A6).** A draft is a near-duplicate of an anchor when shared 6-word runs cover at least 85% of the anchor's text (`near_duplicate_pct`, default 85). Anchor selection: up to `anchor_count` confirmed anchors spanning the scale, with at least one top-band and one low-band anchor where confirmed ones exist; anchors from other essays or works may be supplied. "Near the top band" means an "alone" grade of A- or higher. Order: sort by sha1(seed|reviewer|anchor id), computed by a sixth script, `select_anchors.py`.
- **A29.** Anchor lifecycle: `anchors/CONFIRM.md` (one row per anchor and criterion: tool grade, confirm or adjust, confirmer, date) is generated by init, or by grade when it appends the new draft's anchor; `/betterpaper:init <slug> --confirm` applies it (sets `confirmed_by`, marks `human-adjusted`, replaces grades in history). The grade step appends the new draft as an `unconfirmed` anchor. `anchors/*/ANCHOR.md` is authoritative; the `STATE.md` register is derived.
- **A30.** The orchestrator records its holistic letter grade before `compute_grade.py`. The repeat set is the owners of criteria within one step of a tie point or graded in the A range; the grade of record is the mean of the two runs per criterion in tenths, re-run through `compute_grade.py`, with the spread logged. Confidence: low if any of no confirmed anchors, disagreement, cap fired; medium if any other reason (unverified-quotation share over 30%, within one step of a tie point, top band, same-essay anchors only, non-zero repeat spread); otherwise high. Thresholds are provisional and tested by evals.
- **A31 (refines A11).** Three routes to a sense-bearing difference: (a) a verified counter-passage in an edition matching the author's; (b) provenance proof: the draft wording matches an archived report's wording (word diff shown) and no opened text of the work contains it; (c) a negative from a complete searchable text the plugin opened. A named secondary source that quotes the passage differently supports a "checked against a secondary source" finding but never triggers the split by itself; SECONDARY-ECHO never triggers. A decision table is in the file contracts.
- **A32.** The Phase 7 blind test runs in a fresh session on a throwaway copy of the workspace seeded only with material dated before the latest draft (STATE, SOURCES, feedback, archive and anchors alike); the result is compared with the real latest review and the copy is discarded.
- **A33.** `references/` also holds `report-sections.md`, `tracker-rules.md` and `adjudication-examples.md`, to keep every file under 200 lines.
- **A34.** The privacy hook is committed as `tools/hooks/pre-push` with `tools/install-hooks.sh`; it scans the commit messages and diffs of the pushed range plus the tree. `--history --allow <file>` takes an allowlist kept outside the repo. Files under `evals/` other than scripts and format specs must start with a "SYNTHETIC / PUBLIC-DOMAIN" header. `.gitignore` also ignores `RUBRIC.md`, `STATE.md` and `SOURCES.md` outside templates and the demo.
- **A35.** Demo inventory: `RUBRIC.md`, `STATE.md`, `SOURCES.md`, draft 1 to draft 3, `reviews/draft-1.md` (invented earlier review), `feedback/`, `sources/` public-domain excerpts, 3-4 invented confirmed anchors, a fabricated findings file, a sample report, `grades.json` cases, and an answer key (expected status per quotation, tracker transitions per draft, tags printed, grades per criterion, lint result); controls for a different edition and a catalogue-page source. Init copies the demo for the slug `demo-essay`.
- **A36.** The report header carries the overall confidence line and the human-check flag; the rubric table carries a per-criterion confidence tag; A-range or near-A-range results print as a band with "this grade may be too high or too low"; the calibration-confidence note prints when a cell lies outside the grade range spanned by confirmed anchors, and always beside Structure.
- **A37.** `select_anchors.py` is added; `grades.json` has a documented schema; flat `key: value` formats for `RUBRIC.md` (stdlib-parsable).
- **A38.** Eval arms added: spanning set versus same-essay anchors, lean versus detailed rubric, inter-criterion correlation, human-human baseline, edited-draft regrade, anchor count versus essay length, cap events and checker false positives; a power note. Gold-set rules: each grade confirmed by the author or an instructor; a second grader on a subset; per-band figures reported with n and described as descriptive only.
- **A39.** Init: slug `[a-z0-9-]+` (up to 60 characters) else reject; stop and offer resume if the workspace exists; create the full tree; if the working folder is a git repo, check that `betterpaper/` is ignored and offer to append it. Plus or minus within a band: plain when all band descriptors are met, plus when also showing a verified strength described in the band above, minus when one descriptor is barely met or one named weakness of the band below shows. Partial grading: weights renormalise over graded criteria, the cell prints n/a, the overall is marked partial. Filler list grammar: one lowercase phrase per line, `#` comments, trailing `?` for conditional entries. Style-file tags: `[C18]` CMOS 18 excerpt, `[MLA9]` MLA Handbook page cited through a library guide, `[DC]` that guide, `[D]` Purdue deck, `[S]` search summary, `[U]` unconfirmed. Quick mode carries every open tracker row forward as "not rechecked", records `mode: quick` in grade history, updates no ledger statuses and writes no anchor. Agent names are scoped (`betterpaper:<agent>`). Web queries contain the author, the work and at most 8 distinctive words of a string, never the full string or bridging text; the full comparison is local.
- **A40.** The D2 default (full panel) stays until the gold-set A/B; the Known limits gain three items (the weighted average is a design choice; the integrity cap and two-grade display are untested; no study covers successive drafts by one author).
