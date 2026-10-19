# Source-verifier return, fabricated (fictional demo)

Fictional demo: this return is invented, to test the cited-span check. Finding f-2 and the second ledger line are made up on purpose: the sentence they quote is not in the draft. The Locator column is navigation only and is never checked.

## Findings: source-verifier

| ID | Tier | Criterion | Locator | Draft quote (15 words or fewer) | Problem | Impact on thesis | Evidence / how checked | Label | Fix direction |
|---|---|---|---|---|---|---|---|---|---|
| f-1 | 0 | Use of sources | para 5, Agreement between glasses | a reading at the foot of the glass cannot be mistaken | MISMATCH: the marked sentence says the opposite of the first-edition sentence it cites | the next sentence of the paragraph rests on it | first edition, sec. 5, p. 23: a reading at the foot of the glass may still be mistaken, because the thick grit hides the lowest mark | checked against the original (first edition, 23) | replace term |
| f-2 | 0 | Use of sources | para 5, Agreement between glasses | the glass cannot be trusted at any scale | MISMATCH: the marked sentence overstates the first-edition sentence it cites | the conclusion of the paragraph rests on it | first edition, sec. 5, p. 23 | checked against the original (first edition, 23) | replace term |

## Quotation ledger

```jsonl ledger
{"qid": "q-7bccd2", "draft": 3, "locator": "para 5, Agreement between glasses", "string": "once the grit has settled twice, a reading at the foot of the glass cannot be mistaken", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "MISMATCH", "flags": [], "label": "checked against the original (first edition, 23)", "checked_against": "first edition, sec. 5, p. 23", "counter_passage": "Even when the grit has settled twice, a reading taken at the foot of the glass may still be mistaken, because the thick grit hides the lowest mark.", "diff_type": "sense-bearing difference", "provenance_tests": "route (a): counter-passage in the edition the author cites", "trigger": "yes", "reason": "conditions 1 to 4 yes"}
{"qid": "q-0f0f0f", "draft": 3, "locator": "para 5, Agreement between glasses", "string": "the glass cannot be trusted at any scale", "attributed_to": "Karvale, Tessel-Glass", "work_edition": "On the Reading of the Tessel-Glass, trans. Dorothea Pelling, first edition (Brennock & Vale, 1934)", "source_id": "s-1", "status": "MISMATCH", "flags": [], "label": "checked against the original (first edition, 23)", "checked_against": "first edition, sec. 5, p. 23", "counter_passage": null, "diff_type": "sense-bearing difference", "provenance_tests": "route (a): counter-passage in the edition the author cites", "trigger": "yes", "reason": "conditions 1 to 4 yes"}
```

Coverage: 2 checked, 2 verified original, 0 verified secondary, 0 unverified, 2 defects, 0 not examined.

## Grade suggestion for sources: D: both marked sentences differ in sense from the first edition; conditional C+ if both are replaced with the exact source sentences

## Confidence: high: the first edition is complete and searchable
