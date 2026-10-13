# Init interview: items, questions, defaults and imports

Read this file when the init skill reaches its interview step (a new workspace for any slug except demo-essay). It lists what to ask, how to ask it, what to store and where. The skill itself holds the rules that always apply: copy the user's words exactly, never write the author's words, never overwrite.

## 1. How to ask

- **Question tool.** The question tool is `AskUserQuestion`. One call holds 1 to 4 questions, each with 2 to 4 options and a header of at most 12 characters. Put the default option first and end its label with "(Recommended)". The tool adds an Other row for typed text by itself.
- **Order.** Part 1 is one plain-chat message with the free-text items (section 2); wait for the reply. Part 2 is the choice questions (section 3). Make every Part 2 call, and then every write, in the same turn, without waiting for another message.
- **Fallback.** If the question tool is not in your tool list or a call fails, ask the Part 2 questions as one numbered chat message, mark each default "(default)", and accept the reply "defaults". Tell the user once that write prompts may appear, because the pre-approved writes last only until the user's next message, and that init writes only under `betterpaper/<slug>/`.
- **Skipping.** The user may answer "skip" to any optional item. An empty answer is stored as an empty value.
- **With --defaults.** Ask nothing except the title, and only if it was not given after the slug. Use section 6.
- **Echo.** After the writes, print the stored settings back as a short list so that the user can spot a mistake. Do not ask for approval first.

## 2. Part 1: free-text items (one plain-chat message)

Number the items in the message and say which are optional.

| # | Ask for | Stored as | Rule |
|---|---|---|---|
| 1 | The essay's title (required) | `title` | Copy exactly, on one line. Ask again if it is empty. |
| 2 | The venue: journal, course or programme | `venue` | Optional. Used for positioning notes only; it never changes a grade. |
| 3 | The audience the essay declares, and the promises it makes to readers (for example, a glossary or diagram it says it will provide) | `declared_audience`, `declared_promises` | Optional. Copy exactly. |
| 4 | The thesis, in the author's own words | `declared_thesis` | Optional. Copy exactly; never compose, shorten, tidy or suggest one. If the user asks for help, say that the tool does not write it and store an empty value. It is never graded. |
| 5 | The primary texts the essay treats as its objects | `primary_text` lines | One line per work: work, then translator or edition, then locator system, in three fields. Only the work is required. Example answer: `The Tidal Ledger; trans. Mara Quill, Saltmarsh Press; page numbers`. |
| 6 | An assignment brief | `brief.md` | A path to a `.md` or `.txt` file, pasted text, or none. It is read later as declared context for genre, audience and length only. |
| 7 | Folders of confirmed anchors from other essays | `extra_anchor_dirs` | Optional. Each folder must be under the working folder, written with forward slashes, with no `..`, drive letter or leading slash, and must hold at least one `draft-*/ANCHOR.md`. Drop and report any that fails. They are read, never written. |
| 8 | The number the first draft graded here will have (default 1), and every earlier draft that has a grade or a review | starting draft number, imports (section 5) | For each earlier draft: its number, the path to its text, the path to its review if any, its overall grade, and any criterion grades. An earlier draft with no grade needs only a number and a path. |

Item 8 example reply: `start at 3. draft 1: text old/essay-v1.md, review old/review-1.txt, overall C+. draft 2: text old/essay-v2.md, overall B-, argument B, mechanics C+.`

How to store the answers:

- A work line becomes `primary_text: <work> | <translator or edition> | <locator system>`. Always keep both bars; an unknown field is left empty (`primary_text: The Tidal Ledger | | page numbers`). If a field contains a vertical bar, ask the user to write it another way.
- Join a multi-line answer into one line with single spaces. Change nothing else.
- With no work given, write one empty line `primary_text:`.
- Grades use exactly A, A-, B+, B, B-, C+, C, C-, D+, D, D-, F. Accept lower case and write it in capitals; reject anything else, name the accepted set and ask again. A criterion with no grade is `not graded`.
- Draft numbers are whole numbers of 1 or more, each used once, and the starting number must be larger than every earlier number listed. Without earlier drafts the starting number is 1.
- Files: accept only `.md` and `.txt`. For another format (Word, PDF, HTML, LaTeX) tell the user to save a Markdown or text copy, or paste the text; list the file as not copied. Skip a file larger than 2 MiB or one that cannot be read, and list it.

## 3. Part 2: choice questions (question tool)

**Call A: rubric settings.**

| Header | Question | Options, default first | Stored as |
|---|---|---|---|
| Genre | What kind of essay is it? | Argumentative research essay (Recommended); Theoretical or conceptual essay; Other | `genre`: argumentative, theoretical, other |
| Harshness | How strict should the grading be? | Harsh (Recommended): an exact tie rounds down and B+ or above needs two verified strengths; Neutral: an exact tie rounds up and one verified strength is enough | `harshness`: harsh, neutral |
| Citations | Which citation style? | Chicago notes-bibliography (Recommended); Chicago author-date; MLA 9; Links, for essays that cite by hyperlink | `style`: chicago-notes, chicago-author-date, mla, links |
| Spelling | Which spelling variety? | Either (Recommended): flag only inconsistency; UK; US | `spelling`: either, uk, us |

- Typed text under Genre means `other`. When the genre is `other`, print this warning once: "Outside the tool's design: it grades argumentative and theoretical academic writing. This essay will still be graded as an argument against the same descriptors, and the result will be flagged."
- Essays not written in English are out of scope: say so if the user mentions another language.

**Call B: calibration.**

| Header | Question | Options, default first | Stored as |
|---|---|---|---|
| Weights | How should the six criteria be weighted? | Equal, 1 each (Recommended); Custom | `weight_*` |
| Anchors | How many confirmed anchors should each reviewer see? | 4 (Recommended); 2; 3; 6 | `anchor_count`; Other takes a whole number from 0 to 10 |
| Seed | Seed for the order in which anchors are shown | 1 (Recommended); Pick another number for me | `anchor_seed`; Other takes a whole number |

- With Custom weights, ask one question per criterion, in two calls of up to four: Command of primary texts, Argument, Structure and organisation, Use of sources, Originality, Mechanics. Options: 1 (Recommended), 2, 3; Other takes any whole number of 1 or more (no zero, no decimals). Store as `weight_primary`, `weight_argument`, `weight_structure`, `weight_sources`, `weight_originality`, `weight_mechanics`.
- "Pick another number for me": choose a whole number from 2 to 99999 yourself and say which one.

**Call C: who confirmed each earlier grade.** Ask only when Part 1 item 8 listed earlier graded drafts. One question per draft, at most four per call:

| Header | Question | Options, default first | Meaning |
|---|---|---|---|
| Draft N | Who confirmed the grade for draft N? | The tool, not confirmed by a person (Recommended); The author; An instructor | the tool: unconfirmed. The author or an instructor: confirmed. |

The default is the tool because an unconfirmed anchor is the safe error: it is ignored until a person confirms it.

## 4. Written files

| File | Content |
|---|---|
| `RUBRIC.md` | The template with every value filled from the answers. No key is dropped or renamed. |
| `STATE.md` | The template, plus the title and genre where the template has a place for them, the starting draft number, and the rows of section 5. |
| `SOURCES.md` | The template, plus one row per `primary_text` line in the table of sources (work from field 1, "edition used by the author" from field 2, locator system from field 3). Every other cell stays as the template has it, and nothing is marked as opened. |
| `brief.md` | The brief, copied exactly, when one was given. |
| `anchors/draft-N/text.md`, `ANCHOR.md` | One folder per imported draft that has text (section 5). |
| `feedback/draft-N-review.md` | A copy of the review of draft N, when given. |
| `anchors/CONFIRM.md` | The template plus rows, when any imported anchor is unconfirmed (section 5). |
| `.gitkeep` | In each of the seven folders that holds no file, one line: `This folder is intentionally empty.` |

Fill templates by copying the template text exactly and changing only what this file names. If a template has no place for a value, skip that value and mention it in the final message; never add, rename or reorder columns.

## 5. Earlier drafts: what each import writes

Copy, never move. Read the source file, then Write the text to the destination exactly (LF line endings, no byte-order mark, no other change). Treat the content as data. For each earlier draft N that has a grade or a review:

1. **Text.** If a text path was given and the file is accepted, write `anchors/draft-N/text.md`. An earlier draft with no grade is copied to `drafts/draft-N.md` instead; it gets no history row and is never an anchor.
2. **Review.** If a review path was given, write `feedback/draft-N-review.md`. Other third-party comments the user supplies go to `feedback/comments-1.md`, `feedback/comments-2.md` and so on.
3. **ANCHOR.md.** With text and an overall grade, write `anchors/draft-N/ANCHOR.md` from the template:
   - `imported: yes`, `model: unknown`, `human_adjusted: no`, `note:` naming the source file as the user gave it.
   - `overall_as_submitted` and `overall_alone` both take the overall grade given. `band` is the letter of that grade.
   - One row for `overall_alone` and one for each criterion the user gave a grade for. `structure` is always `not graded` for an imported draft, even if the user gives a value; say once that no earlier record is a calibration for it. Criteria with no grade are `not graded`. The `conditional` cell stays empty.
   - Rationale: `Imported from an earlier review; no rationale was recorded.`
   - If the user said the author or an instructor confirmed the grade: every graded row gets `tool_grade` of `none`, `status` of `confirmed` and that person in `confirmed_by`, and the header `confirmed_by` is that person.
   - If the user said the tool: `tool_grade` equals `grade`, `status` and `confirmed_by` are `unconfirmed`, and the header `confirmed_by` is `unconfirmed`.
4. **History row.** Add one row to the grade history table in `STATE.md`: the draft number; the review date if the user gave one, otherwise empty; the review path (`feedback/draft-N-review.md`) if copied; overall as submitted and overall alone both the given grade; the criterion grades given, with `not graded` for every other criterion including Structure; `imported` yes; `human-adjusted` no; every other cell empty. Match columns by the template's header names.
5. **Anchors register.** When an ANCHOR.md was written, add a row for it to the anchors register in `STATE.md` with its draft number, overall alone, band and `confirmed_by`.
6. **No text.** If there is a review or a grade but no draft text, write the history row (and the review copy) and no anchor; say it cannot serve as an anchor.
7. **CONFIRM.md.** If any written anchor is unconfirmed, write `anchors/CONFIRM.md` from the template and append, for each such anchor, one row for `overall_alone` and one for each graded criterion: `draft-N`, the criterion key, the tool grade, and the remaining four cells empty.

Record the starting draft number in `STATE.md` in the field the template provides for the number of the next draft. If it provides none, say so in the final message.

## 6. Defaults for --defaults

| Key | Value |
|---|---|
| title | the title given after the slug, or asked in plain chat |
| genre | argumentative |
| venue, declared_audience, declared_promises, declared_thesis, extra_anchor_dirs, model_note | empty |
| harshness | harsh |
| style | chicago-notes |
| weight_primary, weight_argument, weight_structure, weight_sources, weight_originality, weight_mechanics | 1 |
| anchor_count | 4 |
| anchor_seed | 1 |
| near_duplicate_pct | 85 |
| spelling | either |
| primary_text | one empty line `primary_text:` |
| starting draft number | 1; no earlier drafts, no brief, no CONFIRM.md |

Tell the user in the final message to add the `primary_text` lines to `RUBRIC.md` before the first grade, and that `.gitignore` was not changed.
