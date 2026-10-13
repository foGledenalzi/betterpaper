# Sources

## About this file

This file records what the tool actually read to check the essay, what it points the author to, the precedents it has registered, and the quotation ledger: one row for every attributed quotation in the draft, with its verification status. The orchestrator (the main agent of the grade skill) writes it; the source-verifier returns proposals and ledger lines. Reviewers receive extracts only. The rules for every section below are in tracker-rules.md, in the grade skill's references folder.

Format: a table row is replaced whole, and a pipe inside a cell is written `\|`. The block tagged `jsonl quotations` holds one JSON object per line, with the keys in the order listed beside it; a missing value is `null`. A line that does not parse stops the run.

## OPENED

What the tool read: a full text, an excerpt, a study, a summary or a catalogue page. A source recalled or only recommended is not listed here. A work the draft cites with no copy available is listed with access `no copy available`. A source stays listed while any open tracker row or non-VERIFIED ledger row depends on it.

At init, one row is seeded for each `primary_text` line of RUBRIC.md: work from the first field, edition used by the author from the second, locator system from the third. The other cells of a seeded row stay empty until a run reads a copy or finds none. Source ids are `s-<n>`, in sequence and never reused.

| id | work | type | edition, translator, year | locator system | edition used by the author | access | can verify | complete, searchable | file | rounds consulted | issue IDs checked | could not verify |
|---|---|---|---|---|---|---|---|---|---|---|---|---|

- edition, translator, year: the edition of the copy that was read. edition used by the author: the edition the draft's notes follow, which a page check and the integrity test compare against.
- complete, searchable: `yes` only when the whole work in that edition can be searched by string; otherwise `no`. Only a complete searchable text of the matching edition supports `not found in <named text>`.
- file: the path under `sources/` of the saved text, empty when there is none. Summaries used for the echo check are listed here with their files.

## RECOMMENDED

Pointers for the author, kept apart from OPENED because nothing here was read for a check. A pointer is a direction to read, not a claim that the source supports the author; there are at most two per problem. The status of each pointer (adopted, not adopted, retired) is in the reading-list status table of STATE.md. Ids are `rec-<n>`.

| id | work | section | purpose | finding ID | locator confidence | draft |
|---|---|---|---|---|---|---|

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
| evidence_level (ledger) | original, secondary, recalled, none |
