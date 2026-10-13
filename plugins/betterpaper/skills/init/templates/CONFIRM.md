# Anchor confirmation sheet

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
