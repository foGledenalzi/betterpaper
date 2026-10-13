# Anchor: draft 23

draft: 23
essay: tessel-glass-short
imported: no
text: text.md
model: unknown
overall_as_submitted: C
overall_alone: C
band: C
confirmed_by: author
human_adjusted: no
note: fictional demo: invented calibration text

## Grades by criterion

| criterion | grade | conditional | tool_grade | status | confirmed_by |
|---|---|---|---|---|---|
| overall_alone | C | | C | confirmed | author |
| primary | C | | C | confirmed | author |
| argument | C+ | | C+ | confirmed | author |
| structure | C | | C | confirmed | author |
| sources | C | | C | confirmed | author |
| originality | C+ | | C+ | confirmed | author |
| mechanics | C | | C | confirmed | author |

## Rationale

- primary: prim-c-2 is the main weakness: the count the glass keeps is used with its contrast term dropped, though the main line still follows the treatise.
- argument: arg-c-1: the thesis is present but the abridged text has no objection and no example, so the reader supplies the steps between paragraphs. A plus because the thesis stays the same claim to the end.
- structure: stru-c-3: proportion is lopsided, with a statement of the thesis, a short account and an ending, and no body to carry the argument.
- sources: src-c-3: the treatise the essay relies on is never named or cited in the text, and no note is given.
- originality: orig-b-2: the false zero is an apt application but is not developed far enough to carry the argument; the rest is standard (orig-c-1).
- mechanics: mech-c-1: long stacked sentences in the second paragraph cloud meaning on a first read; no class recurs often.

## About this file

This file is the record of one graded draft; `text.md` in the same folder holds the draft's text. The `key: value` lines under the title are the header.

| Field | Meaning |
|---|---|
| overall_as_submitted, overall_alone | the two overall series. As submitted is the grade after any cap; alone is the grade on the writing and argument alone. They are equal when no cap fired. |
| band | the letter band (A, B, C, D or F) of overall_alone. The alone series anchors the band: a reviewer comparing a draft with this anchor reads overall_alone, never overall_as_submitted. |
| model | the model ID recorded when the tool produced the paired judgements (both overall series and the criterion grades); none when a person produced them; unknown when it was not recorded |
| imported | yes when the record was brought in from outside this workspace rather than produced by a grade run |
| confirmed_by | author, instructor or unconfirmed. It stays unconfirmed until overall_alone and every graded criterion has status confirmed or adjusted; then it names who confirmed overall_alone. Only an anchor with author or instructor here can anchor a grade. |
| human_adjusted | yes when a person changed any grade the tool had assigned |
| grade | the current grade: a grade from the closed set (A, A-, B+, B, B-, C+, C, C-, D+, D, D-, F) or `not graded` |
| conditional | on the sources row only, and only when a cap fired: the grade once the named quotations are fixed |
| tool_grade | the grade the tool first assigned. It is never overwritten when a person adjusts a grade; it reads `none` where the tool assigned nothing |
| status | unconfirmed, confirmed or adjusted |
| note | optional free text, such as the file name an imported record came from |
