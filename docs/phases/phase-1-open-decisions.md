# Phase 1: open decisions with recommended defaults

Date: 2026-10-06. Each row has a recommended default. Reply "defaults ok", or list row numbers to change. Anything unanswered when the Phase 1 build starts is built with the default and recorded as a decision.

Evidence: `docs/research/phase-1/grading-literature-synthesis.md` (12 papers) and, privately, an analysis of three real reviews (structure and method only, no content).

## A. Grading and calibration

| # | Question | Recommended default | Why |
|---|---|---|---|
| 1 | Default criterion weights | Equal weights, editable in `RUBRIC.md` | Equal weights reproduce all three real overall grades; the earlier 25/25/20/10/10/10 comes out one step low on two. No paper tests weighting |
| 2 | Who reviews Originality | `argument-reviewer` (with Argument and Structure); `primary-text-reviewer` supplies unacknowledged precedents | The plan assigned every criterion except this one |
| 3 | Structure row | Keep it, flagged "low confidence: not calibrated", kept within one notch of Argument unless two structure-specific findings justify more; findings never counted twice | The real reviews never graded it, and adding it at equal weight moves one grade a step |
| 4 | Anchor grades | Human-confirmed (you or an instructor); tool-assigned grades are marked unconfirmed and cannot anchor | Literature warns against tool-assigned anchors |
| 5 | Anchor count and order | A setting, not fixed at two per level; a seeded, recorded order per reviewer; the draft under review is excluded | Anchor count and order both moved results in the studies; none tested the count |
| 6 | Harsh default | Keep, and add a neutral-severity arm to the evals so results decide | Evidence on severity is thin and mixed |
| 7 | Model the plugin runs on | Inherit the session model; record it in every report | Almost all evidence is on other or older models |

## B. Quotation integrity

| # | Question | Recommended default | Why |
|---|---|---|---|
| 8 | When the two-grade split fires | Per quotation: attributed to a named author, a sense-bearing difference shown, load-bearing for the argument, unresolved. Not triggered by "unverified", by "not found", or by recall alone | The plan's literal trigger (any unresolved mismatch) is stricter than the real reviews were, which left minor defects without a split |
| 9 | What the cap changes | Overall "as submitted" grade to F; the Sources row shows a conditional value ("F (C once the quotations are fixed)"); the "alone" grade substitutes the conditional values | This is what the real draft-3 review did |
| 10 | Extra quotation statuses | Add a wrong-work attribution flag, a near-verbatim-without-marks flag, a marks-around-non-quotation flag, and a secondary-summary-match flag (as sub-flags of existing statuses where possible) | The six planned statuses do not fit these real cases |
| 11 | Cited-span check | A script confirms every excerpt a reviewer cites appears verbatim in the draft; failures are dropped or relabelled, not re-asked | One study found models quote text that is not in the essay |

## C. Report and tracking

| # | Question | Recommended default | Why |
|---|---|---|---|
| 12 | Report template | Header block (draft number, title, date); draft-1 variant ("what's worth keeping" plus optional reading list); fixed footer sentence; quotation section above the ranked problems only when the split fires; previous grade printed on each grade line; the word "alone" kept | The real reviews differ by draft and by trigger; a fixed ten-section list would not reproduce them |
| 13 | Correction section | Used for both kinds: a wrong claim in an earlier review, and an earlier suggestion that backfired | Real reviews show both, only one was labelled |
| 14 | Author status markers (fixed, removed, cited) | Stored as a separate "author claim" field and verified next round, never trusted | About a quarter of such claims were contradicted or qualified next round |
| 15 | Recurrence counting | Two counters: drafts present, and rounds flagged; labels such as "third round" are generated from stored counts | The real ordinals mixed the two |
| 16 | Positioning or reputational flags | Only from context the user declares in `RUBRIC.md` (audience, venue, public positions); one sentence inline, no standalone section | The plugin cannot see the author's other writing |
| 17 | Confidence and human-check flag | Categorical confidence with named reasons, labelled "uncalibrated"; human-check flag on the top band, any cap, and reviewer disagreement of a band or more | No study validates a confidence mechanism |

## D. Rules about the author's words

| # | Question | Recommended default | Why |
|---|---|---|---|
| 18 | "Never write the author's sentences" | An allow/deny matrix. Allowed: single-token mechanical corrections, pointers to sources, unrelated-topic examples, blank citation templates. Denied: ready thesis sentences, bridge sentences, replacement quotations, replacement vocabulary for concepts. A paste test flags report text that could be pasted into the essay | The real reviews supplied some of the denied kinds, and a later draft carried reviewer wording into the essay |
| 19 | Citation-format samples | Blank bracketed templates, plus one filled example on an unrelated source; never pre-filled from the author's own works or pages | Pre-filled notes carried a page number that conflicted with another |
| 20 | Run order | The echo check runs first; its results reach the source-verifier and the orchestrator before any remedy wording is written | A real quotation problem traced to wording from earlier reviews |

## E. Evaluation (affects the `evals/` folder)

| # | Question | Recommended default | Why |
|---|---|---|---|
| 21 | Ship self-tests | Style-perturbation and prompt-injection fixtures ship in `evals/` for development; users can run them | Prompt instructions alone did not stop style or injection effects in two studies |
| 22 | Gold set | Build a small human-graded set (your own drafts plus any consenting others), with several near the top band, as the basis for the panel-versus-single and severity tests | Without it the plugin's accuracy claims cannot be tested |
