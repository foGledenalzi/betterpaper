# State

title: What the Glass Answers: Reading and Report in Karvale's Tessel-Glass
genre: argumentative
thesis_locator: para 1, Few instruments are
next_draft: 3
notice: fictional demo; every grade and name here is invented

## About this file

This file is the memory of one essay between grading runs: grade history, the issue tracker, logs and the records the reports are built from. The orchestrator (the main agent of the grade skill) reads and writes it. Reviewers never see it; they receive a stripped extract of the tracker. The rules for every section below are in tracker-rules.md, in the grade skill's references folder.

| Field | Meaning |
|---|---|
| title, genre | copied from the answers given at init; RUBRIC.md holds the settings |
| thesis_locator | the paragraph where the latest graded draft states its thesis, as `para N, first words`; empty until a run fills it. This file holds no wording of the thesis: the author's own wording, if declared, is `declared_thesis` in RUBRIC.md |
| next_draft | the number the next draft will be saved under; the starting number given at init, raised by the last step of each run |

Format: a table row is replaced whole, and a pipe inside a cell is written `\|`. The blocks tagged `jsonl` hold one JSON object per line, with the keys in the order listed beside each block; a missing value is `null`. A line that does not parse stops the run.

## Counters and printed tags

The counters live in the tracker rows and the PATTERNS table. Each printed recurrence tag is generated from the stored value named here and is never written by hand.

| Counter or flag | What it holds | Printed tag it drives |
|---|---|---|
| rounds_flagged | the number of reviews that listed the item | `(second round)`, `(third round)`, `(round N)` |
| drafts_present | the number of consecutive drafts that contain the defect at its anchor, the first draft counted as 1 | `(unchanged since draft M)`; with status PARTIAL, `(half fixed)` |
| reviews_flagged (PATTERNS table) | the number of reviews that flagged a pattern | `(pattern flagged in N reviews)` |
| CANNOT-CHECK (a flag, not stored) | an open row that no reviewer re-read this round | `(not rechecked)` |
| `reopened=<n>` (in verified_status) | the number of times a row came back from RESOLVED | `(reopened)` |

## Grade history

One row per graded round, appended when the run finishes. A row for an earlier draft imported at init carries `imported` yes and was not produced by a run.

| draft | review_date | report | mode | overall_as_submitted | overall_alone | tool_grade | primary | argument | structure | sources | sources_conditional | originality | mechanics | target | open_by_tier | imported | human-adjusted |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2031-02-03 | reviews/draft-1.md | full | C | C | C | D | C | C+ | B- | | C+ | C | B- | 1:3 2:1 3:2 4:1 | no | no |
| 2 | 2031-02-17 | sha1:34aad9facdbec0a85bc0af5c7791398e3cb954bc | full | C+ | C+ | C+ | C- | C+ | C+ | C | | B | C | B- | 1:2 3:2 4:2 | no | no |

- draft, review_date, report: the draft number; the review date (empty when unknown); the workspace-relative path of the report.
- mode: full or quick; empty on an imported row.
- overall_as_submitted, overall_alone: the two overall series, equal when no cap fired. Grades come from the closed set A, A-, B+, B, B-, C+, C, C-, D+, D, D-, F.
- tool_grade: the tool's own overall_alone as first written. It is kept when `init <slug> --confirm` replaces overall_alone with an adjusted grade, and is empty on an imported row.
- primary to mechanics: the criterion grades, each a grade from the closed set or `not graded`. Structure is always `not graded` on an imported row.
- sources_conditional: the conditional grade on Use of sources, filled only when a cap fired.
- target: the target grade named in the report, or `none` in the top band.
- open_by_tier: open tracker rows by severity tier, as `tier:count` pairs separated by spaces.
- imported, human-adjusted: `yes` or `no`; human-adjusted is `yes` once a person adjusted any grade of the row.

## Anchors register

A derived list of the folders `anchors/draft-N/`. The `ANCHOR.md` file in each folder is authoritative when the two differ. confirmed_by is author, instructor or unconfirmed; band is the letter (A, B, C, D or F) of overall_alone.

| draft | overall_alone | band | confirmed_by |
|---|---|---|---|
| 21 | A- | A | instructor |
| 22 | B | B | author |
| 23 | C+ | C | author |
| 24 | D | D | instructor |

## Anchor-order log

The order in which anchors were shown, one row per reviewer per run, as `select_anchors.py` printed it. The seed is `anchor_seed` in RUBRIC.md. order lists the anchor drafts in the order shown; anchors_line is the script's line of the form `anchors: N (M near the top band)`.

| draft | reviewer | order | anchors_line |
|---|---|---|---|

## Token and cost log

One row per agent per run, including the orchestrator and any repeat calls; the estimate printed before a full run goes in the note of the orchestrator's row. model is the model ID recorded for the run; the model-change notice compares it with the model recorded on each anchor. run_date and prompt_hash are empty when the run cannot supply them.

| draft | run_date | model | prompt_hash | agent | calls | input_tokens | output_tokens | note |
|---|---|---|---|---|---|---|---|---|

## Issue tracker

One row per atomic defect at an anchor. The block below holds the rows and starts empty. A row is edited by replacing its whole line, matched by `id`.

### Statuses and the CANNOT-CHECK flag

| Status | Meaning | Open |
|---|---|---|
| OPEN | the defect stands and has not been fixed | yes |
| PARTIAL | part is fixed and the remainder stands | yes |
| RECURRING | it survived an edit or an author-claimed fix in full | yes |
| REGRESSED | it came back after RESOLVED | yes |
| RESOLVED | a reviewer re-read the current draft and the defect is gone | no |
| REMOVED-VERIFIED | the passage was cut and a reviewer verified it; frozen | no |
| WITHDRAWN | the earlier flag was wrong; a Correction records it | no |
| SUPERSEDED | the surface defect is gone but another stands at the same anchor; the child row carries on | no |

CANNOT-CHECK is a flag, not a status: it marks an open row that no reviewer re-read, which keeps its status and prints `(not rechecked)`. It is not stored.

### Keys and what reviewers see

The keys in the order they are written. The last column marks the keys a reviewer sees in its extract. A reviewer also sees a bare re-verify flag on a row whose author marker came with the current run, and never the marker itself.

| Key | Holds | Visible to reviewers |
|---|---|---|
| id | `<CAT>-<NNN>`, never reused; categories PRIM, ARG, STRU, SRC, ORIG, MECH | yes |
| category | the category part of the id | yes |
| subtype | the closed defect code; for SRC: QUO, CIT or CRED; for MECH: a pattern name or `misc` | yes |
| tier | severity tier 0 to 5 from the defect code; null for MECH, CIT and non-capping QUO rows | yes |
| diagnosis | one sentence of diagnosis, no replacement wording; a MECH row ends with its first trigger | yes |
| anchor | `para N, first words` or `note n`; a QUO row starts with its QID | yes |
| instances | the count at the anchor | no |
| first_seen | the earliest draft a reviewer shows holding the defect | no |
| first_flagged | the draft whose review first listed it | no |
| rounds_flagged | counter, see above | no |
| drafts_present | counter, see above | no |
| last_seen | the latest draft whose anchor a reviewer checked and found the defect | no |
| status | one of the eight statuses | no |
| author_claim | the raw marker token as written, or null | no |
| claim_scope | `item` or `group`, or null | no |
| verified_status | null, or items joined by `; `: PENDING, CONFIRMED or DISPUTED, then `gone=`, `function_still_served=`, `replacement_support=` and `reopened=<n>` entries | no |
| origin | `essay`, `earlier-review suggestion` or `earlier-review error` | no |
| thread | the id of the first row of a chain of follow-ups (a first row names itself) | no |
| follow_up_of | the parent row's id, or null | no |
| evidence_level | original, secondary, draft, recalled or none | no |
| checked_against | what the finding was checked against, as its label states it | no |
| confidence | high, medium or low, or null | no |
| display_group | a label shared by rows that print as one item, or null | no |
| severity_history | an array of `{"draft", "tier", "reason"}` objects, oldest first | no |

```jsonl tracker
{"id": "PRIM-001", "category": "PRIM", "subtype": "RELATION-INVERTED", "tier": 1, "diagnosis": "Paragraph 2 states the relation between mark and reading in the reverse direction from the treatise.", "anchor": "para 2, Karvale's account begins", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 1, "status": "RESOLVED", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "PRIM-001", "follow_up_of": null, "evidence_level": "original", "checked_against": "checked against the original (first edition, 11)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 1, "reason": "first flagged"}]}
{"id": "PRIM-002", "category": "PRIM", "subtype": "DISTINCTION-COLLAPSED", "tier": 1, "diagnosis": "Paragraph 2 treats a tally as a count of what the stack does, dropping the contrast between the two terms that the treatise draws.", "anchor": "para 2, Karvale's account begins", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "PRIM-002", "follow_up_of": null, "evidence_level": "original", "checked_against": "checked against the original (first edition, 14)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 1, "reason": "first flagged"}]}
{"id": "PRIM-003", "category": "PRIM", "subtype": "TERM-VS-SOURCE", "tier": 1, "diagnosis": "Paragraph 4 applies settle to the observer, against the source's use of the term for the grit coming to rest.", "anchor": "para 4, Consider a glass", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "PRIM-003", "follow_up_of": null, "evidence_level": "original", "checked_against": "checked against the original (first edition, 19)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 1, "reason": "first flagged"}]}
{"id": "ARG-001", "category": "ARG", "subtype": "NO-EVIDENCE", "tier": 2, "diagnosis": "The claim in paragraph 4 about a glass no one has ever calibrated is asserted with no example or other evidence.", "anchor": "para 4, Consider a glass", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 1, "status": "RESOLVED", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "ARG-001", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 2, "reason": "first flagged"}]}
{"id": "ARG-002", "category": "ARG", "subtype": "BRIDGE-GAP", "tier": 3, "diagnosis": "Paragraph 5 passes from agreement between glasses to the conclusion about what a reading can be with a step missing between them.", "anchor": "para 5, Agreement between glasses", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "ARG-002", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 3, "reason": "first flagged"}]}
{"id": "ARG-003", "category": "ARG", "subtype": "QUOTE-WITHOUT-GLOSS", "tier": 3, "diagnosis": "Paragraph 3 quotes the treatise and states the objection without saying what the quotation shows for the point at stake.", "anchor": "para 3, An obvious objection", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "ARG-003", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 3, "reason": "first flagged"}]}
{"id": "ARG-004", "category": "ARG", "subtype": "EXAMPLE-FIT", "tier": 4, "diagnosis": "The surveyor example in paragraph 4 carries detail beyond the point it is placed to support, so its fit with the claim is loose.", "anchor": "para 4, Consider a glass", "instances": 1, "first_seen": 2, "first_flagged": 2, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 2, "status": "OPEN", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "ARG-004", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 2, "tier": 4, "reason": "first flagged"}]}
{"id": "STRU-001", "category": "STRU", "subtype": "WEAK-ENDING", "tier": 4, "diagnosis": "Paragraph 7 ends on a generalisation about dials that adds a comparison and closes nothing the essay has argued.", "anchor": "para 7, In the end", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "STRU-001", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": 4, "reason": "first flagged"}]}
{"id": "SRC-001", "category": "SRC", "subtype": "QUO", "tier": null, "diagnosis": "Genuine wording credited to Karvale; a secondary source gives it as Weir-Anand's and it is not in the first edition (MISATTRIBUTED).", "anchor": "q-d9951c, para 3, An obvious objection", "instances": 1, "first_seen": 2, "first_flagged": 2, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 2, "status": "OPEN", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "SRC-001", "follow_up_of": null, "evidence_level": "original", "checked_against": "not found in the first edition (complete, searchable); checked against a secondary source (Linden, A Short Guide)", "confidence": null, "display_group": null, "severity_history": [{"draft": 2, "tier": null, "reason": "first flagged"}]}
{"id": "SRC-002", "category": "SRC", "subtype": "QUO", "tier": null, "diagnosis": "A sentence in paragraph 5 follows a first-edition sentence closely but carries no quotation marks and no note (NEAR-VERBATIM-UNMARKED).", "anchor": "q-ee0f90, para 5, Agreement between glasses", "instances": 1, "first_seen": 2, "first_flagged": 2, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 2, "status": "OPEN", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "SRC-002", "follow_up_of": null, "evidence_level": "original", "checked_against": "checked against the original (first edition, 39)", "confidence": null, "display_group": null, "severity_history": [{"draft": 2, "tier": null, "reason": "first flagged"}]}
{"id": "SRC-003", "category": "SRC", "subtype": "QUO", "tier": null, "diagnosis": "A word in paragraph 6 sits in quotation marks with no attribution and no source, which reads as a scare quote (MARKS-WITHOUT-SOURCE).", "anchor": "q-cf706d, para 6, A glass at rest", "instances": 1, "first_seen": 2, "first_flagged": 2, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 2, "status": "OPEN", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "SRC-003", "follow_up_of": null, "evidence_level": "original", "checked_against": "not found in the first edition (complete, searchable)", "confidence": null, "display_group": null, "severity_history": [{"draft": 2, "tier": null, "reason": "first flagged"}]}
{"id": "MECH-001", "category": "MECH", "subtype": "agreement", "tier": null, "diagnosis": "Verb does not agree with its subject, twice in paragraph 2; first trigger: each of the marks ask", "anchor": "para 2, Karvale's account begins", "instances": 2, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "MECH-001", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": null, "reason": "first flagged"}]}
{"id": "MECH-002", "category": "MECH", "subtype": "apostrophe", "tier": null, "diagnosis": "Possessive written without its apostrophe in paragraph 3; first trigger: the glasses scale", "anchor": "para 3, An obvious objection", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 1, "drafts_present": 1, "last_seen": 1, "status": "RESOLVED", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "MECH-002", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": null, "reason": "first flagged"}]}
{"id": "MECH-003", "category": "MECH", "subtype": "comma-splice", "tier": null, "diagnosis": "Two independent clauses are joined by a comma alone in paragraph 6; first trigger: The glass settles, the reader waits", "anchor": "para 6, A glass at rest", "instances": 1, "first_seen": 1, "first_flagged": 1, "rounds_flagged": 2, "drafts_present": 2, "last_seen": 2, "status": "RECURRING", "author_claim": null, "claim_scope": null, "verified_status": null, "origin": "essay", "thread": "MECH-003", "follow_up_of": null, "evidence_level": "draft", "checked_against": "in my reading (the draft's own text)", "confidence": null, "display_group": null, "severity_history": [{"draft": 1, "tier": null, "reason": "first flagged"}]}
```

## PATTERNS

The closed list of Mechanics patterns, one row each. counts_by_draft holds `draft:count` pairs separated by spaces, oldest first, taken from the mechanics-reviewer's whole-text search. consecutive_drafts is the number of consecutive drafts ending at the latest with a count of 1 or more. reviews_flagged is the number of reviews that flagged the pattern.

| pattern | counts_by_draft | consecutive_drafts | reviews_flagged |
|---|---|---|---|
| agreement | 1:2 2:2 | 2 | 2 |
| fragment | 1:0 2:0 | 0 | 0 |
| comma-splice | 1:1 2:1 | 2 | 2 |
| dangling-modifier | 1:0 2:0 | 0 | 0 |
| apostrophe | 1:1 2:0 | 0 | 1 |
| hyphenation | 1:0 2:0 | 0 | 0 |
| symbol-for-word | 1:0 2:0 | 0 | 0 |
| italics-vs-quotes | 1:0 2:0 | 0 | 0 |
| voice-person | 1:0 2:0 | 0 | 0 |
| spelling | 1:0 2:0 | 0 | 0 |
| tense | 1:0 2:0 | 0 | 0 |

### Mechanics class counts

One row per graded draft; the first row is the baseline recorded at the first graded round. M1 is spelling and agreement, M2 syntax, M3 diction and voice.

| draft | words | M1 | M2 | M3 |
|---|---|---|---|---|
| 1 | 674 | 3 | 1 | 0 |
| 2 | 768 | 2 | 1 | 0 |

## Citation ledger

One line per cited work, kept by the source-verifier and matched by `work`. It records what the notes or references of the draft show, checked against the style file selected by `style` in RUBRIC.md. The block starts empty.

| Key | Holds |
|---|---|
| work | the cited work as the draft names it |
| edition_used | the edition the notes follow, or null |
| chapter_page_pairs | an array of short strings, each a chapter with its page |
| completeness_gaps | an array of gaps against the style file, including a second edition in use |
| date_pairs | an array of original and published date pairs |
| placeholders | an array of placeholder text found |
| title_formats | an array of title formatting defects, such as italics against quotation marks |

```jsonl citations
{"work": "Ismund Karvale, On the Reading of the Tessel-Glass", "edition_used": "first edition, trans. Dorothea Pelling (Brennock & Vale, 1934)", "chapter_page_pairs": ["sec. 1, p. 9", "sec. 2, p. 11", "sec. 3, p. 14", "sec. 3, p. 15", "sec. 7, p. 33", "sec. 10, p. 49", "sec. 11, p. 55", "sec. 12, p. 60"], "completeness_gaps": [], "date_pairs": [], "placeholders": [], "title_formats": []}
```

## Suggestions log and rescue log

The suggestions log holds the remedy text of every report, so that a later defect can be compared with it. The rescue log holds each rescue (a suggested way to save a passage by adding a move the essay has not made), at most one per tracker row.

### Suggestions log

id is `sug-<n>`. draft is the report that made the suggestion. suggestion is a one-line summary of the remedy. origin is the tracker row or report section it answered. relied_on is yes, no or unknown (whether a later draft followed it). carried_gap is yes or no (whether the remedy left a gap that a later defect shows).

| id | draft | suggestion | origin | relied_on | carried_gap |
|---|---|---|---|---|---|
| sug-1 | 1 | define tally against count | PRIM-002 | yes | no |
| sug-2 | 1 | supply an example for the claim in paragraph 4 or cut it | ARG-001 | yes | no |
| sug-3 | 2 | cut the example in paragraph 4 or reduce it to the point it supports | ARG-004 | unknown | no |

### Rescue log

id is `resc-<n>`. direction is the route as labelled `a direction to test`; premise is its untested premise; adopted is yes, no or unknown.

| id | draft | tracker_row | direction | premise | adopted |
|---|---|---|---|---|---|

## Archive of earlier reports and reviewer_wording

The archive lists every earlier report, which the echo check compares with the draft. reviewer_wording lists distinctive phrases that reports supplied, to spot them later in the author's text.

### Archive

| draft | report |
|---|---|
| 1 | reviews/draft-1.md |
| 2 | sha1:34aad9facdbec0a85bc0af5c7791398e3cb954bc |

### reviewer_wording

phrase is up to about 12 words. draft_supplied is the draft whose report used it. section is the report section. later_sightings lists the drafts where the phrase appeared in the author's text.

| phrase | draft_supplied | section | later_sightings |
|---|---|---|---|
| a glass set against a stack of known lean still answers only | 1 | Reading for the revision | none |

## Corrections log and earlier source characterisations

The corrections log records every Correction a report made. The characterisations table keeps each earlier characterisation of a source, so that a later run can re-verify it.

### Corrections log

kind is factual error, backfired suggestion or omission.

| report | claim | date | affected_criteria | grade_effect | kind |
|---|---|---|---|---|---|

### Earlier source characterisations

id is `sc-<n>`. scope is the narrowest passage checked. label is one of the eight labels, naming the basis.

| id | draft | work | characterisation | scope | label |
|---|---|---|---|---|---|
| sc-1 | 1 | Ismund Karvale, On the Reading of the Tessel-Glass | the treatise uses settle only of the grit coming to rest | sec. 4, p. 19 | checked against the original (first edition, 19) |

## Risk register

Elements flagged as a risk to a reader, with no counters and no grade effect. Ids are `RISK-<NNN>`, never reused.

| id | element | round_flagged | rationale | flag_given |
|---|---|---|---|---|

## Keep list and commitments

The keep list holds the strengths a report praised. The commitments list holds formats the author promised readers, from `declared_promises` in RUBRIC.md or the draft.

### Keep list

| draft | criterion | descriptor | locator | strength |
|---|---|---|---|---|

### Commitments

| commitment | declared_in | delivered_in_draft |
|---|---|---|

## Decisions

Three records. The holistic grade record holds the orchestrator's holistic letter grade for each full-mode run, written before the computed grade and not edited afterwards. The cap event log holds one entry per graded draft: for each quotation that reached the integrity test, its QID, the result of conditions 1 to 4, the route, the evidence, the near-match type if any and the decision; when a cap fired also the conditional grade, the named fix, both overall grades and the target with its rule; with no firing row, `cap: none; N rows tested`. The disagreement record holds the disagreement signal and any repeat run for each full-mode draft; spread is per criterion and overall, in tenths.

### Holistic grade record

| draft | holistic_grade |
|---|---|
| 1 | C |
| 2 | C+ |

### Cap event log

| draft | entry |
|---|---|
| 1 | cap: none; 0 rows tested |
| 2 | cap: none; 3 rows tested |

### Disagreement and repeat record

| draft | disagreement_signal | repeat | spread |
|---|---|---|---|
| 1 | no | not run | n/a |
| 2 | no | not run | n/a |

## Reading-list status

The pointers in the RECOMMENDED table of SOURCES.md, with what became of each. status is adopted, not adopted or retired; a new pointer starts as not adopted.

| rec_id | work | status | checked_draft |
|---|---|---|---|
| rec-1 | Hollis Weir-Anand, *Dials and Their Questions* (Ashgrove Press, 1988) | not adopted | 2 |
| rec-2 | Ismund Karvale, *On the Reading of the Tessel-Glass*, first edition, sec. 6 | not adopted | 2 |
