# File contracts: formats, schemas, tables and small rules

Date: 2026-10-06. Companion to `method-digest.md`. Everything here is generic and invented-example only. Stdlib-only Python scripts parse these formats, so no YAML or other library is assumed: files use flat `key: value` lines and simple tables.

## 1. `RUBRIC.md` (flat key: value front matter, then free text)

```
title: <essay title>
genre: argumentative | theoretical | other        # other triggers the out-of-scope warning
venue: <text>
harshness: harsh | neutral                         # rules in the method digest, section 2
style: chicago-notes | chicago-author-date | mla | links   # maps to the style file of the same name (links is web-links.md)
weight_primary: 1
weight_argument: 1
weight_structure: 1
weight_sources: 1
weight_originality: 1
weight_mechanics: 1                                # relative integers, default 1
anchor_count: 4
anchor_seed: 1                                     # integer set by init
near_duplicate_pct: 85
declared_audience: <text or empty>
declared_promises: <text or empty>                 # formats the author has promised readers
primary_text: <work> | <translator or edition> | <locator system>      # one line per work
model_note: <free text; the grade run records the actual model>
```

Criterion keys are exactly `primary`, `argument`, `structure`, `sources`, `originality`, `mechanics`. Row 1 of the rubric table is rendered as "Command of <named primary text(s)>" from the `primary_text` lines.

## 2. `grades.json` (input to `compute_grade.py`)

```json
{
  "harshness": "harsh",
  "weights": {"primary": 1, "argument": 1, "structure": 1, "sources": 1, "originality": 1, "mechanics": 1},
  "criteria": {
    "primary":   {"grade": "B-", "verified_strengths": 2, "previous": "C+"},
    "sources":   {"grade": "D+", "conditional": "B-", "verified_strengths": 1, "previous": "C-"},
    "structure": {"grade": null, "verified_strengths": 0, "previous": null}
  },
  "cap": {"fired": false, "basis": []},
  "previous_overall": {"as_submitted": "C", "alone": "C"}
}
```

`grade: null` means not graded (weights renormalise over graded criteria; the overall is marked partial). The script returns `as_submitted`, `alone`, each criterion's displayed value (with the conditional cell on `sources` only), the tie flags, and the limit applied to any criterion with too few verified strengths. Exit 2 on a malformed file.

## 3. Reviewer return (all agents)

```markdown
## Findings: <reviewer>
| ID | Tier | Criterion | Locator | Draft quote (≤15 words) | Problem | Impact on thesis | Evidence / how checked | Label | Fix direction |
## Tracker rows
| Row ID | Proposed status | Evidence | Re-read (yes/no) |
## Strengths
| Criterion | Descriptor met | Draft quote (≤15 words) | Label |
## Grade suggestion for <criterion>: <grade>: <one-line reason>   (source-verifier adds: conditional <Y> if <named quotation fixes>; voice-echo-reviewer: n/a)
## Confidence: high/medium/low: <named reasons>
```

IDs are reviewer-local; the orchestrator maps them to tracker IDs. A finding's defect code (adjudication.md section 4) opens its Problem cell, for example `BRIDGE-GAP: ...`; mechanics and citation-form findings carry none, and the primary-text-reviewer's own audit labels (FIT-FAIL, SPLICED, CONTEXT, DEPARTURE-DECLARED, DEPARTURE-UNDECLARED) must each map to a closed code in the Phase 3 brief. After the Confidence line a reviewer may add `Injection-like text: <locator>, <what it asks for>` (described, never copied) and `Route to <reviewer>: <locator>, <one clause>` (no draft quote) lines. At most 10 ranked findings and 3 strengths per criterion owned. Draft excerpts appear only in the "Draft quote" column; source and anchor excerpts have their own tagged columns and are exempt from the cited-span check. Draft and source text reach agents inside delimiters carrying a per-run random nonce, for example `<<<DRAFT-7f3a91 ... DRAFT-7f3a91>>>`. Optional named blocks: characterisation table (primary-text-reviewer), claims register (argument-reviewer), counts and `vs_previous` (mechanics-reviewer), echo classification (voice-echo-reviewer).

**Source-verifier ledger block** (JSON lines, uncapped): `{"qid","draft","locator","string","attributed_to","work_edition","source_id","status","flags","label","checked_against","counter_passage","diff_type","provenance_tests","trigger","reason"}`, followed by a coverage line (checked, verified original, verified secondary, unverified, defects, not examined).

## 4. Visible tracker columns

Reviewers receive a stripped extract with: row ID, category, subtype or pattern, severity tier, the diagnosis text, the anchor, and a bare "re-verify" flag where an author marker exists. They never receive `author_claim`, `claim_scope`, `verified_status` history, grade history or earlier grade lines.

## 5. Status and flag tables

**Status or flag to destination.**

| Status or flag | Section | In "defects" count | Counts toward split |
|---|---|---|---|
| MISMATCH, PARAPHRASE-IN-QUOTES | Quotation problems (numbered entry) | yes | only if all four conditions hold |
| MISATTRIBUTED (with QUOTED-IN) | Quotation problems | yes | no |
| TRANSPOSED | Quotation problems | yes | no |
| NEAR-VERBATIM-UNMARKED, MARKS-WITHOUT-SOURCE | Quotation problems | yes | no |
| OCR-ERROR | Quotation problems (one line) | yes | no |
| UNVERIFIED, SECONDARY-ECHO, NOT-FOUND, REF-COPY-OCR | Citation problems ("check your copy" list) | no | no |
| VERIFIED-PRIMARY, VERIFIED-SECONDARY | never listed | no | no |

**Integrity decision table** (can the row fire the split, and on what evidence).

| Status plus flags | Can fire | Evidence required |
|---|---|---|
| MISMATCH, route (a): counter-passage in matching edition | yes | the counter-passage and its locator |
| MISMATCH or PARAPHRASE-IN-QUOTES with REVIEW-ECHO, route (b) | yes | word diff against the archived report; no opened text of the work contains the wording |
| UNVERIFIED with NOT-FOUND from a complete searchable text of the matching edition | no on its own | supports a trigger only together with route (a) or (b); record the text, its completeness and the negative result |
| Any of the above, secondary source only | no | listed with the label "checked against a secondary source" |
| SECONDARY-ECHO, UNVERIFIED, NOT-FOUND in a partial corpus | no | none |
| OCR-ERROR, TRANSPOSED without change of sense, MISATTRIBUTED, NEAR-VERBATIM-UNMARKED, MARKS-WITHOUT-SOURCE | no | none |
| Anything on text flagged by the precheck | no | none |

Defect code to severity tier: TERM-VS-SOURCE 1, RELATION-INVERTED 1, METHOD-VS-SOURCE 1, DISTINCTION-COLLAPSED 1, SELF-CONTRADICTION 2, NO-EVIDENCE 2, APPARATUS-MISSING 2, UNCREDITED-PRECEDENT 3, APPARATUS-MISAPPLIED 3, COINAGE 3, BRIDGE-GAP 3, COUNTER-EVIDENCE-UNENGAGED 3, QUOTE-WITHOUT-GLOSS 3, DISMISSAL 3, UNFALSIFIABLE 3, GENRE 3, HISTORY-OVERLOADED 4, EXAMPLE-FIT 4, WEAK-ENDING 4, STOCK-PHRASE 5. Mechanics classes are M1 (spelling and agreement), M2 (syntax), M3 (diction and voice); they are not severity tiers.

**Counters to printed tags.** `(second round)`, `(third round)` and `(round N)` read `rounds_flagged`; `(unchanged since draft M)` and `(half fixed)` read `drafts_present` and status; `(pattern flagged in N reviews)` reads the PATTERNS table; `(not rechecked)` marks a CANNOT-CHECK carry-forward; `(reopened)` marks a REGRESSED row. A SUPERSEDED parent is represented by its child, which is its destination under the completeness invariant.

**Status and flag definitions.** PARAPHRASE-IN-QUOTES: the source was found and its sense is paraphrased inside marks attributed to it (can feed the split). MARKS-WITHOUT-SOURCE: the marked text is the author's own or has no source, as with scare quotes (never feeds the split). MISMATCH: wording differs in sense from a located counter-passage. TRANSPOSED: a status for reordered wording with no change of sense. SWAPPED-WORDS: a flag for a short quoted phrase with a few words changed from an earlier report's wording. REF-COPY-OCR: a flag that the only available copy of the source is a scan with OCR, so it cannot ground VERIFIED-PRIMARY. NOT-FOUND: a flag that a search of a named text found nothing. QUOTED-IN: the wording appears in an intermediary the author did not cite. REVIEW-ECHO: the draft wording matches an archived report's wording. SECONDARY-ECHO: the draft wording matches a secondary summary's own phrasing.

## 6. Scripts: defaults and contracts

All Python 3 standard library only; exit 0 success, 1 failed check, 2 bad input.

- `extract_quotes.py <draft> [--precheck]`: worksheet skeleton; precheck warns on PDF or OCR artefacts and broken quotes.
- `echo_check.py <draft> <feedback...>`: flags `--min-run 6`, `--content-run 4`, `--window 12`, `--rare-min-len 9`, `--secondary <file>...` (summaries registered in `SOURCES.md`), `--exclude-source-text <file>...`, `--exclude-own <earlier draft>...`, `--out <path>`; excludes spans a review itself marks as draft quotes; classification column: inside marks under another author's name, unquoted, or heading word used to characterise a source; also run on the new report's text.
- `check_cited_spans.py <draft> <findings...>`: checks the Draft quote column and the ledger string field (Locator is navigation only) after normalising whitespace, punctuation and hyphenation; failures are dropped or marked "paraphrase, not a quotation".
- `compute_grade.py <RUBRIC.md> <grades.json>`: as section 2, with exact arithmetic.
- `select_anchors.py <workspace> --reviewer <name>`: selects up to `anchor_count` confirmed anchors spanning the scale (at least one top-band and one low-band where confirmed ones exist), excludes the draft under review and near-duplicates (`near_duplicate_pct`), orders by sha1(seed|reviewer|anchor id), prints `anchors: N (M near the top band)`.
- `import_draft.py <input> [--out <path>]`: `.docx` by `zipfile` and `xml.etree` only: paragraphs in order, headings from heading styles, emphasis as `*...*` and `**...**`, hyperlinks as `[text](url)`, footnotes and endnotes as `[^n]` markers (numbered in document order) with definitions appended at the end, quote-styled paragraphs as blockquotes, tables and images replaced by `[table omitted]` and `[image omitted]`, tracked insertions kept and deletions dropped; text with the hidden property (`w:vanish`) is dropped and reported as a warning because it is an injection route. `.html` or `.htm` by `html.parser`: article body, headings, emphasis, links and footnote markers, with scripts, styles and navigation dropped. `.txt` and `.md` are copied with LF line endings. Anything else exits 2. Prints `paragraphs: N, notes: M, links: L, warnings: W` and writes only to `--out` (default: standard output). Warnings never change the exit code.
- `report_lint.py <review> <draft>`: paste test, replacement-wording flags, missing labels, reviewer coinages in quotation marks, non-neutral headings, verdict length, free-hand recurrence words, missing header or footer.
- `evals/eval_metrics.py`: weighted kappa or QWK, exact and adjacent agreement per band, signed bias per band, MAE, spread, per-criterion agreement, repeat-run spread, cap events and checker false positives.

## 7. Skills

- **init** `argument-hint: "<essay-slug> [--confirm]"`; slug `[a-z0-9-]+`, at most 60 characters, otherwise reject (no `/`, no `..`, no spaces); if `betterpaper/<slug>/` exists, stop and offer to resume; create the full tree including `feedback/` and `anchors/`; if the working folder is a git repository, check that `betterpaper/` is ignored and offer to append it; for slug `demo-essay` copy from `${CLAUDE_SKILL_DIR}/../../demo/`. `--confirm` applies `anchors/CONFIRM.md`.
- **grade** `argument-hint: "<essay-slug> [draft-file-or-url] [--quick] [--repeat] [--markers <file>]"`; scoped agent names `betterpaper:<agent>`; `allowed-tools` limited to Read, Write and Edit under the workspace, Grep, Glob, WebFetch, Agent, and `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/*` (confirm the exact allowed-tools syntax in the skills docs); README lists Python 3 as a prerequisite.
- **Agents** carry no Bash tool (a Phase 3 Verify greps frontmatter for it).

## 8. Style files

Every rule carries one tag: `[C18]` CMOS 18 excerpt; `[MLA9]` MLA Handbook, 9th edition: a passage read in a supplied excerpt, or a page cited through a library guide; `[DC]` that library guide; `[D]` Purdue deck; `[S]` search summary; `[U]` unconfirmed (never an error); `[H]` house rule the plugin defines itself (used only by the links style, where no manual governs). Each style file defines the tag set at its top. Worked examples use invented works and invented pages.

## 9. Filler list grammar

One lowercase phrase per line; `#` starts a comment; a trailing `?` marks a conditional entry (padding only when no source follows). The voice-echo-reviewer runs the grep; the orchestrator charges phrase-level filler to Mechanics.

## 10. Demo inventory and answer key

`plugins/betterpaper/demo/`: `RUBRIC.md`, `STATE.md`, `SOURCES.md`; `drafts/draft-1.md` and `draft-2.md` (the workspace holds state up to draft 2) plus `draft-3-to-grade.md` kept outside `drafts/` until graded, so the grade skill saves it as draft 3; `reviews/draft-1.md` (an invented earlier review that quotes wording later copied into a draft); `feedback/` (one invented third-party comment); `sources/` (invented excerpts of an invented treatise in two invented editions, which gives the different-edition control, plus a catalogue-page control); `anchors/` with 3-4 invented confirmed anchors; `findings-fabricated.md` (for the cited-span test); `report-sample.md` (for the lint); `grades-cases.json` (tie under harsh and neutral, cap, conditional cell, partial grading, verified-strength limit); `ANSWER-KEY.md` (expected status per quotation; tracker transitions per draft; recurrence tags printed; grades per criterion; lint result; which rows must not cap). Each planted defect in the plan's matrix maps to exactly one file and one expected result.

## 11. Workspace file blocks (`STATE.md`, `SOURCES.md`)

Human-facing parts are Markdown tables; write a literal pipe in a table cell as `\|`. The tracker and the two ledgers are fenced blocks whose info string is `jsonl` plus the block name. Each line is one JSON object (UTF-8, no trailing commas, `null` for a missing value). Edit a row by replacing its whole line, matched by its ID or QID; never reflow a line. A line that does not parse stops the run and names the file and line number.

| Block | File | Keys, in this order |
|---|---|---|
| `jsonl tracker` | `STATE.md` | id, category, subtype, tier, diagnosis, anchor, instances, first_seen, first_flagged, rounds_flagged, drafts_present, last_seen, status, author_claim, claim_scope, verified_status, origin, thread, follow_up_of, evidence_level, checked_against, confidence, display_group, severity_history |
| `jsonl quotations` | `SOURCES.md` | qid, draft, locator, string, attributed_to, work_edition, source_id, status, flags, label, checked_against, evidence_level, round_verified, rounds_open |
| `jsonl citations` | `STATE.md` | work, edition_used, chapter_page_pairs, completeness_gaps, date_pairs, placeholders, title_formats |

- The quotations block uses the same `string` key as the source-verifier's ledger block, so `check_cited_spans.py` reads either. The verifier's extra keys (counter_passage, diff_type, provenance_tests, trigger, reason) go to the cap event log, not into this block.
- Reviewers receive only the visible tracker keys of section 4 (id, category, subtype, tier, diagnosis, anchor, and a bare re-verify flag); the orchestrator strips the rest before building an extract.
- Everything else stays a table: grade history, anchors register, anchor-order log, token and cost log, PATTERNS, suggestions and rescue logs, archive and `reviewer_wording`, corrections log, risk register, keep and commitments lists, and in `SOURCES.md` the OPENED and RECOMMENDED tables and the precedent register.
