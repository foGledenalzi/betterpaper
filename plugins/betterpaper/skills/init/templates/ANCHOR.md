# Anchor: draft <N>

draft: <N>
essay: <essay-slug>
imported: <yes or no>
text: text.md
model: <model ID, none or unknown>
overall_as_submitted: <grade>
overall_alone: <grade>
band: <A, B, C, D or F>
confirmed_by: unconfirmed
human_adjusted: no
note:

## Grades by criterion

| criterion | grade | conditional | tool_grade | status | confirmed_by |
|---|---|---|---|---|---|
| overall_alone | <grade> | | <grade> | unconfirmed | unconfirmed |
| primary | <grade> | | <grade> | unconfirmed | unconfirmed |
| argument | <grade> | | <grade> | unconfirmed | unconfirmed |
| structure | <grade> | | <grade> | unconfirmed | unconfirmed |
| sources | <grade> | | <grade> | unconfirmed | unconfirmed |
| originality | <grade> | | <grade> | unconfirmed | unconfirmed |
| mechanics | <grade> | | <grade> | unconfirmed | unconfirmed |

## Rationale

<finding IDs behind each criterion grade, one line per criterion, or the source of an imported grade>

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
