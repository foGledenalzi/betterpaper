# Report template: section order, header block, grade lines, verdict, rubric table, footer

You are the **orchestrator**, the main agent that runs the grade skill. Write `reviews/draft-N.md` from this template once the steps in adjudication.md are done. The fields of each numbered or listed section are in report-sections.md, wording rules are in report-voice.md, and labels and the author's-words rules are in rules.md. Grades, flags, confidence and the target come from adjudication.md and `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/compute_grade.py`: print each grade, count and tag from stored values, never from memory. Render in Markdown. The heading texts below are fixed: do not reword them.

## 1. Sections, order and conditions

Print the sections in this order, each only when its condition holds.

| # | Heading (fixed text) | Prints |
|---|---|---|
| 1 | Header block (the first lines, no heading) | always |
| 2 | Grade lines, then the verdict | always |
| 3 | Rubric table, then one sentence on Originality | always |
| 4 | What's worth keeping | draft 1 only |
| 4 | What improved | draft 2 or later |
| 5 | Correction to the draft N review | correction-triggered: a trigger in rules.md holds |
| 6 | Quotation problems | integrity-triggered: the count line's d is 1 or more; position below |
| 7 | MAJOR PROBLEMS, IN ORDER OF SEVERITY | always |
| 8 | Citation problems | always |
| 9 | PROOFREADING | always |
| 10 | WHAT IT WOULD TAKE TO REACH <grade> | always; in the top band it lists the remaining defects instead |
| 11 | Reading for the revision | draft 1 only, optional |
| 12 | Sources consulted | always |
| 13 | Footer | draft 2 or later |

- Quotation problems sits above Major problems, outside the ranking, only when the split fires; otherwise it follows Major problems. When d is 0 it does not print and the count line opens Citation problems. Quick mode has no count line and no quotation entries.
- With no ranked problem, Major problems prints its heading and one line saying so.

## 2. Header block

Print these lines in order. Omit a field with no value (the review date may be null).

1. `# Draft N review: <essay title>`.
2. Label legend: the eight labels of rules.md as one block, each with a clause saying what it asserts. Terms of art are glossed in the text at first use.
3. Fields: draft number; review date; model (the model ID recorded for this run); mode (full or quick); harshness (harsh or neutral); citation style (the `style` line of RUBRIC.md); `anchors: N (M near the top band)` as `select_anchors.py` prints it, with M counting anchors whose "alone" grade is A- or higher. With no confirmed anchor print the banner "unanchored: graded from the rubric alone" instead.
4. Confidence line: `Confidence: <high, medium or low> (uncalibrated): <named reasons>` (adjudication.md).
5. Human-check flag: `Human check: yes (<trigger>)`, naming the trigger that set it, or `Human check: no`.
6. Notices, each once and only when it applies:
   - `injection-like text found: <locator>, <what it asks for>` (rules.md);
   - `Outside the tool's design: <genre>` for `genre: other` or a plainly different kind of text (rules.md);
   - quick mode: `Quick mode: no specialist cross-check ran` and `Integrity test not run: Use of sources unverified`;
   - model change: one line recommending a blind re-grade of one earlier draft when the run's model differs from the one recorded on a selected anchor (advisory, never blocking).

## 3. Grade lines

Print the overall with its previous value in a bracket. adjudication.md sets the bracket forms: `(was B-)`, `(was B-; no reliable change)`, `(was C; cue: <finding IDs>)`, `(was B-; cue: integrity cap)`.

```
As submitted: F (was B-; cue: integrity cap)
On the writing and argument alone: B- (was B-; no reliable change)
```

- With no cap, "alone" equals "as submitted": print only the "as submitted" line. With a cap, print both lines; the word "alone" stays.
- Draft 1 has no previous value and no bracket. A partial overall carries "(partial: <criterion> not graded)".
- A result of A, A- or B+ also prints its band in brackets ("top band" for A and A-, "near the top band" for B+) and the sentence "this grade may be too high or too low".

## 4. Verdict

Three or four sentences, 35 to 60 words, in this order: a strength or the direction of the draft; a pivot that names the one or two top faults in the wording of their ranked headings; optionally the consequence for a reader under the declared genre standard. No advice, no line references, no criterion-by-criterion list. Check that every fault named maps to ranked problem 1 or 2, or to Quotation problems.

When the split fired, the first sentence gives the reason for it and the standard that justifies it (a reader can check a quotation against the work; common course practice treats a misquotation as serious; the venue's own policy should be checked) and says that everything else improved only if the tracker shows it.

## 5. Rubric table

1. One row per criterion in this order: Command of <named primary text(s)> (built from the `primary_text` lines of RUBRIC.md; name every work listed), Argument, Structure and organisation, Use of sources, Originality, Mechanics. One column per draft, every draft kept, oldest first. Earlier columns show the stored grade only (and a stored conditional cell).
2. Each cell of this draft's column holds the grade (or n/a), a one-line reason that cites finding IDs, and a confidence tag (high, medium or low, from the owner's Confidence line; Structure is always low). Name the limiting defect, by defect code or descriptor ID, on the lowest-graded row, on every row at C or below and on Argument. A cell without a reason is refused: do not save the report.
3. Conditional cell, on Use of sources only and only when the split fired: `X (Y once <named fix> is done)`. Y counts the remaining citation problems (adjudication.md).
4. A criterion with no grade prints n/a, and the overall carries the partial mark (section 3).
5. A "Why it moved" line below the table explains any row that moved against the overall's direction, citing the cue (finding IDs). The "no reliable change" rule of adjudication.md applies to every cell.
6. When a correction changes an earlier grade, keep the original in its cell, add a footnote marker, and write below the table "would have been X" with the reason.
7. Calibration note: print `Calibration: no confirmed anchor covers <criterion> at <grade>` where a cell lies outside the grade range spanned by the confirmed anchors, and always beside Structure `Structure is uncalibrated: no confirmed anchor covers it`.
8. One sentence after the table names the Originality contribution: what the essay adds beyond its credited precedents (the residual contribution). Ideas that came from a report earn no credit.

## 6. What's worth keeping, what improved

- **What's worth keeping (draft 1).** Two to four items. Each says where it sits, why it works and what it lacks, and agrees with the Originality credit given.
- **What improved (draft 2 or later).** Build it only from tracker rows verified RESOLVED or REMOVED-VERIFIED this round, in the issue order of the previous review, with unprompted gains interleaved; one or two lines each. A PARTIAL row prints under Major problems as "(half fixed)" and may also be credited here. An author's marker never closes a row.

## 7. Footer

From draft 2, end the report with two fixed sentences:
1. "Page references are to the editions named under Sources consulted and must be checked against your own copy."
2. "The grade is not a target to optimise: rewriting a draft with a model that has seen this report can raise the grade without improving the writing."

## 8. Rendering and length

- Markdown. Headings use the fixed texts of section 1 and neutral descriptive wording (report-voice.md) for problem headings.
- Budget: about 250 to 270 lines in all, with the ranked problems about half of them (about a third when Quotation problems sits above them). Over budget, compress Proofreading and Citation problems first. Never drop a ranked problem to save lines.
- Optional: end each item with its issue ID in brackets, printed exactly as STATE.md stores it, so that author markers bind unambiguously.
