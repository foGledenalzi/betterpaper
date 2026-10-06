# Report sections: the status table and the fields of each section

You are the **orchestrator**, the main agent that runs the grade skill. report-template.md sets the order and conditions of the sections; this file sets what each one holds. Wording rules are in report-voice.md and the author's-words rules in rules.md. Grades, the integrity test, the severity key and the target rule are in adjudication.md. End every item that has a tracker row with its ID in brackets, printed as STATE.md stores it.

## 1. Status table

A **defect** here is a quotation row that prints as a numbered entry or a one-line item in Quotation problems; d in the count line counts them. Which row fires the split is decided by the decision table in adjudication.md, never by this table.

| Status or flag | Prints in | Counts in d | Can count toward the split |
|---|---|---|---|
| MISMATCH, PARAPHRASE-IN-QUOTES | Quotation problems, numbered entry | yes | only if all four conditions hold |
| MISATTRIBUTED (with QUOTED-IN) | Quotation problems, numbered entry | yes | no |
| TRANSPOSED | Quotation problems, numbered entry | yes | no |
| NEAR-VERBATIM-UNMARKED, MARKS-WITHOUT-SOURCE | Quotation problems, numbered entry | yes | no |
| OCR-ERROR | Quotation problems, one line | yes | no |
| UNVERIFIED, SECONDARY-ECHO, NOT-FOUND, REF-COPY-OCR | Citation problems, "check your copy" list | no | no |
| VERIFIED-PRIMARY, VERIFIED-SECONDARY | never listed | no | no |

The flags REVIEW-ECHO, SWAPPED-WORDS and QUOTED-IN travel with the row that carries them and have no entry of their own.

## 2. Correction to the draft N review

Prints when a trigger in rules.md holds (N is the draft that earlier review graded). Fields in order:
1. The heading "Correction to the draft N review".
2. The earlier claim, restated with its location in that report.
3. One verdict sentence: that was wrong, incomplete or overstated.
4. The correct content, with its label and what it was checked against.
5. One clause crediting the author when their draft exposed the error.
6. Numbered consequences, each naming the affected rubric row before and after (the rubric table carries the matching footnote).
7. The author's new action.
8. A note when the correction still rests on a secondary source.

List every tracker row set WITHDRAWN here. An inline heading tag such as "earlier suggestion" may appear in another section only if this section also records the item. Third person for the earlier report and no apology language (report-voice.md). Log the correction in STATE.md (rules.md).

## 3. Quotation problems

Four parts, in this order.
1. **Count line:** `N attributed quotations checked: a against the original, b against a secondary source, c unverified, d with defects`, for example `14 attributed quotations checked: 9 against the original, 1 against a secondary source, 4 unverified, 2 with defects`. When some quotations were not examined, a second sentence says how many and why, so that silence never reads as verification.
2. **Numbered entries**, one per row marked "numbered entry" in the status table. Fields in order: the note number (the locator when the draft has no numbered notes); the draft's exact string, errors intact, with the author and work it is attributed to; the verdict, naming what it was checked against, with its label; the origin (`matches wording in the draft N report`, a named secondary summary, another work, or none found); what the source says (verbatim with locator and label, or the locator plus "copy it from your edition" when only recalled); a one-sentence fit note (from the primary-text-reviewer's findings, or labelled `in my reading`); and "counts toward split: yes" or "counts toward split: no". An OCR-ERROR gets one line (the corrupted and the corrected token) plus "check every quotation against the printed edition". A VERIFIED row is never listed.
3. **Probable cause:** one paragraph on the probable cause, never intent (for example, working from a note instead of the page), and what a reader who checks will find.
4. **Fix:** one paragraph that separates quoted material from the author's own bridging argument. For wording that differs or is unmarked: replace it with the exact source sentence checked against its locator, or paraphrase it fully with a citation; never advise "add quotation marks" (rules.md).

UNVERIFIED and SECONDARY-ECHO rows go to the "check your copy" list in Citation problems, not here.

## 4. Major problems

Under the heading MAJOR PROBLEMS, IN ORDER OF SEVERITY print, in this order:
- the fixed sentence "The order is a judgement call; reasonable readers may rank these differently.";
- the sentence that argument moves in the report are the author's to accept or reject (report-voice.md);
- when problems were held back, one line giving how many; they stay open in the tracker.

Rank and cap as adjudication.md sets (severity key, at most 12). A tier-0 integrity finding is not ranked here. Each problem holds, in order:
1. A heading: an upper-case, full-sentence claim about the essay that blames the text, not the writer (report-voice.md), with its recurrence tag when one applies (section 7). A `(round N)` heading opens its body with "First raised in the draft M review."
2. The locator.
3. The quoted trigger: the draft's exact string, 15 words or fewer.
4. What the passage does, and its steelman (report-voice.md).
5. The basis, with its label.
6. The consequence, with a one-clause impact on the thesis.
7. Optional: an anticipated objection.
8. Optional: one route, tagged "route, not a fix" (a rescue; report-voice.md).
9. Optional: one positioning flag (rules.md).

Problem 1 runs to about eight bullets at most. Problem 1, and any problem that sets a rubric row at C or below, carries a "why it ranks here" sentence. A row with status PARTIAL prints here as "(half fixed)". A problem that merges several defect codes takes the most severe code for its heading.

## 5. Citation problems

When d is 0 and the quotation check ran, open with the count line (section 3). Then:
1. Run the six mechanical checks against the style file that `style` in RUBRIC.md selects: edition consistency across notes; chapter and page cross-check against one edition; completeness against the named style manual; original versus published dates; italics versus quotation marks by work type; placeholder scan.
2. One item per pattern: first locator, count of instances, the rule in your own words, its tag, the manual and edition, and the weight. List errors first, then minor items marked minor. A rule tagged `[U]` is never listed as a defect: write "check your style guide" and name the point.
3. Help is the rule of form plus the blank bracketed template from the style file, for example `[Author], [Title], trans. [translator] ([publisher], [year]), [page]`. One filled example on an unrelated invented source may follow; it is the only filled citation in the report. Mark every page "check against your edition". Never fill a template from the author's works.
4. The "check your copy" list: every UNVERIFIED, SECONDARY-ECHO, NOT-FOUND and REF-COPY-OCR row and every recalled claim. Name the item, what to check and where. Never call one an error; unverified means not checked. Add that editions may differ where an opened source was a different edition.
5. Uncredited precedents are not listed here: they are ranked problems that drive Use of sources.

## 6. Proofreading

Group items by mechanics class (M1, M2, M3 of adjudication.md), and within a class by pattern.
- A typo, apostrophe, hyphen, capitalisation or single-token agreement item gets `wrong -> right`, inside the mechanics boundary of rules.md.
- Every larger defect (comma splice, fragment, dangling modifier, tense, run-on, register) gets diagnosis only: type, locator, a few quoted words copied exactly, a plain-language rule, and never a rewritten clause.
- A meaning-check item carries a definition with its source and a question to the author.
- Gloss each grammar label once per report.
- When an error pattern has appeared in three consecutive drafts, open with one sentence: the class persists after instance fixes, so audit the whole text for it.
- List confirmed phrase-level filler here (from filler-phrases.md). Paragraph-level padding belongs to Structure.

## 7. Recurrence tags

The tags are a closed set. Generate them from the stored counters in STATE.md and never write them by hand. A free-hand "again", "still" or "last time" is forbidden without a tag.

| Tag | Goes on | Reads |
|---|---|---|
| `(second round)`, `(third round)` | line items | `rounds_flagged` of 2 or 3 |
| `(round N)` | problem headings (and line items from the fourth round); the body opens "First raised in the draft M review." | `rounds_flagged` = N; M is `first_flagged` |
| `(half fixed)` | a problem or line item | status PARTIAL |
| `(unchanged since draft M)` | an open item | `drafts_present`; M = this draft's number minus `drafts_present` plus 1 |
| `(pattern flagged in N reviews)` | a Proofreading pattern | the PATTERNS table |
| `(not rechecked)` | a carried-forward item (CANNOT-CHECK; every open row in quick mode) | the flag |
| `(reopened)` | a REGRESSED row | the reopened count |

A SUPERSEDED parent prints through its child.

## 8. What it would take

Heading: WHAT IT WOULD TAKE TO REACH <target>, with the distance in steps. The target and distance come from adjudication.md. Under a cap the target is the "alone" grade, the heading reads "what it takes to restore it" and no step count prints. In the top band the section is marked "not in the top band" and lists the remaining defects instead.
1. Write 5 to 8 steps. Each has an imperative verb, one object, an optional exit path ("or cut it") and the issue ID or IDs it closes.
2. Order: the integrity fix first (and name the grade it restores); the choices that govern other steps; the ranked problems in order; the ending; citation mechanics last.
3. Add a mechanics step whenever Mechanics is below the target.
4. Steps say decide, define, argue, supply or gloss, never what to conclude (report-voice.md).
5. End with one sentence naming the open issues that did not make the list, including held-back problems.

## 9. Reading for the revision (draft 1 only, optional)

Pointers from the RECOMMENDED table of SOURCES.md, at most two per problem. Each gives the work, the section, a one-line purpose and the finding ID it serves, with a label taken from its locator confidence: work-level gets `check this against <the work>`; checked with an edition gets `checked against the original (<edition, page>)`; recalled gets `as I recall: check your copy`. A pointer is a direction to read, never a claim that the source supports the author.

## 10. Sources consulted

Generate it from the OPENED rows of SOURCES.md used this round plus earlier sources still relied on, each with a "checked:" note saying what was checked. Recollection is not a source. Say where no copy of the original was available. Add one disclaimer line naming the edition and the style manual used for page and format checks, and any named secondary summary used for an echo check.
