# LLM grading evidence: claim check and design patterns (Phase 1)

Date: 2026-10-06. Scope: verify what the plan cites about arXiv:2601.22386, and extract patterns
from two MIT-licensed skill repos.

## Read this first: provenance

- **Paper: now read in full.** The research agent could not open arxiv.org (proxy block) and
  worked from an abstract relay. The user then supplied the PDF (arXiv:2601.22386v1, 12 pages)
  and it was read directly on 2026-10-06. The Claim check below is corrected from the paper's
  own tables and text, and cites sections, tables and pages.
- Repo findings come from WebFetch summaries of the GitHub pages (a small model condensed each
  page), not from raw files. Treat thresholds and counts as "reported by the summary".
- The "Extra findings" section is still search-relay leads only and is unverified.

## Claim check (against the paper)

| Claim in the plan | Verdict | Real figure | Source and location |
|---|---|---|---|
| Graded examples improve agreement with human graders by about 26% | CONFIRMED, as a relative gain in QWK | Single-agent QWK 0.5664 to 0.7165 (+26.5%); multi-agent 0.5917 to 0.7453 (+25.96%). Two examples per score level, 12 in total. Exact-match accuracy rose 4.89 points (single) and 9.55 points (multi). | Table 1; section 4 (p. 5); section 4.2 (pp. 7-8) |
| ...more than any other change | CONFIRMED, but only against the other lever tested | The paper says few-shot has "the greatest impact" and calls it the dominant factor. The only other factor varied was architecture: best multi-agent versus best single-agent differed by 2.88 QWK points (0.7453 vs 0.7165), about 4% relative. The authors did not vary the number or choice of examples. | Section 4 (p. 5); section 4.3 (p. 8); section 5.3 (p. 10) |
| Top-band accuracy is around 30% | CONFIRMED for the second-highest band only, with a small sample | Score 5 (n=26): exact match 30.8% for both few-shot setups, versus 7.7% (single, zero-shot) and 11.5% (multi, zero-shot). Score 6 (n=3): 33.3% with few-shot, 0% zero-shot; the authors say this is statistically insufficient. | Table 2; section 4.1.3 (p. 7) |

Wording to use in the README: "In one published study (Idowu & Almasoud, 2026), giving the
grader two worked examples per score level raised agreement with human graders by about 26%
(relative QWK). The same study found exact-match accuracy of about 31% on its second-highest
band, so treat A-range grades as provisional." Do not call 30% the top-band figure: the top
band had only three essays.

### What the study did

- **Data.** ASAP 2.0 (Crossley et al., 2025): US secondary-school students in grades 6-10 writing
  source-based argumentative essays. The test set was 450 essays (stratified sample); the
  calibration set was 12 separate essays, none overlapping the test set. Human scores run 1-6,
  using a rubric adapted from the SAT. Test counts per score level: 30, 120, 168, 103, 26, 3.
- **Model.** GPT-5.1 only, through the OpenAI API (section 3.2).
- **Conditions.** Single agent versus multi-agent, each zero-shot (rubric only) and few-shot
  (rubric plus calibration examples).
- **Multi-agent design.** Three specialists (Content, Structure, Language), each told by negative
  prompting to ignore the other dimensions, plus a Chairman who applies rule-based logic:
  a veto (any specialist scoring 1 forces a final 1) and a cap (any specialist scoring 2 caps the
  final at 2 or 3). It needs four calls per essay, so about 4x the cost (section 4.3).
- **Result pattern.** Multi-agent was much better on low-scoring essays (score 1: 73.3% versus
  46.7% exact match, few-shot; score 2: 65.8% versus 55.0%). Single-agent matched or beat it on
  mid-range essays (scores 3-4). Both did badly on high-scoring essays.
- **Bias at the top.** Both systems under-predicted: they often gave 3 or 4 to essays human raters
  marked 5 or 6 ("regression to the mean"). The authors say the Chairman's capping logic makes this
  worse, because a concern about one dimension can pull down the whole grade (section 4.1.3).
- **Stated limits (section 5.3).** Single dataset, school-level writers, one model; they did not
  vary the number or selection of examples; they did not test whether the specialist rationales
  are useful to students.

### Design consequences for betterpaper

- Keep the anchors: the example-based calibration effect is the best-supported lever here.
- The integrity rule (two grades when a quotation fails) is a veto-style cap. The paper warns
  caps can depress strong work, so apply the cap only for quotation integrity, never for a
  single mechanics or structure flaw, and show both grades.
- Treat A-range grades as provisional and say how many anchors sit near the top band.
- The Content/Structure/Language split, with each specialist told what to ignore, supports the
  reviewer split. Our adjudication should not be a simple minimum or cap.

## Patterns to adopt

Paraphrased from the repos. Nothing copied. Both are MIT: `wenxuec/llm-judge`, and
`AlexWortega/ai-peer-review-skill` (MIT covers the skill adaptation only; its README says the
upstream `poldrack/ai-peer-review` tool is unlicensed and only the design is referenced).

### From wenxuec/llm-judge (SKILL.md, templates/, docs/)

- **Rubric template.** Each criterion carries five things: a short definition, whether it is
  judged on a part or the whole piece, the scoring method, a concrete example for every score
  point, and the failure behaviours it is meant to catch. Offers four scales (binary, 3-point,
  5-point with defined anchors, continuous). For grade-bands.md, give every band a concrete
  behavioural anchor, not an adjective.
- **Aggregation choice made explicit.** Three modes: all criteria must pass (conjunctive), weighted
  average, or report-only with no total. For essays, consider conjunctive gates (for example no
  identifiable thesis caps the band) alongside weighted criteria. Put that choice in rules.md.
- **Judge prompt skeleton.** Role statement; definition of good and poor; an anchored scale;
  inputs; five working rules (reason before scoring, use only supplied information, ignore surface
  polish, use partial credit instead of defaulting to extremes, flag ambiguous cases); structured
  output holding a short rationale, the score, an ambiguity flag and quoted evidence. Recommends
  at least one worked example spanning the scale.
- **Bias catalogue and mitigations.**
  - Position: randomise order, or run twice reversed and count only agreement. Prefer pointwise
    scoring. For us the analogue is the order of anchor essays in the prompt (my inference).
  - Verbosity: explicit "do not reward length", record length next to each verdict, and calibrate
    on cases where the shorter piece is better. Highly relevant to essays.
  - Self-preference: use a different model family when judging model output, hide authorship.
    Relevant if drafts are AI-assisted and the grader is also an LLM.
  - Halo and format: strip or normalise formatting where substance matters.
  - Anchoring and framing: keep scale wording constant, use concrete examples instead of
    adjectives, recalibrate after any prompt edit.
  - Ordering: rationale before score, with cited evidence.
  - Midpoint drift when uncertain: track the "ambiguous" rate (reported target below ~10%).
  - Reference over-trust: present any reference as one acceptable answer, not the answer.
- **Calibration loop.** Hand-label 20-50 examples with the rubric, compare judge to human, and
  iterate on prompt or anchors until agreement is acceptable. Reported targets: Cohen's kappa
  above 0.6 for categorical, Spearman above 0.7 for ordinal (stated in both the SKILL summary and
  the calibrate.py summary). Re-run whenever the judge model or the rubric changes.
- **Gap to fill ourselves.** Their calibrate.py reportedly gives only aggregate agreement per
  criterion: no confusion matrix, no per-class breakdown, no disagreement listing. Given the
  top-band weakness above, we should report per-band results and list disagreements. For ordered
  bands, a weighted kappa is a better fit than plain kappa (standard practice, my inference).
- **Ensembling** (voting or score averaging across judges) is listed as a bias-reduction pattern,
  alongside pointwise, pairwise, reference-based and rubric-based judging.

### From AlexWortega/ai-peer-review-skill (SKILL.md, prompts/)

- **Independent parallel reviewers.** N separate `claude -p` processes launched concurrently, each
  unable to see the others, anonymised under codenames, launches staggered by a few seconds. This
  gives true isolation, which prompt-level "pretend you are three reviewers" does not.
- **Diversity by seeded lens and stance.** Each reviewer gets a lens (six options) and stance
  intensity (three options, including hostile) derived from a random seed. Good for finding
  flaws, risky for grading, because random hostility moves the grade. Adapt: keep one common
  rubric for all reviewers and vary only the dimension emphasis (content, structure, language),
  never the severity.
- **Reviewer output shape.** Overview; ranked major flaws each with location, impact and fix;
  minor issues; one categorical verdict. Grounding rules: quote only what is in the text, say
  when information is absent, never invent citations.
- **Anti-sycophancy clause.** Reviews that find no flaws in substantive work are declared failed.
  Useful against inflation, but for grading it biases downward. Replace with "list evidence for
  and against the band above and the band below".
- **Meta-review by the main thread, not a subagent.** It reads all saved reviews, keeps each
  verdict unaveraged, and explains which view carries more weight. A boolean concerns matrix
  (rows are major concerns, columns are reviewers) separates shared concerns (at least two
  reviewers) from unique ones, and reviewers are ranked by how serious the flaws they caught
  were. Output is one verdict plus JSON. For a grader we need a deterministic aggregate (for
  example median band plus spread), with adjudication triggered only when reviewers differ by a
  band or more. That rule is my design suggestion, not from the repo.
- **Panel size.** The repo contradicts itself: SKILL.md parameters say default 3 (range 3-8), the
  README says default 5 (range 3-8). Decide our own N and justify it.
- **Outputs worth copying in shape:** one file per reviewer, a meta-review, a CSV concerns table,
  and a JSON results bundle.

## Extra findings

All five are leads from web-search summaries only. I could not open any of these pages, and the
search summaries did not tie each number to one source, so verify before citing.

- LLM scores drift toward the middle: reported to inflate weak essays, deflate strong ones, and
  to track praise in the model's own feedback more than human raters do. Fits the paper's
  top-band weakness. Design: calibrate the top and bottom bands separately and flag extremes for
  human review. https://arxiv.org/pdf/2603.23714 ("LLMs Do Not Grade Essays Like Humans")
- Generalizability-theory study of AI and human raters on AP Chinese writing: humans were more
  reliable overall, and composite human-plus-AI scores improved reliability. Supports reporting a
  score range plus a human-check flag, not a single authoritative number.
  https://arxiv.org/pdf/2507.19980
- Higher-ed news coverage reports AI markers giving higher marks than humans, with one case 40
  marks off on a 100-mark essay. Anecdotal, so use it to motivate a leniency check, not as an
  effect size. https://www.timeshighereducation.com/node/744645 and
  https://www.cardiff.ac.uk/news/view/3072159-genai-cannot-accurately-mark-essays-in-higher-education
- Few-shot anchors help but not uniformly: one search summary cites QWK 0.306 zero-shot vs 0.531
  six-shot, while another says few-shot gains are modest and inconsistent across datasets and
  models. Source for the 0.306/0.531 pair not identified. Candidates:
  https://arxiv.org/html/2401.06431v1 and https://arxiv.org/html/2502.09497v1
- Run-to-run stability: a summary says over 80% of ratings were unchanged across three
  temperature-0 replications. Source unidentified. Design: still run repeats, and treat
  disagreement across runs as an uncertainty signal.

## Open uncertainties

1. Corpus fit: the paper itself says ASAP 2.0 is US secondary-school (grades 6-10) argumentative
   essays and that generalisability to other genres or populations is an open question (sections
   3.1 and 5.3). Transfer to humanities and philosophy drafts is untested, so treat 26% as a
   direction, not a forecast for this project.
2. "Greatest impact" rests on only two levers (architecture, few-shot), one model, and a
   12-essay calibration set. The study does not say which anchor selection, how many anchors,
   rubric wording or reviewer count matters most for us.
3. The score scale is 1-6 with exact-match accuracy, not letter grades with +/-. The "within one
   step" pass criterion in Phase 7 is looser than the paper's exact-match metric.
4. Repo summaries were condensed by a small model. The reviewer-count conflict shows they can be
   inconsistent. Re-read the raw prompt and template files before borrowing any threshold.
5. Neither repo validates its own bias mitigations on essays. They are good checklists, not
   evidence that each fix works for grading.
6. Cite 26% as a relative QWK gain from the paper's Table 1, and cite the ~31% figure only as
   score-5 exact match (n=26), never as "the top band".
