title: <essay title>
genre: argumentative
venue:
harshness: harsh
style: chicago-notes
weight_primary: 1
weight_argument: 1
weight_structure: 1
weight_sources: 1
weight_originality: 1
weight_mechanics: 1
anchor_count: 4
anchor_seed: 1
near_duplicate_pct: 85
declared_audience:
declared_promises:
declared_thesis:
spelling: either
extra_anchor_dirs:
primary_text: <work> | <translator or edition> | <locator system>
model_note:

## About this file

The lines above are the essay's settings. Each line is `key: value` with nothing after the value, and a value may be empty. The tools read only these lines; the text below is for people.

| Key | Allowed values | Notes |
|---|---|---|
| genre | argumentative, theoretical, other | other means the essay is outside the tool's design: it is graded as an argument and flagged once |
| harshness | harsh, neutral | the two settings differ in two rules only: the direction of an exact tie, and the verified strengths needed for B+ or above (two under harsh, one under neutral) |
| style | chicago-notes, chicago-author-date, mla, links | selects the citation style file of the same name (links covers essays that cite by hyperlink) |
| weight_primary, weight_argument, weight_structure, weight_sources, weight_originality, weight_mechanics | whole numbers of 1 or more | relative weights; equal by default |
| anchor_count | whole number, 0 to 10 | the most confirmed anchors shown to each reviewer |
| anchor_seed | whole number | fixes the order in which anchors are shown; set once |
| near_duplicate_pct | whole number | an anchor is skipped when six-word runs shared with the draft under review cover at least this percentage of the anchor's text |
| declared_audience, declared_promises | free text on one line | context the author declares; it never changes a grade |
| declared_thesis | free text on one line | the author's own words, possibly empty; the tools never write, change or grade it |
| spelling | uk, us, either | either flags only inconsistency inside the essay; essays not written in English are out of scope |
| extra_anchor_dirs | folders separated by semicolons | folders of confirmed anchors from other essays, such as `betterpaper/other-essay/anchors`; read only |
| primary_text | `<work> \| <translator or edition> \| <locator system>` | one line per work, repeating the key; the edition and the locator system seed the sources register |
| model_note | free text | optional; each grade run records the model it used |

The first row of the rubric table in a review is named from the primary_text lines.

## Notes

(Add notes for yourself here.)
