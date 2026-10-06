# Phase 1: open decisions with recommended defaults

Date: 2026-10-06. **STATUS: ACCEPTED by the user on 2026-10-06 ("defaults are fine for now").** Every row below is adopted as written and referred to as R1-R22 in `PLAN.md`; rows can be revisited after the first gold-set run.

Evidence: `docs/research/phase-1/grading-literature-synthesis.md` (12 papers) and, privately, a private analysis of earlier tool-assigned reviews (structure and method only; no review content is reproduced here).

## A. Grading and calibration

| # | Question | Recommended default | Why |
|---|---|---|---|
| 1 | Default criterion weights | Equal weights, editable in `RUBRIC.md` | Equal weights are the simplest transparent default. No paper tests weighting, and the earlier 25/25/20/10/10/10 was an unsupported guess |
| 2 | Who reviews Originality | `argument-reviewer` (with Argument and Structure); `primary-text-reviewer` supplies unacknowledged precedents | The plan assigned every criterion except this one |
| 3 | Structure row | Keep it, flagged "low confidence: not calibrated", kept within one notch of Argument unless two structure-specific findings justify more; findings never counted twice | No earlier review graded it, so it has no calibration evidence |
| 4 | Anchor grades | Human-confirmed (you or an instructor); tool-assigned grades are marked unconfirmed and cannot anchor | Literature warns against tool-assigned anchors |
| 5 | Anchor count and order | A setting, not fixed at two per level; a seeded, recorded order per reviewer; the draft under review is excluded | Anchor count and order both moved results in the studies; none tested the count |
| 6 | Harsh default | Keep, and add a neutral-severity arm to the evals so results decide | Evidence on severity is thin and mixed |
| 7 | Model the plugin runs on | Inherit the session model; record it in every report | Almost all evidence is on other or older models |

## B. Quotation integrity

| # | Question | Recommended default | Why |
|---|---|---|---|
| 8 | When the two-grade split fires | Per quotation: attributed to a named author, a sense-bearing difference shown, load-bearing for the argument, unresolved. Not triggered by "unverified", by "not found", or by recall alone | A literal "any unresolved mismatch" trigger would fire on minor defects; the cap should need a checkable, load-bearing mismatch |
| 9 | What the cap changes | Overall "as submitted" grade to F; the Sources row shows a conditional value (for example "F (<grade> once the quotations are fixed)"); the "alone" grade substitutes the conditional values | Keeps the cap visible and reversible |
| 10 | Extra quotation statuses | Add a wrong-work attribution flag, a near-verbatim-without-marks flag, a marks-around-non-quotation flag, and a secondary-summary-match flag (as sub-flags of existing statuses where possible) | The six planned statuses do not cover these cases |
| 11 | Cited-span check | A script confirms every excerpt a reviewer cites appears verbatim in the draft; failures are dropped or relabelled, not re-asked | One study found models quote text that is not in the essay |

## C. Report and tracking

| # | Question | Recommended default | Why |
|---|---|---|---|
| 12 | Report template | Header block (draft number, title, date); draft-1 variant ("what's worth keeping" plus optional reading list); fixed footer sentence; quotation section above the ranked problems only when the split fires; previous grade printed on each grade line; the word "alone" kept | A report varies by draft number and by trigger; a fixed section list does not fit every draft |
| 13 | Correction section | Used for both kinds: a wrong claim in an earlier review, and an earlier suggestion that backfired | Both kinds of earlier error can mislead the author |
| 14 | Author status markers (fixed, removed, cited) | Stored as a separate "author claim" field and verified next round, never trusted | Author markers are claims; a marker can be wrong or only partly true |
| 15 | Recurrence counting | Two counters: drafts present, and rounds flagged; labels such as "third round" are generated from stored counts | One counter conflates two different things |
| 16 | Positioning or reputational flags | Only from context the user declares in `RUBRIC.md` (audience, venue, public positions); one sentence inline, no standalone section | The plugin cannot see the author's other writing |
| 17 | Confidence and human-check flag | Categorical confidence with named reasons, labelled "uncalibrated"; human-check flag on the top band, any cap, and reviewer disagreement of a band or more | No study validates a confidence mechanism |

## D. Rules about the author's words

| # | Question | Recommended default | Why |
|---|---|---|---|
| 18 | "Never write the author's sentences" | An allow/deny matrix. Allowed: single-token mechanical corrections, pointers to sources, unrelated-topic examples, blank citation templates. Denied: ready thesis sentences, bridge sentences, replacement quotations, replacement vocabulary for concepts. A paste test flags report text that could be pasted into the essay | Reviewer wording can be copied into an essay and later fail an originality or quotation check |
| 19 | Citation-format samples | Blank bracketed templates, plus one filled example on an unrelated source; never pre-filled from the author's own works or pages | Pre-filled notes can carry a page that conflicts with the author's own |
| 20 | Run order | The echo check runs first; its results reach the source-verifier and the orchestrator before any remedy wording is written | Wording from earlier reviews can resurface inside quotation marks |

## E. Evaluation (affects the `evals/` folder)

| # | Question | Recommended default | Why |
|---|---|---|---|
| 21 | Ship self-tests | Style-perturbation and prompt-injection fixtures ship in `evals/` for development; users can run them | Prompt instructions alone did not stop style or injection effects in two studies |
| 22 | Gold set | Build a small human-graded set (your own drafts plus any consenting others), with several near the top band, as the basis for the panel-versus-single and severity tests | Without it the plugin's accuracy claims cannot be tested |
