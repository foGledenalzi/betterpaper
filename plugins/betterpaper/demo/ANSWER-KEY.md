# Answer key: What the Glass Answers (fictional demo)

Fictional demo: every grade, quotation, source, anchor and name in this key is invented, to test the plugin's format and logic. No demo grade is evidence of how the plugin grades a real essay. The key is for checking a run; a grade run does not read it.

## 1. Notice and tolerance

- Arithmetic is exact. Grades in tenths, rounding, tie direction, near-tie flags, verified-strength limits, partial marks and movements in rungs must match this key to the digit.
- A reviewer's grade suggestion for one criterion may differ from this key by one step, and the wording of any report sentence may differ (section 8). Statuses, counters, quotation IDs, cap decisions and printed tags are not wording and must match.
- The key describes the first run on `draft-3-to-grade.md` from the stored state at draft 2 (the file is saved as draft 3, `next_draft` 3). A workspace that already holds a quick run of the same file starts from changed state, so compare from a fresh copy.
- Source IDs: s-1 the first edition (complete, searchable), s-2 the Linden guide, s-3 the second edition excerpt (pages 13, 52 and 71 only), s-4 the Larkmoor catalogue page, s-5 Weir-Anand (never supplied). Page numbers are first-edition pages unless marked.

## 2. Quotations

A QID is `q-` and the first six hex digits of the sha1 of the normalised string. Rows q1 to q11 are the 11 stored ledger rows; q12 to q21 are new in draft 3; q2 and q9 occur in draft 3 as well. After the run the ledger holds 21 rows: q1, q3 to q8, q10 and q11 stay as records (`draft` at the last draft that held them), q2 and q9 move to draft 3 with `round_verified` 3 (q9 `rounds_open` 2), and q12 to q21 are added.

| id | qid | drafts, locator | status; flags | label | counts toward split | trigger, reason |
|---|---|---|---|---|---|---|
| q1 | q-f6b49d | 1 2, para 1 | VERIFIED-PRIMARY; none | checked against the original (first edition, 9) | no | no: verified |
| q2 | q-a22e4f | 1 2 3, para 2 (note 1 in draft 3) | VERIFIED-PRIMARY; none | checked against the original (first edition, 11) | no | no: verified; re-verified in draft 3, not carried forward (q18 is an OCR-ERROR) |
| q3 | q-c01568 | 1 2, para 2 | VERIFIED-PRIMARY; none | checked against the original (first edition, 14) | no | no: verified |
| q4 | q-188599 | 1 2, para 3 | VERIFIED-PRIMARY; none | checked against the original (first edition, 15) | no | no: verified |
| q5 | q-62a625 | 1 2, para 7 | VERIFIED-PRIMARY; none | checked against the original (first edition, 49) | no | no: verified |
| q6 | q-6071dc | 1 2, para 4 | VERIFIED-PRIMARY; none | checked against the original (first edition, 33) | no | no: verified |
| q7 | q-a67e36 | 1 2, para 7 | VERIFIED-PRIMARY; none | checked against the original (first edition, 60) | no | no: verified |
| q8 | q-dd85b3 | 1 2, para 5 | VERIFIED-PRIMARY; none | checked against the original (first edition, 55) | no | no: verified |
| q9 | q-d9951c | 2 3, para 3 (note 5) | MISATTRIBUTED; QUOTED-IN | checked against a secondary source (Linden, A Short Guide) | no | no: genuine wording, wrong author (Weir-Anand per the guide, paragraph 3); not in the first edition; remedy: cite as quoted in Linden |
| q10 | q-ee0f90 | 2, para 5 | NEAR-VERBATIM-UNMARKED; none | checked against the original (first edition, 39) | no | no: condition 1 fails (no marks, no attribution) |
| q11 | q-cf706d | 2, para 6 | MARKS-WITHOUT-SOURCE; none | in my reading | no | no: condition 1 fails (a scare quote, no attribution) |
| q12 | q-a4a89f | 3, para 4 (note 7) | VERIFIED-PRIMARY; none | checked against the original (first edition, 19) | no | no: verified; it exposes the withdrawn claim (PRIM-003) |
| q13 | q-7bccd2 | 3, para 5 (note 11) | MISMATCH; none | checked against the original (first edition, 23) | yes | YES, route (a): cannot be mistaken against may still be mistaken, because the thick grit hides the lowest mark (sec. 5, p. 23); the next sentence builds the foot needs no second look on it |
| q14 | q-fa3917 | 3, para 3 (note 4) | PARAPHRASE-IN-QUOTES; REVIEW-ECHO | matches wording in the draft 1 report | yes | YES, route (b): the word diff against the draft 1 report is the capital and the full stop; absent from the complete s-1 (nearest sentence sec. 6, p. 28); the reply in paragraph 3 rests on it |
| q15 | q-515d48 | 3, para 5 (note 12) | UNVERIFIED (diff type: edition or translation variant); none | check this against Karvale, first edition, 44 | no | no: near-match, the wording is the second edition's (s-3, p. 52); the first edition's sentence (p. 44) reads differently |
| q16 | q-db1a04 | 3, para 4 (note 8) | UNVERIFIED; none | as I recall: check your copy | no | no: recall alone, no copy opened (Weir-Anand, s-5) |
| q17 | q-8803a9 | 3, para 3 (note 6) | UNVERIFIED; SECONDARY-ECHO, NOT-FOUND | not found in the first edition (complete, searchable) | no | no: the guide's own phrasing (s-2, paragraph 2); a secondary source never fires the cap |
| q18 | q-b1704b | 3, para 2 (note 3) | OCR-ERROR; none | checked against the original (first edition, 16) | no | no: non-trigger status on text the precheck flags; corrupted tal1y, corrected tally |
| q19 | q-e16fdb | 3, para 4 (note 9) | UNVERIFIED; NOT-FOUND | not found in the first edition (complete, searchable) | no | no: a catalogue page (s-4) grounds nothing; NOT-FOUND needs route (a) or (b) too |
| q20 | q-f98893 | 3, para 2 (note 2) | UNVERIFIED (diff type: declared own translation, original supplied); none | check this against the 1926 original | no | no: a declared own translation is a near-match; the published sentence is sec. 2, p. 11 |
| q21 | q-fbe7f5 | 3, para 5 (note 10) | TRANSPOSED; none | checked against the original (first edition, 39) | no | no: reordered wording, same sense (sec. 8, p. 39); child of the row for q10 |

Count lines, as printed under Quotation problems or Citation problems:
- Draft 1: `8 attributed quotations checked: 8 against the original, 0 against a secondary source, 0 unverified, 0 with defects`
- Draft 2 (q10 counts as original, q11 as unverified): `11 attributed quotations checked: 9 against the original, 1 against a secondary source, 1 unverified, 3 with defects`
- Draft 3: `12 attributed quotations checked: 6 against the original, 1 against a secondary source, 5 unverified, 5 with defects`. Original: q2, q12, q13, q14, q18, q21. Secondary: q9. Unverified: q15, q16, q17, q19, q20. Defects: q9, q13, q14, q18, q21. The rows that reach the cap test are the non-VERIFIED rows: 0 in draft 1, 3 in draft 2 (q9, q10, q11), 10 in draft 3.

Where each draft 3 row prints: q13 and q14 are numbered entries (SRC-004, SRC-005, counts toward split: yes); q9 (SRC-001) and q21 (SRC-007) are numbered entries (counts toward split: no); q18 (SRC-006) is one line; q15, q16, q17, q19 and q20 go to the "check your copy" list under Citation problems and are never called errors; q2 and q12 are never listed.

Used by: script tests (`extract_quotes.py`: the worksheet lists these QIDs, and `--precheck` flags `tal1y` only and finds no injection text; `echo_check.py`: q14 matches the draft 1 review as REVIEW-ECHO, q17 and q9 match the guide, the sentence `p18` of the comment appears unquoted in draft 3, and nothing is reported against the author's own earlier drafts); a grade run (ledger statuses and flags).

## 3. Cap decision

Fires in draft 3: q13 and q14, each with conditions 1 to 4 yes. Must not cap, and why (conditions 1 to 4 as yes or no; a row stops at the first failing step):

| row | conditions | why it cannot fire |
|---|---|---|
| q9 | y n y y | MISATTRIBUTED is a non-trigger status: genuine wording, wrong author |
| q15 | y n y y | near-match (edition or translation variant), never counted |
| q16 | y n y y | recall alone is no counter-passage, and no archived report echoes the wording |
| q17 | y n y y | SECONDARY-ECHO: a secondary source never fires the cap |
| q18 | y n y y | OCR-ERROR on text flagged by the precheck |
| q19 | y n y y | NOT-FOUND alone needs route (a) or (b); a catalogue page grounds nothing |
| q20 | y n y y | near-match (declared own translation, original supplied) |
| q21 | y n y y | TRANSPOSED without change of sense |
| q10 | n - - - | draft 2: no quotation marks (condition 1 fails) |
| q11 | n - - - | draft 2: no attribution (condition 1 fails) |

- Never tested: every VERIFIED row. Drafts 1 and 2 never capped: the stored cap log reads `cap: none; 0 rows tested` and `cap: none; 3 rows tested`. The quick run never caps and runs no integrity test.
- Cap event log entry for draft 3: `cap: fired; q-7bccd2 conditions 1 to 4 yes, route (a), counter-passage first edition sec. 5 p. 23; q-fa3917 conditions 1 to 4 yes, route (b), word diff capital and full stop only, s-1 complete and searchable; 8 other rows failed at condition 2 or earlier (q9, q15 to q21); Y = C+; fix: replace both strings with the exact source sentences or paraphrase fully with a citation; as submitted F, alone B-; target B- under the cap rule`. Basis in the grades file: `q-7bccd2 route-a` and `q-fa3917 route-b`.
- Effect: as submitted F; Use of sources shows `D (C+ once the quotations in paragraphs 3 and 5 are corrected)`; the alone grade uses C+ in place of D; Originality and Mechanics are never capped.

Used by: a grade run (adjudication).

## 4. Tracker

Status is written `rounds_flagged/drafts_present/last_seen`. The first block of rows is the stored state at draft 2; the second is the state a full run leaves.

| id | code (tier) | stored at draft 2 | after draft 3 | report: place, tags, evidence |
|---|---|---|---|---|
| PRIM-001 | RELATION-INVERTED (1) | RESOLVED 1/1/1 | unchanged | not printed; draft 1 holds p1, draft 2 has it gone and p2 present |
| PRIM-002 | DISTINCTION-COLLAPSED (1) | RECURRING 2/2/2 | PARTIAL 3/3/3, anchor now para 6, A glass at rest | ranked problem 1; `(round 3)` `(half fixed)`; draft 1: p3, p5; draft 2: p4, p5; draft 3: p3 and p4 gone, p5 stays |
| PRIM-003 | TERM-VS-SOURCE (1) | RECURRING 2/2/2 | WITHDRAWN 2/2/2, origin earlier-review error | Correction to the draft 1 review; q12 uses settle of the grit and of the observer |
| ARG-001 | NO-EVIDENCE (2) | RESOLVED 1/1/1 | REGRESSED 2/1/3, `reopened=1`, origin earlier-review suggestion | ranked problem 2; `(round 2)` `(reopened)`; p7 bare in draft 1, p9 added before it in draft 2, p9 cut in draft 3 |
| ARG-002 | BRIDGE-GAP (3) | RECURRING 2/2/2 | RECURRING 3/3/3 | ranked problem 3; `(round 3)` `(unchanged since draft 1)`; p8 in all drafts |
| ARG-003 | QUOTE-WITHOUT-GLOSS (3) | RECURRING 2/2/2 | RESOLVED 2/2/2 | What improved; q4 and p16 had no gloss in drafts 1 and 2, every draft 3 quotation is framed |
| ARG-004 | EXAMPLE-FIT (4) | OPEN 1/1/2 (first seen 2) | REMOVED-VERIFIED 1/1/2; `gone=yes; function_still_served=no; replacement_support=no` | What improved, and Correction to the draft 2 review; no child row: the gap is ARG-001, matched by category, subtype and anchor |
| STRU-001 | WEAK-ENDING (4) | RECURRING 2/2/2 | RECURRING 3/3/3 | ranked problem 4; `(round 3)` `(unchanged since draft 1)`; p10 in all drafts |
| SRC-001 | QUO MISATTRIBUTED, q9 | OPEN 1/1/2 | RECURRING 2/2/3 | Quotation problems; `(second round)` `(unchanged since draft 2)` |
| SRC-002 | QUO NEAR-VERBATIM-UNMARKED, q10 | OPEN 1/1/2 | SUPERSEDED 1/1/2, child SRC-007 | prints through SRC-007; the author added marks and reordered |
| SRC-003 | QUO MARKS-WITHOUT-SOURCE, q11 | OPEN 1/1/2 | RESOLVED 1/1/2 | What improved; reworded `a view that puts convention first` |
| SRC-004 | QUO MISMATCH, q13 (tier 0) | none | OPEN 1/1/3 | Quotation problems; fires the cap |
| SRC-005 | QUO PARAPHRASE-IN-QUOTES, q14 (tier 0) | none | OPEN 1/1/3 | Quotation problems; fires the cap |
| SRC-006 | QUO OCR-ERROR, q18 | none | OPEN 1/1/3 | one line: tal1y corrected to tally, and check every quotation against the printed edition |
| SRC-007 | QUO TRANSPOSED, q21 | none | OPEN 1/1/3; `follow_up_of` and `thread` SRC-002 | numbered entry, no tag |
| SRC-008 | CIT, note 1 | none | OPEN 1/1/3 | Citation problems; citation ledger gap `translator not named in the first note`; template `[First Last], *[Title]*, trans. [First Last] ([Publisher], [year]), [page].` |
| MECH-001 | agreement | RECURRING 2/2/2 (2 instances) | PARTIAL 3/3/3 (1 instance) | Proofreading; `(half fixed)` `(pattern flagged in 3 reviews)`; draft 1: p11, p12; draft 2: p11, p13; draft 3: p13 |
| MECH-002 | apostrophe | RESOLVED 1/1/1 | unchanged | not printed; p14 in draft 1, gone in draft 2 |
| MECH-003 | comma-splice | RECURRING 2/2/2 | RESOLVED 2/2/2 | What improved; p15 in drafts 1 and 2, gone in draft 3 |

- Other keys: `instances` is 1 except MECH-001; `thread` is the row's own ID except SRC-007; `evidence_level` is original for PRIM and SRC rows and draft for the rest; `severity_history` holds one entry `{draft: first flagged, tier, reason: "first flagged"}` (SRC-004 and SRC-005: reason `integrity: fired the cap`; SRC-007: `marks added to the unmarked passage, clauses reordered`); `diagnosis` is one sentence naming the defect with no replacement wording (MECH rows end with the first trigger, a few words copied exactly); `origin` is essay except ARG-001 (earlier-review suggestion) and PRIM-003 (earlier-review error); `author_claim`, `claim_scope`, `follow_up_of` (except SRC-007), `confidence` and `display_group` are null; `verified_status` is null except as marked below.
- PATTERNS after draft 3: agreement `1:2 2:2 3:1`, consecutive 3, reviews 3; comma-splice `1:1 2:1 3:0`, consecutive 0, reviews 2; apostrophe `1:1 2:0 3:0`, consecutive 0, reviews 1. Class counts for draft 3 (839 words by `wc -w`): M1 1, M2 0, M3 0.
- Completeness: the 11 rows open at the start of the run end in PRIM-002, ARG-002, STRU-001, SRC-001 and MECH-001 (problems or lists), in ARG-003, ARG-004, SRC-003 and MECH-003 (What improved, in that order, with the unprompted gain `p17` after ARG-004), in PRIM-003 (Correction) and in SRC-002 (through SRC-007). New in draft 3: ARG-001 (REGRESSED), SRC-004 to SRC-008.
- Statuses exercised: OPEN, PARTIAL, RECURRING, REGRESSED, RESOLVED, REMOVED-VERIFIED, WITHDRAWN, SUPERSEDED.
- Correction to the draft 1 review (factual error): it said the treatise uses settle only of the grit coming to rest, labelled checked against the original (first edition, 19). That was wrong: sec. 4, p. 19 uses it of the grit and of the observer, and the draft exposed this by quoting the whole sentence. Consequence: Command of the treatise in the draft 2 column, C- would have been C (a footnote and a "would have been" line); draft 1 stays D on PRIM-001; the draft 2 overall stays C+ (136 over 6 is 22.67).
- Correction to the draft 2 review (backfired suggestion, sug-3): the suggestion to cut or reduce the example in paragraph 4 was incomplete, because the example was the only support for ARG-001; following it reopened that row. Argument stays C+. After draft 3 the suggestions log reads sug-3 relied yes, carried gap yes; `reviewer_wording` shows 3 as the later sighting of `a glass set against a stack of known lean still answers only`; rec-1 becomes adopted (draft 3 cites Weir-Anand).
- Quick run on draft 3: the same 11 rows are flagged CANNOT-CHECK and print `(not rechecked)`. Statuses, counters and `last_seen` are unchanged, no row is opened, and no ledger, tracker or anchor write happens. The history row reads `mode: quick`.
- With `--markers markers-draft-2.md`: five markers bind and one does not. `fixed [PRIM-002]`, `cited [SRC-001]` and `fixed [MECH-001]` end DISPUTED (the defect stands or is half fixed); `removed [ARG-004]` and `fixed [ARG-003]` end CONFIRMED. The last line (`fixed`, no ID) is listed in the run summary and stored nowhere. No marker moves a status, a counter or a grade.

Used by: a grade run (tracker update and report tags).

## 5. Grades

Scale in tenths: the usual twelve steps from A 40 to F 0; ladder positions F 0, D- 1, D 2, D+ 3, C- 4, C 5, C+ 6, B- 7, B 8, B+ 9, A- 10, A 11.

| draft | as submitted | alone | primary | argument | structure | sources (conditional) | originality | mechanics | S / W = mean | target |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 (2031-02-03) | C | C | D | C | C+ | B- | C+ | C | 123 / 6 = 20.5 | B- (2 steps) |
| 2 (2031-02-17) | C+ | C+ | C- | C+ | C+ | C | B | C | 133 / 6 = 22.17 | B- (1 step) |
| 3 (expected) | F | B- | B- | C+ | B- | D (C+) | B | C+ | 153 / 6 = 25.5 | B- (restore, no step count) |

- Draft 3 working, harsh, weights 1, cap fired: Originality B+ (33) has 1 verified strength and harsh needs 2, so it is limited to B (30). Alone uses the conditional: S = 27 + 23 + 27 + 23 + 30 + 23 = 153, W = 6, mean 25.5. The adjacent steps are B- (27) and C+ (23): (27 + 23) x 6 = 300 and 2S = 306 is above it, so the higher step, B-. No exact tie. Harsh and neutral agree (neutral: B+ stands, S = 156, 2S = 312, B-).
- Near a tie point: harsh yes (2S - 300 = 6, which is at most W = 6, the end of the range, which counts); neutral no (12 is more than 6). Dispersion is 7 tenths, below 13.
- Movement in rungs: as submitted -6, alone +1, primary +3, argument 0, structure +1, sources -3 (conditional +1), originality 0, mechanics +1.
- Printed lines: `As submitted: F (was C+; cue: integrity cap)` and `On the writing and argument alone: B- (was C+)`. The second moved one rung, but criterion-level evidence exists for criteria that moved (for example MECH-003 RESOLVED for Mechanics), so neither "no reliable change" nor a cue prints.
- Cell brackets: primary `(was C-; cue: PRIM-002, PRIM-003)`; argument `(was C+)`; structure `(was C+; no reliable change)` (one step, no structure-tagged row changed); sources `(was C; cue: SRC-004, SRC-005)` with the cell `D (C+ once the quotations in paragraphs 3 and 5 are corrected)`; originality `(was B)`; mechanics `(was C)` (one step, MECH-003 is the evidence). Beside Structure always: `Structure is uncalibrated: no confirmed anchor covers it`.
- Drivers (descriptor IDs): primary B- from prim-b-1 and prim-b-2, the minus from the PRIM-002 remainder in paragraph 6 (prim-c-2); argument C+ with ARG-001 bare (arg-c-2) and ARG-002 (arg-c-1), the plus from the fair objection `p17` (arg-b-2); structure B- from stru-b-1 and stru-b-2, one step above Argument, low confidence; sources D from q13 (src-d-1) and q14 (src-d-2), conditional C+ with one class of defect left (src-c-1: SRC-001, SRC-006, SRC-007) and SRC-008 a single slip of form, the plus from src-b-1 (q12 reproduces the first edition); originality B+ proposed on the residual contribution `p19` (orig-a-1), limited to B; mechanics C+ with agreement staying (mech-c-2), the plus from mech-b-2.
- After the run: a history row for draft 3 (report `reviews/draft-3.md`, mode full, tool_grade B-, overall as submitted F, alone B-, sources_conditional C+, target B-, `open_by_tier` `0:2 1:1 2:1 3:1 4:1`, imported no, human-adjusted no); `anchors/draft-3/` with `confirmed_by: unconfirmed`, overall as submitted F, alone B-; seven blank rows added to `CONFIRM.md`. No positioning flag is required.

The twelve cases of `grades-cases.json` (exact fractions; 2S is compared with (lo + hi) x W; the harness writes the case's harshness and weights into a temporary RUBRIC.md):

| case | input in short | S, W, mean | working | as submitted / alone | flags |
|---|---|---|---|---|---|
| tie-harsh | harsh; weights 2 1 1 2 1 1; B- C+ C+ B- C+ C+ | 200, 8, 25 | 2S = 400 = (27 + 23) x 8 | C+ / C+ | exact tie, near tie |
| tie-neutral | the same, neutral | 200, 8, 25 | the same tie, higher step | B- / B- | exact tie, near tie |
| tie-3-tenth-harsh | harsh; weights 1; B B B B- B- B- | 171, 6, 28.5 | 2S = 342 = (30 + 27) x 6 | B- / B- | exact tie, near tie |
| tie-3-tenth-neutral | the same, neutral | 171, 6, 28.5 | the same tie, higher step | B / B | exact tie, near tie |
| cap-conditional | harsh; B B- B- D (B) C+ B-; cap fired, `q-3b9e41 route-a` | 164, 6, 27.33 | 2S = 328 is below 342 | F / B- | none |
| partial-grade | harsh; weights 2 2 1 2 1 1; B, B+ (2 strengths), not graded, B-, C+, B | 233, 8, 29.125 | 2S = 466 is above 456; 10 is more than 8 | B / B | partial |
| verified-strength-limit-harsh | harsh; B B+ (1) B B- C+ B+ (0) | 170, 6, 28.33 | argument and mechanics limited to B; 2S = 340 is below 342 | B- / B- | near tie; limits argument:B+>B, mechanics:B+>B |
| verified-strength-limit-neutral | the same, neutral | 173, 6, 28.83 | only mechanics limited; 2S = 346 is above 342 | B / B | near tie; limits mechanics:B+>B |
| repeat-means | harsh; means 30 28.5 30 28.5 30 23 | 170, 6, 28.33 | 2S = 340 is below 342 | B- / B- | near tie |
| negative-controls-no-cap | harsh; B B- B- B- C+ B-; no cap | 161, 6, 26.83 | 2S = 322 is above 300 | B- / B- | none |
| demo-draft-3-harsh | harsh; B- C+ B- D (C+) B+ (1) C+; cap fired, `q-7bccd2 route-a` and `q-fa3917 route-b` | 153, 6, 25.5 | originality limited to B; 2S = 306 is above 300 | F / B- | near tie (6 of 6), no exact tie; limits originality:B+>B |
| demo-draft-3-neutral | the same, neutral | 156, 6, 26 | B+ stands; 2S = 312 is above 300 | F / B- | no tie flag, no limits |

Used by: script tests (`compute_grade.py` on the cases file); a grade run (grades and printed lines).

## 6. Header and sections of the draft 3 report

- Header: `anchors: 3 (1 near the top band)`; mode full; harshness harsh; style chicago-notes. `Confidence: low (uncalibrated): a cap fired; unverified-quotation share over 30% (5 of 12); within one step of a tie point`. No further reason applies (dispersion 7 tenths, below 13; the anchors record model `unknown` and are not same-essay anchors).
- `Human check: yes (any cap; repeat conditions hold but --repeat was not passed)`. The repeat condition is the near tie of the harsh run (6 of 6, ends included). With `--repeat` the four owners of graded criteria run again. The disagreement signal fires only if the recorded holistic grade is outside band B (not checked here).
- Section order for draft 3: header, grade lines, verdict (35 to 60 words; its first sentence gives the reason for the split and says everything else improved only if the tracker shows it), rubric table with one sentence on Originality (the residual contribution `p19`, 1 verified strength), What improved, the two Corrections, Quotation problems (above the ranking), MAJOR PROBLEMS, Citation problems, PROOFREADING, the steps, Sources consulted, the two-sentence footer. No Reading for the revision.
- Quotation problems: the count line, numbered entries for SRC-004 and SRC-005 (counts toward split: yes), SRC-001 and SRC-007 (no), one line for SRC-006, then the probable-cause and fix paragraphs.
- MAJOR PROBLEMS: the fixed sentence, the sentence that argument moves are the author's to accept or reject, then PRIM-002, ARG-001, ARG-002 and STRU-001 in that order. No problem is held back.
- PROOFREADING opens with the three-consecutive-drafts sentence for agreement, then the MECH-001 item with its tags.
- Steps: heading `WHAT IT WOULD TAKE TO REACH B-` with the words what it takes to restore it and no step count; 7 steps: the integrity fix first (SRC-004, SRC-005, restores B-), then PRIM-002, ARG-001, ARG-002, STRU-001, a mechanics step for MECH-001 (Mechanics C+ is below the target B-), and citation mechanics (SRC-008) last. The closing sentence names the open issues without a step: SRC-001, SRC-006, SRC-007.
- Sources consulted: s-1 (original), s-2 (secondary), s-3 (second edition excerpt, a different edition), s-4 (catalogue page, grounds nothing), s-5 Weir-Anand, no copy available; one disclaimer line naming the first edition and the Chicago Manual of Style, 18th edition, and the guide used for the echo check.
- Quick run header: the banner `Quick mode: no specialist cross-check ran` and `Integrity test not run: Use of sources unverified`; no count line and no quotation entries; no cap; only the as-submitted line prints.

Used by: a grade run (report).

## 7. Anchors, lint and cited spans

Anchors (all `imported: no`, `model: unknown`, note `fictional demo: invented calibration text`; the tool's grades, then confirmed). Grades are primary, argument, structure, sources, originality, mechanics.

| folder | essay slug | alone | grades | S, mean | confirmed_by, date | role |
|---|---|---|---|---|---|---|
| draft-21 | lantern-gauge | A- | A- A- B+ A- B+ A | 217, 36.17 | instructor, 2030-11-04 | the near-top-band anchor |
| draft-22 | pier-scale | B | B B B B- B- B | 174, 29.0 | author, 2030-11-04 | middle |
| draft-23 | tessel-glass-short | C+ | C+ C+ C+ C C+ C | 132, 22.0 | author, 2030-11-05 | near-duplicate of draft 3, excluded |
| draft-24 | reed-meter | D | D D+ D D D+ D (tool); sources adjusted to D- | 66 tool, 63 adjusted, 10.5 | instructor, 2030-11-06 | low band; `human_adjusted: yes` |

- `ANCHOR.md` rows: `tool_grade` equals `grade` except draft-24 sources (tool D, grade D-, status `adjusted`); all other rows are `confirmed`, each naming the header confirmer; the `overall_alone` row confirms D for draft-24. `CONFIRM.md` holds 28 rows (7 per anchor), all `confirm` except draft-24 sources (`adjust`, adjusted grade D-), so `init demo-essay --confirm` reports every row already applied.
- `select_anchors.py` on the workspace with draft 3 saved as `drafts/draft-3.md` prints `anchors: 3 (1 near the top band)` for every reviewer. Draft-23 is dropped as a near-duplicate (6-word runs cover at least 85% of its text; expected 95% to 100%, measured 97%); the others (coverage near 0) are kept and span A- to D. None of the anchor texts quotes the treatise.
- Order is ascending sha1 of the string `7|<reviewer>|<folder>`; check one with `python3 -c "import hashlib; print(hashlib.sha1(b'7|argument-reviewer|draft-21').hexdigest())"`.

| folder | argument-reviewer | primary-text-reviewer |
|---|---|---|
| draft-21 | 4bb5db133c5569556093bb38cf1c45d2c555fd27 | d3c2a3f17affa7aae22f1bad11ea700c9dc3f38d |
| draft-22 | 540bf3e53b0031df892db8c86d365ea08bf1c025 | 09d83afc19b7c3a9be7a4eaf3a01f07f58114641 |
| draft-23 (excluded) | c75366b91988a669d9558e81ba4e781d18b48acc | 4fa90add585421478e7df368d88dc50797fbbdf2 |
| draft-24 | f5406e7c7c05058d31aab31a44154f3cee1b6ced | 848e509e3c01114ae2b3ffba6a57cdfb7cb5b63d |

- Orders (draft-23 excluded): source-verifier `draft-21, draft-22, draft-24`; primary-text-reviewer `draft-22, draft-24, draft-21`; argument-reviewer `draft-21, draft-22, draft-24`; mechanics-reviewer `draft-22, draft-24, draft-21`; voice-echo-reviewer `draft-21, draft-24, draft-22`. The anchor-order log gets one row per reviewer for draft 3.
- Lint: `report_lint.py sample-report.md draft-3-to-grade.md` exits 0 with no flag. `lint-fail-sample.md` differs from it in one line only, step 2: `Argue that the agreement is made by the cutting, not found in the stack, and cut the rest (ARG-002).` It repeats 12 consecutive words of the author's text outside marks and is a claim a writer could paste, so the lint exits 1 and names that sentence and no other.
- Cited spans: `check_cited_spans.py draft-3-to-grade.md findings-fabricated.md` keeps finding `f-1` and ledger line 1 (the full q13 string), drops finding `f-2` and ledger line 2 (QID `q-0f0f0f`) as "paraphrase, not a quotation", and exits 1. The Locator column is never checked.

Used by: script tests (`select_anchors.py`, `report_lint.py`, `check_cited_spans.py`); a grade run (the intake line and the anchor-order log).

## 8. Not checked

The holistic grade the orchestrator records before computing; the wording of report prose; reviewer grade suggestions (a one-step difference is within tolerance); token counts and the cost log; the model ID printed in the header; run dates.
