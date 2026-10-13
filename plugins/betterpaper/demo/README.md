# Demo essay: What the Glass Answers (fictional demo)

Fictional demo: this folder is a ready-made test case for betterpaper. Everything in it is invented, including the treatise, its author and translators, the essay, the grades, the anchors and the dates.

## What the demo is

- A fictional essay in three drafts, *What the Glass Answers: Reading and Report in Karvale's Tessel-Glass*. Drafts 1 and 2 are in `drafts/`. Draft 3 is `draft-3-to-grade.md`, kept at the top level so that grading it saves it as draft 3.
- Its invented treatise, *On the Reading of the Tessel-Glass*, in two editions: the complete first edition, and an excerpt of a revised second edition (a different edition, for the edition check). Two invented web pages, a short guide and a catalogue entry, complete the sources.
- A workspace whose stored state stands at draft 2: the settings, the issue tracker, the quotation ledger, the draft 1 review and one reading-group comment.
- Four invented anchors (`anchors/draft-21` to `draft-24`) with their confirmation sheet.
- Test files for the plugin's scripts, a sample report and an answer key.

## Notice

Every grade, anchor, quotation, source and name in this folder is fictional. The demo tests the plugin's format and logic, not grading accuracy. No demo grade is evidence of how the plugin grades a real essay.

## Run it

1. Open a session in a working folder of your own, with the plugin installed. Init refuses your home folder, a drive root and the plugin folder.
2. Run `/betterpaper:init demo-essay`. It copies the files listed in `MANIFEST.md` to `betterpaper/demo-essay/`, adds empty `worksheets/` and `reviewer-notes/` folders, and never overwrites anything. It may offer to add `betterpaper/` to `.gitignore`.
3. Run `/betterpaper:grade demo-essay draft-3-to-grade.md --quick` first. Quick mode is cheap, prints a banner and never applies the integrity cap.
4. Then run the same command without `--quick` for the full report. Optionally add `--markers markers-draft-2.md` to pass the author markers file.
5. `/betterpaper:init demo-essay --confirm` re-applies the anchor sheet. Every row is already applied, so it should report nothing new.

Every graded run is recorded in the workspace, and the next run then starts from changed state. The answer key assumes the stored state at draft 2, so to compare a run with it, start from a fresh copy: a new working folder, or remove `betterpaper/demo-essay/` yourself first.

## Compare with the key

Open `ANSWER-KEY.md` after the run. It gives the expected status of every quotation, the cap decision, the tracker rows with their printed tags, the grades, the header flags, the anchor results and the lint result. Arithmetic is exact; the wording of a report, and a reviewer's grade suggestion, may differ by one step. The key and the sample files are for checking: a grade run does not read them.

## Files

| File | What it is |
|---|---|
| `README.md` | this file |
| `MANIFEST.md` | the list of files that init copies (it does not copy itself) |
| `RUBRIC.md` | settings: harsh, Chicago notes, six equal weights, four anchors |
| `STATE.md` | grade history for drafts 1 and 2, issue tracker, patterns and logs |
| `SOURCES.md` | sources opened, reading list, quotation ledger of 11 rows |
| `drafts/draft-1.md`, `drafts/draft-2.md` | the first two drafts, 7 paragraphs each |
| `draft-3-to-grade.md` | the draft to grade, 7 paragraphs and 12 attributed quotations |
| `reviews/draft-1.md` | an invented review of draft 1 (the draft 2 review is not shipped; STATE.md holds its digest) |
| `feedback/comments-1.md` | one invented reading-group comment |
| `sources/karvale-1934-first-edition.md` | the complete first edition, searchable, with page markers |
| `sources/karvale-1971-second-edition-excerpt.md` | an excerpt of the second edition (three pages only) |
| `sources/linden-short-guide.md` | an invented web summary of the treatise |
| `sources/larkmoor-catalogue-page.md` | an invented catalogue entry |
| `anchors/CONFIRM.md` | the confirmation sheet, 28 rows, all completed |
| `anchors/draft-21` to `draft-24` | four anchors, each with `ANCHOR.md` and `text.md`, graded from A- to D |
| `findings-fabricated.md` | a source-verifier return with one made-up finding, for the cited-span check |
| `sample-report.md` | a short sample report that passes the lint |
| `lint-fail-sample.md` | the same report with one line changed, which fails the lint |
| `grades-cases.json` | twelve cases for the grade arithmetic script |
| `markers-draft-2.md` | an annotated draft 2 report with author markers, for `--markers` |
| `ANSWER-KEY.md` | the expected results |

## Known gaps

The flags REF-COPY-OCR and SWAPPED-WORDS are not exercised by this demo. The sources are invented, so any web check finds nothing; an empty result there is expected and is not a fault.
