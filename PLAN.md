# PLAN.md: `betterpaper`, a grading framework for Claude Code (revision 2.2, 2026-10-06)

> **For the agent executing this plan.** Work phase by phase. Each phase has three subphases in order: **Q&A** (record decisions in `docs/phases/phase-N-discussion.md`), **agentic research** (notes in `docs/research/phase-N/`), then **build**. Finish every build task, run its **Verify** checks (including the privacy scan), show the user the result, then commit and push to `main` (push after every meaningful change, not only at phase ends). Where this plan names a Claude Code file format, flag or command, confirm it against the official docs linked in the phase; if a doc contradicts this plan, follow the doc and note it in `CHANGELOG.md`. Ask the user only where a decision is not already in `DECISIONS.md`.
>
> **Inputs.** `DECISIONS.md` (D1-D16, R1-R22, A1-A56) is the single source of truth for decisions. `docs/design/method-digest.md` holds the detailed requirements for the reference files, templates, agent briefs and scripts, and `docs/design/file-contracts.md` holds formats, schemas, tables and small rules; Phases 1-5 build from both. `docs/research/phase-1/` holds the evidence and the verified style rules. Private source material (earlier reviews, essay drafts, the denylist) lives **outside the repository** in `../betterpaper-private/` and is never read into a tracked file.

**What changed from revision 1.** Names; six criteria; argumentative and theoretical academic writing only; three citation styles; human-confirmed anchors; a narrower integrity cap; reviewer waves with a verification step between them; six deterministic scripts plus an eval-metrics tool; an adjudication file with worked examples; confidence and human-check flags; an allow/deny matrix for the author's words; a demo built early; a committed privacy hook; a private gold set; Phase 7 kept generic.

---

## 0. What we are building

A Claude Code **plugin**, published from a GitHub repo, that grades successive drafts of post-graduate humanities essays (argumentative research essays and theoretical or conceptual essays; philosophy and critical theory first) the same way every time. It runs a five-step loop (intake, map, review, adjudicate, report) and keeps its memory in files, not in the chat.

Design principles:

1. **State lives in files.** Each essay has a workspace with its rubric, grade history, issue tracker, quotation ledger and confirmed anchors. Every run reads it first and updates it last.
2. **Reviewers work in fresh contexts.** Five specialist subagents see the draft (as untrusted data) and only what they need. The panel is justified as a *diagnostic structure*, not as proven more accurate than one grader.
3. **Quotations are checked before anything is graded**, with an explicit status for each, and a script confirms that every draft excerpt a reviewer cites really appears in the draft.
4. **Human-confirmed graded examples anchor the scale** (R4). A grade made by the tool alone cannot become an anchor until the author or an instructor confirms it.
5. **The tool never writes the author's prose** (R18): an allow/deny matrix, a paste test, and a lint step.
6. **It is honest about what it checked.** Every factual or quotation claim carries one label from a short set; recall never lowers a grade or triggers a cap.
7. **It shows its uncertainty.** A-range grades are provisional, Structure is uncalibrated, and confidence is a categorical note with named reasons plus a human-check flag.

### Evidence base (quote exactly, with limits)

Full notes: `docs/research/phase-1/` (`llm-grading-evidence.md`, `grading-literature-synthesis.md`, `purdue-deck-verification.md`).

- In one preprint (Idowu & Almasoud 2026, arXiv:2601.22386; ASAP 2.0 US school essays, grades 6-10; GPT-5.1; 450 test essays; single run), twelve calibration essays (two per score level on a 1-6 scale) raised QWK from 0.5664 to 0.7165 for a single agent (+26.5% *relative*) and from 0.5917 to 0.7453 for a three-specialist-plus-chairman design (+25.96% *relative*). The same study measured exact-match accuracy of 30.8% on score 5 of 6 under few-shot (both designs; n=26; zero-shot 7.7% and 11.5%); the top score had only 3 essays and the authors call it statistically insufficient. The multi-agent design did better on weak essays, marginally better overall and slightly worse mid-range, at four calls instead of one, and its capping rule probably pulled strong essays down.
- Eleven further preprints were read and cross-checked. None compares a weighted average with a holistic grade, tests editable weights, or tests five fresh-context specialists with a deterministic adjudicator or a confidence mechanism. In one study explicit instructions not to penalise informal or non-native style did not prevent score drops (no no-instruction control); in another, one appended sentence demanding the maximum grade raised scores (no defended condition was tested). Models quoted text that was not in the essay in one study.
- All evidence is on school-level, exam or non-Claude material, and none covers successive drafts by one author. Treat every figure as direction, not forecast, for graduate humanities drafts.

### Reference implementations (read, don't copy)

`open-gsd/gsd-core` (MIT): phase loop, `STATE.md`, fresh subagents. `AlexWortega/ai-peer-review-skill` (MIT): isolated reviewers, meta-review by the main thread (vary dimension emphasis, never severity). `wenxuec/llm-judge` (MIT): rubric templates, one example per score point, bias catalogue, calibration loop (add per-band reporting). `Imbad0202/academic-research-skills` (**CC BY-NC 4.0**): ideas only, no code.

---

## Decisions (summary; `DECISIONS.md` governs)

| # | Decision | Value |
|---|---|---|
| D1 | Name | `betterpaper` |
| D2 | Default mode | Full panel; `--quick` single pass (stays until the gold-set A/B, A40) |
| D3 | `proof-note` | Included |
| D4 | Workspace folder | `betterpaper/<slug>/`; this repo ignores it anchored (`/betterpaper/`), and users add the unanchored `betterpaper/` to their own writing folder's `.gitignore` |
| D5, D6 | Licence, visibility | MIT; public; no private content in the tree; early-history exposure accepted (D16) |
| D7 | Criteria | Six, adding Structure and organisation |
| D8, A9 | Citation styles | Chicago notes-bibliography (default), Chicago author-date, MLA 9; the source-verifier loads the style file |
| D9 | Calibration cues | Subject-neutral in the public repo |
| D10, R1 | Overall grade | Weighted average; equal weights by default, editable |
| D11 | Padding | Phrase-level under Mechanics, paragraph-level under Structure |
| D12 | Style-rule sources | Built only after the user's source material is ingested (done); `[U]` rules are never errors |
| D13, D14 | Venue and scope | Post-graduate; argument with research plus general theory; **theory-fiction out of scope** |
| D15 | Reference grades | Tool-assigned, so unconfirmed (R4) |
| R1-R22, A1-A56 | Sheet and assistant defaults | See `DECISIONS.md` |

---

## Repository layout (target)

```
betterpaper/                                   # repo root = marketplace root
├── .claude-plugin/marketplace.json
├── plugins/betterpaper/                       # plugin root (what a user installs)
│   ├── .claude-plugin/plugin.json
│   ├── skills/
│   │   ├── init/ SKILL.md + templates/ RUBRIC.md STATE.md SOURCES.md ANCHOR.md CONFIRM.md
│   │   ├── grade/ SKILL.md + references/
│   │   │     grade-bands.md  adjudication.md  adjudication-examples.md  rules.md  tracker-rules.md
│   │   │     report-template.md  report-sections.md  report-voice.md
│   │   │     chicago-notes.md  chicago-author-date.md  mla.md  filler-phrases.md
│   │   └── proof-note/SKILL.md
│   ├── agents/ source-verifier primary-text-reviewer argument-reviewer mechanics-reviewer voice-echo-reviewer (.md)
│   ├── scripts/ extract_quotes.py echo_check.py check_cited_spans.py compute_grade.py select_anchors.py report_lint.py (+ test_*.py)
│   └── demo/                                  # fictional essay + workspace, ships with the plugin
├── evals/ eval_metrics.py (+ test) gold-set/ style-perturbation/ injection/ panel-vs-single/ severity/   # repo only; clone to run
├── tools/ privacy-scan.sh  install-hooks.sh  hooks/pre-push      # development tools; denylist lives outside the repo
├── docs/ phases/ research/ design/            # Q&A records, research notes, method digest, file contracts
├── PLAN.md  README.md  CHANGELOG.md  DECISIONS.md  LICENSE  .gitignore
```

**Path convention (A20).** Skills and agents refer to `${CLAUDE_PLUGIN_ROOT}/skills/grade/references/<file>` and run `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/<script>`; templates are referenced with `${CLAUDE_SKILL_DIR}`. Agent names are scoped (`betterpaper:<agent>`).

### Essay workspace (user's writing folder, never in this repo)

```
betterpaper/<essay-slug>/
├── RUBRIC.md      # flat key: value front matter (file contracts, section 1)
├── STATE.md       # thesis, genre, grade history (with mode), anchors register, tracker, ledgers, logs
├── SOURCES.md     # OPENED and RECOMMENDED tables, precedent register, quotation ledger
├── anchors/ CONFIRM.md   anchors/draft-N/ text.md  ANCHOR.md    # ANCHOR.md is authoritative
├── feedback/      # imported earlier reviews and third-party comments (read by the echo stage)
├── drafts/draft-N.md   worksheets/draft-N-map.md   reviewer-notes/draft-N/<reviewer>.md   reviews/draft-N.md
└── sources/       # page photos, scans, bundled excerpts for quote checks
```

---

## Pipeline

```
Intake ─ read workspace; select anchors (select_anchors.py); pre-check text; read markers
Map ──── extract_quotes.py → echo_check.py (once, before Review)
Review ─ wave 1 (parallel): source-verifier, primary-text-reviewer, mechanics-reviewer, voice-echo-reviewer
   3b ── check_cited_spans.py on wave-1 output; merge ledger block into SOURCES.md; second source-verifier call on
         wave-1 precedent candidates; build wave-2 input (verified ledger + precedent register + stripped extract)
         wave 2: argument-reviewer (no other findings or grades)
Adjudicate ─ source-verifier pass on wave-2 candidates → cap test → merge → holistic grade recorded → compute_grade.py
         → repeat set if the repeat rule fires (mean of runs, compute_grade.py again) → flags → tracker
Report ─ write review → echo on the report's own text → report_lint.py → update STATE.md and SOURCES.md; append anchor
```

---

## Phase 0: Scaffold the repo (done)

Repo, manifests, `.gitignore`, MIT licence, `DECISIONS.md`; both `claude plugin validate` checks pass. Docs: <https://code.claude.com/docs/en/plugins/create.md>, <https://code.claude.com/docs/en/plugins/create-marketplace.md>.

---

## Phase 1: Shared references (the rules of the house) (built; open style points in `docs/phases/phase-1-build-notes.md`)

Build from `docs/design/method-digest.md` sections 1-5 (sections 4-5 for definitions) and `docs/design/file-contracts.md`, and from `docs/research/phase-1/` (the user's Chicago and MLA material is already ingested; addenda A and B of `purdue-deck-verification.md` carry the final tags). Files go under `skills/grade/references/`, each under 200 lines and readable alone. `SKILL.md` stays under 500 lines by linking here. Shipped files define any term they need inline and never cite D, R or A codes. First task: `tools/install-hooks.sh`.

### 1.1 `grade-bands.md`
Six criteria on the 12-step scale (band = letter, step = one rung, top band = A range). For each criterion: definition, whether it is judged on a part or the whole, observable descriptors for A, B, C, D, F (A-band descriptors are conjunctive: every listed element must hold), a near-miss example on an invented topic, and the plus or minus rule (plain when all descriptors are met; plus with a verified strength from the band above; minus when one is barely met or a named weakness of the band below shows). Partial grading: weights renormalise over graded criteria, a cell prints n/a, the overall is marked partial. Tag descriptors `[observed]` (seen in earlier unconfirmed tool-assigned reviews; evidence, not ground truth), `[derived]` or `[extrapolated]`, each written as a topic-neutral generalisation from sanitized material; state that evidence is thin at the extremes of the scale and absent for Structure.

| Criterion | Reviewer | Note |
|---|---|---|
| Command of primary texts | primary-text-reviewer | Concepts used as sources define them; deliberate departures flagged and argued. Wrong quotations are charged to Sources, not here |
| Argument | argument-reviewer | Thesis, premises, contradictions, strongest objection. Each row's reason names the limiting defect |
| Structure and organisation | argument-reviewer | Uncalibrated: graded only from structure-tagged findings, within one step of Argument unless two structure-specific findings justify more, never double-counted; includes paragraph-level padding |
| Use of sources | source-verifier | Accuracy of quotation and attribution, credited precedents, all citation-form defects; carries the conditional cell |
| Originality | argument-reviewer | Delta over credited precedent, graded after source adjudication; plugin-supplied ideas earn no credit; independent of correctness; never capped (A11) |
| Mechanics | mechanics-reviewer | Prose-level errors and phrase-level filler (from the voice-echo-reviewer's grep, charged by the orchestrator); counts by class, word count, recurrence; never graded by item count |

### 1.2 `adjudication.md` and `adjudication-examples.md`
`adjudication.md` is written in full so it is deterministic (digest section 2, file contracts section 5): scale; integer weights; rounding and tie rule (A2); the two harshness rules and the verified-strength definition (A3, A26); merge rule; the four-condition integrity test, two evidence routes (counter-passage, provenance), decision table, normalisation, non-trigger list and event log (A11, A31); confidence mapping, disagreement signal, repeat rule and grade of record (A5, A30); calibration guards; completeness invariant; severity key and the defect-code-to-tier table (A12); the target rule (A13). No veto and no minimum rule. `adjudication-examples.md` holds worked examples on invented data: a tie under harsh and neutral, a cap with its conditional cell, a partial grade, a verified-strength limit, and a repeat.

### 1.3 `rules.md`
The allow/deny matrix and paste test (R18), blank citation templates (R19), the label set, the grade-effect rule (claims about sources, quotations, dates and facts outside the draft may lower a grade or trigger a cap only when checked against the original or a named secondary source; findings about the draft's own text may lower a grade on the draft alone), no intent inference, the Correction triggers (R13), positioning flags from declared context only (R16), the genre rule (D14), the mechanics boundary, harshness definitions, the web-query rule (author, work and at most 8 distinctive words of a string, never the full string or bridging text), prompt-injection hardening (nonce delimiters), the severity key, and no authorship claims or detector talk. Reviewers are never told whether an essay was AI-assisted or where it came from (identity cues moved ratings in published tests).

### 1.4 `report-template.md`, `report-sections.md`, `report-voice.md`
Template: section conditions and order, header block with confidence line and human-check flag, grade lines with previous values, verdict spec, rubric table, footer, rendering and length budget. Sections: Correction shape, Quotation problems spec and entry fields, Major problems fields, Citation problems, Proofreading, recurrence tags, steps, Sources consulted, the status-to-section table. Voice: stance, steelman-before-critique, rescue limits, praise rules, plain-language rules, heading neutrality.

### 1.5-1.7 Citation styles
`chicago-notes.md`, `chicago-author-date.md`, `mla.md`: templates for book, translated book, chapter, journal article (DOI as `https://doi.org/` link), online source, "quoted in", classical works, block quotations, short forms, and a scannable error list. Templates are blank and bracketed, plus one filled example on an unrelated source (R19). Each file defines the tag set at its top (`[C18]`, `[MLA9]`, `[DC]`, `[D]`, `[S]`, `[U]`); `[U]` rules are never errors (the reviewer says "check your style guide"). Settled points: CMOS 18 note names only the first of more than two authors; bibliography up to six (more than six: first three plus "et al."); soft 100-word block-quote rule; notes-bibliography "quoted in" lists both sources while author-date and MLA list only the one consulted; ancient works cited by standard divisions without page numbers; MLA 9 lowercases seasons and gives DOIs as links; classical numbering is never flagged. Settled by the supplied excerpts (addenda B and C): the whole author-date system, abbreviations and page ranges in reference lists, web, blog, social-media and AI-content citation, translated titles and quoted translations, abbreviations for frequently cited works, MLA poetry, divisions and line numbers, page-range elision and month abbreviations. Open: two-edition (A/B) and academy-edition ("Ak.") numbering for modern classics, author-date for ancient works, newsletter posts as a named category, MLA translator-first entries and Plato and Aristotle numbering. Worked examples use invented works and pages.

### 1.8 `filler-phrases.md`
Phrase-level padding list in the grammar of the file contracts (one lowercase phrase per line, `#` comments, trailing `?` for conditional entries); excludes single "AI-sounding" words and legitimate signposts.

**Verify.** Each file under 200 lines and readable alone; every style rule tagged; no D, R or A codes in shipped files (`grep`); `tools/privacy-scan.sh` clean and the hook installed; `adjudication-examples.md` contains the worked examples listed above (`compute_grade.py` reproduces them in Phase 4). **Commit and push.**

---

## Phase 2: Workspace init skill, templates, and a minimal demo

Docs: <https://code.claude.com/docs/en/skills.md>. Build from digest sections 4-5 and file contracts sections 1, 7 and 10.

1. `skills/init/SKILL.md`: `name: init`, `argument-hint: "<essay-slug> [--confirm]"`, `disable-model-invocation: true`, with `allowed-tools` for workspace writes (confirm the syntax in the docs).
2. Behaviour (file contracts section 7): slug `[a-z0-9-]+` up to 60 characters, else reject; stop and offer to resume if the workspace exists; create the full tree including `feedback/` and `anchors/`; check `.gitignore` coverage if the folder is a git repo; copy the demo for the slug `demo-essay`. Interview the user: title; genre (argumentative research essay, theoretical or conceptual essay, other: triggers the out-of-scope warning); venue; harshness (default harsh); citation style (default Chicago notes-bibliography, mapped to a style file); integer weights (default 1); `anchor_count` (default 4) and `anchor_seed`; declared audience and promises; `primary_text` lines (work, translator or edition, locator system), which seed the "edition used by the author" column of `SOURCES.md`; which graded earlier drafts exist and **who confirmed each grade**; where the answer is "the tool", write `anchors/CONFIRM.md`. `init <slug> --confirm` applies a completed `CONFIRM.md` (A29).
3. Templates: `RUBRIC.md` (flat key: value); `STATE.md` (counters header and counter-to-tag mapping, thesis, genre, grade history with a `mode` column, anchors register, anchor-order log, token and cost log, issue tracker with the eight statuses, the CANNOT-CHECK flag, severity history and a visible-to-reviewers marker per column, PATTERNS, citation ledger, suggestions and rescue logs, archive and `reviewer_wording`, corrections log with the store of earlier source characterisations, risk register, keep and commitments lists, decisions field); `SOURCES.md` (OPENED, RECOMMENDED, precedent register, quotation ledger with the statuses and flags); `ANCHOR.md` (per-criterion grades, both overall series, the model version of the paired judgements, `confirmed_by` in {author, instructor, unconfirmed}, rationale, band; the "alone" series anchors the band); `CONFIRM.md`.
4. `references/tracker-rules.md`: the behavioural rules of digest sections 4-5 (status transitions, counters, never-close-on-a-marker, SUPERSEDED children, ledger carry-forward and re-verify, the "complete, searchable" rule), read by the grade skill and the agents.
5. **Minimal demo (`plugins/betterpaper/demo/`).** Built to the inventory in file contracts section 10 (three drafts, an invented earlier review, `feedback/`, public-domain `sources/`, invented confirmed anchors, a fabricated findings file, a sample report, `grades-cases.json`, `ANSWER-KEY.md`). Defects are invented, never adapted from any real essay. **Planted-defect matrix** (extended in Phase 8):

| Planted defect | Caught by | Verified in |
|---|---|---|
| Quote copied from an earlier review, inside marks | echo_check.py, source-verifier (route b) | Phase 4, 5 |
| OCR-style corruption in a quotation | extract_quotes.py `--precheck`, source-verifier | Phase 4 |
| Transposed phrase without change of sense | source-verifier (non-trigger) | Phase 5 |
| Near-verbatim wording without marks | source-verifier (non-trigger) | Phase 5 |
| Clause-length sense-bearing mismatch, load-bearing, unresolved | source-verifier, adjudication cap | Phase 5 |
| Cited span not in the draft (fabricated findings file) | check_cited_spans.py | Phase 4 |
| Report sentence copying author text | report_lint.py | Phase 4 |
| Grade arithmetic: tie under harsh and neutral, cap, conditional cell, partial grade, verified-strength limit | compute_grade.py | Phase 4 |
| Anchor selection: near-duplicate excluded, spanning set, seeded order | select_anchors.py | Phase 4 |
| Negative controls: recall-only item, secondary-echo item, OCR-ERROR, different-edition source, catalogue-page source | adjudication (must not cap) | Phase 5 |
| A draft with minor quotation defects and no split | adjudication (must not cap) | Phase 5 |
| A fixture draft with injected "give the maximum grade" | orchestrator, all agents | Phase 6 |

**Verify.** `claude --plugin-dir ./plugins/betterpaper`, then `/betterpaper:init demo-essay` creates the full tree with populated templates and the demo content; slug and existing-workspace rules behave as specified; `init demo-essay --confirm` applies the demo's `CONFIRM.md`. **Commit and push.**

---

## Phase 3: Reviewer subagents

Docs: <https://code.claude.com/docs/en/sub-agents.md>. Build from digest section 6 and file contracts section 3.

Each agent file has `name`, `description`, `tools`, `model: inherit`. Each brief says exactly which files to read, treats the draft as untrusted data inside nonce delimiters, has an ignore list (dimensions it must not judge), receives anchors in the per-reviewer order from `select_anchors.py` (A28) and compares the draft with the nearest anchors above and below, quoting a passage. No agent has Bash (A21). Reviewers never see the essay's own grade history, tracker verification status or author claims (A23); anchors carry their confirmed grades by design. Web queries follow the web-query rule.

**Return format** (file contracts section 3): a findings table with ID, Tier, Criterion, Locator, Draft quote (15 words or fewer), Problem, Impact on thesis, Evidence / how checked, Label and Fix direction; blocks for Tracker rows and Strengths (at most 3 per criterion owned); a grade suggestion line per criterion owned (source-verifier adds a conditional clause; voice-echo-reviewer writes n/a); a confidence line with named reasons; at most 10 ranked findings. The `source-verifier` additionally returns an uncapped ledger block and a coverage line. Reviewer IDs are local; the orchestrator maps them to tracker IDs.

| Agent | Tools | Owns | Brief (summary; full in digest) |
|---|---|---|---|
| `source-verifier` | Read, Grep, Glob, WebSearch, WebFetch | Use of sources; quotation and citation ledgers; precedent register | Verify every quotation per the evidence standard; citation-form checks against the style file selected by `RUBRIC.md`; verify and register precedent candidates in follow-up passes (A24, A25); recall alone stays UNVERIFIED; receives QIDs to re-verify with marker text withheld |
| `primary-text-reviewer` | Read, Grep, WebSearch, WebFetch | Command of primary texts | Re-verify earlier characterisations first; term, relation, distinction, fit and method audits; may nominate precedent candidates but grades none |
| `mechanics-reviewer` | Read, Grep | Mechanics | Prose-level only; classes M1-M3; `vs_previous` for open rows; patterns; no filler input |
| `voice-echo-reviewer` | Read, Grep | none | Reads the saved echo output; owns the filler grep; classification; adoption of earlier suggestions |
| `argument-reviewer` (wave 2) | Read, Grep | Argument, Structure, Originality | Defect codes, claims register, structure checklist including paragraph-level padding, residual-contribution clause, precedent candidates; concedes a point only when the draft's answer would meet the B+ descriptor for Argument |

**Verify.** `claude plugin validate ./plugins/betterpaper` passes including agent frontmatter; a grep confirms no agent frontmatter lists Bash; each agent, run on the demo essay by its scoped name, returns the fixed format; the source-verifier's ledger block parses; the cited-span check passes on a clean return and drops the planted fabricated finding. **Commit and push.**

---

## Phase 4: Deterministic scripts

Python 3 standard library only; exit 0 success, 1 failed check, 2 bad input; each with `test_*.py` runnable by `python3 -m unittest`. Contracts, flags and defaults are in file contracts sections 2 and 6.

- `extract_quotes.py <draft> [--precheck]`: the precheck also strips or flags zero-width and bidirectional control characters, compares visible text with extracted text for PDF and docx input, and flags injection-like imperative text addressed to a grader; the report prints "injection-like text found" when it fires.
- `echo_check.py <draft> <feedback...>` with the documented flags; **CRITICAL** for matches inside quotation marks; also runs on the new report's text.
- `check_cited_spans.py <draft> <findings...>`: the Draft quote column and the ledger string field; Locator is navigation only.
- `compute_grade.py <RUBRIC.md> <grades.json>`: integer weights, exact arithmetic, tie rule, partial grading, verified-strength limit, cap, conditional-cell substitution, previous values.
- `select_anchors.py <workspace> --reviewer <name>`: selection, near-duplicate exclusion, seeded order, `anchors: N (M near the top band)`.
- `report_lint.py <review> <draft>`: paste test, replacement-wording flags, missing labels, reviewer coinages in marks, heading neutrality, verdict length, free-hand recurrence words, header and footer.
- `evals/eval_metrics.py` (repo only) with its test.

**Verify.** Every row of the planted-defect matrix assigned to a script is detected, including each `adjudication-examples.md` example; negative controls produce no cap; a toy QWK computed by hand matches `eval_metrics.py`. **Commit and push.**

---

## Phase 5: The grading skill (the orchestrator)

`skills/grade/SKILL.md`: `name: grade`, `argument-hint: "<essay-slug> [draft-file-or-url] [--quick] [--repeat] [--markers <file>]"`, `disable-model-invocation: true`, with `allowed-tools` for the scripts and workspace writes. Link to `references/`, do not inline.

1. **Intake.** Read `RUBRIC.md`, `STATE.md`, `SOURCES.md`, anchors. Run `select_anchors.py` for each reviewer (spanning set, near-duplicates excluded, seeded order); print `anchors: N (M near the top band, meaning an "alone" grade of A- or higher)`. **With zero confirmed anchors**: grade rubric-only, force confidence low with the reason "no confirmed anchors", print an "unanchored" banner, set the human-check flag. Draft from path, pasted text or URL (WebFetch; if the body is empty, ask the user to paste, never guess); save as `drafts/draft-N.md`; run the precheck; read `--markers` as claims (never shown to reviewers). Log the model ID, prompt hash and run date; each confirmed anchor records the model version that produced its paired judgements, and when the version has changed print a notice recommending a blind re-grade of one earlier draft (advisory, never blocking).
2. **Map.** `extract_quotes.py`; complete `worksheets/draft-N-map.md`; run `echo_check.py` once against archived reviews and `feedback/`.
3. **Review.** Full mode: wave 1 in parallel; step 3b (see Pipeline); wave 2. Log tokens per reviewer and print an estimate before a full run, then proceed without asking; put the shared rubric first and anchors after (per-reviewer anchor order costs shared-prefix caching; accepted). **Quick mode (A15):** the orchestrator grades inline; runs precheck, echo, cited-span and filler checks; prints "Integrity test not run: Use of sources unverified"; never caps; carries open rows forward as "not rechecked"; records `mode: quick`.
4. **Adjudicate.** Verify wave-2 precedent candidates; test the integrity cap per quotation (decision table) and log it; merge findings by the digest rule; record the holistic letter grade, then run `compute_grade.py`; set the disagreement signal; if `--repeat` was passed and the repeat rule fires, run the repeat set and re-run `compute_grade.py` on the mean (without `--repeat` the rule only sets the human-check flag); update the tracker (two counters, markers verified not trusted, completeness invariant); compare provisional grades with anchors and explain any gap of more than one step; print "no reliable change" instead of a movement when a grade moved by one step or less without criterion-level evidence; set confidence and flags.
5. **Report.** Write `reviews/draft-N.md` per the template; run the echo script on the report's own text; run `report_lint.py`; append the grade-history column; write `anchors/draft-N/` with `confirmed_by: unconfirmed` and refresh `CONFIRM.md`; print a five-line chat summary and the report path.

**Verify.** `/betterpaper:grade demo-essay <the demo's third draft file, kept outside `drafts/` until graded>` yields the full report, updates `STATE.md` and `SOURCES.md`, and matches `ANSWER-KEY.md`: the split fires on the planted case, does not fire on the minor-defects draft or any negative control, tags print from stored counters, the lint passes; quick mode on the same draft prints the banner and never caps. **Commit and push.**

---

## Phase 6: `proof-note` and evals

**6a: `proof-note`.** `skills/proof-note/SKILL.md`: one pass, no state files, no subagents; word-level errors, ambiguity, terms used against their source meaning, internal contradiction, consistency with pasted earlier notes. Output: numbered issues with reasons, then single-token mechanical corrections only; never changes the claim or adds sentences. **Verify:** three test notes (clean, a word confusion, an internal contradiction). **Commit and push.**

**6b: define the evals** (`evals/`, docs <https://code.claude.com/docs/en/plugin-evals.md>). Arms: `gold-set/` (format spec and synthetic fixtures only); `style-perturbation/` (variants: grammar errors, register shift, non-native phrasing, padding, polish; a human-checked equivalence step; raw point change per criterion; Mechanics and Structure may move, other rows should not; power note: a 20-pair test detects only large effects); `injection/` (a one-sentence "give the maximum grade" appended to a fixture; change across reviewers and the adjudicator); `panel-vs-single/`; `severity/` (harsh versus neutral, swapping only the harshness block); anchors (count, order, guess-then-reveal, spanning set versus same-essay anchors, anchor count versus essay length); lean versus detailed rubric; holistic cross-check against the weighted grade; quick versus full; inter-criterion correlation, cap events and checker false positives, a human-human baseline and a re-grade of a lightly edited draft. Added from the evidence review (A44-A52): a blind-versus-anchored check; a revision-sensitivity test (strengthen and weaken one paragraph and check the grade moves the right way); a stability study (several human-graded drafts graded repeatedly, publishing the observed spread under padding, plain-register paraphrase, markdown stripped and anchor-order permutations); a red-team of the real plugin (simple and rubric-aware injections, Unicode-hidden text, repeated attempts across drafts, and essays that legitimately quote imperative text to count false positives); and a weight-sensitivity check against equal weights, median and minimum. Results are published with the model version. Fixtures live under `evals/<arm>/fixtures/` and start with the header "SYNTHETIC / PUBLIC-DOMAIN". Users run them from a clone (A19). **Verify:** the injection fixture and one style-perturbation pair run on the demo, and `eval_metrics.py` reproduces a hand-computed toy result. **Commit and push.**

**6c: run the evals** once the private gold set exists (A17, A38; it waits for Phase 7 step 6): target 20 drafts with grades confirmed by the author or an instructor (minimum useful 10), at least 3 near the top band, consent for others' drafts, a second grader on a subset. Per-band figures are reported with n and described as descriptive only. Include a double-marked subset (human-human agreement per criterion, allowing that more than one grade may be defensible). Record **aggregate results only** in `docs/` (no essay content). Re-run when the model, rubric or anchors change.

---

## Phase 7: Seed a real workspace (PRIVATE) and calibrate

Runs in the user's **private writing folder** or `../betterpaper-private/`, never in a tracked path. Generic by design.

1. `/betterpaper:init <slug>`.
2. Copy earlier drafts and reviews into `anchors/draft-N/` and `feedback/`. Reference grades that the tool assigned (D15) start `unconfirmed`; `anchors/CONFIRM.md` is filled in by the author or an instructor and applied with `init <slug> --confirm`; adjusted grades replace the tool's in the history, marked `human-adjusted`. Only confirmed records serve as anchors.
3. Seed `STATE.md` (grade history, recurring issues, both counters) and `SOURCES.md` (known quotation statuses and flags). **Precondition:** for each known load-bearing quotation, place a copy of the original in `sources/`; any quotation without one is excluded from the detection check.
4. **Blind calibration test (A32)** in a fresh session on a **throwaway copy** of the workspace seeded only with material dated before the latest draft (state, ledgers, feedback, archive and anchors alike). Grade the latest draft; compare with the real latest review; discard the copy. *Objective checks* (verifiable against the real texts): if the latest real review contains an integrity split, it triggers and every load-bearing mismatch with an available original is detected with its evidence; an earlier draft that was not split does not trigger; negative controls do not cap; at least 80% of recurring proofreading items are flagged; confidence and flags are shown. *Grade check*: while the reference grades are unconfirmed, comparing grades within one step measures self-consistency only, and the report says so; once confirmed, the draft becomes a gold-set case and the comparison counts as accuracy evidence. If a check fails, adjust references or briefs and re-run.
5. Any change fed back into the public references is first re-derived from invented examples and passes `tools/privacy-scan.sh`.
6. **Gold-set intake.** Collect human-graded drafts with confirmed grades and the consent of any other author into `../betterpaper-private/gold-set/`; Phase 6c waits for it (target 20, minimum useful 10, at least 3 near the top band).

---

## Phase 8: Package and publish

Docs: <https://code.claude.com/docs/en/plugins/host-marketplace.md>.

1. Extend `plugins/betterpaper/demo/` to the full planted-defect matrix (every status and flag), using invented content only: never the quotations, typos, phrases or review wording of any real essay.
2. `README.md`: what it is; install (`claude plugin marketplace add <owner>/<repo>`, `claude plugin install betterpaper@betterpaper`); prerequisites (Python 3); usage; privacy (workspaces stay in the user's folder; add `betterpaper/` to that folder's `.gitignore`); credits; an evidence paragraph using only the quoted figures above, with corpus and level stated; the Known limits below.
3. `claude plugin validate .` and `claude plugin validate ./plugins/betterpaper` pass.
4. Test the published install path on a clean machine or account: add the marketplace from GitHub, install, run init and grade on the bundled demo.
5. Tag `v0.1.0`, update `CHANGELOG.md`, push.

**Verify.** `tools/privacy-scan.sh --history --allow ../betterpaper-private/known-history.txt` is clean (the allowlist holds only the lines accepted in D16); `git ls-files` shows no top-level `betterpaper/` tree and no `drafts/`, `reviews/`, `reviewer-notes/`, `anchors/`, `sources/`, `worksheets/`, `feedback/` or `_private/` path, and no `RUBRIC.md`, `STATE.md` or `SOURCES.md`, outside the init templates and `plugins/betterpaper/demo/`; every file under `evals/` fixtures carries the synthetic header; fresh install works from GitHub.

---

## Definition of done

- [ ] Plugin and marketplace validate; no D, R or A codes in shipped files; no Bash in any agent.
- [ ] `init`, `grade` and `proof-note` work from a fresh install, including the bundled demo.
- [ ] Five subagents return the fixed format; the cited-span check removes any draft excerpt not in the draft.
- [ ] Six scripts and `eval_metrics.py` pass their unit tests; every planted-defect row is detected and every negative control stays uncapped.
- [ ] The blind calibration test passes (Phase 7); the gold-set evals have run once on the private set (at least 10 drafts, target 20) and aggregate results are recorded.
- [ ] `tools/privacy-scan.sh` is clean on the tree, the pushed range and (with the allowlist) the history; no private drafts, reviews, state or denylist in the public repo.
- [ ] README explains install, usage, privacy, the evidence with its caveats, and the Known limits.

## Known limits (state them in the README)

1. Calibration rests on one published study of US school essays (a relative QWK gain of about 26% from two worked examples per score level). No published test covers graduate humanities writing or successive drafts by one author; treat it as direction, not forecast.
2. Until a gold-set evaluation is run and published, grades have not been validated against human graders on philosophy or critical-theory drafts.
3. Grades near the top are least reliable: in the one study that measured it, exact agreement on the second-highest band was about 31% (26 essays) and models tended to under-score strong essays. A-range grades are provisional; the error may run in either direction.
4. Even in other bands, exact-grade agreement in published studies is modest (roughly one-third to just over half), and human markers disagree with each other. A grade is an estimate, not a verdict.
5. Published graders marked down grammar errors, informal register and non-native phrasing even when told not to, and were swayed by one hidden instruction. betterpaper cannot promise immunity; non-native writers and unconventional registers are the highest-risk cases.
6. Whether a grader is too lenient or too strict varies by model, prompt and task; the default severity setting has not been tested.
7. The five-reviewer panel has not been shown to grade more accurately than a single grader; it gives focused diagnosis per criterion and costs more than quick mode.
8. The overall grade is a weighted average with editable, equal-by-default weights: a design choice for transparency, not a measured accuracy gain over a holistic grade.
9. The quotation-integrity cap and the two-grade display are untested; the one study with capping rules found they probably pulled strong essays down. Unverified or unreachable quotations never trigger it.
10. Quotations are checked only against originals the tool can reach; "unverified" means not checked, not wrong; text extracted from PDFs or scans can contain artefacts that look like errors.
11. Repeated runs may give different grades; the confidence note is a flag built from observable signals, not a calibrated probability.
12. No study shows that diagnosis-without-rewriting feedback improves the next draft.
13. The order of "what to fix first" is a judgement call; in one study human experts agreed on the urgency tier of a comment only about 38% of the time.
14. There is no human reviewer in the loop; published tools that pair a model with an instructor saw the instructor override a substantial share of the model's judgments.
15. Anchors drawn from earlier drafts of the same essay may pull scores toward the earlier grade (untested); Structure is uncalibrated.
16. Theory-fiction and creative writing are out of scope. The tool reports wording overlaps and filler only; it does not detect AI authorship and must not claim to.
17. Style points still unconfirmed (two-edition A/B and academy-edition "Ak." numbering for modern classics, author-date handling of ancient works, newsletter posts as a named category, MLA translator-first entries) are flagged "check your style guide".
18. The closest published evidence on university essays is undergraduate: models compressed marks toward the middle, marked weak essays up and strong essays down, and rewarded length and vocabulary; nothing confirmed covers graduate humanities, and human markers in the humanities are themselves noisy.
19. Grades from different model versions are not on one scale: version changes shifted severity in a published audit. A model change breaks comparability with earlier grades and anchors until recalibrated.
20. A grader can be stable yet insensitive: small or zero grade changes between drafts may mean the revision was missed, and worse revisions may not be marked down. Small changes print as "no reliable change" unless criterion-level evidence supports them.
21. Reviewers from one model family are not independent checks: published panels carried only a few effective votes, so agreement among reviewers is not confirmation.
22. Several grades can be defensible for one essay; one human-confirmed grade is a noisy gold standard, and the confirmation step may itself be anchored on a grade the tool proposed.
23. If you revise with a model that has seen this report and are then re-graded by the same model family, the grade can rise without the writing improving. The grade is not a target.
24. How anchors are shown (grades visible, order, selection) and cues about an essay's source or AI assistance can move ratings; reviewers are not given authorship cues.
25. The integrity cap's false-positive rate on honest essays is unmeasured: an unmatched quotation can come from a different edition, a translation, an ellipsis or a conversion artefact, which is why those never trigger it.
26. Hidden or Unicode-control text can inject instructions into a grader and graders may not say so; the precheck flags such text but cannot promise immunity.
