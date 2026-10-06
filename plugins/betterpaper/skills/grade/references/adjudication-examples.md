# Adjudication examples: worked numbers on invented data

Every essay, work, quotation, page number and error below is invented. Each number was computed with exact fractions, and `compute_grade.py` must reproduce each result exactly. See adjudication.md for the rules these examples apply. Scale in tenths: A 40, A- 37, B+ 33, B 30, B- 27, C+ 23, C 20, C- 17, D+ 13, D 10, D- 7, F 0. Tie points (midpoints, in tenths): A/A- 38.5, A-/B+ 35, B+/B 31.5, B/B- 28.5, B-/C+ 25, C+/C 21.5, C/C- 18.5, C-/D+ 15, D+/D 11.5, D/D- 8.5, D-/F 3.5. The gaps are not equal: A- to B+, B- to C+ and C- to D+ are 4 tenths, D- to F is 7, the rest are 3. Ladder positions for counting steps: F 0, D- 1, D 2, D+ 3, C- 4, C 5, C+ 6, B- 7, B 8, B+ 9, A- 10, A 11.

**Terms used below.** A verified strength is a reviewer-listed positive, tagged to a grade-band descriptor, whose draft quote passed the cited-span check; a grade of B+ or above needs two under harsh and one under neutral, otherwise that value is limited to B. The near-tie flag means the mean is within 0.05 points (half a tenth) of a tie point. The integrity cap sets the overall "as submitted" to F, shows Use of sources as a conditional cell `X (Y once <named fix> is done)`, and computes the "alone" grade with Y in place of X; it needs one quotation meeting four conditions: (1) marked and attributed to a named work, (2) a sense-bearing difference of at least clause length, shown by route (a), a counter-passage in an edition matching the author's, or route (b), wording that matches an archived earlier report and appears in no opened text of the work, (3) load-bearing, (4) unresolved in the draft being graded. Criterion-level evidence is a tracker row of that criterion verified resolved, newly opened or regressed this round, or a verified strength gained or lost.

**Reading the inputs.** Each input table gives the values of the grades.json fields of the same name (`weights`, `criteria.<key>.grade`, `.conditional`, `.verified_strengths`, `harshness`); the tenths column is derived, not an input. Unless a table says otherwise, every `previous` is null, `previous_overall` is `{"as_submitted": null, "alone": null}` and `cap` is `{"fired": false, "basis": []}`. S is the sum of weight x tenths over graded criteria and W the sum of their weights. To round, compare 2S with (hi + lo) x W for the two adjacent steps around the mean S/W: below gives lo, above gives hi, equal is an exact tie.

## Example 1: an exact tie, resolved differently under harsh and neutral

Input (`harshness` harsh, then neutral; nothing else changes):

| Key | grade | tenths | weight | verified_strengths |
|---|---|---|---|---|
| primary | B- | 27 | 2 | 0 |
| argument | C+ | 23 | 1 | 0 |
| structure | C+ | 23 | 1 | 0 |
| sources | B- | 27 | 2 | 0 |
| originality | C+ | 23 | 1 | 0 |
| mechanics | C+ | 23 | 1 | 0 |

Working: S = 2x27 + 23 + 23 + 2x27 + 23 + 23 = 200; W = 2+1+1+2+1+1 = 8; mean = 200/8 = 25 tenths. The adjacent steps are B- (27) and C+ (23): (27 + 23) x 8 = 400 = 2S, so the mean sits exactly on a tie point (a 4-tenth gap). No grade is B+ or above, so no verified-strength limit applies.

Result: harsh takes the lower step, so `as_submitted` C+ and `alone` C+. Neutral takes the higher step, so B- and B-. The exact-tie flag is yes under both, and the near-tie flag is yes.

Variant on a 3-tenth gap (all weights 1; grades B, B, B, B-, B-, B-): S = 171, W = 6, mean 28.5; (30 + 27) x 6 = 342 = 2S, an exact tie between B (30) and B- (27): harsh B-, neutral B.

## Example 2: an integrity cap and its conditional cell

Input (`harshness` harsh; neutral gives the same result), all weights 1:

| Key | grade | tenths | conditional | verified_strengths |
|---|---|---|---|---|
| primary | B | 30 | | 0 |
| argument | B- | 27 | | 0 |
| structure | B- | 27 | | 0 |
| sources | D | 10 | B (30) | 0 |
| originality | C+ | 23 | | 0 |
| mechanics | B- | 27 | | 0 |

Cap data: `{"fired": true, "basis": ["q-3b9e41 route-a"]}`; `previous_overall` `{"as_submitted": "B-", "alone": "B-"}`. The same input as a complete grades.json:

```json
{"harshness": "harsh",
 "weights": {"primary": 1, "argument": 1, "structure": 1, "sources": 1, "originality": 1, "mechanics": 1},
 "criteria": {
  "primary": {"grade": "B", "verified_strengths": 0, "previous": null},
  "argument": {"grade": "B-", "verified_strengths": 0, "previous": null},
  "structure": {"grade": "B-", "verified_strengths": 0, "previous": null},
  "sources": {"grade": "D", "conditional": "B", "verified_strengths": 0, "previous": null},
  "originality": {"grade": "C+", "verified_strengths": 0, "previous": null},
  "mechanics": {"grade": "B-", "verified_strengths": 0, "previous": null}},
 "cap": {"fired": true, "basis": ["q-3b9e41 route-a"]},
 "previous_overall": {"as_submitted": "B-", "alone": "B-"}}
```

The one ledger row that reached the test (an invented treatise on tidal engineering, quoted in draft 3):

| Field | Value |
|---|---|
| QID, locator | q-3b9e41, paragraph 14 |
| Draft string | "a basin dredged twice a year cannot silt, so its sluice may stay shut" |
| Attributed to | the author of the treatise *The Tidal Basin Ledger*, second edition (the edition the author cites in SOURCES.md) |
| Status, flags | MISMATCH, none |
| Counter-passage | second edition, p. 88: "a basin dredged twice a year still silts at its sluice, so the sluice must be worked on every tide" (opened in full, matching edition; checked against the original) |
| Conditions 1 to 4 | yes (marks, attributed to a named work); yes (route (a): after normalising, the clause differs in sense); yes (the next sentence builds "no flushing schedule is needed" on it); yes (unchanged in draft 3) |

Working: MISMATCH with a counter-passage in the matching edition meets the first row of the decision table in adjudication.md (a status that can fire, with its evidence), so the cap fires. `as_submitted` is F. For `alone`, Y = B (30) replaces X = D (10) on sources: S = 30 + 27 + 27 + 30 + 23 + 27 = 164; W = 6; mean 82/3 = 27.33; (30 + 27) x 6 = 342 and 2S = 328 is below it, so the lower step B-. No tie, not near a tie point.

Result: `as_submitted` F, `alone` B-; movement from `previous_overall`: -7 and 0. The sources cell prints "D (B once the quotation in paragraph 14 is corrected)". Printed lines, assuming no criterion-level evidence for the second: "As submitted: F (was B-)" and "On the writing and argument alone: B- (no reliable change)". The target is B- ("what it takes to restore it"). Log: "cap: fired; q-3b9e41 route (a); Y = B; fix: replace the string with the exact second-edition sentence, or paraphrase it fully with a citation; alone B-".

## Example 3: a partial grade (structure not graded)

Input (harsh; neutral gives the same result):

| Key | grade | tenths | weight | verified_strengths |
|---|---|---|---|---|
| primary | B | 30 | 2 | 0 |
| argument | B+ | 33 | 2 | 2 |
| structure | null | none | 1 | 0 |
| sources | B- | 27 | 2 | 0 |
| originality | C+ | 23 | 1 | 0 |
| mechanics | B | 30 | 1 | 0 |

Working: structure is left out of both sums, so W = 2+2+2+1+1 = 8 (not 9). Argument is B+ with 2 verified strengths, which meets the harsh requirement of 2, so no limit. S = 2x30 + 2x33 + 2x27 + 23 + 30 = 233; mean 233/8 = 29.125; (30 + 27) x 8 = 456 and 2S = 466 is above it, so the higher step B. Not near a tie point (466 - 456 = 10 > 8).

Result: `as_submitted` B, `alone` B, partial flag yes, structure cell "n/a", and this overall is excluded from top-band counts. Counting structure as F would give 233/9 = 25.9 and B-, which is wrong.

## Example 4: a verified-strength limit (B+ proposed with too few)

Input (all weights 1), run once with `harshness` harsh (requires 2 verified strengths for B+ or above) and once with neutral (requires 1):

| Key | grade | tenths | verified_strengths |
|---|---|---|---|
| primary | B | 30 | 0 |
| argument | B+ | 33 | 1 |
| structure | B | 30 | 0 |
| sources | B- | 27 | 0 |
| originality | C+ | 23 | 0 |
| mechanics | B+ | 33 | 0 |

Working, harsh: argument has 1 of 2, so it is limited to B (30); mechanics has 0 of 2, so it is limited to B (30). S = 30 + 30 + 30 + 27 + 23 + 30 = 170; mean 85/3 = 28.33; (30 + 27) x 6 = 342 and 2S = 340 is below it, so the lower step B-. Neutral: argument has 1 of 1, so B+ (33) stands; mechanics has 0 of 1, so it is still limited to B. S = 30 + 33 + 30 + 27 + 23 + 30 = 173; mean 173/6 = 28.83; 2S = 346 is above 342, so the higher step B.

Result: harsh `alone` B- (limits: argument B+ to B, mechanics B+ to B); neutral `alone` B (limit: mechanics B+ to B). Both means are near the tie point 28.5 (differences 2 and 4, at most W = 6), so without `--repeat` the human-check flag is set, and with `--repeat` the repeat rule fires (example 5).

## Example 5: a repeat (two runs averaged in tenths)

Input: `harshness` harsh, all weights 1, `--repeat` passed, all `verified_strengths` 0, `previous_overall` `{"as_submitted": "B", "alone": "B"}`. Run 1 is the first pass; run 2 is the repeat.

| Key | Run 1 | Run 2 | Mean (tenths) | Displayed (harsh) |
|---|---|---|---|---|
| primary | B (30) | B (30) | 30 | B |
| argument | B (30) | B- (27) | 28.5 | B- (exact tie, lower step) |
| structure | B (30) | B (30) | 30 | B |
| sources | B (30) | B- (27) | 28.5 | B- (exact tie, lower step) |
| originality | B (30) | B (30) | 30 | B |
| mechanics | C+ (23) | C+ (23) | 23 | C+ |

Working: run 1 has S = 173, mean 173/6 = 28.83; (30 + 27) x 6 = 342 and 2S = 346, so B, and 346 - 342 = 4 <= W = 6 puts it within 0.05 points of a tie point. The repeat rule fires: re-run the owners of every graded criterion (four reviewer calls: the owners for sources, primary, argument with structure and originality, and mechanics). Run 2 through the script: S = 167, mean 27.83, 2S = 334 is below 342, so B-. Both runs are in the B band, so no disagreement from the runs. Re-run `compute_grade.py` with the means as numbers in the grade field (30, 28.5, 30, 28.5, 30, 23) and `verified_strengths` 0: S = 170, W = 6, mean 85/3 = 28.33; 2S = 340 is below 342, so the lower step B-.

Result: the grade of record is B- for `as_submitted` and `alone` (run 1 alone gave B). Logged spread: argument 3 tenths, sources 3, the other criteria 0, overall 1 tenth; cost 4 extra reviewer calls. Confidence gains the reasons "non-zero repeat spread" and "within one step of a tie point" (340 is 2 from 342), so it is medium (assuming no low reason applies). The overall moved from B to B- (-1 step); with no criterion-level evidence for any criterion that moved, print "no reliable change" and keep "was B" in the bracket.

## Example 6: two negative controls that must not cap

Input: the grades of example 2 except sources is B- (27) with no conditional; cap data `{"fired": false, "basis": []}`; all weights 1, harsh. Two ledger rows reach the test and neither fires.

| Field | 6a: recall-only item | 6b: different-edition variant |
|---|---|---|
| QID, locator | q-81d5c2, paragraph 6 | q-5e90a7, paragraph 9 |
| Draft string | "every sluice should be logged at the turn of the tide" | "dredging follows the spring tides, never the neaps" |
| Attributed to | the treatise (no copy opened) | the treatise, second edition (as the author cites it) |
| What the check found | a reviewer recalls different wording; no opened text | the opened first-edition excerpt (p. 61) reads "dredging follows the neap tides, never the springs" |
| Status, flags, label | UNVERIFIED, none, "as I recall: check your copy" | UNVERIFIED, none, diff type "edition or translation variant" |
| Conditions 1 to 4 | yes, **no**, yes, yes | yes, **no**, yes, yes |
| Why condition 2 fails | recall alone is no counter-passage, and no archived report echoes it, so neither route holds | the counter-passage is not in an edition matching the author's, so route (a) fails; the difference is an edition variant, a near-match recorded and never counted; no archived report echoes it, so route (b) fails |
| Destination | Citation problems, "check your copy" list, no grade effect | same list, with a note that the editions may differ |

Working: no row fires, so `cap.fired` is false and the log reads "cap: none; 2 rows tested". S = 30 + 27 + 27 + 27 + 23 + 27 = 161; W = 6; mean 161/6 = 26.83; (27 + 23) x 6 = 300 and 2S = 322 is above it, so the higher step B-.

Result: `as_submitted` B- and `alone` B- (equal; both stored); only the "as submitted" line prints, with no conditional cell. Neutral gives the same.

## Example 7: the target rule

| Case | "Alone" grade | Target | Distance |
|---|---|---|---|
| Example 1, harsh | C+ | B- (lowest step of the B band) | 1 step (C+ 6 to B- 7) |
| Example 1, neutral | B- | A- | 3 steps (7 to 10) |
| Example 3 | B | A- | 2 steps (8 to 10) |
| Example 2 (cap fired) | B- | B- ("what it takes to restore it") | none: the target is the "alone" grade |
| Any A or A- | A or A- | none: print "not in the top band" and list the remaining defects | none |
