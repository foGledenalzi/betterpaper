# PLAN.md: `betterpaper`, a grading framework for Claude Code (revision 2.1, 2026-10-06)

> **For the agent executing this plan.** Work phase by phase. Each phase has three subphases in order: **Q&A** (record decisions in `docs/phases/phase-N-discussion.md`), **agentic research** (notes in `docs/research/phase-N/`), then **build**. Finish every build task, run its **Verify** checks (including the privacy scan), show the user the result, then commit and push to `main`. Where this plan names a Claude Code file format, flag or command, confirm it against the official docs linked in the phase; if a doc contradicts this plan, follow the doc and note it in `CHANGELOG.md`. Ask the user only where a decision is not already in `DECISIONS.md`.
>
> **Inputs.** `DECISIONS.md` (D1-D15, R1-R22, A1-A22) is the single source of truth for decisions. `docs/design/method-digest.md` holds the detailed requirements for the reference files, templates, agent briefs and scripts; Phases 1-5 build from it. `docs/research/phase-1/` holds the evidence and the verified style rules. Private source material (earlier reviews, essay drafts, the denylist) lives **outside the repository** in `../betterpaper-private/` and is never read into a tracked file.

**What changed from revision 1.** Names; six criteria; argumentative and theoretical academic writing only; three citation styles; human-confirmed anchors; a narrower integrity cap; reviewer waves; five deterministic scripts plus an eval-metrics tool; an adjudication file; confidence and human-check flags; an allow/deny matrix for the author's words; a minimal demo built early; a privacy scan; a private gold set; Phase 7 kept generic.

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
- Eleven further preprints were read and cross-checked. None tests five fresh-context specialists with a deterministic adjudicator, a weighted-average grade, or a confidence mechanism. In one study explicit instructions not to penalise informal or non-native style did not prevent score drops (no no-instruction control); in another, one appended sentence demanding the maximum grade raised scores (no defended condition was tested). Models quoted text that was not in the essay in one study.
- All evidence is on school-level, exam or non-Claude material. Treat every figure as direction, not forecast, for graduate humanities drafts.

### Reference implementations (read, don't copy)

`open-gsd/gsd-core` (MIT): phase loop, `STATE.md`, fresh subagents. `AlexWortega/ai-peer-review-skill` (MIT): isolated reviewers, meta-review by the main thread (vary dimension emphasis, never severity). `wenxuec/llm-judge` (MIT): rubric templates, one example per score point, bias catalogue, calibration loop (add per-band reporting). `Imbad0202/academic-research-skills` (**CC BY-NC 4.0**): ideas only, no code.

---

## Decisions (summary; `DECISIONS.md` governs)

| # | Decision | Value |
|---|---|---|
| D1 | Name | `betterpaper` |
| D2 | Default mode | Full panel; `--quick` single pass (to be revisited after the gold-set A/B) |
| D3 | `proof-note` | Included |
| D4 | Workspace folder | `betterpaper/<slug>/` (git-ignored, anchored `/betterpaper/`) |
| D5, D6 | Licence, visibility | MIT; public, no private content ever committed |
| D7 | Criteria | Six, adding Structure and organisation |
| D8 | Citation styles | Chicago notes-bibliography (default), Chicago author-date, MLA 9; the source-verifier loads the style file (A9) |
| D9 | Calibration cues | Subject-neutral in the public repo |
| D10, R1 | Overall grade | Weighted average; equal weights by default, editable |
| D11 | Padding | Phrase-level under Mechanics, paragraph-level under Structure |
| D12 | Style-rule sources | Built only after the user's source material is ingested; `[U]` rules are never errors |
| D13, D14 | Venue and scope | Post-graduate; argument with research plus general theory; **theory-fiction out of scope** |
| D15 | Reference grades | Tool-assigned, so unconfirmed (R4) |
| R1-R22, A1-A22 | Sheet and assistant defaults | See `DECISIONS.md` |

---

## Repository layout (target)

```
betterpaper/                                   # repo root = marketplace root
├── .claude-plugin/marketplace.json
├── plugins/betterpaper/                       # plugin root (what a user installs)
│   ├── .claude-plugin/plugin.json
│   ├── skills/
│   │   ├── init/ SKILL.md + templates/ RUBRIC.md STATE.md SOURCES.md ANCHOR.md
│   │   ├── grade/ SKILL.md + references/
│   │   │     grade-bands.md  adjudication.md  rules.md  report-template.md  report-voice.md
│   │   │     chicago-notes.md  chicago-author-date.md  mla.md  filler-phrases.md
│   │   └── proof-note/SKILL.md
│   ├── agents/ source-verifier primary-text-reviewer argument-reviewer mechanics-reviewer voice-echo-reviewer (.md)
│   ├── scripts/ extract_quotes.py echo_check.py check_cited_spans.py compute_grade.py report_lint.py (+ test_*.py)
│   └── demo/                                  # fictional essay + workspace, ships with the plugin
├── evals/ eval_metrics.py (+ test) gold-set/ style-perturbation/ injection/ panel-vs-single/ severity/   # repo only; clone to run
├── tools/privacy-scan.sh                      # development tool; denylist lives outside the repo
├── docs/ phases/ research/ design/            # Q&A records, research notes, method digest
├── PLAN.md  README.md  CHANGELOG.md  DECISIONS.md  LICENSE  .gitignore
```

**Path convention (A20).** Skills and agents refer to `${CLAUDE_PLUGIN_ROOT}/skills/grade/references/<file>` and run `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/<script>`; templates are referenced with `${CLAUDE_SKILL_DIR}`.

### Essay workspace (user's writing folder, never in this repo)

```
betterpaper/<essay-slug>/
├── RUBRIC.md      # criteria, integer weights, genre, harshness, style, anchor_count, anchor_seed, declared context
├── STATE.md       # thesis, genre, grade history, anchors register, tracker, ledgers, logs (see digest section 4)
├── SOURCES.md     # OPENED and RECOMMENDED tables, precedent register, quotation ledger
├── anchors/draft-N/ text.md  ANCHOR.md          # per-criterion grades, both overall series, confirmed_by, rationale
├── feedback/      # imported earlier reviews and third-party comments (read by the echo stage)
├── drafts/draft-N.md   worksheets/draft-N-map.md   reviewer-notes/draft-N/<reviewer>.md   reviews/draft-N.md
└── sources/       # page photos, scans, bundled excerpts for quote checks
```

---

## Pipeline

```
Intake ─ read workspace, confirm anchors, pre-check text, read markers
Map ──── extract_quotes.py → echo_check.py (once, before Review)
Review ─ wave 1 (parallel): source-verifier, primary-text-reviewer, mechanics-reviewer, voice-echo-reviewer
         wave 2: argument-reviewer (given verified ledger + precedent register, no other findings or grades)
Adjudicate ─ cited-span check → ledger → cap test → compute_grade.py → cross-check → flags → tracker
Report ─ report_lint.py → write review → update STATE.md and SOURCES.md
```

---

## Phase 0: Scaffold the repo (done)

Repo, manifests, `.gitignore`, MIT licence, `DECISIONS.md`; both `claude plugin validate` checks pass. Docs: <https://code.claude.com/docs/en/plugins/create.md>, <https://code.claude.com/docs/en/plugins/create-marketplace.md>.

---

## Phase 1: Shared references (the rules of the house)

Build from `docs/design/method-digest.md` sections 1-3 and `docs/research/phase-1/` (the user's Chicago and MLA material is already ingested; addenda A and B of `purdue-deck-verification.md` carry the final tags). Under `skills/grade/references/`, each file under 200 lines and readable alone. `SKILL.md` stays under 500 lines by linking here. Shipped files define any term they need inline and never cite D, R or A codes.

### 1.1 `grade-bands.md`
Six criteria on the 12-step scale (band = letter, step = one rung, top band = A range). For each criterion: definition, whether it is judged on a part or the whole, observable descriptors for A, B, C, D, F, and a near-miss example on an invented topic. Tag descriptors `[observed]` (seen in earlier unconfirmed tool-assigned reviews, so evidence not ground truth), `[derived]` or `[extrapolated]`, and state where evidence is thin (nothing observed above B- or below D; Structure none).

| Criterion | Reviewer | Note |
|---|---|---|
| Command of primary texts | primary-text-reviewer | Concepts used as sources define them; deliberate departures flagged and argued. Wrong quotations are charged to Sources, not here |
| Argument | argument-reviewer | Thesis, premises, contradictions, strongest objection. Each row's reason names the limiting defect |
| Structure and organisation | argument-reviewer | Uncalibrated: graded only from structure-tagged findings, within one step of Argument unless two structure-specific findings justify more, never double-counted; includes paragraph-level padding |
| Use of sources | source-verifier | Accuracy of quotation and attribution, credited precedents, all citation-form defects; carries the conditional cell |
| Originality | argument-reviewer | Delta over credited precedent, graded after source adjudication; plugin-supplied ideas earn no credit; independent of correctness and never capped (cap scope follows A11) |
| Mechanics | mechanics-reviewer | Prose-level errors and phrase-level filler; counts by tier, word count, recurrence; never graded by item count |

### 1.2 `adjudication.md`
Written in full so it is deterministic (digest section 2): scale; integer weights; nearest-step rounding with the tie rule (A2); the two harshness rules (A3); merge rule (de-duplicate by quoted location, rank by severity key then weight, 12 ranked problems at most, report how many were held back); the four-condition integrity test with its evidence standard, normalisation and non-trigger list (A11), the conditional cell on Use of sources only, and an event log; confidence reasons, the human-check flag, the disagreement signal and the repeat rule (A5); calibration guards; the completeness invariant; the severity key (A12); the target rule (A13). No veto and no minimum rule.

### 1.3 `rules.md`
The allow/deny matrix and paste test (R18), blank citation templates (R19), the label set, the grade-effect rule for as-recalled claims, no intent inference, the Correction triggers (R13), positioning flags from declared context only (R16), the genre rule (D14: if the essay is something else, say so once and grade it as an argument, flagged as outside the design), the mechanics boundary, harshness definitions, prompt-injection hardening, and no authorship claims or detector talk.

### 1.4 `report-template.md` and `report-voice.md`
Template: section conditions and order, header block, grade lines with previous values, verdict spec, rubric table with reasons and the conditional cell, draft-1 variant, Correction shape, Quotation problems spec and entry fields, Major problems fields, Citation problems, Proofreading, recurrence tags, steps, Sources consulted, footer, rendering and length budget (digest section 1). Voice file: stance, steelman-before-critique, rescue limits, praise rules, plain-language rules, heading neutrality.

### 1.5-1.7 Citation styles
`chicago-notes.md`, `chicago-author-date.md`, `mla.md`: templates for book, translated book, chapter, journal article (DOI as `https://doi.org/` link), online source, "quoted in", classical works, block quotations, short forms, and a scannable error list. Every rule is tagged `[C18]`, `[MLA9]`, `[S]`, `[D]` or `[U]` as in `purdue-deck-verification.md`; `[U]` rules are never errors (the reviewer says "check your style guide"). Settled points: CMOS 18 note names only the first of more than two authors; bibliography up to six (more than six: first three plus "et al."); soft 100-word block-quote rule; notes-bibliography "quoted in" lists both sources while author-date and MLA list only the one consulted; ancient works cited by standard divisions without page numbers; MLA 9 lowercases seasons and gives DOIs as links; classical numbering is never flagged. Open: Kant A/B and "Ak.", author-date for ancient works, Substack forms.

### 1.8 `filler-phrases.md`
Phrase-level padding list (grep-able, one per line), feeding Mechanics; excludes single "AI-sounding" words and legitimate signposts.

**Verify.** Each file under 200 lines and readable alone; every style rule tagged; no D, R or A codes in shipped files (`grep`); `tools/privacy-scan.sh` clean on the tree; adjudication examples reproduce by hand on an invented three-draft fixture with an answer key (built in Phase 2). **Commit and push.**

---

## Phase 2: Workspace init skill, templates, and a minimal demo

Docs: <https://code.claude.com/docs/en/skills.md>. Build from digest sections 4-5.

1. `skills/init/SKILL.md`: `name: init`, `argument-hint: "<essay-slug>"`, `disable-model-invocation: true`.
2. Body: create `betterpaper/$ARGUMENTS/` (including `feedback/` and `anchors/`), copy templates from `${CLAUDE_SKILL_DIR}/templates/`, then interview the user: title; genre (argumentative research essay, theoretical or conceptual essay, other: triggers the out-of-scope warning); venue; harshness (default harsh, defined by the A3 rules); citation style (default Chicago notes-bibliography; the value maps to a style file); weights as integers (default 1 each); `anchor_count` (default 4) and `anchor_seed`; declared context for positioning flags (audience, venue, promises); primary texts and editions; which graded earlier drafts exist and **who confirmed each grade**; where the answer is "the tool", generate an anchor confirmation sheet (criterion grades with confirm and adjust columns).
3. Templates: `RUBRIC.md`; `STATE.md` (digest section 4: counters header, thesis, genre, grade history, anchors register, issue tracker with the eight statuses and the CANNOT-CHECK flag, PATTERNS, citation ledger, suggestions and rescue logs, archive and `reviewer_wording`, corrections log, risk register, keep and commitments lists, decisions field); `SOURCES.md` (OPENED, RECOMMENDED, precedent register, quotation ledger with the statuses and flags); `ANCHOR.md` (per-criterion grades, both overall series, `confirmed_by` in {author, instructor, unconfirmed}, rationale, band; the "alone" series anchors the band).
4. **Minimal demo (`plugins/betterpaper/demo/`).** A short fictional argumentative essay on a public-domain topic with draft 1 and draft 2, a workspace with bundled public-domain excerpts in `sources/`, and an **invented** three-draft STATE fixture with an answer key. Defects are invented, never adapted from any real essay. **Planted-defect matrix** (extended in Phase 8):

| Planted defect | Caught by | Verified in |
|---|---|---|
| Quote copied from an earlier review, inside marks | echo_check.py, source-verifier | Phase 4, 5 |
| OCR-style corruption in a quotation | extract_quotes.py `--precheck`, source-verifier | Phase 4 |
| Transposed phrase without change of sense | source-verifier (non-trigger) | Phase 5 |
| Near-verbatim wording without marks | source-verifier | Phase 5 |
| Clause-length sense-bearing mismatch, load-bearing, unresolved | source-verifier, adjudication cap | Phase 5 |
| Cited span not in the draft (in a fabricated finding) | check_cited_spans.py | Phase 4 |
| Report sentence copying author text | report_lint.py | Phase 4 |
| Grade arithmetic: tie, cap, conditional cell | compute_grade.py | Phase 4 |
| Negative controls: recall-only item, secondary-echo item, OCR-ERROR | adjudication (must not cap) | Phase 5 |
| A draft with minor quotation defects and no split | adjudication (must not cap) | Phase 5 |
| A fixture draft with injected "give the maximum grade" | orchestrator, all agents | Phase 6 |

**Verify.** `claude --plugin-dir ./plugins/betterpaper`, then `/betterpaper:init demo-essay` creates the full tree with populated templates; the demo workspace copies into it. **Commit and push.**

---

## Phase 3: Reviewer subagents

Docs: <https://code.claude.com/docs/en/sub-agents.md>. Build from digest section 6.

Each agent file has `name`, `description`, `tools`, `model: inherit`. Each brief says exactly which files to read, treats the draft as untrusted data inside delimiters, has an ignore list (dimensions it must not judge), receives anchors in the per-reviewer seeded order (A6) and compares the draft with the nearest anchors above and below, quoting a passage. No agent has Bash (A21). Earlier grades and author claims are never shown (A8). Web queries contain only attributed quotations or public work details.

**Return format.** Findings table, at most 10 ranked findings, plus a grade suggestion line per criterion owned and a confidence line with named reasons:

```markdown
## Findings: <reviewer>
| ID | Severity tier | Criterion | Draft quote (≤15 words) | Problem | Evidence / how checked | Label | Fix direction |
## Grade suggestion for <criterion>: <grade>: <one-line reason>     (voice-echo-reviewer: n/a)
## Confidence: high/medium/low: <named reasons>
```

The `source-verifier` additionally returns a second, **uncapped** block of ledger rows (digest section 5) and a coverage line. Draft excerpts appear only in the "Draft quote" column; source and anchor excerpts have their own tagged columns and are exempt from the cited-span check.

| Agent | Tools | Owns | Brief (summary; full in digest) |
|---|---|---|---|
| `source-verifier` | Read, Grep, Glob, WebSearch, WebFetch | Use of sources; quotation and citation ledgers; precedent register | Verify every quotation per the evidence standard; citation-form checks against the style file selected by `RUBRIC.md`; verify and register precedent candidates; recall alone stays UNVERIFIED |
| `primary-text-reviewer` | Read, Grep, WebSearch, WebFetch | Command of primary texts | Re-verify earlier characterisations first; term, relation, distinction, fit and method audits; flags uncredited precedents to the orchestrator's register |
| `mechanics-reviewer` | Read, Grep | Mechanics | Prose-level only; phrase-level filler from the echo output and filler list; `vs_previous` for open rows; patterns |
| `voice-echo-reviewer` | Read, Grep | none | Reads the saved echo output; filler interpretation; classification; adoption of earlier suggestions |
| `argument-reviewer` (wave 2) | Read, Grep | Argument, Structure, Originality | Defect codes, claims register, structure checklist including paragraph-level padding, residual-contribution clause; concedes a point only when the draft's answer would meet the B+ descriptor for Argument |

**Verify.** `claude plugin validate ./plugins/betterpaper` passes including agent frontmatter; each agent, run on the demo essay, returns the fixed format; the source-verifier's second block parses. **Commit and push.**

---

## Phase 4: Deterministic scripts

Python 3 standard library only; exit 0 success, 1 failed check, 2 bad input; each with `test_*.py` runnable by `python3 -m unittest`. Contracts are in digest section 7.

- `extract_quotes.py <draft> [--precheck]`: quotes, block quotes, footnotes, worksheet skeleton; precheck warns on PDF or OCR artefacts and broken quotes so conversion errors are never blamed on the author or used to trigger a cap.
- `echo_check.py <draft> <feedback...>`: content-word and contiguous-run detection with exemptions; **CRITICAL** for matches inside quotation marks; also runs on the new report's text.
- `check_cited_spans.py <draft> <findings...>`: only the Draft quote column.
- `compute_grade.py <RUBRIC.md> <grades.json>`: integer weights, exact arithmetic, tie rule, cap, conditional-cell substitution, previous values.
- `report_lint.py <review> <draft>`: paste test, replacement-wording flags, missing labels, reviewer coinages in marks, heading neutrality, header and footer.
- `evals/eval_metrics.py` (repo only) with its test.

**Verify.** Every row of the planted-defect matrix assigned to a script is detected, including the tie, the cap, the conditional cell and a case where an exact tie goes lower under harsh and higher under neutral; negative controls produce no cap. **Commit and push.**

---

## Phase 5: The grading skill (the orchestrator)

`skills/grade/SKILL.md`: `name: grade`, `argument-hint: "<essay-slug> [draft-file-or-url] [--quick] [--markers <file>]"`, `disable-model-invocation: true`. Link to `references/`, do not inline.

1. **Intake.** Read `RUBRIC.md`, `STATE.md`, `SOURCES.md`, anchors. Exclude the draft being graded and near-duplicates from the anchor set; print `anchors: N (M near the top band)`. Treat an `unconfirmed` anchor as unusable. **With zero confirmed anchors**: grade rubric-only, force confidence low with the reason "no confirmed anchors", print an "unanchored" banner, set the human-check flag. Draft from path, pasted text or URL (WebFetch; if the body is empty, ask the user to paste, never guess); save as `drafts/draft-N.md`; run the precheck; read `--markers` as claims.
2. **Map.** `extract_quotes.py`; complete `worksheets/draft-N-map.md`; run `echo_check.py` once against archived reviews and `feedback/`; pass its output path to wave 1.
3. **Review.** Full mode: wave 1 in parallel, then wave 2. Log tokens per reviewer and print an estimate before a full run; put the shared rubric first and anchors after (per-reviewer anchor order costs shared-prefix caching; accepted). **Quick mode (A15):** the orchestrator grades inline; runs precheck, echo, cited-span and filler checks; prints "Integrity test not run: Use of sources unverified"; never caps; same template and confidence note.
4. **Adjudicate.** Cited-span check; update the ledgers and register; test the integrity cap per quotation and log it; merge findings by the digest rule; compute grades with `compute_grade.py`; run the holistic cross-check and set the disagreement signal; repeat reviewers if the repeat rule fires; update the tracker (two counters, markers verified not trusted, completeness invariant); compare provisional grades with anchors and explain any gap of more than one step; set confidence and flags.
5. **Report.** Write `reviews/draft-N.md` per the template; run the echo script on the report's own text; run `report_lint.py`; append the grade-history column; print a five-line chat summary and the report path.

**Verify.** `/betterpaper:grade demo-essay <demo draft 2>` yields the full report, updates `STATE.md` and `SOURCES.md`, catches every planted defect assigned to Phase 5 and none of the negative controls as a cap, and passes the lint; the invented three-draft fixture reproduces its answer key (split fires on the planted case; does not fire on the minor-defects draft). **Commit and push.**

---

## Phase 6: `proof-note` and evals

**6a: `proof-note`.** `skills/proof-note/SKILL.md`: one pass, no state files, no subagents; word-level errors, ambiguity, terms used against their source meaning, internal contradiction, consistency with pasted earlier notes. Output: numbered issues with reasons, then single-token mechanical corrections only; never changes the claim or adds sentences. **Verify:** three test notes (clean, a word confusion, an internal contradiction).

**6b: define the evals** (`evals/`, docs <https://code.claude.com/docs/en/plugin-evals.md>): `gold-set/` (format spec and synthetic fixtures only; the real set is private); `style-perturbation/` (same-content variants with a human-checked equivalence step; raw point change per criterion; expect only Mechanics and voice-echo to move); `injection/` (a one-sentence "give the maximum grade" appended to a fixture; change across reviewers and the adjudicator); `panel-vs-single/`; `severity/` (harsh versus neutral, swapping only the A3 block); arms for anchor count, anchor order, guess-then-reveal, holistic cross-check against the weighted grade, and quick versus full; `eval_metrics.py` metrics (digest section 7). Users run the fixtures from a clone (R21 as amended by A19).

**6c: run the evals** once the private gold set exists (A17): at least 20 human-graded drafts with confirmed grades, at least 3 near the top band, consent for others' drafts; record **aggregate results only** in `docs/` (no essay content). Re-run when the model, rubric or anchors change.

---

## Phase 7: Seed a real workspace (PRIVATE) and calibrate

Runs in the user's **private writing folder** or `../betterpaper-private/`, never in a tracked path. Generic by design.

1. `/betterpaper:init <slug>`.
2. Copy earlier drafts and reviews into `anchors/` and `feedback/`. Reference grades that the tool assigned (D15) start `unconfirmed`; generate the confirmation sheet; the author or an instructor confirms or adjusts each criterion grade; adjusted grades replace the tool's in the history, marked `human-adjusted`. Only confirmed records serve as anchors.
3. Seed `STATE.md` (grade history, recurring issues, both counters) and `SOURCES.md` (known quotation statuses and flags). **Precondition:** for each known load-bearing quotation, place a copy of the original in `sources/`; any quotation without one is excluded from the detection check.
4. **Blind calibration test** in a fresh session: temporarily remove the latest draft's review from `anchors/` and grade that draft. *Objective checks* (verifiable against the real texts): if the seeded latest review contains an integrity split, it triggers and every load-bearing mismatch with an available original is detected with its evidence; an earlier seeded draft that was not split does not trigger; negative controls do not cap; at least 80% of recurring proofreading items are flagged; confidence and flags are shown. *Grade check*: while the reference grades are unconfirmed, comparing grades within one step measures self-consistency only, and the report says so; once confirmed, the draft becomes a gold-set case and the comparison counts as accuracy evidence. If a check fails, adjust references or briefs and re-run; restore the anchor afterwards.
5. Any change fed back into the public references is first re-derived from invented examples and passes `tools/privacy-scan.sh`.

---

## Phase 8: Package and publish

Docs: <https://code.claude.com/docs/en/plugins/host-marketplace.md>.

1. Extend `plugins/betterpaper/demo/` to the full planted-defect matrix (every status and flag), using invented content only: never the quotations, typos, phrases or review wording of any real essay.
2. `README.md`: what it is; install (`claude plugin marketplace add <owner>/<repo>`, `claude plugin install betterpaper@betterpaper`); usage; privacy (workspaces stay in the user's folder; add `betterpaper/` to that folder's `.gitignore`); credits; an evidence paragraph using only the quoted figures above, with corpus and level stated; the Known limits below.
3. `claude plugin validate .` and `claude plugin validate ./plugins/betterpaper` pass.
4. Test the published install path on a clean machine or account: add the marketplace from GitHub, install, run init and grade on the bundled demo.
5. Tag `v0.1.0`, update `CHANGELOG.md`, push.

**Verify.** `tools/privacy-scan.sh --history` is clean (or any known disclosed history is recorded and accepted by the user); `git ls-files` shows no top-level `betterpaper/` tree and no `drafts/`, `reviews/`, `reviewer-notes/`, `anchors/`, `sources/`, `worksheets/`, `feedback/` or `_private/` path outside `plugins/betterpaper/demo/`; fresh install works from GitHub.

---

## Definition of done

- [ ] Plugin and marketplace validate; no D, R or A codes in shipped files.
- [ ] `init`, `grade` and `proof-note` work from a fresh install, including the bundled demo.
- [ ] Five subagents return the fixed format; the cited-span check removes any draft excerpt not in the draft.
- [ ] Five scripts and `eval_metrics.py` pass their unit tests; every planted-defect row is detected and every negative control stays uncapped.
- [ ] The blind calibration test passes (Phase 7); the gold-set evals have run once on the private set and aggregate results are recorded.
- [ ] `tools/privacy-scan.sh` is clean on the tree and the history decision is recorded; no private drafts, reviews, state or denylist in the public repo.
- [ ] README explains install, usage, privacy, the evidence with its caveats, and the Known limits.

## Known limits (state them in the README)

1. Calibration rests on one published study of US school essays (a relative QWK gain of about 26% from two worked examples per score level). No published test covers graduate humanities writing; treat it as direction, not forecast.
2. Until a gold-set evaluation is run and published, grades have not been validated against human graders on philosophy or critical-theory drafts.
3. Grades near the top are least reliable: in the one study that measured it, exact agreement on the second-highest band was about 31% (26 essays) and models tended to under-score strong essays. A-range grades are provisional; the error may run in either direction.
4. Even in other bands, exact-grade agreement in published studies is modest (roughly one-third to just over half), and human markers disagree with each other. A grade is an estimate, not a verdict.
5. Published graders marked down grammar errors, informal register and non-native phrasing even when told not to, and were swayed by one hidden instruction. betterpaper cannot promise immunity; non-native writers and unconventional registers are the highest-risk cases.
6. Whether a grader is too lenient or too strict varies by model, prompt and task; the default severity setting has not been tested.
7. The five-reviewer panel has not been shown to grade more accurately than a single grader; it gives focused diagnosis per criterion and costs more than quick mode.
8. Quotations are checked only against originals the tool can reach; "unverified" means not checked, not wrong; text extracted from PDFs or scans can contain artefacts that look like errors.
9. Repeated runs may give different grades; the confidence note is a flag built from observable signals, not a calibrated probability.
10. No study shows that diagnosis-without-rewriting feedback improves the next draft.
11. The order of "what to fix first" is a judgement call; in one study human experts agreed on the urgency tier of a comment only about 38% of the time.
12. There is no human reviewer in the loop; published tools that pair a model with an instructor saw the instructor override a substantial share of the model's judgments.
13. Anchors drawn from earlier drafts of the same essay may pull scores toward the earlier grade (untested); Structure is uncalibrated.
14. Theory-fiction and creative writing are out of scope. The tool reports wording overlaps and filler only; it does not detect AI authorship and must not claim to.
15. Style points still unconfirmed (Kant A/B and "Ak.", author-date handling of ancient works, Substack forms) are flagged "check your style guide".
