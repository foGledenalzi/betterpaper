# Grade bands: the rubric the graders apply

Use this file to grade six criteria on a 12-step scale. Reviewers suggest a grade per criterion and cite descriptor IDs from the tables below; the orchestrator (the main agent that merges the reviews) sets the grades of record using adjudication.md and `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/compute_grade.py`. adjudication.md holds the weights, rounding, harshness rules and the integrity cap (the only cap on the overall grade: an unresolved, demonstrated sense-bearing quotation mismatch sets the "as submitted" grade to F).

Weights and harshness sit in RUBRIC.md, grade history and open issues in STATE.md, source and quotation records in SOURCES.md.

## 1. Scale, bands and partial grading

| Step | A | A- | B+ | B | B- | C+ | C | C- | D+ | D | D- | F |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Points | 4.0 | 3.7 | 3.3 | 3.0 | 2.7 | 2.3 | 2.0 | 1.7 | 1.3 | 1.0 | 0.7 | 0 |

- A **step** is one rung of this scale (B to B- is one step). A **band** is a letter grade spanning its plus and minus steps: A band = A, A-; B band = B+, B, B-; C band = C+, C, C-; D band = D+, D, D-; F band = F. There is no A+.
- The **top band** is the A range (A and A-). Print results in or near it as a band with the sentence "this grade may be too high or too low", and set the human-check flag (a report line asking a person to review the grade; rules in adjudication.md).
- **Partial grading.** Weights are relative integers set in RUBRIC.md. When a criterion has no grade (its owner returned no usable evidence, or an imported earlier record never graded it), weights renormalise over the graded criteria only: overall = sum of (weight x points) over graded criteria, divided by the sum of those weights. Print n/a in that criterion's cell, mark the overall partial and leave it out of top-band counts. Never fill the gap with another criterion's grade.

## 2. Placing a grade, then plus or minus

Place each criterion in the highest band whose descriptors the text meets (the A band needs every descriptor), then refine inside the band:

| Mark | When it applies |
|---|---|
| plain | all band descriptors are met |
| plus | plain, and the criterion also shows a verified strength described in the band above (cite its descriptor ID) |
| minus | one descriptor is only barely met, or one named weakness of the band below shows (cite its descriptor ID) |

A **verified strength** is a reviewer-listed positive, tagged to a descriptor ID in this file, with a draft quote of 15 words or fewer that passes the cited-span check (a script confirms the quote appears in the draft) and is not contradicted by a problem on the same passage; adjudication.md holds the full definition and the number required for B+ or above under each harshness setting (harsh or neutral, set in RUBRIC.md).

"Barely met" means the descriptor holds only if the reader supplies one missing step or reads one passage generously: name that passage. The A band has no plus (A- is its minus); F has neither mark.

## 3. Descriptor tags and IDs

| Tag | Meaning |
|---|---|
| [observed] | seen in earlier tool-assigned, unconfirmed reviews (evidence, not ground truth: no person confirmed those grades) |
| [derived] | derived from published rubric conventions or from this tool's stated requirements |
| [extrapolated] | extended by reasoning, with no direct evidence |

Evidence is thin at the extremes of the scale (the A range, D and F) and absent for Structure and organisation, which no earlier review graded. Descriptors are topic-neutral generalisations: none depends on a subject, a school of thought or a citation style.

Every descriptor has a lowercase ID `<criterion>-<band>-<n>`; the prefixes prim, arg, stru, src, orig and mech stand for the RUBRIC.md keys primary, argument, structure, sources, originality and mechanics (example: prim-a-1). Tag strengths and named weaknesses with these IDs. Each criterion ends with an invented near-miss: read it for the pattern and never copy its wording into a report.

## 4. The six criteria

Every descriptor names something a reader can point to: quote it (15 words or fewer) or give its locator. **A-band descriptors are conjunctive: every listed element must hold.** For B to F, a criterion sits in the highest band whose descriptors fit the main line of the essay; a lower-band flaw confined to one passage is a named weakness (a minus), not a placement.

### 4.1 Command of primary texts (prefix prim)

- **Definition.** How accurately and closely the essay reads, characterises and applies the primary texts it treats as its objects (the `primary_text` lines of RUBRIC.md). Concepts taken from a source are defined as the source defines them; a deliberate departure is flagged and argued.
- **Owner:** primary-text-reviewer. **Judged on:** the whole essay, from the passages that characterise, quote or apply a primary text. **Boundary:** a wrong or invented quotation is charged to Use of sources, not here; whether a correctly quoted passage fits its use and context is judged here.

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | prim-a-1 | Every claim about what a primary text says, does or denies is tied to a quoted or located passage that a reader can check against the claim. | [derived] |
| A | prim-a-2 | Each concept taken from a primary text is defined as that text defines it, with its contrast term kept and every distinction the text draws preserved (no DISTINCTION-COLLAPSED). | [derived] |
| A | prim-a-3 | Every departure from the text's own terms, method or emphasis is flagged as a departure and argued; none is silent. | [derived] |
| A | prim-a-4 | Where the text allows competing readings or contains a tension, the essay names it and gives a reason for the reading it chooses. | [derived] |
| B | prim-b-1 | No significant misreading: characterisations are accurate and tied to the text, though some claims rest on thinner evidence than they need. | [derived] |
| B | prim-b-2 | Concepts are used as the text uses them; at most one term is left undefined or one distinction is blurred, and no step of the argument turns on it. | [derived] |
| B | prim-b-3 | Where readings compete, the essay picks one without saying why, or flags a departure without arguing it. | [derived] |
| C | prim-c-1 | The text's main claims are grasped, but several characterisations are loose summary or asserted with no passage. | [derived] |
| C | prim-c-2 | A concept is used in a sense the essay never defines, or with its contrast term dropped, though the main line still follows the text. | [derived] |
| C | prim-c-3 | A departure from the text's terms or method appears unflagged, in a passage the thesis does not depend on. | [derived] |
| D | prim-d-1 | A significant misreading sits in a passage the thesis depends on: a relation the text states is reversed (RELATION-INVERTED), a term is used against the source's sense (TERM-VS-SOURCE), or the essay's method contradicts the text's (METHOD-VS-SOURCE). | [derived] |
| D | prim-d-2 | The text is mentioned rather than used: a few loosely connected quotations or references carry the discussion with little reading of what they say. | [derived] |
| F | prim-f-1 | No sign the text was read: claims or content the text does not contain are attributed to it throughout, or the declared primary text is never engaged. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay on a treatise, "The Measure of Tides", locates each claim about "gauge" by chapter and page and defines the word as the treatise does (prim-a-1 and prim-a-2 hold). The treatise uses "gauge" in two incompatible senses, in its chapters 2 and 5; the essay adopts one and never says the other exists, so prim-a-4 fails and the criterion stays in the B band (B+ only with verified strengths).

### 4.2 Argument (prefix arg)

- **Definition.** Whether the essay defends a clear thesis with reasoning that holds: thesis, premises, contradictions and the strongest objection. A load-bearing claim is one the thesis depends on.
- **Owner:** argument-reviewer (reads after the source checks and sees no other reviewer's findings or grades). **Judged on:** the whole essay, from thesis to ending.
- **Rules.** Name the limiting defect, by descriptor ID, in every Argument grade reason. Treat an objection as answered only when the reply meets arg-a-3, the strength that lifts an Argument grade to B+ or above; a reply that meets only arg-b-2 is partly answered. An adopted rescue (a repair route that an earlier report, meaning a review of an earlier draft of this essay, suggested and the draft took up) earns credit here for execution only.

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | arg-a-1 | A substantive thesis is stated early and stays the same claim to the end; its key terms are defined and used consistently. | [derived] |
| A | arg-a-2 | Each load-bearing claim has a mechanism, example, evidence, source or baseline the reader can point to; none rests on assertion alone. | [derived] |
| A | arg-a-3 | The strongest objection is stated in a form its holder would accept and answered by a reply that addresses the objection's own premise; counter-evidence the essay invokes is engaged (no COUNTER-EVIDENCE-UNENGAGED). | [derived] |
| A | arg-a-4 | No two claims contradict each other (no SELF-CONTRADICTION), and the essay separates what it establishes from what it assumes. | [derived] |
| B | arg-b-1 | A clear thesis and a coherent chain of reasoning; at least one premise is left undefended or one conclusion overreaches slightly, without breaking the chain. | [derived] |
| B | arg-b-2 | Significant objections are considered and answered, but a reply is partial or leaves the objection's main premise untouched. | [derived] |
| B | arg-b-3 | Key terms are defined or used consistently with at most one lapse, and no thesis-level contradiction appears. | [derived] |
| C | arg-c-1 | A thesis is present but underdeveloped: gaps or non-sequiturs between claims (BRIDGE-GAP) leave the reader to supply a step. | [derived] |
| C | arg-c-2 | Objections are missing or handled as straw men, and assertion stands in for support in at least one load-bearing claim (NO-EVIDENCE). | [derived] |
| C | arg-c-3 | A local contradiction or a shifting use of a key term goes unnoticed, though the thesis survives either way. | [derived] |
| D | arg-d-1 | The thesis is vague or shifts, so a reader cannot say what the essay defends, or its central claims contradict each other at thesis level. | [derived] |
| D | arg-d-2 | Mostly assertion, description or opinion: two or more of arg-c-1 to arg-c-3 show in the main line of the essay. | [derived] |
| F | arg-f-1 | No discernible argument, or an argument that never addresses the question the essay sets itself. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay argues that a city's records-retention schedule works as a policy of forgetting. It states the thesis in paragraph 1, backs each load-bearing claim and contradicts nothing (arg-a-1, arg-a-2, arg-a-4). It states the strongest objection fairly (the schedule only manages storage cost), but its reply shows only that cost is not the sole motive and never touches the objection's premise that cost explains the schedule's timing, so arg-a-3 fails and the grade stays in the B band.

### 4.3 Structure and organisation (prefix stru)

- **Definition.** How the material is arranged: where the thesis and strongest claim first appear, each paragraph's job, the order of premises, transitions, proportion, the ending, and paragraph-level padding (a paragraph that repeats earlier material or does no work). Phrase-level filler belongs to Mechanics.
- **Owner:** argument-reviewer. **Judged on:** the whole essay, from paragraph-level checks. **Uncalibrated:** no confirmed anchor (a graded earlier draft whose grade the author or an instructor confirmed) covers it, so its confidence is always low.
- **Rules.** Grade it only from findings and strengths the argument-reviewer tags Structure; with none, leave it n/a. Keep it within one step of the Argument grade unless two structure-specific findings, each with a quote, justify a larger gap. Never count a fault twice: charge missing reasoning (an absent premise, an unsupported claim) to Argument, and material that is misplaced, misordered, repeated or out of proportion to Structure.

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | stru-a-1 | The thesis or governing question appears early and precisely, and the ending restates what the body showed without adding a new claim. | [derived] |
| A | stru-a-2 | Each paragraph has one job that serves the thesis and that a one-sentence summary can state; no paragraph repeats another or does no work (no paragraph-level padding). | [derived] |
| A | stru-a-3 | Premises are ordered so each rests only on what is already established; terms are defined before they are used; each quotation is framed before and after. | [derived] |
| A | stru-a-4 | Transitions state the logical relation between sections (because, so, however), and proportion is sound: the strongest objection gets room to be felt and answered, and promised elements (diagrams, sections, announced counter-cases) are delivered. | [derived] |
| B | stru-b-1 | The thesis is clear and the order generally logical; the reader is never lost. | [derived] |
| B | stru-b-2 | Paragraphs are mostly unified; one weak transition appears, or one premise is used before it is motivated. | [derived] |
| B | stru-b-3 | Proportion is uneven in one place (for example the objection is handled briefly), or one paragraph repeats earlier material. | [derived] |
| C | stru-c-1 | The thesis is buried, vague or revealed only at the end, or the roadmap is absent or empty (a promise that the essay will discuss a topic, with no order stated). | [derived] |
| C | stru-c-2 | Paragraphs hold several ideas or digress, so the reader must reconstruct the order of premises. | [derived] |
| C | stru-c-3 | Proportion is lopsided (long exposition with a token objection), or several paragraphs restate earlier ones. | [derived] |
| D | stru-d-1 | Organisation obscures the argument: no identifiable thesis placement, paragraphs without unity, absent transitions. | [derived] |
| D | stru-d-2 | Repetition or material that does no work fills a substantial part of the essay. | [derived] |
| F | stru-f-1 | No organising principle: a run of unconnected statements. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay on a harbour ferry timetable states its thesis in paragraph 1, gives a roadmap the body follows and gives most paragraphs one job (stru-a-3, stru-a-4 hold). Section 4 restates section 2's claim at length (paragraph-level padding) and the last paragraph adds a new claim about fares, so stru-a-2 and the ending clause of stru-a-1 fail and the grade stays in the B band, within one step of Argument.

### 4.4 Use of sources (prefix src)

- **Definition.** Accuracy of quotation and attribution, credit given to precedents (earlier work the essay's idea builds on), and every citation-form defect against the style named in RUBRIC.md.
- **Owner:** source-verifier. **Judged on:** the whole essay, from per-quotation and per-citation checks. **Charging:** wrong quotations and attributions land here, not in Command of primary texts; judgements of fit, context and gloss (explaining what a quotation does for the argument) land in Command of primary texts or Argument. An uncredited precedent is charged here for the failure to credit, and under Originality only for the delta, never both for one fault.
- **Grade effect.** Only items checked against an original or a named secondary source can lower this grade. Items the tool could not check (UNVERIFIED), matched only to a summary's own phrasing (SECONDARY-ECHO) or not found in a named text (NOT-FOUND) have no grade effect.
- **Conditional cell.** Only this criterion carries one. When a quotation defect may trigger the integrity cap, grade X as submitted and Y with the named quotations fixed, citation problems still counted; the cell reads `X (Y once <named fix> is done)`.

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | src-a-1 | Every quotation checked against an original or a named secondary source reproduces it (no change of sense, no paraphrase inside quotation marks), and its attribution (author, work, locator) is right. | [derived] |
| A | src-a-2 | Every precedent the essay builds on is credited where it is used, and the essay says what it adds. | [derived] |
| A | src-a-3 | One citation style, the one named in RUBRIC.md, is applied throughout: complete entries, one edition per work, consistent page and date pairs, correct title formatting, no placeholder left; isolated slips of form do not affect finding the source. | [derived] |
| A | src-a-4 | Wording is the author's own wherever quotation marks are absent: nothing close to a source's or an earlier report's wording appears unmarked. | [derived] |
| B | src-b-1 | Quotations checked are accurate; any defect is minor and leaves the sense intact (an edition variant, an unmarked ellipsis, a slipped locator). | [derived] |
| B | src-b-2 | Precedents the essay relies on are credited, though what the essay adds is not always stated. | [derived] |
| B | src-b-3 | Citation form follows one style, but one class of slip recurs (for example mixed editions or incomplete entries) without making a source hard to find. | [derived] |
| C | src-c-1 | Quotation or attribution defects leave the claim intact: reordered wording that keeps the sense, a locator in the wrong chapter, genuine wording credited to the wrong work, or a conversion artefact inside a quotation. | [derived] |
| C | src-c-2 | Wording close to a source appears with no marks or citation, or marks surround wording that is not a quotation. | [observed] |
| C | src-c-3 | A precedent the essay relies on is not credited, or several classes of form error (mixed editions, incomplete entries, confused dates, leftover placeholders) make a source hard to find. | [derived] |
| D | src-d-1 | At least one load-bearing quotation in marks differs in sense from a passage located in an original, or paraphrases the source's sense inside marks. | [derived] |
| D | src-d-2 | Wording inside quotation marks, attributed to a source, matches the wording of an earlier report and appears in no opened text of the work. | [observed] |
| D | src-d-3 | Borrowed phrasing without attribution recurs across several passages, or the thesis rests on a precedent the essay never credits. | [derived] |
| F | src-f-1 | Quotations or sources are fabricated, or stretches of others' words are reproduced without marks or credit across the essay. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay on canal-lock engineering quotes a treatise accurately in nine places, checked against the matching edition, credits two precedents with what it adds, and follows one style (src-a-1, src-a-2). Its notes mix two editions of the treatise and leave two entries without publisher or year, a recurring class of form slips rather than isolated ones, so src-a-3 fails and the criterion stays in the B band.

### 4.5 Originality (prefix orig)

- **Definition.** The delta the essay adds over what its credited precedents and sources already supply: an idea, distinction, counterexample, reading or application that is the author's own. Judge against what was available to the author, not against the field.
- **Owner:** argument-reviewer. **Judged on:** the whole essay, after source adjudication (only verified precedents reduce the delta; a precedent candidate the source-verifier could not verify, registered UNVERIFIED, has no grade effect).
- **Rules.** Originality is independent of correctness: a flawed or mistaken contribution that is the author's own still earns credit, and quotation, reading and support errors lower other criteria. It is never capped, the integrity cap included. Plugin-supplied ideas earn no credit: nothing from a reviewer's suggestion, rescue or "direction to test" counts, even when adopted (adoption earns Argument credit for execution).

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | orig-a-1 | The essay offers at least one idea, distinction, counterexample, reading or application of its own that the credited sources and verified precedents do not already supply; the reviewer can state this residual contribution (what the essay adds beyond the credited precedent) in one clause. | [derived] |
| A | orig-a-2 | The contribution is worked out in depth: its premises, scope and consequences appear in the text, not only its name. | [derived] |
| A | orig-a-3 | The contribution bears on the thesis: removing it would change what the essay concludes. | [derived] |
| A | orig-a-4 | The contribution is the author's: it matches no idea an earlier report supplied, and the essay marks where its own claim begins and its sources' claims end. | [derived] |
| B | orig-b-1 | Independent and competent work that stays largely within received interpretations or the credited precedents. | [derived] |
| B | orig-b-2 | An apt analogy, sharp distinction, counterexample or application appears but is not developed far enough to carry the argument. | [derived] |
| C | orig-c-1 | Standard material and arguments are reproduced with little of the author's own; the author's view is hard to tell from the sources'. | [derived] |
| C | orig-c-2 | A claimed contribution is already supplied by a verified precedent, and the residual-contribution clause is empty or marginal. | [derived] |
| D | orig-d-1 | Largely derivative: standard objections and replies are restated with no sign of independent thought. | [extrapolated] |
| F | orig-f-1 | Entirely derivative or copied: no claim, reading or application is the author's own. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay on signal-flag codes draws a sharp distinction between flags that warn and flags that instruct, and applies it to three harbours. A credited precedent, an invented flag manual, already draws that distinction; the residual contribution is the third harbour only, so orig-a-1 fails and the criterion stays in the B band. A mistaken claim in the same essay about flag dyes would not change this grade, because correctness is judged elsewhere.

### 4.6 Mechanics (prefix mech)

- **Definition.** Prose-level errors in classes M1 (spelling and agreement), M2 (syntax) and M3 (diction and voice), plus phrase-level filler.
- **Owner:** mechanics-reviewer (prose-level only); the orchestrator charges phrase-level filler here from the voice-echo-reviewer's search against filler-phrases.md (a list of stock phrases). **Judged on:** the whole text, with every pattern searched across it.
- **Rules.** Never grade by item count: weigh the class mix, recurrence, density against word count, and whether meaning stays clear on a first read. Judge whether the prose is correct and clear, not whether the idiom is native-like; unusual but clear, grammatical phrasing is not a defect. Citation-form defects go to Use of sources and paragraph-level padding to Structure.

| Band | ID | Descriptor | Tag |
|---|---|---|---|
| A | mech-a-1 | Errors of spelling, agreement, punctuation and typography (M1) are rare for the length of the text and form no recurring class. | [derived] |
| A | mech-a-2 | Sentences parse on a first read: no fragment, comma splice, dangling modifier or run-on (M2) forces a reread, and none recurs. | [derived] |
| A | mech-a-3 | Diction is precise: no word is used against its ordinary sense, and voice, person and tense stay consistent (M3). | [derived] |
| A | mech-a-4 | Phrase-level filler is absent or isolated; each sentence carries only the words its idea needs. | [derived] |
| B | mech-b-1 | A few slips (single-token errors, an occasional comma or apostrophe) that never impede meaning. | [derived] |
| B | mech-b-2 | At most one class recurs, in a few places; the rest of the text is clean. | [derived] |
| B | mech-b-3 | Small patches of phrase-level filler or wordiness never hide the point. | [derived] |
| C | mech-c-1 | Errors, awkwardness or wordiness are conspicuous: two or more classes recur, and some sentences cloud meaning on a first read. | [derived] |
| C | mech-c-2 | A class flagged earlier persists after instance-level fixes, so the whole text needs proofreading for it, though it is repairable without rewriting. | [derived] |
| C | mech-c-3 | Filler recurs in many paragraphs, so a reader skims. | [derived] |
| D | mech-d-1 | Frequent errors or imprecise diction distract or impede reading in every section. | [derived] |
| D | mech-d-2 | Phrase-level filler or padding is pervasive. | [derived] |
| F | mech-f-1 | Errors so pervasive that meaning is often unrecoverable. | [extrapolated] |

**Near-miss (B+, not A).** An invented essay on grain-elevator architecture has clean spelling, agreement and diction and almost no filler. A comma splice recurs in one paragraph in four, so mech-a-2 fails and the class recurs: the band comes from that recurrence and the rereads it forces, not from how many splices there are, and it stays in the B band.

## 5. Calibration guards

- Cite the cue behind every row change (a changed grade in a criterion's row of the report's rubric table): name the descriptor ID and give a draft quote or locator. Justify in writing any move of more than three steps.
- Never use problem counts or list length as a proxy for a grade. A long list of minor items can leave a criterion in its band, and a single defect that a descriptor names can place it lower.
- Compare each provisional grade with the nearest confirmed anchors above and below, quoting a passage, and explain any gap of more than one step. Where confirmed anchors give no coverage for a cell, the report prints a calibration note.
- Structure differs: no confirmed anchor ever covers it, so grade it only from findings the argument-reviewer tags Structure, keep it within one step of Argument unless two structure-specific findings justify more, carry low confidence, and print the calibration note beside it every time.
