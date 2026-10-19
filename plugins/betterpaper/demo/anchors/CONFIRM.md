# Anchor confirmation sheet

Fictional demo: every row is invented.

A graded draft can serve as a scale reference for later reviews (an anchor) only after the author or an instructor has confirmed its grades. Grades the tool assigned start unconfirmed. This sheet lists them, one row per anchor and criterion.

## How to fill it in

- Read the tool grade in each row against the draft in `anchors/<anchor>/text.md`.
- If the grade is right, write `confirm` in the action cell. If it is not, write `adjust` and put your grade in the adjusted_grade cell.
- Then write who you are in the confirmer cell (`author` or `instructor`) and today's date as YYYY-MM-DD in the date cell.
- Leave the action, adjusted_grade, confirmer and date cells of a row empty to skip it. Skipped rows stay unconfirmed.
- Allowed grades: A, A-, B+, B, B-, C+, C, C-, D+, D, D-, F. Anything else is rejected.
- Do not edit the anchor, criterion or tool_grade cells.
- The row `overall_alone` is the overall grade on the writing and argument alone. An anchor is usable only when its `overall_alone` row and every other row for that anchor are completed; otherwise it stays unconfirmed.
- Save the file, then run `/betterpaper:init <essay-slug> --confirm`. It applies every completed row, lists the skipped and rejected rows, and is safe to run twice. The tool's own grade stays in the tool_grade column of the anchor's `ANCHOR.md`, and a changed grade marks the draft's history row human-adjusted.

## Rows

| anchor | criterion | tool_grade | action | adjusted_grade | confirmer | date |
|---|---|---|---|---|---|---|
| draft-21 | overall_alone | A- | confirm | | instructor | 2030-11-04 |
| draft-21 | primary | A- | confirm | | instructor | 2030-11-04 |
| draft-21 | argument | A- | confirm | | instructor | 2030-11-04 |
| draft-21 | structure | B+ | confirm | | instructor | 2030-11-04 |
| draft-21 | sources | A- | confirm | | instructor | 2030-11-04 |
| draft-21 | originality | B+ | confirm | | instructor | 2030-11-04 |
| draft-21 | mechanics | A | confirm | | instructor | 2030-11-04 |
| draft-22 | overall_alone | B | confirm | | author | 2030-11-04 |
| draft-22 | primary | B | confirm | | author | 2030-11-04 |
| draft-22 | argument | B | confirm | | author | 2030-11-04 |
| draft-22 | structure | B | confirm | | author | 2030-11-04 |
| draft-22 | sources | B- | confirm | | author | 2030-11-04 |
| draft-22 | originality | B- | confirm | | author | 2030-11-04 |
| draft-22 | mechanics | B | confirm | | author | 2030-11-04 |
| draft-23 | overall_alone | C | confirm | | author | 2030-11-05 |
| draft-23 | primary | C | confirm | | author | 2030-11-05 |
| draft-23 | argument | C | confirm | | author | 2030-11-05 |
| draft-23 | structure | C | confirm | | author | 2030-11-05 |
| draft-23 | sources | C- | confirm | | author | 2030-11-05 |
| draft-23 | originality | C | confirm | | author | 2030-11-05 |
| draft-23 | mechanics | C- | confirm | | author | 2030-11-05 |
| draft-24 | overall_alone | D | confirm | | instructor | 2030-11-06 |
| draft-24 | primary | D | confirm | | instructor | 2030-11-06 |
| draft-24 | argument | D+ | confirm | | instructor | 2030-11-06 |
| draft-24 | structure | D | confirm | | instructor | 2030-11-06 |
| draft-24 | sources | D | adjust | D- | instructor | 2030-11-06 |
| draft-24 | originality | D+ | confirm | | instructor | 2030-11-06 |
| draft-24 | mechanics | D | confirm | | instructor | 2030-11-06 |
