# Sources

notice: fictional demo; every source here is invented

## About this file

This file records what the tool actually read to check the essay, what it points the author to, the precedents it has registered, and the quotation ledger: one row for every attributed quotation in the draft, with its verification status. The orchestrator (the main agent of the grade skill) writes it; the source-verifier returns proposals and ledger lines. Reviewers receive extracts only. The rules for every section below are in tracker-rules.md, in the grade skill's references folder.

Format: a table row is replaced whole, and a pipe inside a cell is written `\|`. The block tagged `jsonl quotations` holds one JSON object per line, with the keys in the order listed beside it; a missing value is `null`. A line that does not parse stops the run.

## OPENED

What the tool read: a full text, an excerpt, a study, a summary or a catalogue page. A source recalled or only recommended is not listed here. A work the draft cites with no copy available is listed with access `no copy available`. A source stays listed while any open tracker row or non-VERIFIED ledger row depends on it.

At init, one row is seeded for each `primary_text` line of RUBRIC.md: work from the first field, edition used by the author from the second, locator system from the third. The other cells of a seeded row stay empty until a run reads a copy or finds none. Source ids are `s-<n>`, in sequence and never reused.

| id | work | type | edition, translator, year | locator system | edition used by the author | access | can verify | complete, searchable | file | rounds consulted | issue IDs checked | could not verify |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| s-1 | Ismund Karvale, On the Reading of the Tessel-Glass | primary full text | first edition, trans. Dorothea Pelling, Brennock & Vale, 1934 | page, with section number | first edition (Brennock & Vale, 1934) | full text searchable | wording, page | yes | sources/karvale-1934-first-edition.md | 1, 2 | PRIM-001, PRIM-002, PRIM-003, SRC-001, SRC-002, SRC-003 | none |
| s-2 | Petra Linden, A Short Guide to Karvale's Tessel-Glass | secondary web summary | web page by Petra Linden, last updated 2030-09-12, https://guides.example/karvale | paragraph number | not cited by the author | full text searchable | wording | yes | sources/linden-short-guide.md | 2 | SRC-001 | the remark as Weir-Anand wrote it (no copy supplied) |

- edition, translator, year: the edition of the copy that was read. edition used by the author: the edition the draft's notes follow, which a page check and the integrity test compare against.
- complete, searchable: `yes` only when the whole work in that edition can be searched by string; otherwise `no`. Only a complete searchable text of the matching edition supports `not found in <named text>`.
- file: the path under `sources/` of the saved text, empty when there is none. Summaries used for the echo check are listed here with their files.

## RECOMMENDED

Pointers for the author, kept apart from OPENED because nothing here was read for a check. A pointer is a direction to read, not a claim that the source supports the author; there are at most two per problem. The status of each pointer (adopted, not adopted, retired) is in the reading-list status table of STATE.md. Ids are `rec-<n>`.

| id | work | section | purpose | finding ID | locator confidence | draft |
|---|---|---|---|---|---|---|
| rec-1 | Hollis Weir-Anand, *Dials and Their Questions* (Ashgrove Press, 1988) | the chapter on scales | a direction to read on how a scale relates to the question a dial asks, for the tally and count contrast | PRIM-002 | work-level | 1 |
| rec-2 | Ismund Karvale, *On the Reading of the Tessel-Glass*, first edition | sec. 6 | a passage to read on a glass put to a stack of known lean, as material the claim in paragraph 4 may use or a reason to cut it | ARG-001 | checked with edition | 1 |

draft is the draft whose report first recommended the pointer.

## Precedent register

Candidates for an uncredited precedent, registered by the source-verifier after verifying them. A candidate it could not verify is registered UNVERIFIED, carries the label `check this against <named thing>` and has no grade effect. Ids are `prec-<n>`.

| id | who | where | when | status | label | supporting finding | credited in the draft | residual-contribution clause |
|---|---|---|---|---|---|---|---|---|

- who, where, when: who put the idea forward, in which work and passage, and when.
- status: VERIFIED-PRIMARY, VERIFIED-SECONDARY or UNVERIFIED.
- credited in the draft: yes or no.
- residual-contribution clause: what the essay adds beyond the precedent, as the argument-reviewer stated it.

## Format basis

The style file and the manual behind the page and format checks. One disclaimer line in each report is built from this table.

| style file | manual and edition | used for |
|---|---|---|
| chicago-notes.md | the Chicago Manual of Style, 18th edition | page and format checks |

## Quotation ledger

One line per attributed quotation, matched by `qid`. The block starts empty. A string no longer in the draft keeps its row as a record. A row with no `source_id` cannot be VERIFIED.

| Key | Holds |
|---|---|
| qid | `q-` and the first six hexadecimal digits of the sha1 of the normalised string; stable while the string is unchanged |
| draft | the latest draft that holds the string |
| locator | `para N, first words` or `note n`; a string quoted twice and attributed to one work lists both |
| string | the draft's exact string, errors intact |
| attributed_to | the author and work the draft attributes it to |
| work_edition | the work and edition the check used, or null |
| source_id | the id of an OPENED row, or null |
| status | one of the ten statuses in the legend |
| flags | an array of flags from the legend, empty when none |
| label | one of the eight labels of rules.md |
| checked_against | the edition and page or the named secondary source, or null |
| evidence_level | original, secondary, recalled or none |
| round_verified | the latest draft whose review checked the string, or null |
| rounds_open | the number of rounds the row stood in a non-VERIFIED status; 0 when VERIFIED |

```jsonl quotations
{"qid": "q-f6b49d", "draft": 2, "locator": "para 1, Few instruments are", "string": "The tessel-glass is a tapered tube of glass, part filled with fine grit and cut along its length with a scale of marks", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 9)", "checked_against": "first edition, sec. 1, p. 9", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-a22e4f", "draft": 2, "locator": "para 2, Karvale's account begins", "string": "Each mark asks a question of the stack; a reading only answers it", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 11)", "checked_against": "first edition, sec. 2, p. 11", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-c01568", "draft": 2, "locator": "para 2, Karvale's account begins", "string": "A tally is not a count", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 14)", "checked_against": "first edition, sec. 3, p. 14", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-188599", "draft": 2, "locator": "para 3, An obvious objection", "string": "A reading is a tally of what the scale asks and not of what the stack does", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 15)", "checked_against": "first edition, sec. 3, p. 15", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-62a625", "draft": 2, "locator": "para 7, In the end", "string": "Every glass carries its maker's question, and no glass can carry another's", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 49)", "checked_against": "first edition, sec. 10, p. 49", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-6071dc", "draft": 2, "locator": "para 4, Consider a glass", "string": "In the dark the observer reads by touch, and the touch is trained to the marks, not to the stack", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 33)", "checked_against": "first edition, sec. 7, p. 33", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-a67e36", "draft": 2, "locator": "para 7, In the end", "string": "A glass is honest when it is read as the question it was cut to ask", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 60)", "checked_against": "first edition, sec. 12, p. 60", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-dd85b3", "draft": 2, "locator": "para 5, Agreement between glasses", "string": "A scale cut finer asks more of the stack, and the stack can answer less", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "VERIFIED-PRIMARY", "flags": [], "label": "checked against the original (first edition, 55)", "checked_against": "first edition, sec. 11, p. 55", "evidence_level": "original", "round_verified": 1, "rounds_open": 0}
{"qid": "q-d9951c", "draft": 2, "locator": "para 3, An obvious objection", "string": "every scale is a standing question", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "Petra Linden, A Short Guide to Karvale's Tessel-Glass", "source_id": "s-2", "status": "MISATTRIBUTED", "flags": ["QUOTED-IN"], "label": "checked against a secondary source (Linden, A Short Guide)", "checked_against": "Linden, A Short Guide, paragraph 3", "evidence_level": "secondary", "round_verified": 2, "rounds_open": 1}
{"qid": "q-ee0f90", "draft": 2, "locator": "para 5, Agreement between glasses", "string": "Two glasses cut alike give two readings alike on a single stack, and the agreement is made by the cutting, not found in the stack", "attributed_to": null, "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "NEAR-VERBATIM-UNMARKED", "flags": [], "label": "checked against the original (first edition, 39)", "checked_against": "first edition, sec. 8, p. 39", "evidence_level": "original", "round_verified": 2, "rounds_open": 1}
{"qid": "q-cf706d", "draft": 2, "locator": "para 6, A glass at rest", "string": "convention-first", "attributed_to": null, "work_edition": null, "source_id": null, "status": "MARKS-WITHOUT-SOURCE", "flags": [], "label": "in my reading", "checked_against": null, "evidence_level": "none", "round_verified": 2, "rounds_open": 1}
```

## Legend

### Statuses (one per ledger row)

| Status | Meaning | Prints in | Can feed the split |
|---|---|---|---|
| VERIFIED-PRIMARY | wording and locator confirmed against the original in a matching edition | never listed | no |
| VERIFIED-SECONDARY | confirmed against a named secondary source | never listed | no |
| UNVERIFIED | not checked or not checkable, which means not wrong | Citation problems, "check your copy" list | no |
| MISMATCH | wording differs in sense from a located counter-passage | Quotation problems, numbered entry (a defect) | only if all four conditions hold |
| PARAPHRASE-IN-QUOTES | the source was found and its sense is paraphrased inside marks attributed to it | Quotation problems, numbered entry (a defect) | only if all four conditions hold |
| OCR-ERROR | the draft string differs from the source only by character corruption of the kind scanning or conversion produces | Quotation problems, one line (a defect) | no |
| MISATTRIBUTED | genuine wording credited to the wrong author or work | Quotation problems, numbered entry (a defect) | no |
| TRANSPOSED | reordered wording with no change of sense | Quotation problems, numbered entry (a defect) | no |
| NEAR-VERBATIM-UNMARKED | close source wording without quotation marks | Quotation problems, numbered entry (a defect) | no |
| MARKS-WITHOUT-SOURCE | the marked text is the author's own or has no source, as with scare quotes | Quotation problems, numbered entry (a defect) | no |

### Flags (added to a status when they apply)

| Flag | Meaning | Prints in |
|---|---|---|
| REVIEW-ECHO | the draft wording matches an archived report's wording | travels with its row |
| SECONDARY-ECHO | the draft wording matches a secondary summary's own phrasing (status UNVERIFIED plus SECONDARY-ECHO, or VERIFIED-SECONDARY if the author cites the summary) | Citation problems, "check your copy" list |
| SWAPPED-WORDS | a short quoted phrase with a few words changed from an earlier report's wording | travels with its row |
| NOT-FOUND | a search of a named text found nothing | Citation problems, "check your copy" list |
| QUOTED-IN | the wording appears in an intermediary the author did not cite (with MISATTRIBUTED) | travels with its row |
| REF-COPY-OCR | the only copy of the source is a scan with OCR, so it cannot ground VERIFIED-PRIMARY | Citation problems, "check your copy" list |

### Other vocabularies

| Column | Values |
|---|---|
| type (OPENED) | primary full text, primary excerpt, secondary study, secondary web summary, catalogue page |
| access (OPENED) | full text searchable, excerpt, abstract, catalogue only, scan with OCR, no copy available |
| can verify (OPENED) | wording, page, bibliographic data only (wording and page may be listed together) |
| complete, searchable (OPENED) | yes, no |
| locator confidence (RECOMMENDED) | work-level, checked with edition, recalled |
| status (precedent register) | VERIFIED-PRIMARY, VERIFIED-SECONDARY, UNVERIFIED |
| credited in the draft (precedent register) | yes, no |
| evidence_level (ledger) | original, secondary, recalled or none |
