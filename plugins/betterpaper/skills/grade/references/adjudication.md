# Adjudication: from reviewer returns to grades, flags and a ranked list

Read this after every reviewer has returned. You are the orchestrator (the main agent running the grade skill); a reviewer is one of the five specialist subagents. Apply each rule as written, log the cue behind each decision, and never replace a rule with judgement. Worked numbers are in adjudication-examples.md; the report layout is in report-template.md and report-sections.md. Every threshold in this file is provisional, and the confidence note is a triage heuristic labelled "uncalibrated", not a probability. Order of work:
1. Test every quotation for the integrity cap (section 5) and merge the findings (section 3).
2. Count verified strengths per criterion and set each criterion grade (section 2); write the grades.json file (section 1).
3. Record your holistic letter grade (section 7), then run `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/compute_grade.py <RUBRIC.md> <grades.json>`.
4. Apply the repeat rule, then set the disagreement signal, flags and confidence (section 7).
5. Apply the print rule and the target rule (section 8), then the checks in section 9.

## 1. Scale, weights and rounding

A step is one rung of the 12-step ladder; a band is a letter with its plus and minus steps (A and A-; B+, B, B-; C+, C, C-; D+, D, D-; F); the top band is the A range. Work in integer tenths of a grade point. The gaps are not equal (A- to B+ is 4 tenths, most are 3, D- to F is 7), so never interpolate by letter. A tie point is the midpoint between two adjacent steps.

| Step | A | A- | B+ | B | B- | C+ | C | C- | D+ | D | D- | F |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Tenths | 40 | 37 | 33 | 30 | 27 | 23 | 20 | 17 | 13 | 10 | 7 | 0 |
| Gap to the next step down | 3 | 4 | 3 | 3 | 4 | 3 | 3 | 4 | 3 | 3 | 7 | none |
| Tie point with the next step down | 38.5 | 35 | 31.5 | 28.5 | 25 | 21.5 | 18.5 | 15 | 11.5 | 8.5 | 3.5 | none |

The criterion keys are `primary` (Command of primary texts), `argument` (Argument), `structure` (Structure and organisation), `sources` (Use of sources), `originality` (Originality) and `mechanics` (Mechanics). Weights are the six `weight_*` lines of RUBRIC.md: relative integers of 1 or more, default 1 each. Copy `harshness` and the weights into grades.json unchanged. Let S be the sum of weight x tenths over the graded criteria and W the sum of their weights; the mean is S/W as an exact fraction (never a float). A criterion with `grade: null` is not graded: leave it out of S and W (the weights renormalise over the graded criteria), print n/a in its cell, mark the overall partial, and exclude a partial overall from top-band counts (such as the M in "anchors: N (M near the top band)").

Rounding goes to the nearest step. Find adjacent steps lo and hi with lo <= mean <= hi and compare 2S with (lo + hi) x W: below gives lo, above gives hi, equal is an exact tie. An exact tie goes to the lower step under harsh and the higher step under neutral. A mean is near a tie point when |2S - (lo + hi) x W| <= W for an adjacent pair (within 0.05 points, which is half a tenth, ends included). `compute_grade.py` does the following and exits 2 on any malformed input (a weight that is not an integer of 1 or more, a weight or harshness that differs from RUBRIC.md, an unknown grade, no graded criterion):

1. Read each grade as tenths: a letter, or a number of tenths with at most one decimal place (used only for repeat means, section 7).
2. Apply the verified-strength limit (section 2) to every grade and to the `sources` conditional.
3. With `cap.fired` false, `as_submitted` and `alone` are both the rounded mean, and any conditional is ignored. With `cap.fired` true, `as_submitted` is F and `alone` is the rounded mean with the limited conditional in place of the `sources` grade; this needs a non-empty `basis` (one string per firing quotation, for example "q-3b9e41 route-a") and a conditional on a graded `sources`, otherwise exit 2.
4. Return `as_submitted`, `alone`, the partial flag, each criterion's displayed value (rounded by the same rule; `sources` also shows its conditional under a cap), the exact-tie flag with the direction taken, the near-tie flag, each limit applied, and the movement in steps from every `previous` value. Previous values never enter the arithmetic.

## 2. Harshness and verified strengths

`harshness` (harsh or neutral, stored in RUBRIC.md and the report header) changes two rules only; severity ranking, wording and tolerances never vary with it.

| Rule | harsh | neutral |
|---|---|---|
| Exact tie in a rounding | lower step | higher step |
| Evidence needed for B+ or above on a criterion | two verified strengths | one verified strength |

There is no veto and no minimum rule: a low criterion lowers the overall only through its weight, and the integrity cap (section 5) is the only cap.

A verified strength is a positive in a reviewer's Strengths block that is tagged to a descriptor in grade-bands.md, carries a draft quote of 15 words or fewer that passes the cited-span check (`python3 ${CLAUDE_PLUGIN_ROOT}/scripts/check_cited_spans.py`), and is not contradicted by a problem on the same passage in the merged findings. You count them per criterion (each passing row counts once) and enter the count as `verified_strengths`. For a grade of B+, A- or A (a criterion grade, or the `sources` conditional) with a count below the requirement, the script limits that value to the highest step below B+, which is B; B and lower are never touched. The limit applies per criterion before averaging, and the overall is never limited separately. The grade you enter per criterion is your decision after reading the owner's grade suggestion; record the cue for any change from the suggestion.

## 3. Merge rule

Merge all reviewer tables into one list. Each reviewer returns at most 10 ranked findings and 3 strengths per criterion owned; if a return is longer, keep the first 10 in the reviewer's own order and log the overflow.
1. Map reviewer-local IDs to tracker IDs (existing row or new row). A finding's defect code is the capitalised code that opens its Problem cell (for example `BRIDGE-GAP: ...`). Mechanics findings (classes M1 to M3) and citation-form findings carry no code by design (step 4); any other finding with no code from section 4 is not ranked, so return it to its reviewer to recode, or log it and list it among the open issues.
2. De-duplicate by quoted location: findings whose draft quotes overlap one passage become one entry that keeps the most severe tier and lists every reviewer ID and each distinct defect code.
3. Charge each defect to one criterion, overriding the author's tag: citation-form defects and wrong quotations to Use of sources (never to Command of primary texts); phrase-level filler to Mechanics; paragraph-level padding to Structure; an uncredited precedent to Use of sources for the failure to credit and to Originality only for the contribution beyond the precedent, never both for one fault.
4. Rank only findings that carry a defect code: tier ascending (section 4), then the weight of the charged criterion (heavier first), then return order. Rank by residual damage to the thesis in this draft, never by instance count. Citation-form defects go to Citation problems and mechanics items to Proofreading, outside the ranking.
5. Keep at most 12 ranked problems. Print how many were held back, keep their tracker rows open, and name them in the one sentence that the steps section of the report reserves for open issues that did not make the list.

## 4. Severity key and defect codes

| Tier | Meaning |
|---|---|
| 0 | Integrity: the quotation split; sits outside the ranked list |
| 1 | Foundation: source relation reversed, terms used against the source, method contradicting the source |
| 2 | Support: assertion without evidence or mechanism, thesis-level contradiction, missing framework |
| 3 | Bridge gaps, unengaged counter-evidence, definitions, vocabulary, coinage, genre |
| 4 | Examples, history, ending |
| 5 | Usage promoted only on reader reaction; always last |

| Tier | Defect codes (closed set; the table overrides a reviewer's tier) |
|---|---|
| 1 | TERM-VS-SOURCE, RELATION-INVERTED, METHOD-VS-SOURCE, DISTINCTION-COLLAPSED |
| 2 | SELF-CONTRADICTION, NO-EVIDENCE, APPARATUS-MISSING |
| 3 | UNCREDITED-PRECEDENT, APPARATUS-MISAPPLIED, COINAGE, BRIDGE-GAP, COUNTER-EVIDENCE-UNENGAGED, QUOTE-WITHOUT-GLOSS, DISMISSAL, UNFALSIFIABLE, GENRE |
| 4 | HISTORY-OVERLOADED, EXAMPLE-FIT, WEAK-ENDING |
| 5 | STOCK-PHRASE |

Mechanics classes are M1 (spelling and agreement), M2 (syntax) and M3 (diction and voice); they are not severity tiers.

## 5. Integrity test and the cap

The integrity cap (the "split") is the only cap. Test each row of the source-verifier's quotation ledger block (one row for every attributed quotation, identified by its QID, a stable ID derived from the normalised string, with its status and flags and no 10-row limit) one at a time; its "trigger" field is a proposal, so re-test every row yourself. One row that meets all four conditions fires the cap; rows that miss a condition never add up. Grade-lowering and cap decisions may rest only on a check against the original or a named secondary source; recall and not-found-only claims go to the "check your copy" list with no grade effect.

| # | Condition | Test |
|---|---|---|
| 1 | Marked and attributed | The string is in quotation marks or a block quotation and is attributed to a named work (scare quotes and unattributed marks fail) |
| 2 | Sense-bearing difference | After normalisation, the draft wording differs in sense from the source by at least clause length, shown by route (a) or (b); a shorter difference never counts |
| 3 | Load-bearing | A claim or gloss in the draft relies on the string; an epigraph or ornament that nothing builds on fails |
| 4 | Unresolved | The string still stands as marked in the draft being graded; one the author has since fixed, removed or re-marked as a paraphrase fails |

- **Route (a), counter-passage.** You or the source-verifier read the passage in an edition that matches the one the author cites (the "edition used by the author" column of SOURCES.md), and it differs in sense; keep the counter-passage and its locator. A scanned copy read through OCR cannot ground VERIFIED-PRIMARY (flag REF-COPY-OCR), so it cannot support this route; a catalogue or abstract page grounds nothing; and a named secondary source that quotes the passage differently supports only "checked against a secondary source", never the cap.
- **Route (b), provenance proof.** The draft wording matches an archived report's wording (an earlier review of this essay; flag REVIEW-ECHO; show the word diff) and no opened text of the work contains it. The negative needs a complete searchable text (the "complete, searchable" flag in SOURCES.md); a partial corpus gives only UNVERIFIED with NOT-FOUND. Recall alone stays UNVERIFIED, and absence alone never makes a MISMATCH.
- **Normalise** before comparing: collapse whitespace, ignore punctuation, rejoin hyphenated line breaks, undo conversion artefacts (ligatures, soft hyphens, curly quotes, zero-width characters). A difference that normalisation removes never counts.
- **Near-matches** are recorded with their type and never count: an edition or translation variant; an ellipsis; a bracketed alteration; a published translation modified and flagged as such; a translation the author declares as their own with the original supplied; an OCR or conversion artefact.
- **Non-triggers:** OCR-ERROR, TRANSPOSED without change of sense, MISATTRIBUTED with genuine wording, MARKS-WITHOUT-SOURCE, NEAR-VERBATIM-UNMARKED, UNVERIFIED, SECONDARY-ECHO, and anything on text flagged by the precheck (`extract_quotes.py --precheck`: OCR or conversion artefacts, broken quotes, hidden or control characters).

Apply per row and stop at the first failure: precheck-flagged text, a non-trigger status, a near-match type, conditions 1, 3 and 4, then the evidence below. Record why a row failed.

| Status plus flags | Can fire | Evidence required |
|---|---|---|
| MISMATCH, route (a): counter-passage in matching edition | yes | the counter-passage and its locator |
| MISMATCH or PARAPHRASE-IN-QUOTES with REVIEW-ECHO, route (b) | yes | word diff against the archived report; no opened text of the work contains the wording |
| UNVERIFIED with NOT-FOUND from a complete searchable text of the matching edition | no on its own | supports a trigger only together with route (a) or (b); record the text, its completeness and the negative result |
| Any of the above, secondary source only | no | listed with the label "checked against a secondary source" |
| SECONDARY-ECHO, UNVERIFIED, NOT-FOUND in a partial corpus | no | none |
| OCR-ERROR, TRANSPOSED without change of sense, MISATTRIBUTED, NEAR-VERBATIM-UNMARKED, MARKS-WITHOUT-SOURCE | no | none |
| Anything on text flagged by the precheck | no | none |

**Effect when the cap fires:**
- The overall "as submitted" becomes F.
- Use of sources shows a conditional cell, `X (Y once <named fix> is done)`: X is its grade as submitted and Y is the grade with the named quotations fixed and the remaining citation problems still counted (the source-verifier proposes Y in its grade suggestion; you decide).
- The "alone" grade (the grade on the writing and argument alone) is computed with Y in place of X. No other cell changes: Originality and Mechanics are never capped.

**When no cap fires**, "alone" equals "as submitted": store both, print only the "as submitted" line, and print no conditional. Quick mode (a single inline pass with no specialist cross-check) never caps and prints "Integrity test not run: Use of sources unverified".

**Cap event log.** In STATE.md decisions, one entry per graded draft: for each row that reached the test, its QID, the result of conditions 1 to 4, the route, the evidence (counter-passage and locator, or word diff plus the texts searched with their completeness), the near-match type if any, and the decision; when the cap fires also Y, the named fix, both overall grades, and the target (the "alone" grade) with the rule. With no firing row write "cap: none; N rows tested".

## 6. Status and flag definitions

Statuses (one per ledger row):
- VERIFIED-PRIMARY: wording and locator confirmed against the original in a matching edition.
- VERIFIED-SECONDARY: confirmed against a named secondary source.
- UNVERIFIED: not checked or not checkable, which means not wrong.
- MISMATCH: wording differs in sense from a located counter-passage.
- PARAPHRASE-IN-QUOTES: the source was found and its sense is paraphrased inside marks attributed to it (can feed the cap).
- OCR-ERROR: the draft string differs from the source only by character corruption of the kind scanning or conversion produces.
- MISATTRIBUTED: genuine wording credited to the wrong author or work (with QUOTED-IN: state the corpus searched and its completeness, where the wording appears, and the remedy "cite as quoted in <intermediary>").
- TRANSPOSED: reordered wording with no change of sense.
- NEAR-VERBATIM-UNMARKED: close source wording without quotation marks.
- MARKS-WITHOUT-SOURCE: the marked text is the author's own or has no source, as with scare quotes.

Flags (added to a status when they apply). REVIEW-ECHO: the draft wording matches an archived report's wording. SECONDARY-ECHO: it matches a secondary summary's own phrasing (status UNVERIFIED plus SECONDARY-ECHO, or VERIFIED-SECONDARY if the author cites the summary). SWAPPED-WORDS: a short quoted phrase with a few words changed from an earlier report's wording. NOT-FOUND: a search of a named text found nothing. QUOTED-IN: the wording appears in an intermediary the author did not cite. REF-COPY-OCR: the only copy of the source is a scan with OCR, so it cannot ground VERIFIED-PRIMARY.

Which report section prints each status, and whether it counts as a defect, is the status table in report-sections.md; the decision table above says what can fire the cap.

## 7. Confidence, flags, disagreement and repeat

Confidence is categorical, with named reasons. Print the category, every reason that applies (names exactly as below) and the word "uncalibrated". **Low** if any low reason applies; **medium** if no low reason applies and any medium reason does; **high** otherwise.

| Reason | Level | Test |
|---|---|---|
| no confirmed anchors | low | `select_anchors.py` returned none; grading was rubric-only (print the "unanchored" banner) |
| cross-check disagreement | low | the disagreement signal below fired |
| a cap fired | low | section 5 fired the cap |
| unverified-quotation share over 30% | medium | UNVERIFIED rows divided by the attributed quotations checked this round (the count line's c over N) exceeds 0.30 |
| within one step of a tie point | medium | the unrounded "alone" mean (after a repeat, the mean of record) is within 0.05 points of a tie point, so one criterion moving one step could change the overall step |
| top band | medium | the "alone" grade is A or A- (also when the overall is partial) |
| same-essay anchors only | medium | every selected anchor (a human-confirmed graded earlier draft shown as a scale reference) is an earlier draft of this essay |
| non-zero repeat spread | medium | the two repeat runs differ on any criterion or on the overall |
| model-version change since the anchors were graded | medium | the model recorded for this run differs from the model recorded on any selected anchor |
| high dispersion across criteria | medium | the highest and lowest graded values in the "alone" computation differ by 13 tenths or more |

Agreement among reviewers never raises confidence: they share one model family and one draft, so their agreement is not independent confirmation. Nothing raises a category; agreement, or a repeat with zero spread, only leaves the reasons above unmet. The thresholds (30%, 0.05 points, 13 tenths) stay provisional and the note stays "uncalibrated" until a gold set of human-confirmed grades shows that it separates larger errors from smaller ones.

**Human-check flag.** Set it, and print the trigger that set it, when any of these holds: the top band (the "alone" grade is A or A-); any cap; cross-check disagreement (including two runs differing by a letter band); no confirmed anchors; the repeat conditions below hold but `--repeat` was not passed.

**Disagreement signal (full mode only).** Before running `compute_grade.py`, record your holistic letter grade for the essay (a letter, plus or minus allowed) in STATE.md decisions with the draft number, and never edit it afterwards; it never changes the computed grade. The signal fires when its band differs from the band of the "alone" grade, or when the two runs of a repeat have "alone" grades in different bands (a band is a letter: A and A- are one band, B+, B and B- another).

**Repeat rule (full mode; opt-in with `--repeat`).** Conditions: the unrounded "alone" mean is within 0.05 points of a tie point, or the "alone" grade is in the A range. Without the flag the conditions only set the human-check flag. With it:
1. Run each owner of a graded criterion once more, with the same inputs in a fresh context (owners: source-verifier for sources, primary-text-reviewer for primary, argument-reviewer for argument, structure and originality, mechanics-reviewer for mechanics).
2. Score the second run through `compute_grade.py`; the first pass's cap decision and ledger stand, and only criterion grades are re-graded.
3. Take, per criterion, the mean of the two runs' limited values in tenths (the conditional the same way), and run `compute_grade.py` again with those means in the grade field and `verified_strengths` set to the lower of the two counts. That result is the grade of record; a mean that lands on a tie point rounds by the harshness rule.
4. Log the spread (per criterion and overall, in tenths) and the cost (extra reviewer calls and tokens). Run the repeat at most once.

## 8. Print rule and target rule

**No reliable change.** When a criterion cell or an overall moved by one step or less since the previous draft and you cannot cite criterion-level evidence, print "no reliable change" instead of any movement words, inside the bracket that holds the previous value: `(was B-; no reliable change)` (movement is counted in rungs; `compute_grade.py` reports it). Criterion-level evidence is a tracker row charged to that criterion verified RESOLVED or REMOVED-VERIFIED, newly opened or REGRESSED this round, or a verified strength gained or lost, cited by finding ID; for an overall, evidence for at least one criterion that moved. A cap is the cue for the "as submitted" line: `(was B-; cue: integrity cap)`. A move of more than one step prints with its cue: `(was C; cue: <finding IDs>)`. With no previous value (draft 1) print no bracket.

**Target.** The target is the lowest step of the next letter band above the "alone" grade; the distance is the rungs between them. Under a cap the target is the "alone" grade ("what it takes to restore it"), with no step count.

| "Alone" grade | A, A- | B+, B, B- | C+, C, C- | D+, D, D- | F |
|---|---|---|---|---|---|
| Target | none: top band, replace the steps section with the remaining defects | A- | B- | C- | D- |

## 9. Calibration guards and completeness

- Cite the cue behind every rubric row change, and justify any move of more than three steps in one criterion between drafts.
- Never use problem counts or list length as a proxy for a grade.
- Structure is graded only from structure-tagged findings, within one step of Argument unless two structure-specific findings justify more, and never double-counted (see grade-bands.md).
- Print the calibration-confidence note where a cell lies outside the grade range spanned by the confirmed anchors, and always beside Structure, which no anchor covers.

**Completeness invariant.** Before writing the report, list every row of the tracker (the issue table in STATE.md) that was open at the start of the round; each must end in exactly one place, or stop and fix the list. A recurrence tag is a printed tag such as "(second round)" generated from stored counters.

| Row state this round | Destination |
|---|---|
| RESOLVED, REMOVED-VERIFIED | What improved |
| OPEN, PARTIAL, RECURRING, REGRESSED | A problem, citation or proofreading list, with its recurrence tag (held-back problems: the one-sentence list of open issues) |
| WITHDRAWN | The Correction section |
| SUPERSEDED | Its child row, which has its own destination |
| No reviewer return (CANNOT-CHECK) | Carried forward at the same severity as "not rechecked", never dropped, including after a wholesale rewrite |
