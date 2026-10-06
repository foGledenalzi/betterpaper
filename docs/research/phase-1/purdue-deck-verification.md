# Verification against the user-supplied style guides (Phase 1)

Date: 2026-10-06. Sources supplied by the user:
- "Chicago Manual of Style (18th Edition): Notes & Bibliography Formatting and Style Guide", Purdue OWL slide deck, 31 pages.
- "MLA 9th Edition Formatting and Style Guide", Purdue OWL slide deck, 46 pages.

Both were read in full (text extracted, every page). Wording below is paraphrased; the filled examples in the
build files will use invented generic data, not the decks' examples.

## How far to trust the decks

New tag **[D]** = stated or shown in one of these two decks. They are secondary: the Chicago deck says it draws on
Turabian 9th as well as CMOS 18, and neither deck is the Manual or the Handbook. Defects seen:
- The MLA deck labels the 9th edition "Update 2016"; its own figure caption says 2021, so some content is MLA 8-era.
- One MLA example entry misspells a title and a translator's name. Do not copy example entries.
- The MLA deck's poetry rule contradicts itself (three lines are both run in and blocked).
- Both decks write DOIs as `doi: 10...`, which conflicts with the `https://doi.org/` form in the earlier notes.
- The Chicago deck's note examples keep the place of publication; CMOS 18 only made it optional, so no conflict.

Rule of thumb for the build: where a deck agrees with an earlier `[S]` note, treat the item as stronger; where they
disagree, treat it as CONFLICT and do not let the reviewer flag it as an error.

## Items settled or strengthened

| # | Item (earlier status) | After the decks | Reviewer policy |
|---|---|---|---|
| 1 | Original year in a translated work's note (U) | **Example-confirmed [D]**: a note for a translated essay shows the pattern (original year; repr., place: publisher, reprint year), with "trans." and the translator after the author | Accept present or absent; never flag |
| 2 | Cite the translation actually read (U, rule sentence) | Examples consistent [D] (translator named, reprint edition, page from that edition). No explicit rule sentence in the deck | Keep the check "translated work with no translator named"; mark as practice, not a quoted rule |
| 3 | Bare page number in notes, no "p." (U) | **Example-confirmed [D]** (notes end `, 30.` and `, 41.`) | Flag "p." / "pp." in notes as minor |
| 4 | Page-range elision, e.g. 354-69 (U, unchanged in 18th) | **Example-consistent [D]** in a note; not a rule statement; the deck is Turabian-influenced | Flag only inconsistent ranges within one essay |
| 5 | Note number after punctuation except a dash; footnotes preferred (S) | **Confirmed [D]** | Keep |
| 6 | Short note = author + shortened title (S) | **Confirmed [D]**; deck never mentions ibid. | Keep; ibid. remains optional |
| 7 | Access date only when no publication date; "n.d." (U for CMOS 17, S for 18) | **Confirmed [D]** | Keep |
| 8 | MLA: translator placement, author-first entry (S) | **Confirmed [D]** ("Translated by" after the title, before the publisher) | Keep |
| 9 | MLA: original publication year as an optional element (S) | **Confirmed [D]** (year after the source title) | Accept present or absent |
| 10 | MLA in-text: initial for same surnames; "et al." for 3+; short title for same author; no page means author only; "qtd. in" (S) | **All confirmed [D]** | Keep |
| 11 | MLA block quote threshold: more than four lines of prose (S) | **Confirmed [D]** | Flag only clear misses |
| 12 | MLA month abbreviations (U) | **Mostly example-confirmed [D]**: Jan., Feb., Mar., Apr., Dec. abbreviated; May and July in full. June and Aug.-Nov. not shown | Flag only a clearly inconsistent mix |
| 13 | MLA page ranges (U) | **Example-consistent [D]**: 153-68, 69-88, 74-94, 193-200 (hundreds digit kept only when it changes) | Flag only inconsistent forms |
| 14 | MLA URLs without "https://" (S) | **Consistent [D]** | Minor only |

## New conflicts (earlier note vs deck): do not hard-fail

| # | Item | Earlier note [S] | Deck [D] | Policy |
|---|---|---|---|---|
| C1 | Chicago authors in a note | at most 2 named; more than 2 means first + "et al." | 2-3 named; 4+ means first + "et al." | Flag only 4+ authors all named in a note, or an inconsistent mix |
| C2 | Chicago authors in the bibliography | up to 6; more than 6 means first 3 + "et al." | 4-10 authors: first six listed | Flag nothing about counts above 6; flag only inconsistency |
| C3 | DOI form (Chicago and MLA) | full `https://doi.org/...` link; "DOI:" label is an error | `doi: 10...` prefix | Accept both; at most a minor note suggesting the link form |
| C4 | Chicago block quote | about 100 words (CMOS 17 wording, S); 5+ lines is a Turabian heuristic | 5 or more lines | Flag only a run-in quote over about 100 words or a block under about 40 words |
| C5 | MLA poetry block threshold | background only (U) | self-contradictory | Do not flag |

## New item from the Chicago deck (unverified beyond the deck)

The deck lists changes in the 18th edition that matter for the Mechanics reviewer, with the section numbers it gives:
a complete sentence after a colon now starts with a capital (6.67); "wk." as an abbreviation of week (10.76);
words from other languages used as part of a multilingual author's vocabulary need not be italicised (11.4);
time-zone names are not capitalised (8.91). Policy: check **consistency** only. Do not call either capitalisation
after a colon an error. Tag [D], section numbers unverified.

## Still unconfirmed (no deck coverage)

1. MLA and Chicago author-date handling of Plato (Stephanus), Aristotle (Bekker) and Kant (A/B) numbering. The MLA
   deck shows only a Bible in-text pattern (version, book, chapter:verse) and a multivolume pattern, which support
   "cite standard divisions" in general. Policy stays: never flag standard classical numbering.
2. Chicago author-date: parenthetical form for classical works and whether the reference list needs an entry.
3. MLA translator-first entry wording (the decks show only the author-first form).
4. Substack short and bibliography forms; whether "quoted in" lists both sources in the bibliography.
5. CMOS section and threshold for abbreviating frequently cited works; ATP vs TP; whether abbreviations are italic.
6. "Ak." prefix convention and "edited and translated by" wording.
7. CMOS 17 author-list limits; the current CMOS 18 block-quote wording.

None of these changes the Phase 1 build: each stays `[U]` and the reviewer treats it as "check your style guide".

---

# Addendum A: Douglas College Library "MLA 9th Edition" guide (22 pages, May 2023)

Supplied by the user 2026-10-06; read in full (text extracted). Tag **[DC]** = stated in this guide. It is a library
guide, so still secondary, but it cites page numbers in the MLA Handbook, 9th ed. (written "Handbook p. N" below),
which makes it stronger than the Purdue deck for MLA. Paraphrased; examples are not copied.

## What it settles

| # | Item | Result | Reviewer policy |
|---|---|---|---|
| A1 | DOI form in MLA (conflict C3) | **Resolved for MLA [DC]**: write a DOI as a web address starting `https://doi.org/`; if there is no DOI, use a stable link or the URL. The Purdue deck's `doi:` form is MLA 8-era. Chicago's DOI form is still open | MLA: flag a `doi:` or bare-number DOI as minor ("use the link form") |
| A2 | Seasons in MLA 9 dates | **New [DC]**: seasons are no longer capitalised (winter 2021, not Winter 2021). The Purdue deck's "Spring 2008" is the older form | Minor, only if the essay is in MLA 9 and inconsistent |
| A3 | "qtd. in": which source goes in Works Cited | **Settled for MLA [DC, Handbook p. 284]**: list the indirect source actually read, not the quoted one; "qtd. in" is unnecessary if the prose makes the secondhand status clear. Chicago's rule is still open | MLA: flag a Works Cited entry for a source only quoted secondhand; do not require "qtd. in" when the prose says it |
| A4 | Translated book entry | **Confirmed [DC, Handbook pp. 146-147]**: author first, "Translated by" after the title, before the publisher | Keep (matches item 8) |
| A5 | Original publication date for reprints | **Confirmed [DC, Handbook p. 210]**: record the date of the version consulted; the original date is optional and useful | Accept present or absent |
| A6 | MLA block quotes | **Confirmed with page [DC, Handbook p. 254]**: up to four lines run in with double quotes; more than four lines set off, indented half an inch, no quotation marks, period before the citation | Flag only clear misses |
| A7 | Quote exactly | **Confirmed [DC, Handbook p. 253]**: do not change spelling, capitalisation, interior punctuation, italics or accents in a quotation | Supports the integrity rule in `rules.md` |
| A8 | URLs without "https://" | **Confirmed [DC]**: omit the protocol unless hyperlinking | Minor only |

## What it complicates

| # | Item | Result | Reviewer policy |
|---|---|---|---|
| A9 | Page-range elision (item 13) | **Now a conflict between guides**: Purdue shows elided ranges (153-68); this guide mostly shows full second numbers (326-354, 492-500) and one odd form (237-8) | Accept both; flag only an inconsistent mix within one essay |
| A10 | Month abbreviations (item 12) | Abbreviated: Apr., Aug., Oct., Nov., Dec., and "Sept." once; May and June in full. But the guide's own entries also spell out March and November, so it is not applied consistently | Flag nothing except an obviously chaotic mix, and then as minor |

## Still unconfirmed for MLA
Plato, Aristotle and Kant numbering (the guide covers no classical works, plays or sacred texts); the translator-first
entry; the MLA poetry-block threshold (no verse coverage).
Net: MLA is now in good shape. The open style risks are Chicago, notably author counts, DOI form and classical works.
