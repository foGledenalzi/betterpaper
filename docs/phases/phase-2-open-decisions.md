# Phase 2: grey-area questionnaire with recommended defaults

Date: 2026-10-06. **STATUS: ACCEPTED by the user on 2026-10-06 ("Defaults fine for now").** Every row below is adopted as written and referred to as G1-G26; rows can be revisited after first real use. Phase 2 builds the `init` skill, the five workspace templates, `references/tracker-rules.md` and the minimal demo. The four headline questions (demo sources, ledger storage, platform, draft format) are asked interactively and recorded in `docs/phases/phase-2-discussion.md`. This sheet holds the grey areas: points the plan leaves open, where reasonable people differ, or where a wrong guess would be costly to undo. Every row has a recommended default. Rows can be revisited after first real use.

Evidence base for the defaults: `docs/design/method-digest.md` (sections 4 and 5), `docs/design/file-contracts.md` (sections 1, 7 and 10) and the Phase 1 build notes. Accepted rows are recorded as G1-G26 in `DECISIONS.md`.

## A. Workspace and init

| # | Question | Recommended default | Why |
|---|---|---|---|
| 1 | How does `init` collect settings? | A short interview in batches of at most four questions, every question with its default pre-selected; a `--defaults` flag skips the interview and writes the default `RUBRIC.md` for you to edit | Typing a long argument line is error-prone; a skip flag helps repeat users and tests. This adds one flag to the plan's argument hint |
| 2 | Where may a workspace be created? | `betterpaper/<slug>/` under the folder Claude Code runs in; refuse when that folder is your home directory, a drive root or the plugin's own folder, and say why | A workspace holds drafts; creating one in a wide folder would scatter private files |
| 3 | What may `init` change? | Only `betterpaper/<slug>/` and, with your consent, one line in `.gitignore`. It never deletes, moves or overwrites a file, and copies (never moves) any draft or review you point it at | Originals must stay untouched; a destructive init is the worst failure mode |
| 4 | Starting point for an essay already in progress | `init` asks which draft number comes next and whether earlier drafts and graded reviews exist; each earlier graded draft becomes an `imported` history row with Structure stored as "not graded"; imported drafts never become anchors until confirmed | You may be at draft 4 on day one; numbering must not restart at 1 |
| 5 | How earlier drafts and reviews are supplied | You give paths during the interview (or paste text); `init` copies them into `anchors/draft-N/`, `feedback/` or `drafts/` as you say. A file it cannot read is listed, never guessed | Keeps the user in control of what enters the workspace |
| 6 | One-time privacy notice | `init` prints once: draft text is processed by the model you run; web searches carry only attributed quotations and public work details (author, work, at most 8 distinctive words), never your own sentences; the workspace stays in your folder and should be git-ignored. No acknowledgement needed | The user should know what leaves the machine before pasting private writing |

## B. Drafts and locators

| # | Question | Recommended default | Why |
|---|---|---|---|
| 7 | Paragraph and note numbering for locators | Paragraphs count from 1 over the text blocks of the saved file, headings skipped; a block quotation belongs to its paragraph; footnotes and endnotes are `[^n]` markers with definitions at the end of the file, cited as "note n"; a locator prints as "para N, first words" or "note N" | Every finding, ledger row and tracker anchor depends on one numbering rule that survives re-saves |
| 8 | Declared thesis | Optional `declared_thesis` in `RUBRIC.md`, in your own words and possibly empty. The argument-reviewer treats it as declared intent: a mismatch between it and the draft is a finding about the text; it is never graded and the tool never writes it for you | The argument-reviewer's brief expects a declared thesis, and the tool must not write one for you |
| 9 | Assignment brief | Optional `brief.md` in the workspace (prompt, word limit, course rubric). The orchestrator and argument-reviewer read it as declared context for genre, audience and length only; it never changes the six criteria or the bands. No length is enforced | Graduate essays often answer a brief; letting it rewrite the rubric would break comparability across drafts |
| 10 | Spelling variety | `RUBRIC.md` key `spelling: uk, us or either`, default `either`: flag only inconsistency inside the essay. Essays not written in English are out of scope | Otherwise one variety would be flagged as an error in the other |
| 11 | Quotation marks and dashes in saved drafts | Drafts are UTF-8 with LF line endings; curly and straight quotes and the usual dash forms are normalised before any comparison; CRLF files are accepted on read | Platform differences must not cause false mismatches |

## C. Workspace state

| # | Question | Recommended default | Why |
|---|---|---|---|
| 12 | Tracker row size | One row per atomic defect at an anchor. Mechanics items are one row per pattern per paragraph, with an instance count and the first quoted trigger; one-off typos in a paragraph share one "misc" row | Per-typo rows would make `STATE.md` hundreds of rows long |
| 13 | `STATE.md` growth | One file in version 0.1, no archive. The grade skill prints a notice above 800 lines suggesting you trim your notes; RESOLVED rows are never purged | An archive adds a second place for the same facts; a notice is enough until real use shows the size |
| 14 | When is an anchor usable? | Only when the overall "alone" grade and every graded criterion are confirmed or adjusted; a half-confirmed anchor stays unconfirmed | Mixed grades would give a reviewer a scale reference nobody vouched for |
| 15 | What `init <slug> --confirm` does | Applies every completed row of `anchors/CONFIRM.md`, skips blank rows and lists them, rejects unknown grade strings, is safe to run twice, and keeps the tool's original grade in a `tool_grade` column beside the confirmed one. An adjusted grade marks the history row `human-adjusted` | Keeps an audit trail so self-consistency checks stay possible. This refines the plan's "replace": the tool's value is kept, not lost |
| 16 | Anchors from other essays | An optional `extra_anchor_dirs` line in `RUBRIC.md` lists folders of confirmed anchors from other workspaces; the plugin reads them and never writes there; near-duplicates are still excluded | The calibration evidence favours a spanning set; one essay's drafts may not span the scale |
| 17 | Resubmitting a draft edited after grading | Always saved as the next draft number; the previous file is never overwritten | History and rubric columns assume one file per grading |
| 18 | A rewrite that matches no earlier anchor text | Open rows carry forward as "not rechecked" at the same severity. After two consecutive "not rechecked" rounds the report lists them under one line asking you to confirm whether they still apply; statuses never change without a reviewer's re-reading | Never drop a row silently after a wholesale rewrite |

## D. Demo

| # | Question | Recommended default | Why |
|---|---|---|---|
| 19 | Demo size | Three drafts of 600 to 900 words (6 to 8 paragraphs, 8 to 12 quotations), 3 to 4 invented anchors of 300 to 450 words, and an invented primary text with excerpt files | Small enough to run in minutes, large enough to hold every planted defect |
| 20 | How the demo labels its grades | Every demo grade and anchor is marked `fictional demo`; the README and `ANSWER-KEY.md` say the demo tests the plugin's logic and format, not grading accuracy | Prevents a reader mistaking the demo's grades for a validation |
| 21 | First-run advice | The README suggests `--quick` on the demo first (cheap), then a full run | A full run uses five reviewers plus checks; a newcomer should see the cost first |
| 22 | Demo authorship check | The demo is written by the assistant, then a second independent agent checks that every planted defect and every answer-key line matches the files | The answer key is only useful if it is right |

## E. Platform and safety

| # | Question | Recommended default | Why |
|---|---|---|---|
| 23 | Calling Python | The skills probe once for `python3`, then `python`, then `py -3` on every run (amended after research: the command is not stored in `RUBRIC.md`, see A62); the `allowed-tools` list covers all three forms. The README lists Python 3.9 or later as a prerequisite | A Windows machine often has no `python3`; a failing script call would stop a run at step one |
| 24 | Version floor | Python 3.9 or later, standard library only | Wide availability; no dependency to install |
| 25 | Guard against prompt text in templates | Template and demo files carry no instructions addressed to an assistant other than the skill's own text | A planted instruction in a template would be copied into every workspace |
| 26 | Extra checks before each push | Phase 2's Verify adds: the privacy scan, the "no decision codes in shipped files" grep, `claude plugin validate`, and a dry run of `init demo-essay` in a throwaway folder | Same discipline as Phase 1 |

## Notes
- If a default conflicts with an interactive answer, the interactive answer wins and the row is updated here.
- Nothing in this sheet changes a grading rule; those are fixed in the Phase 1 references.
