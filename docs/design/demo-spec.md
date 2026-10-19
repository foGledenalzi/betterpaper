# Demo specification: fictional essay, workspace and answer key
Development document, not shipped. It fixes every file of `plugins/betterpaper/demo/` so that writers make no design decisions and an independent checker can verify the files and `ANSWER-KEY.md` mechanically (section 12). Everything is invented and every grade is fictional. Design: an invented treatise in two editions, an invented essay in three drafts, a workspace holding state up to draft 2, and draft 3 kept at the workspace root for grading.
## 0. Rules for every demo file
- Shipped-file rules: no decision codes (`\b[DRA][0-9]{1,2}\b`, `\bG[0-9]{1,2}\b`); no mention of the plan, decision log, design documents, research notes or phases; plain ASCII (straight quotes and apostrophes, hyphen, no em dash, no section sign: write `sec.`); no URLs except `.example` domains and `https://doi.org/`; no model names or versions; no instruction addressed to an assistant; invented dates only; LF line endings. Every grade, anchor and source carries the label `fictional demo` somewhere readable (RUBRIC `model_note`, STATE and SOURCES `notice:` or first line, each ANCHOR `note:`, first lines of the review, sources, README, ANSWER-KEY, sample report).
- Draft layout: line 1 `# <title>`; seven paragraphs separated by blank lines, openers fixed by row `o` of 3.3; then note definitions `[^n]: ...` (not paragraphs). First note `Ismund Karvale, *On the Reading of the Tessel-Glass*, trans. Dorothea Pelling (Brennock & Vale, 1934), 9.` (draft 3 omits `trans. Dorothea Pelling`); later notes `Karvale, *Tessel-Glass*, <page>.`; no bibliography. A quotation's closing mark follows the string directly and the sentence punctuation follows the mark or note marker (`"..."[^5].`). Weir-Anand first note `Hollis Weir-Anand, *Dials and Their Questions* (Ashgrove Press, 1988), 41.` Own-translation note `Ismund Karvale, *Vom Lesen des Tesselglases* (Lindenhof Verlag, 1926), 11, my translation; original: Die Ablesung antwortet nur auf die Frage, die der Strich stellt.`
- Note pages are the proving page: q1 9, q2 11, q3 14, q4 15, q5 49, q6 33, q7 60, q8 55, q12 19, q13 23, q14 28, q15 44 (first edition, though the wording is the second edition's), q17 14, q18 16, q21 39; q9 11 and q19 49 (pages that do not hold them). Words per draft by `wc -w` (notes included): draft 1 650-750, draft 2 750-850, draft 3 800-890; notes at most 100 words. Draft 1 paragraphs 80-100 words; draft 2 85-110, paragraph 4 130-160; draft 3 paragraphs 1, 6 and 7 hold no quotation marks and run 100-115 words each (300-345 in all), paragraphs 2 to 5 run 95-110. Outside quotation marks no draft shares an 8-word run with the first edition, except `q10` in draft 2 (the script checks this). Each draft 3 quotation is framed and glossed by its sentence; q4 in drafts 1 and 2 is not (ARG-003). Files that must contain the text `fictional demo`: every file except `MANIFEST.md`, the three drafts and the four anchor `text.md` files; `grades-cases.json` carries a top-level `"notice"` key.
## 1. The invented world
- **Treatise.** *On the Reading of the Tessel-Glass* (original *Vom Lesen des Tesselglases*, 1926) by Ismund Karvale. The tessel-glass is a tapered glass tube part filled with fine grit and cut with a scale of marks, held against a stack; the grit settles and its level on the scale is the reading. Karvale's terms: the mark (asks a question of the stack), the reading (answers only that), the tally (what the scale was cut to ask; not a count), the settle, the false zero.
- **Editions.** First: trans. Dorothea Pelling, Brennock & Vale, 1934, 64 pages, twelve sections starting on pages 9, 11, 14, 19, 23, 28, 33, 39, 44, 49, 55 and 60; the file `s1` is the whole treatise, so it is complete and searchable. Second: revised translation, Larkmoor University Press, 1971, other pagination, same section numbers, small variants (sec. 2 p. 13 `Each mark puts a question to the stack; a reading only answers it.`, sec. 9 p. 52 as `sp11b`, sec. 12 p. 71 unchanged). Locator system: page, with section number (`sec. 5, p. 23`). Other works: Hollis Weir-Anand, *Dials and Their Questions* (Ashgrove Press, 1988), never supplied; Petra Linden, "A Short Guide to Karvale's Tessel-Glass" (`https://guides.example/karvale`), file `s2`; a Larkmoor catalogue page (`https://press.example/larkmoor/tessel-glass`), file `s4`.
- **Essay.** *What the Glass Answers: Reading and Report in Karvale's Tessel-Glass*. Thesis, in the author's words in draft paragraph 1 only (`declared_thesis` stays empty): a reading of the tessel-glass is a tally, an answer fixed by the question its scale asks, not a report of the lean it indicates, and the claim survives the objection from calibration. Arc: P1 puzzle and thesis; P2 Karvale's grammar (mark asks, reading answers, tally is not count); P3 the objection from calibration and the reply; P4 uncalibrated glasses and the observer's settling; P5 agreement between glasses and the foot of the glass (the essay infers that no reading can be wrong); P6 what the account adds (the false zero); P7 ending. Genre argumentative research essay; style `chicago-notes`.
- **RUBRIC.md.** `genre: argumentative`, `venue: Graduate seminar on measurement and meaning`, `harshness: harsh`, six weights 1, `anchor_count: 4`, `anchor_seed: 7`, `near_duplicate_pct: 85`, `declared_audience: Members of a graduate seminar on measurement and meaning`, `spelling: either`, `model_note: fictional demo; every grade here is invented`, empty `declared_promises`, `declared_thesis`, `extra_anchor_dirs`, and one line:
```
primary_text: On the Reading of the Tessel-Glass | trans. Dorothea Pelling, first edition (Brennock & Vale, 1934) | page, with section number
```
## 2. File manifest (paths under `plugins/betterpaper/demo/`)
| path | purpose | approx length |
|---|---|---|
| `MANIFEST.md` | one comment line, then the other 28 paths, one per line, in table order (anchor folders in numeric order, `ANCHOR.md` before `text.md`); init copies them and adds `.gitkeep` placeholders for `worksheets/` and `reviewer-notes/`, which stay empty; it does not list itself | 30 lines |
| `README.md`, `RUBRIC.md` | outline in section 9; section 1 values with the template notes kept | 45 lines each |
| `STATE.md`, `SOURCES.md` | template plus the stored state of section 11 (14 tracker rows through draft 2; `s-1`, `s-2`, 11 ledger rows) | 300, 140 lines |
| `drafts/draft-1.md`, `drafts/draft-2.md` | baseline draft with 8 attributed quotations; minor-defect draft with 9 attributed quotations, an unmarked passage and a scare quote (3, 4) | 7 paragraphs, 650-750 and 750-850 words |
| `draft-3-to-grade.md` | the draft to grade, outside `drafts/` so that the grade skill saves it as draft 3; 12 attributed quotations | 7 paragraphs, 800-890 words |
| `reviews/draft-1.md` | invented earlier review in report-template form for draft 1 (no footer): 7 ranked problems in the order PRIM-001, PRIM-002, PRIM-003, ARG-001, ARG-002, ARG-003, STRU-001, each with a trigger quoted exactly from the draft (15 words or fewer, from rows `p1`, `p3`, `p6`, `p7`, `p8`, `q4`, `p10`); Proofreading lists `p11`, `p12`, `p14` as `wrong -> right` and `p15` as diagnosis only; steps that include the wording of sug-1 and sug-2; the wrong claim `p22` under PRIM-003; the echo sentence `sp18` unquoted after the words `my paraphrase`; pointers `rec-1` and `rec-2` | 110 lines |
| `feedback/comments-1.md` | one invented reading-group comment that holds `p18` and no other table string | 70 words |
| `sources/karvale-1934-first-edition.md` | `s1`: complete first edition, sections 1-12 with page markers, every `+s1` string and `sp` sentence at its page, other sentences free but sharing no table string | 450-650 words |
| `sources/linden-short-guide.md`, `sources/larkmoor-catalogue-page.md` | `s2`: secondary web summary holding `sp15` and `sp16`; `s4`: catalogue entry whose blurb is `sp17` | 250, 90 words |
| `sources/karvale-1971-second-edition-excerpt.md` | `s3`: excerpt of pages 13, 52 and 71 only (not complete) | 110 words |
| `anchors/CONFIRM.md`; `anchors/draft-21` to `draft-24` with `text.md`, `ANCHOR.md` | template plus the line `Fictional demo: every row is invented.` and 28 completed rows; four confirmed anchors of 300-450 words (section 6) | 50 lines; 8 files |
| `findings-fabricated.md`, `sample-report.md`, `lint-fail-sample.md`, `grades-cases.json`, `markers-draft-2.md`, `ANSWER-KEY.md` | sections 8, 7, 11 and 10 | 25, 60, 60 lines; 12 cases; 8 lines; 150 lines |

## 3. Quotations
### 3.1 Source sentences (file keys: `s1` first edition, `s2` guide, `s3` second edition, `s4` catalogue, `rev` review, `fb` comment). A verified string equals its `s1` sentence minus the full stop and is not repeated here.
| sp | file | locator | sentence |
|---|---|---|---|
| sp2b | s1 | sec. 2, p. 11 | `A reading answers only the question that the mark puts.` |
| sp5 | s1 | sec. 3, p. 16 | `The tally is kept by the scale and read by the eye.` |
| sp7 | s1 | sec. 5, p. 23 | `Even when the grit has settled twice, a reading taken at the foot of the glass may still be mistaken, because the thick grit hides the lowest mark.` |
| sp8 | s1 | sec. 6, p. 28 | `Put the glass to a stack whose lean is known, and it will still give the tally its scale was cut to take, and no other.` |
| sp10 | s1 | sec. 8, p. 39 | `Two glasses cut alike will give two readings alike on one stack, and the agreement is made by the cutting, not found in the stack.` |
| sp11 | s1 | sec. 9, p. 44 | `Where the grit lies level with no mark, the glass asks nothing and tells nothing.` |
| sp11b | s3 | sec. 9, p. 52 | `Where the grit lies level with no mark, the glass puts no question and gives no tally.` |
| sp15 | s2 | guide, paragraph 3 | `As Weir-Anand puts it, "every scale is a standing question."` |
| sp16 | s2 | guide, paragraph 2 | `In short, a reading is the glass's reply to a question it did not choose.` |
| sp17 | s4 | blurb | `A glass, Karvale argues, never speaks until it has been spoken to.` |
| sp18 | rev | Reading for the revision | `A glass set against a stack of known lean still answers only the question its scale was etched to ask.` |

### 3.2 Quotation table (one row per distinct string; `drafts` says where it appears, always in paragraph `para`; any other draft must not contain it)
Kinds: `m` inside straight double quotes, `u` unmarked. Proof tokens: `+key` the string appears in that file, `-key` it does not; other tokens name the source sentence. c1 to c4: marked and attributed; sense-bearing difference by route (a) or (b); load-bearing; unresolved. Stored ledger rows (q1-q11): `locator` is `para N, <opener>`; `work_edition` the first edition (`s-1`) or the guide (`s-2`); labels `checked against the original (first edition, <page>)`, `checked against a secondary source (Linden, A Short Guide)`, `in my reading` (q11); `draft` 2, `round_verified` 1 for q1-q8 (carried) and 2 for q9-q11; `rounds_open` 0 for verified rows, else 1; flags `["QUOTED-IN"]` for q9, else `[]`; `evidence_level` original, secondary (q9), none (q11); `attributed_to` null for q10 and q11, `source_id` null for q11.

| id | qid | drafts | para | kind | string | attributed to | status + flags | proof | c1 c2 c3 c4 | trigger and reason |
|---|---|---|---|---|---|---|---|---|---|---|
| q1 | q-f6b49d | 1 2 | 1 | m | `The tessel-glass is a tapered tube of glass, part filled with fine grit and cut along its length with a scale of marks` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q2 | q-a22e4f | 1 2 3 | 2 | m | `Each mark asks a question of the stack; a reading only answers it` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified; re-verified in draft 3 (q18 is an OCR-ERROR, so nothing is carried forward) |
| q3 | q-c01568 | 1 2 | 2 | m | `A tally is not a count` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q4 | q-188599 | 1 2 | 3 | m | `A reading is a tally of what the scale asks and not of what the stack does` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q5 | q-62a625 | 1 2 | 7 | m | `Every glass carries its maker's question, and no glass can carry another's` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q6 | q-6071dc | 1 2 | 4 | m | `In the dark the observer reads by touch, and the touch is trained to the marks, not to the stack` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q7 | q-a67e36 | 1 2 | 7 | m | `A glass is honest when it is read as the question it was cut to ask` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q8 | q-dd85b3 | 1 2 | 5 | m | `A scale cut finer asks more of the stack, and the stack can answer less` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified |
| q9 | q-d9951c | 2 3 | 3 | m | `every scale is a standing question` | Karvale | MISATTRIBUTED + QUOTED-IN | +s2 -s1 -s3 sp15 | y n y y | no: genuine wording, wrong author (Weir-Anand per sp15); remedy: cite as quoted in Linden |
| q10 | q-ee0f90 | 2 | 5 | u | `Two glasses cut alike give two readings alike on a single stack, and the agreement is made by the cutting, not found in the stack` | none | NEAR-VERBATIM-UNMARKED | -s1 -s2 -s3 near:sp10 | n - - - | no: condition 1 fails (no marks) |
| q11 | q-cf706d | 2 | 6 | m | `convention-first` | none | MARKS-WITHOUT-SOURCE | -s1 -s2 -s3 -s4 | n - - - | no: condition 1 fails (no attribution) |
| q12 | q-a4a89f | 3 | 4 | m | `The grit settles of itself, and the observer settles on the nearer mark` | Karvale | VERIFIED-PRIMARY | +s1 | n/a | no: verified; it exposes the withdrawn claim |
| q13 | q-7bccd2 | 3 | 5 | m | `once the grit has settled twice, a reading at the foot of the glass cannot be mistaken` | Karvale | MISMATCH | -s1 -s2 -s3 -s4 counter:sp7 | y y y y | YES, route (a): "cannot be mistaken" against "may still be mistaken, because the thick grit hides the lowest mark"; the next sentence builds "the foot needs no second look" on it |
| q14 | q-fa3917 | 3 | 3 | m | `a glass set against a stack of known lean still answers only the question its scale was etched to ask` | Karvale | PARAPHRASE-IN-QUOTES + REVIEW-ECHO | +rev:sp18 -s1 -s2 -s3 -s4 near:sp8 | y y y y | YES, route (b): word diff against sp18 is the capital and the full stop; absent from complete s1; the reply in the paragraph rests on it |
| q15 | q-515d48 | 3 | 5 | m | `Where the grit lies level with no mark, the glass puts no question and gives no tally` | Karvale | UNVERIFIED (diff type: edition or translation variant) | +s3:sp11b -s1 first:sp11 | y n y y | no: near-match, the wording is the second edition's; label check this against Karvale, first edition, 44 |
| q16 | q-db1a04 | 3 | 4 | m | `a dial is a courtesy extended to the stack` | Weir-Anand | UNVERIFIED | -s1 -s2 -s3 -s4 -rev | y n y y | no: recall alone, no copy opened; label as I recall: check your copy |
| q17 | q-8803a9 | 3 | 3 | m | `a reading is the glass's reply to a question it did not choose` | Karvale | UNVERIFIED + SECONDARY-ECHO + NOT-FOUND | +s2:sp16 -s1 -s3 | y n y y | no: the guide's own phrasing; a secondary source never fires the cap |
| q18 | q-b1704b | 3 | 2 | m | `The tal1y is kept by the scale and read by the eye` | Karvale | OCR-ERROR | -s1 -s2 -s3 -s4 source:sp5 | y n y y | no: non-trigger status, precheck-flagged; corrupted tal1y, corrected tally |
| q19 | q-e16fdb | 3 | 4 | m | `never speaks until it has been spoken to` | Karvale | UNVERIFIED + NOT-FOUND | +s4:sp17 -s1 -s2 -s3 -rev | y n y y | no: a catalogue page grounds nothing; NOT-FOUND in complete s1 needs route (a) or (b) too |
| q20 | q-f98893 | 3 | 2 | m | `A reading answers only the question that the line poses` | Karvale (my translation) | UNVERIFIED (diff type: declared own translation, original supplied) | -s1 -s2 -s3 -s4 published:sp2b | y n y y | no: declared own translation, near-match; label check this against the 1926 original |
| q21 | q-fbe7f5 | 3 | 5 | m | `the agreement is made by the cutting, not found in the stack, and two glasses cut alike will give two readings alike on one stack` | Karvale | TRANSPOSED | -s1 -s2 -s3 -s4 source:sp10 | y n y y | no: reordered wording, same sense; child of the row for q10 |

Count lines. Draft 1: `8 attributed quotations checked: 8 against the original, 0 against a secondary source, 0 unverified, 0 with defects`. Draft 2 (q10 counts as original, q11 as unverified): `11 attributed quotations checked: 9 against the original, 1 against a secondary source, 1 unverified, 3 with defects`. Draft 3: `12 attributed quotations checked: 6 against the original, 1 against a secondary source, 5 unverified, 5 with defects` (original q2 (re-verified, because q18 is an OCR-ERROR and nothing is carried forward), q12, q13, q14, q18, q21; secondary q9; unverified q15, q16, q17, q19, q20; defects q9, q13, q14, q18, q21). Rows reaching the cap test are the non-VERIFIED rows: 0, 3 and 10.
### 3.3 Other planted strings (`x`: present in the listed files, absent from every draft not listed; `c`: present where listed; `o`: the seven openers, in order, in all drafts; para `n`: anywhere in the file)
| id | row | drafts | para | kind | string |
|---|---|---|---|---|---|
| o | paragraph openers | 1 2 3 | 1-7 | o | `Few instruments are;Karvale's account begins;An obvious objection;Consider a glass;Agreement between glasses;A glass at rest;In the end` |
| p1 | PRIM-001 | 1 | 2 | x | `a reading fixes what the mark asks` |
| p2 | PRIM-001 fixed | 2 | 2 | c | `the mark fixes what a reading answers` |
| p3 | PRIM-002 | 1 | 2 | x | `a tally, that is, a count of what the stack does` |
| p4 | PRIM-002 | 2 | 2 | x | `a tally, or count, of what the stack does` |
| p5 | PRIM-002 | 1 2 3 | 6 | x | `the count the glass keeps` |
| p6 | PRIM-003 | 1 2 | 4 | x | `the observer settles the reading` |
| p7 | ARG-001 | 1 2 3 | 4 | x | `the same holds of a glass no one has ever calibrated` |
| p8 | ARG-002 | 1 2 3 | 5 | x | `It follows that no reading can be wrong.` |
| p9 | ARG-004 | 2 | 4 | x | `A surveyor reads the glass by touch in a dark shed` |
| p10 | STRU-001 | 1 2 3 | 7 | x | `The same holds of every dial in the harbour.` |
| p11 | MECH-001 | 1 2 | 2 | x | `each of the marks ask` |
| p12 | MECH-001 | 1 | 2 | x | `the scale and the grit remains` |
| p13 | MECH-001 | 2 3 | 2 | x | `neither of the readings are` |
| p14 | MECH-002 | 1 | 3 | x | `the glasses scale` |
| p15 | MECH-003 | 1 2 | 6 | x | `The glass settles, the reader waits.` |
| p16 | straw objection | 1 2 | 3 | x | `a calibrated glass simply reports the lean` |
| p17 | unprompted gain | 3 | 3 | x | `a glass checked against a known lean has been made to track that lean` |
| p18 | unquoted echo of the comment | 3 fb | 3 | x | `the scale, not the stack, decides which answers are possible` |
| p19 | Originality strength | 3 | 6 | x | `the tally account reaches the false zero, where the scale asks nothing` |
| p20 | SRC-008 translator | 1 2 | n | x | `trans. Dorothea Pelling` |
| p21 | own translation, original supplied | 3 | n | x | `Die Ablesung antwortet nur auf die Frage, die der Strich stellt.` |
| p22 | wrong claim in review 1 | rev | n | x | `the treatise uses settle only of the grit coming to rest` |

## 4. Planted content that is not a quotation
Drivers of the fictional grades (descriptor IDs from the grade bands):

| criterion | draft 1 | draft 2 | draft 3 (expected) |
|---|---|---|---|
| Command of the treatise | D: PRIM-001 reverses the relation in the thesis passage (prim-d-1) | C-: PRIM-002 drops the contrast term in the main line (prim-c-2); the minus is PRIM-003, later withdrawn | B-: prim-b-1, prim-b-2 hold; minus for the PRIM-002 remainder in paragraph 6 (prim-c-2) |
| Argument | C: ARG-001 assertion in a load-bearing claim (arg-c-2); ARG-002 gap | C+: ARG-001 supported by the example, ARG-002 stays (arg-c-1); plus from a strength | C+: ARG-001 bare again (arg-c-2), ARG-002 stays; plus from the fair objection `p17` (arg-b-2), 1 verified strength |
| Structure | C+: stru-b-1 holds, held to one step above Argument; STRU-001 | C+ | B-: stru-b-1, stru-b-2; STRU-001 unchanged; one step above Argument; low confidence |
| Use of sources | B-: 8 accurate quotations (src-b-1), src-b-3 barely | C: SRC-001 (src-c-1), SRC-002 and SRC-003 (src-c-2) | D: q13 (src-d-1), q14 (src-d-2); conditional C+: with q13 and q14 fixed, one class of defect remains (src-c-1: SRC-001, SRC-006, SRC-007; the src-c-2 rows of draft 2 are gone) and SRC-008 is a single slip of form; plus from src-b-1 (q12 reproduces the first edition) |
| Originality | C+: view hard to tell from a standard reading (orig-c-1) | B: orig-b-1 | B+ proposed, residual contribution `p19` (orig-a-1), 1 verified strength: limited to B under harsh |
| Mechanics | C: agreement (M1) and comma splice (M2) recur (mech-c-1) | C: agreement persists after fixes (mech-c-2) | C+: comma splice and apostrophe gone, agreement remains (mech-c-2); plus from mech-b-2 |

Tracker (status `rounds_flagged/drafts_present/last_seen`; stored state is the draft 2 column; QUO rows are SRC rows of subtype QUO and their anchors start with the QID):

| id | code (tier) | anchor | draft 1 | draft 2 (stored) | draft 3 (expected) | tags printed and evidence |
|---|---|---|---|---|---|---|
| PRIM-001 | RELATION-INVERTED (1) | para 2, Karvale's account begins | OPEN 1/1/1 | RESOLVED 1/1/1 | unchanged | draft 1: p1; draft 2: p1 gone, p2 present |
| PRIM-002 | DISTINCTION-COLLAPSED (1) | para 2, Karvale's account begins | OPEN 1/1/1 | RECURRING 2/2/2 | PARTIAL 3/3/3, anchor para 6, A glass at rest | `(round 3)` `(half fixed)`; ranked problem 1; draft 1: p3, p5; draft 2: p4, p5; draft 3: p3 and p4 gone, p5 remains |
| PRIM-003 | TERM-VS-SOURCE (1) | para 4, Consider a glass | OPEN 1/1/1 | RECURRING 2/2/2 | WITHDRAWN 2/2/2, origin earlier-review error | Correction to the draft 1 review; p6 in drafts 1 and 2; draft 3 has q12, which uses settle of the grit and of the observer |
| ARG-001 | NO-EVIDENCE (2) | para 4, Consider a glass | OPEN 1/1/1 | RESOLVED 1/1/1 (p9 supports p7) | REGRESSED 2/1/3, `reopened=1`, origin earlier-review suggestion | `(round 2)` `(reopened)`; ranked problem 2; p7 bare in draft 1, p9 added before p7 in draft 2, p9 cut in draft 3 |
| ARG-002 | BRIDGE-GAP (3) | para 5, Agreement between glasses | OPEN 1/1/1 | RECURRING 2/2/2 | RECURRING 3/3/3 | `(round 3)` `(unchanged since draft 1)`; problem 3; p8 in all drafts |
| ARG-003 | QUOTE-WITHOUT-GLOSS (3) | para 3, An obvious objection | OPEN 1/1/1 | RECURRING 2/2/2 | RESOLVED 2/2/2 | What improved; q4 and p16 in drafts 1 and 2 with no gloss, every draft 3 quotation framed |
| ARG-004 | EXAMPLE-FIT (4) | para 4, Consider a glass | none | OPEN 1/1/2 (first seen 2) | REMOVED-VERIFIED 1/1/2, `gone=yes; function_still_served=no; replacement_support=no` | What improved and Correction to the draft 2 review; no child row: the gap is ARG-001, matched by category, subtype and anchor |
| STRU-001 | WEAK-ENDING (4) | para 7, In the end | OPEN 1/1/1 | RECURRING 2/2/2 | RECURRING 3/3/3 | `(round 3)` `(unchanged since draft 1)`; problem 4; p10 in all drafts |
| SRC-001 | QUO MISATTRIBUTED q9 | q-d9951c, para 3, An obvious objection | none | OPEN 1/1/2 | RECURRING 2/2/3 | `(second round)` `(unchanged since draft 2)`; Quotation problems |
| SRC-002 | QUO NEAR-VERBATIM-UNMARKED q10 | q-ee0f90, para 5, Agreement between glasses | none | OPEN 1/1/2 | SUPERSEDED 1/1/2, child SRC-007 | prints through SRC-007; the author added marks and reordered |
| SRC-003 | QUO MARKS-WITHOUT-SOURCE q11 | q-cf706d, para 6, A glass at rest | none | OPEN 1/1/2 | RESOLVED 1/1/2 | What improved; reworded `a view that puts convention first` |
| SRC-004 | QUO MISMATCH q13 (0) | q-7bccd2, para 5, Agreement between glasses | none | none | OPEN 1/1/3 | Quotation problems; fires the cap |
| SRC-005 | QUO PARAPHRASE-IN-QUOTES q14 (0) | q-fa3917, para 3, An obvious objection | none | none | OPEN 1/1/3 | Quotation problems; fires the cap |
| SRC-006 | QUO OCR-ERROR q18 | q-b1704b, para 2, Karvale's account begins | none | none | OPEN 1/1/3 | one line: tal1y corrected to tally; check every quotation against the printed edition |
| SRC-007 | QUO TRANSPOSED q21 | q-fbe7f5, para 5, Agreement between glasses | none | none | OPEN 1/1/3, `follow_up_of` and thread SRC-002 | numbered entry, no tag |
| SRC-008 | CIT | note 1 | none | none | OPEN 1/1/3 | Citation problems; the citation ledger gap `translator not named in the first note`, template `[First Last], *[Title]*, trans. [First Last] ([Publisher], [year]), [page].` |
| MECH-001 | agreement | para 2, Karvale's account begins | OPEN 1/1/1 (2 instances) | RECURRING 2/2/2 (2) | PARTIAL 3/3/3 (1) | `(third round)` `(half fixed)` `(pattern flagged in 3 reviews)`; Proofreading opens with the three-consecutive-drafts sentence; draft 1: p11, p12; draft 2: p11, p13; draft 3: p13 |
| MECH-002 | apostrophe | para 3, An obvious objection | OPEN 1/1/1 | RESOLVED 1/1/1 | unchanged | p14 in draft 1, gone in draft 2 |
| MECH-003 | comma-splice | para 6, A glass at rest | OPEN 1/1/1 | RECURRING 2/2/2 | RESOLVED 2/2/2 | What improved; p15 in drafts 1 and 2, gone in draft 3 |

Other tracker keys: `instances` 1 except MECH-001; `thread` the row's own ID except SRC-007; `evidence_level` original for PRIM and SRC rows, draft for the rest; `severity_history` one entry `{draft: first flagged, tier, reason: "first flagged"}` (SRC-004 and SRC-005: `integrity: fired the cap`; SRC-007: `marks added to the unmarked passage, clauses reordered`); `diagnosis` one sentence naming the defect, no replacement wording (MECH rows end with the first trigger, a few words copied exactly); `origin` essay (draft 3: ARG-001 earlier-review suggestion, PRIM-003 earlier-review error); `author_claim`, `claim_scope`, `follow_up_of`, `confidence`, `display_group` null; `verified_status` null except as shown. After draft 3 PATTERNS read agreement `1:2 2:2 3:1`, consecutive 3, reviews 3; comma-splice `1:1 2:1 3:0`, 0, 2; apostrophe `1:1 2:0 3:0`, 0, 1; class counts draft 3 M1 1, M2 0, M3 0. Draft 3 completeness: the 11 rows open at its start end in PRIM-002, ARG-002, STRU-001, SRC-001, MECH-001 (problems or lists), ARG-003, ARG-004, SRC-003, MECH-003 (What improved, in that order with the unprompted gain `p17` after ARG-004), PRIM-003 (Correction), SRC-002 (through SRC-007). Statuses exercised in the draft 3 run: OPEN, PARTIAL, RECURRING, REGRESSED, RESOLVED, REMOVED-VERIFIED, WITHDRAWN, SUPERSEDED. Quick run on draft 3: the same 11 rows are flagged CANNOT-CHECK and print `(not rechecked)`; statuses, counters and `last_seen` unchanged, no row opened, no ledger, tracker or anchor write, history row `mode: quick`.
Corrections printed in draft 3. **Correction to the draft 1 review** (factual error): it said the treatise uses settle only of the grit coming to rest, labelled checked against the original (first edition, 19); that was wrong, sec. 4, p. 19 uses it of the grit and of the observer; the draft exposed this by quoting the whole sentence; consequence: Command of the treatise in the draft 2 column, C- would have been C (footnote; draft 1 stays D on PRIM-001; the draft 2 overall stays C+, 136 over 6 is 22.67). **Correction to the draft 2 review** (backfired suggestion, sug-3): the suggestion to cut or reduce the example in paragraph 4 was incomplete, because the example was the only support for ARG-001; following it reopened that row; Argument stays C+.
## 5. Grades (fictional demo; tenths; exact arithmetic checked by script)
| draft | as submitted | alone | primary | argument | structure | sources (conditional) | originality | mechanics | S / W, mean | target |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 (2031-02-03) | C | C | D | C | C+ | B- | C+ | C | 123 / 6 = 20.5 | B- (2 steps) |
| 2 (2031-02-17) | C+ | C+ | C- | C+ | C+ | C | B | C | 133 / 6 = 22.17 | B- (1 step) |
| 3 expected | F | B- | B- | C+ | B- | D (C+) | B | C+ | 153 / 6 = 25.5 | B- (restore, no step count) |

Draft 3 working, harsh, weights 1: cap fired, basis `q-7bccd2 route-a` and `q-fa3917 route-b`. Originality B+ (33) has 1 verified strength, harsh needs 2, so it is limited to B (30). Alone uses the conditional: S = 27 + 23 + 27 + 23 + 30 + 23 = 153, W = 6, mean 25.5; the adjacent steps are B- (27) and C+ (23), (27 + 23) x 6 = 300 and 2S = 306 is above it, so the higher step, B-: no exact tie, and harsh and neutral agree (neutral: B+ stands, S = 156, 2S = 312, B-). Near a tie point: harsh yes (|2S - 300| = 6 <= 6, the end of the range, which counts), neutral no (12 > 6). Movement in rungs: as submitted -6, alone +1, primary +3, argument 0, structure +1, sources -3 (conditional +1), originality 0, mechanics +1. Printed lines: `As submitted: F (was C+; cue: integrity cap)`, `On the writing and argument alone: B- (was C+)` (one rung, but criterion-level evidence exists for criteria that moved, for example MECH-003 RESOLVED for Mechanics, so neither "no reliable change" nor a cue prints); cell brackets: primary `(was C-; cue: PRIM-002, PRIM-003)`, argument `(was C+)`, structure `(was C+; no reliable change)` (one step, no structure-tagged row changed), sources `(was C; cue: SRC-004, SRC-005)` with the cell `D (C+ once the quotations in paragraphs 3 and 5 are corrected)`, originality `(was B)`, mechanics `(was C)` (one step, MECH-003 is the evidence). Beside Structure always: `Structure is uncalibrated: no confirmed anchor covers it`. Cap log: `cap: fired; q-7bccd2 conditions 1 to 4 yes, route (a), counter-passage first edition sec. 5 p. 23; q-fa3917 conditions 1 to 4 yes, route (b), word diff capital and full stop only, s-1 complete and searchable; 8 other rows failed at condition 2 or earlier (q9, q15 to q21); Y = C+; fix: replace both strings with the exact source sentences or paraphrase fully with a citation; as submitted F, alone B-; target B- under the cap rule`.
After the run: history row draft 3 (report `reviews/draft-3.md`, mode full, tool_grade B-, sources_conditional C+, target B-, `open_by_tier` `0:2 1:1 2:1 3:1 4:1`), `anchors/draft-3/` with `confirmed_by: unconfirmed`, overall as submitted F, alone B-, and seven blank rows in `CONFIRM.md`. No positioning flag is required. Header and flags: `anchors: 3 (1 near the top band)`; mode full; harshness harsh; style chicago-notes; `Confidence: low (uncalibrated): a cap fired; unverified-quotation share over 30% (5 of 12); within one step of a tie point` (dispersion 7 tenths, below 13; anchors record model `unknown`, anchors not same-essay: no further reason); `Human check: yes (any cap; repeat conditions hold but --repeat was not passed)` (the repeat condition is the near tie of the harsh run, 6 of 6, ends included); the disagreement signal fires only if the recorded holistic grade is outside band B (not checked); with `--repeat` the four owners of graded criteria run again. Steps heading `WHAT IT WOULD TAKE TO REACH B-` with the words what it takes to restore it and no step count; 5 to 8 steps: the integrity fix first (SRC-004, SRC-005, restores B-), then PRIM-002, ARG-001, ARG-002, STRU-001, a mechanics step for MECH-001 (Mechanics C+ is below the target B-), citation mechanics (SRC-008) last: 7 steps. Sources consulted: `s-1` (original), `s-2` (secondary), `s-3` (second edition excerpt, a different edition), `s-4` (catalogue page, grounds nothing), `s-5` Weir-Anand, no copy available.
## 6. Anchors (all `imported: no`, `model: unknown`, `note: fictional demo: invented calibration text`; the tool's grades, then confirmed)
| folder | essay slug, text | alone (as submitted) | P A St Src O M | S, mean | confirmed_by, date | role |
|---|---|---|---|---|---|---|
| draft-21 | lantern-gauge, an A- piece on a lamp whose flame height reads wind | A- | A- A- B+ A- B+ A | 217, 36.17 | instructor, 2030-11-04 | the near-top-band anchor |
| draft-22 | pier-scale, a sound B piece with one weak transition | B | B B B B- B- B | 174, 29.0 | author, 2030-11-04 | middle |
| draft-23 | tessel-glass-short, an abridged earlier version of this argument: draft 3 paragraphs 1, 6 and 7 copied verbatim | C | C C C C- C C- | 114, 19.0 | author, 2030-11-05 | near-duplicate of draft 3, excluded |
| draft-24 | reed-meter, a D piece: assertion, drifting thesis, no sources | D | D D+ D D D+ D (tool); sources adjusted to D- | 66 tool, 63 adjusted, 10.5 | instructor, 2030-11-06 | low band; `human_adjusted: yes` |

ANCHOR.md rows: `tool_grade` equals `grade` except draft-24 sources (tool D, grade D-, status `adjusted`); other rows `confirmed`; each row names the header confirmer; the `overall_alone` row confirms D for draft-24. `CONFIRM.md` holds 28 rows (7 per anchor): `confirm`, except draft-24 sources (`adjust`, adjusted_grade D-), with the confirmer and date above, so `init demo-essay --confirm` reports every row already applied. `select_anchors.py` on the workspace with draft 3 saved as `drafts/draft-3.md` prints `anchors: 3 (1 near the top band)` for every reviewer: draft-23 is dropped as a near-duplicate (6-word runs cover at least 85% of its text; expected 95% to 100%), the others (coverage near 0) are kept and span A- to D. Order is ascending sha1 of the string `7|<reviewer>|<folder>` (check one: `python3 -c "import hashlib; print(hashlib.sha1(b'7|argument-reviewer|draft-21').hexdigest())"`); none of the anchor texts quotes the treatise (draft-21 evidences every claim and answers its strongest objection on its premise; draft-22 has one weak transition and a partial reply; draft-24 asserts, drifts and errs):

| folder | argument-reviewer | primary-text-reviewer |
|---|---|---|
| draft-21 | 4bb5db133c5569556093bb38cf1c45d2c555fd27 | d3c2a3f17affa7aae22f1bad11ea700c9dc3f38d |
| draft-22 | 540bf3e53b0031df892db8c86d365ea08bf1c025 | 09d83afc19b7c3a9be7a4eaf3a01f07f58114641 |
| draft-23 (excluded) | c75366b91988a669d9558e81ba4e781d18b48acc | 4fa90add585421478e7df368d88dc50797fbbdf2 |
| draft-24 | f5406e7c7c05058d31aab31a44154f3cee1b6ced | 848e509e3c01114ae2b3ffba6a57cdfb7cb5b63d |

Orders (draft-23 excluded): source-verifier `draft-21, draft-22, draft-24`; primary-text-reviewer `draft-22, draft-24, draft-21`; argument-reviewer `draft-21, draft-22, draft-24`; mechanics-reviewer `draft-22, draft-24, draft-21`; voice-echo-reviewer `draft-21, draft-24, draft-22`. The anchor-order log gets one row per reviewer for draft 3.
## 7. `grades-cases.json`
One object `{"cases": [...]}`, one case per line, each `{"name", "input", "expect"}`; `input` is a complete grades file (file contracts, section 2; the harness writes a temporary RUBRIC.md with the case's harshness and weights) and `expect` holds `as_submitted`, `alone`, `partial`, `exact_tie`, `near_tie`, `limits`. The twelve cases copy the worked examples of the adjudication examples file (ex1 to ex6, repeat means written as numbers in tenths) plus the two draft 3 cases of section 5; results (as submitted/alone, flags), verified with exact fractions: `tie-harsh` (ex1) C+/C+ exact tie, near tie; `tie-neutral` (ex1) B-/B- exact tie, near tie; `tie-3-tenth-harsh` (ex1 variant) B-/B- exact tie, near tie; `tie-3-tenth-neutral` (ex1 variant) B/B exact tie, near tie; `cap-conditional` (ex2) F/B-; `partial-grade` (ex3) B/B partial; `verified-strength-limit-harsh` (ex4) B-/B- near tie, limits argument:B+>B,mechanics:B+>B; `verified-strength-limit-neutral` (ex4) B/B near tie, limits mechanics:B+>B; `repeat-means` (ex5) B-/B- near tie; `negative-controls-no-cap` (ex6) B-/B-; `demo-draft-3-harsh` (section 5) F/B- near tie (6 of 6), no exact tie, limits originality:B+>B; `demo-draft-3-neutral` (section 5) F/B- no tie flag, no limits. The draft 3 pair no longer ties exactly; the exact tie is exercised by `tie-harsh`, `tie-neutral`, `tie-3-tenth-harsh` and `tie-3-tenth-neutral`. The draft 3 inputs are the section 5 row (sources D with conditional C+, originality B+ with 1 verified strength, 0 for the others, cap fired with both QIDs in `basis`, `previous` and `previous_overall` from draft 2). In `expect`, `partial`, `exact_tie` and `near_tie` are booleans and `limits` is a list of `criterion:from>to` strings, empty when none (the checker compares all of them).
## 8. Findings file, sample report, lint pair
- `findings-fabricated.md`: reviewer-return form for the source-verifier. Findings table with two rows, `f-1` (Locator `para 5, Agreement between glasses`, Draft quote `a reading at the foot of the glass cannot be mistaken`, MISMATCH, label checked against the original (first edition, 23)) and `f-2` (same Locator, Draft quote `the glass cannot be trusted at any scale`, a made-up problem); then a `jsonl ledger` block of two lines whose `string` fields are the full q13 string and the fabricated sentence (qid `q-0f0f0f`); a sources grade line and a Confidence line. `check_cited_spans.py draft-3-to-grade.md findings-fabricated.md` keeps `f-1` and ledger line 1, drops `f-2` and ledger line 2 as "paraphrase, not a quotation", exit 1; the Locator is never checked.
- `sample-report.md`: a short partial report on draft 3 that passes the lint (exit 0): header with legend, confidence and human-check flag, grade lines as in section 5, a verdict of 35 to 60 words, the rubric table (three draft columns, a reason and confidence tag per cell), Quotation problems with the count line and the two firing entries, MAJOR PROBLEMS with its fixed sentence and PRIM-002 only, Citation problems, PROOFREADING, WHAT IT WOULD TAKE TO REACH B- with five steps (the integrity fix first, restoring B-; step 2 as below; PRIM-002; a mechanics step for MECH-001, because Mechanics C+ is below the target; SRC-008 last), Sources consulted, the two-sentence footer. Draft strings appear only exact, in marks, 15 words or fewer; every specific claim has a label; no reviewer wording in marks. Step 2 reads: `Decide whether "the agreement is made by the cutting, not found in the stack" is the claim paragraph 5 rests on, and supply evidence or cut it (ARG-002).`
- `lint-fail-sample.md` is needed, because one file cannot both pass and fail: a copy of `sample-report.md` with exactly one line changed, step 2 now `Argue that the agreement is made by the cutting, not found in the stack, and cut the rest (ARG-002).` It repeats 12 consecutive words of the author's text outside marks and is a claim a writer could paste; the lint exits 1 and names that sentence and no other.
## 9. README outline (addressed to the user)
1. What the demo is: a fictional essay in three drafts, its invented treatise, a workspace holding state to draft 2, a draft 3 to grade, four invented anchors, test files. 2. Notice: every grade, anchor, quotation, source and name is fictional; the demo tests the plugin's format and logic, not grading accuracy; no demo grade is evidence of real grading. 3. Run: `/betterpaper:init demo-essay`, then `/betterpaper:grade demo-essay draft-3-to-grade.md --quick` first (cheap; prints the banner and never caps), then the same without `--quick`; optional `--markers markers-draft-2.md`; `init demo-essay --confirm` re-applies the anchor sheet. 4. Compare with `ANSWER-KEY.md`; the key and the sample files are for checking and a grade run does not read them. 5. A one-line-per-file table. 6. Known gaps: REF-COPY-OCR and SWAPPED-WORDS are not exercised; sources are invented, so web checks find nothing.
## 10. `ANSWER-KEY.md` structure and use (the shipped key says "script tests" and "a grade run", never phase numbers; the last column below is for this document only)
| section | holds | used by |
|---|---|---|
| 1 Notice | fictional demo; tolerance: arithmetic is exact, reviewer grade suggestions may differ by one step | readers |
| 2 Quotations | table 3.2 reduced to qid, locator, status, flags, label, counts toward split, trigger yes/no, reason; the three count lines; q2 re-verified, not carried forward | Phase 4: `extract_quotes.py` (QIDs; precheck flags `tal1y` only, no injection text), `echo_check.py` (q14 against review 1 as REVIEW-ECHO, q17 and q9 against the guide, `p18` unquoted against the comment, no hit on the author's own drafts); Phase 5: ledger statuses and flags |
| 3 Cap decision | q13 and q14 fire; must not cap: q9, q15 to q21 (each with its failed condition), every verified row, all of drafts 1 and 2 (`cap: none; 0 rows tested`, `cap: none; 3 rows tested`) and the quick run; event-log text; Y = C+ | Phase 5 adjudication |
| 4 Tracker | section 4 table, completeness destinations, both corrections, quick-run carry-forward, marker outcomes (PRIM-002, SRC-001, MECH-001 DISPUTED; ARG-003, ARG-004 CONFIRMED) | Phase 5 tracker update and report tags |
| 5 Grades | sections 5 and 7: per-criterion grades, series, brackets, working in tenths | Phase 4 `compute_grade.py` (cases file); Phase 5 grades and prints |
| 6 Header and sections | confidence, flags, target, steps, sources consulted | Phase 5 report |
| 7 Anchors, lint, spans | section 6 results and digests; lint pair; fabricated-findings result | Phase 4 `select_anchors.py`, `report_lint.py`, `check_cited_spans.py`; Phase 3 Verify; Phase 5 intake line |
| 8 Not checked | holistic grade, prose wording, reviewer grade suggestions, tokens | readers |

## 11. Stored state and small files
- **STATE.md** (template kept, then): `title`, `genre: argumentative`, `thesis_locator: para 1, Few instruments are`, `next_draft: 3`, `notice: fictional demo; every grade and name here is invented`. History rows: draft 1 report `reviews/draft-1.md`; draft 2 report `sha1:34aad9facdbec0a85bc0af5c7791398e3cb954bc` (an invented digest; that review is not shipped); mode full; tool_grade equal to alone; grades and targets from section 5; `open_by_tier` `1:3 2:1 3:2 4:1` and `1:2 3:2 4:2`; imported no; human-adjusted no. Anchors register: four rows. Tracker: the 14 stored rows. PATTERNS: agreement `1:2 2:2`, consecutive 2, reviews 2; comma-splice `1:1 2:1`, 2, 2; apostrophe `1:1 2:0`, 0, 1. Class counts (words by `wc -w`): draft 1 M1 3, M2 1, M3 0; draft 2 M1 2, M2 1, M3 0. Citation ledger: one line for Karvale, first edition, pairs from the note pages, no gaps. Suggestions log: sug-1 (draft 1, define tally against count, PRIM-002, relied yes, gap no), sug-2 (draft 1, supply an example for the claim in paragraph 4 or cut it, ARG-001, yes, no), sug-3 (draft 2, cut the example in paragraph 4 or reduce it to the point it supports, ARG-004, unknown, no; after draft 3 yes, yes). Archive: the two reports. reviewer_wording: `a glass set against a stack of known lean still answers only` (draft 1, Reading for the revision, no sightings; after draft 3: 3). Characterisation sc-1 (draft 1): `the treatise uses settle only of the grit coming to rest`, sec. 4, label checked against the original (first edition, 19). Holistic grades C, C+. Cap log `cap: none; 0 rows tested`, `cap: none; 3 rows tested`. Reading list: rec-1, rec-2 not adopted (rec-1 becomes adopted after draft 3, which cites Weir-Anand). Empty: token log, anchor-order log, rescue log, corrections log, risk register, keep list, commitments.
- **SOURCES.md**: OPENED `s-1` (first edition, primary full text, full text searchable, complete yes, the edition used by the author) and `s-2` (the guide, secondary web summary, round 2); RECOMMENDED `rec-1` (Weir-Anand, the chapter on scales, work-level, PRIM-002, draft 1) and `rec-2` (Karvale sec. 6, checked with edition, ARG-001); precedent register empty; format basis `chicago-notes.md`, the Chicago Manual of Style, 18th edition, page and format checks; 11 ledger rows from 3.2. Draft 3 adds `s-3`, `s-4` and `s-5` (no copy available).
- **reviews/draft-1.md** header: draft 1, review date 2031-02-03, model unknown, mode full, harshness harsh, `anchors: 4 (1 near the top band)`, `Confidence: high (uncalibrated): no low or medium reason applies`, `Human check: no`, `As submitted: C`, target B-. **feedback/comments-1.md**: a short peer note that praises an example, asks for the point about the scale to be made plainly (holding `p18`) and asks what "tally" means.
- **markers-draft-2.md**: a title line, then one report-style line per marker, each ending in the token then the bracketed ID: `fixed [PRIM-002]`, `removed [ARG-004]`, `fixed [ARG-003]`, `cited [SRC-001]`, `fixed [MECH-001]`, and one line ending `fixed` with no ID (unbindable: listed in the run summary, stored nowhere).
## 12. Verification procedure (independent checker)
Run from the repository root after the demo is written. Single facts: `tr '\n' ' ' < <file> | grep -ciF -- '<string>'` (1 or more means present, 0 absent). Shipped-file rules, run on the demo folder: `grep -rnP '\b[DRA][0-9]{1,2}\b|\bG[0-9]{1,2}\b'` and `grep -rnP '[^\x00-\x7F]'` must print nothing; `grep -rnE 'https?://'` shows only `.example` hosts; `grep -rLiF 'fictional demo'` lists only `MANIFEST.md`, the three drafts and the four anchor `text.md` files; every path in `MANIFEST.md` exists and nothing else does (apart from `.gitkeep` placeholders). The script below reads the tables of this document and checks every planted string, QID, opener, absence rule, draft size, anchor length and near-duplicate coverage, and recomputes every case of `grades-cases.json` (both grades, the partial flag, exact and near tie, limits); save it as `check_demo.py` outside the demo and run `python3 -I check_demo.py docs/design/demo-spec.md plugins/betterpaper/demo` (exit 0 prints `OK`); add `--commands` to print one `grep` per presence or absence test with its expected count, for running by hand. Then read `ANSWER-KEY.md` against sections 3 to 7 by hand (statuses, flags, counts, brackets, tags).
```python
import re, sys, json, hashlib, unicodedata
from fractions import Fraction as F
from pathlib import Path
spec, demo = Path(sys.argv[1]).read_text(encoding='utf-8').splitlines(), Path(sys.argv[2])
D = {'1': 'drafts/draft-1.md', '2': 'drafts/draft-2.md', '3': 'draft-3-to-grade.md', 'rev': 'reviews/draft-1.md', 'fb': 'feedback/comments-1.md',
     's1': 'sources/karvale-1934-first-edition.md', 's2': 'sources/linden-short-guide.md',
     's3': 'sources/karvale-1971-second-edition-excerpt.md', 's4': 'sources/larkmoor-catalogue-page.md'}
def norm(s):
    s = unicodedata.normalize('NFKC', re.sub(r'[\\*_]', '', s))
    for a, b in ((8217, "'"), (8220, '"'), (8221, '"'), (173, ''), (8203, '')): s = s.replace(chr(a), b)
    return re.sub(r'\s+', ' ', re.sub('[' + chr(8208) + '-' + chr(8213) + ']', '-', s)).strip().lower()
def rd(k): return (demo / D[k]).read_text(encoding='utf-8')
def paras(k): return [re.sub(r'\s+', ' ', b.strip()) for b in re.split(r'\n\s*\n', rd(k)) if b.strip() and not b.strip().startswith(('#', '[^'))]
def table(head):                                  # rows of the spec table whose header starts with head
    i = next(j for j, l in enumerate(spec) if l.startswith('| ' + head)); rows = []
    for l in spec[i + 2:]:
        if not l.startswith('|'): break
        rows.append([c.strip().strip('`') for c in l.strip('| ').split('|')])
    return rows
bad, cmds = [], []
def chk(ok, msg): ok or bad.append(msg)
def has(k, s, want, msg):                         # whole-file test; records the equivalent shell command
    cmds.append("tr '\\n' ' ' < %s/%s | grep -ciF -- '%s'   # expect %s" % (demo, D[k], s.replace("'", "'\\''"), '1 or more' if want else '0'))
    chk((norm(s) in norm(rd(k))) == want, msg)
for r in table('sp |'): has(r[1], r[3], True, 'sp %s not in %s' % (r[0], r[1]))
for i, q, dr, para, kind, s, *rest in table('id | qid'):          # quotation table
    chk('q-' + hashlib.sha1(norm(s).encode()).hexdigest()[:6] == q, 'qid of ' + i)
    for d in '123':
        if d in dr.split(): p = paras(d)[int(para) - 1]; chk(('"' + s + '"' in p) if kind == 'm' else (s in p and '"' + s not in p), '%s wrong in draft %s' % (i, d)); has(d, s, True, '%s absent from draft %s' % (i, d))
        else: has(d, s, False, '%s must be absent from draft %s' % (i, d))
    for t in rest[2].split():
        if t[0] in '+-' and t[1:].split(':')[0] in D: has(t[1:].split(':')[0], s, t[0] == '+', '%s %s' % (i, t))
for i, row, dr, para, kind, s in table('id | row'):                # other planted strings
    for d in '123':
        ps = paras(d)
        if kind == 'o': chk(len(ps) == 7 and all(p.startswith(o) for p, o in zip(ps, s.split(';'))), 'openers draft ' + d)
        elif d in dr.split(): chk(norm(s) in norm(rd(d) if para == 'n' else ps[int(para) - 1]), '%s missing in draft %s' % (i, d)); has(d, s, True, '%s absent from draft %s' % (i, d))
        elif kind == 'x': has(d, s, False, '%s must be absent from draft %s' % (i, d))
    for d in ('rev', 'fb'): d not in dr.split() or has(d, s, True, '%s missing in %s' % (i, d))
for d in '123': chk(600 <= len(rd(d).split()) <= 900 and 6 <= len(paras(d)) <= 8, 'size of draft ' + d)
def words(t): return re.findall(r"[a-z0-9'-]+", norm(t))
w1 = words(rd('s1')); runs8 = {tuple(w1[i:i + 8]) for i in range(len(w1) - 7)}          # no unmarked source wording except the planted q10
us = [norm(r[5]) for r in table('id | qid') if r[4] == 'u']
for d in '123':
    t = norm(re.sub(r'"[^"]*"', ' ', rd(d)))
    for u in us: t = t.replace(u, ' ')
    w = words(t); chk(not any(tuple(w[i:i + 8]) in runs8 for i in range(len(w) - 7)), 'unmarked source wording in draft ' + d)
def cover(a, d, n=6):                      # share of the anchor's words inside 6-word runs that also occur in the draft
    a, d = words(a), words(d); runs = {tuple(d[i:i + n]) for i in range(len(d) - n + 1)}; cov = set()
    for i in range(len(a) - n + 1): cov.update(range(i, i + n) if tuple(a[i:i + n]) in runs else ())
    return len(cov) / len(a)
for k in (21, 22, 23, 24):
    a = (demo / ('anchors/draft-%d/text.md' % k)).read_text(encoding='utf-8'); c = cover(a, rd('3'))
    chk(300 <= len(a.split()) <= 450 and (c >= 0.85) == (k == 23), 'anchor %d: %d words, coverage %.2f' % (k, len(a.split()), c))
T = {'A': 40, 'A-': 37, 'B+': 33, 'B': 30, 'B-': 27, 'C+': 23, 'C': 20, 'C-': 17, 'D+': 13, 'D': 10, 'D-': 7, 'F': 0}
def rnd(S, W, harsh):
    m = F(S) / W; lo = max(v for v in T.values() if v <= m); hi = min(v for v in T.values() if v >= m); inv = {v: k for k, v in T.items()}
    return inv[lo] if lo == hi or 2 * S < (lo + hi) * W or (2 * S == (lo + hi) * W and harsh) else inv[hi]
for c in json.loads((demo / 'grades-cases.json').read_text(encoding='utf-8'))['cases']:
    g, e = c['input'], c['expect']; harsh = g['harshness'] == 'harsh'; cap = g['cap']['fired']; S = W = 0; lim = []
    for k, v in g['criteria'].items():
        L = v['conditional'] if cap and k == 'sources' else v['grade']
        if L is None: continue
        x = T[L] if isinstance(L, str) else F(str(L))
        if isinstance(L, str) and x >= 33 and v['verified_strengths'] < (2 if harsh else 1): lim.append('%s:%s>B' % (k, L)); x = 30
        S += g['weights'][k] * x; W += g['weights'][k]
    pr = list(zip(sorted(T.values()), sorted(T.values())[1:]))          # adjacent steps: exact tie, near tie (ends included)
    chk(rnd(S, W, harsh) == e['alone'] and e['as_submitted'] == ('F' if cap else e['alone']) and e['partial'] == any(v['grade'] is None for v in g['criteria'].values())
        and e['exact_tie'] == any(2 * S == (a + b) * W for a, b in pr) and e['near_tie'] == any(abs(2 * S - (a + b) * W) <= W for a, b in pr)
        and sorted(e['limits']) == sorted(lim), 'case ' + c['name'])
if '--commands' in sys.argv: print(*cmds, sep='\n')
print('FAIL' if bad else 'OK', *bad, sep='\n'); sys.exit(bool(bad))
```
## 13. Open points
Conflicts and assumptions are listed in the return of the task that wrote this document. Main ones: route (b) needs a complete searchable text, so `s1` is a complete short treatise; anchors are numbered 21 to 24 to stay clear of the essay's draft numbers; the removal-child rule and the match-before-open rule are reconciled in the ARG-004 row; the quick run supplies the CANNOT-CHECK flag; the `report_lint.py` heuristics are not yet defined, so the lint pair differs by one unmistakable line.
