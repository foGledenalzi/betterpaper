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

1. MLA and Chicago author-date handling of Plato (Stephanus), Aristotle (Bekker) and two-edition (A/B) numbering for modern classics. The MLA
   deck shows only a Bible in-text pattern (version, book, chapter:verse) and a multivolume pattern, which support
   "cite standard divisions" in general. Policy stays: never flag standard classical numbering.
2. Chicago author-date: parenthetical form for classical works and whether the reference list needs an entry.
3. MLA translator-first entry wording (the decks show only the author-first form).
4. Newsletter-platform short and bibliography forms; whether "quoted in" lists both sources in the bibliography.
5. CMOS section and threshold for abbreviating frequently cited works; code conventions for frequently cited works; whether abbreviations are italic (CMOS 18 says generally yes for italicised titles, addendum B).
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
Plato, Aristotle and two-edition (A/B) numbering (the guide covers no classical works, plays or sacred texts); the translator-first
entry; the MLA poetry-block threshold (no verse coverage).
Net: MLA is now in good shape. The open style risks are Chicago, notably author counts, DOI form and classical works.

---

# Addendum B: Chicago Manual of Style, 18th edition (excerpts supplied by the user)

Supplied 2026-10-06 as a text file of excerpts with CMOS 18 section numbers (14.143-14.152 classical references, 13.x authors and short forms, 14.73-14.77 articles and DOIs, 12.10-12.24 and 12.82-83 quotations, 14.160 secondary sources, ch. 10 abbreviations). Tag **[C18]** = stated in these excerpts. This is the primary source, so it overrides every earlier tag. Paraphrased; no passages are copied.

## Resolves earlier conflicts

| # | Item | CMOS 18 says [C18] | Verdict on earlier sources |
|---|---|---|---|
| B1 | Authors in a note (C1) | More than two authors or editors: name only the first, then "et al." (17th edition: more than three). No comma before "et al." in a note | Earlier research notes were right; the Purdue deck's "2-3 named" is the 17th-edition or Turabian rule |
| B2 | Authors in the bibliography (C2) | Up to six listed; more than six: first three then "et al." (17th: up to ten listed). With no bibliography, the first full note follows the bibliography rule | Earlier research notes were right; the deck's "first six for 4-10" mixes the rules |
| B3 | DOI form (C3), Chicago | A DOI is written as a URL appended to `https://doi.org/`; it is preferred over the address-bar URL. For print-consulted articles no URL is needed | The `doi:` form in the deck is dated: reviewer flags it as minor |
| B4 | Block quote threshold (C4) | A hundred words or more "can generally" be set off; length usually decides, but two or more paragraphs, quoted correspondence, lists and material needing special format also qualify; comparing quotations may justify blocking short ones | Keep the soft 100-word rule. "Five lines" is a Turabian heuristic, not CMOS |
| B5 | Access dates | Not required for formally published electronic sources; if used, they come immediately before the URL or database name, set off by commas in a note and by periods in a bibliography entry | Confirms earlier [U]/[S] |

## Corrects my earlier notes

| # | Item | Earlier note | CMOS 18 [C18] |
|---|---|---|---|
| B6 | "Quoted in" in notes-bibliography | List only the source actually read | **If the original is unavailable, both the original and the secondary source must be listed**; quoting at second hand is generally discouraged. (Author-date differs: name the original author and date in the text, and list only the secondary source.) MLA is unchanged: list the indirect source only |
| B7 | Italics for abbreviations | Unknown | An abbreviation of a consistently italicised title is generally italicised too. A list of abbreviations is optional, useful when many are used or a few are used often, alphabetised by abbreviation, and never a substitute for the full form at first use |

## Settles earlier [U] items

| # | Item | Result [C18] |
|---|---|---|
| B8 | Original year for translations | **Confirmed**: the Manual's own sample list of abbreviations gives the year of the edition used, then the original year in square brackets, inside the parenthesis (the Purdue deck's "repr." pattern is a second, valid form). Reviewer accepts either, or neither |
| B9 | Plato and Aristotle numbering | **Confirmed for notes**: ancient works are cited by standard divisions (for example Stephanus or Bekker numbers), which stay the same across editions and translations; page numbers are omitted except for a modern editor's introduction or notes, or for a specific translation. Details of the edition used (translator, publisher, year) are given the first time or in the bibliography. Not covered in the excerpts: two-edition (A/B) and academy-edition numbers for modern classics, and author-date handling of ancient works |
| B10 | Ibid. for classical works | When recognised abbreviations (Oxford Classical Dictionary list) are used, they replace "ibid." in later references; abbreviations must not be used where two authors could be meant |
| B11 | Medieval works | Cited like classical works (author, title, standard divisions); a translation adds the translator and the edition details |
| B12 | Editor and translator in notes | "ed. and trans." and "trans. and ed." both appear, in title-page order; "ed." and "trans." are dropped in short forms |
| B13 | Page ranges and "p." | Examples elide ranges (two-digit second numbers such as 479-96 and 371-84) and use bare page numbers with no "p." |
| B14 | Short notes | Author surname plus a shortened title; a leading article is dropped from the short title; multiple authors follow B1 |
| B15 | Preprints | "Preprint" is reserved for items on a preprint server; an accepted but unpublished journal article is "forthcoming"; "ahead of print" is separate, and the placement of the date differs |
| B16 | Subscription databases | The database name may replace a very long URL |

## Still unconfirmed after all sources
1. Two-edition (A/B) pagination and the academy-edition "Ak." prefix for modern classics (the excerpts cover ancient and medieval works only).
2. Chicago author-date handling of ancient works and standard divisions.
3. Newsletter-platform forms (analogy to blogs only).
4. MLA and Chicago treatment of translator-first entries; MLA poetry-block threshold; MLA handling of Plato, Aristotle and two-edition (A/B) numbering.
5. The exact CMOS 18 section number for abbreviating frequently cited works and for "edited and translated by" in bibliographies.

Net: the Chicago side is now in good shape. The reviewer treats the remaining five items as "check your style guide".

---

# Addendum C: CMOS 18 and MLA 9 snippets supplied by the user (2026-10-06)

The user extracted excerpts from the full texts and supplied them as two text files. CMOS 18: author-date (13.101-13.128), websites, blogs and social media (14.103-14.107), interviews and personal communications (14.108-14.111), AI-generated content (14.112), patents, standards and secondary sources (14.158-14.160), translated titles and translated quotations (13.101, 11.9-11.19), frequently cited works, sacred works, classical abbreviations. MLA Handbook 9: poetry (6.36-6.38), line and division citation, translations (2.57, 5.31, 6.75), indirect sources (6.77), and Appendix 2 works-cited examples. The text has OCR artefacts (for example a malformed DOI prefix in one MLA example); those were ignored. Tags **[C18]** and **[MLA9]** mean "in the Manual" and "in the Handbook"; they override every earlier tag. All wording is paraphrased.

## C1. Chicago author-date: now confirmed [C18]
- **Overview.** Text citations give the author's last name and the year in parentheses; the reference list (titled "References" or "Works Cited") is a bibliography with the year directly after the author's name (13.101-13.102).
- **Abbreviations (13.103).** In the reference list, noun forms (editor, translator, volume, edition) are abbreviated; verb forms ("Edited by", "Translated by") are spelled out; in text citations all such terms are omitted.
- **Page numbers (13.104, 13.109).** A text citation may give a page or range after the year, separated by a comma. A reference-list entry gives the page range for a journal article but omits most other page numbers, including a chapter in an edited book (a departure from earlier editions).
- **Entry forms (13.106-13.110).** Single author or editor (ed. or eds. in the list, omitted in text); two authors (only the first inverted; both last names in text); more than two authors: up to six in the list (more than six: first three plus "et al."), first author plus "et al." in text; author plus translator ("Translated by" spelled out; the year is that of the edition used); chapter in an edited book ("In <title>, edited by <name>"); journal article (volume, issue in parentheses, page range after a colon, DOI as an `https://doi.org/` link).
- **Reference lists (13.111-13.114).** Alphabetical; several works by one author in ascending order of date; names are repeated for successive works (the 3-em dash is still permitted but no longer recommended); same author and year distinguished as 2004a, 2004b (by title order), and `n.d.-a` or `forthcoming-a` for undated or forthcoming items.
- **Text citations (13.115-13.128).** Every text citation needs a matching list entry; basic form has no punctuation between name and year; multiple sources separated by semicolons; same surname distinguished by initial; locators follow the date after a comma (vol., colon for volume and page, sec., chap., eq., `n` for a note, a heading for unnumbered web text); added comments follow a semicolon; the citation precedes punctuation, and in a block quotation the parenthesis follows the final punctuation with no period after it; consecutive citations to one source may be placed after the last reference with later pages bare; prefer "in Smith (1999)" to "in Smith 1999"; more than two authors take first author plus "et al." (not italic in text), extended to the first two authors or a short title when two works would collide; multiple works by the same author cited by date only; "see also" follows other references; no-author works cite the title (up to the first four words); pseudonyms and organisations as authors have their own forms; notes may supplement author-date for substantive comment only.

## C2. Corrections to earlier notes
- **"ed." in a reference list is not an error.** The earlier author-date research listed `ed.` and `trans.` in list entries as a format slip. Under 13.103 the noun form `ed.` or `eds.` after a name is correct; the verb forms "Edited by" and "Translated by" are spelled out, and `trans.` or `ed.` as a verb abbreviation is the slip.
- **3-em dash.** The earlier note said the 18th edition requires repeating the name. The Manual says repeating is now recommended and the dash is still allowed for authors or publishers who need it (13.113).
- **Chapter page range.** Confirmed omitted in the reference list (13.109).
- **"Quoted in", notes-bibliography.** Reconfirmed: both the original and the secondary source must be listed if the original is unavailable; author-date lists only the secondary source, with the original named in the text (14.160).
- **Newsletters.** Still not named. The Manual treats a blog as a periodical, with the blog title in italics and "(blog)" added if the title does not make that clear (14.105); a newsletter post is therefore cited by analogy, tagged `[S]`.

## C3. New confirmed rules [C18]
- **Web pages (14.104).** Usually cited in the text or a note, not in a bibliography; a bibliography entry, if needed, is listed under the owner or sponsor; include a publication or revision date, or an access date if none; archived copies (Wayback Machine, Perma.cc) may be cited. In author-date style an undated page uses lowercase `n.d.`, preceded by a comma in a text citation.
- **Blogs (14.105).** Author, post title in quotation marks, blog title in italics, date, URL; comments are cited in terms of the post; in author-date style the year follows the author.
- **Social media, forums, mailing lists (14.106-14.107).** Usually mentioned in text or a note, not listed; a note quotes enough of the post to identify it (up to 280 characters); platform names are treated like website names; private messages are personal communications.
- **Interviews and personal communications (14.108-14.111).** Cited in text or a note; in author-date style personal communications are cited in the text only, after the name.
- **AI-generated content (14.112).** An author who relied on a chatbot or similar tool must make clear how it was used, in the text, a note or a preface; specific content, quoted or paraphrased, is cited where it occurs (tool as author, developer as publisher, version number, date generated, a public URL if there is one, and "edited" if edited); chatbot conversations are not usually listed in a bibliography.
- **Translated titles (13.101).** An English translation of a title follows the original in brackets, in sentence case, not italic or quoted; a title given only in English translation notes the original language in brackets; if both an original and a translation are cited, the bibliography may add "Originally published as <title> (<publisher>, <year>)" after the translated entry, or the reverse.
- **Translated quotations (11.16-11.19).** Credit the published translation (title, translator, bibliographic details, page); an author's own translation must be declared ("my translation"); a machine translation must be credited; modifying a published translation needs "translation modified" and square brackets; never retranslate a passage from a translation (find the original); edit a translated quotation only within the permitted changes.
- **Frequently cited works (13.65, 12.78).** A frequently cited work may be abbreviated in text or later notes with the full citation at first mention and "hereafter cited as <abbreviation>" (more helpful with footnotes); an abbreviated title may rearrange or abbreviate words, unlike a short title.
- **Classical and sacred works.** Classical abbreviations follow the Oxford Classical Dictionary list and replace "ibid." (14.144, already C18); other sacred works are treated like biblical or classical works, with the version or translator named and divisions cited by number (for example Koran 19:17-21).
- **Patents and standards (14.158-14.159).** Cited by title, issuing body, dates and URL.

## C4. MLA 9: now confirmed [MLA9]
- **Poetry (6.36-6.38).** Up to about three lines of verse may run in, in quotation marks, with a forward slash and a space on each side to mark line breaks and two slashes for a stanza break; a verse quotation of **more than three lines** is set off as a block, indented half an inch, with no added quotation marks; a long line takes a hanging indent; unusual spacing is reproduced; the citation follows the last line (on a new line, flush right, if it does not fit). This resolves the Purdue deck's self-contradiction (conflict C5).
- **Classical and standard works with divisions.** Cite by division and line, not page: line numbers only as "line" or "lines" (not l. or ll.), "bk. 18, lines 129-31" for a book of an epic, and "1.5.35-37" with a short title for a play; the Works Cited entry names the translation or edition used (translator after the title; for a play in an anthology, the anthology's page range). This covers the Homer and Shakespeare pattern; Plato and Aristotle numbering is still not shown specifically.
- **Page ranges.** The Handbook's own examples elide the second number to its last two digits when it has more than two (139-60, 114-29, 1135-97, 1306-42) and give two-digit ranges in full (18-19). The Douglas guide's full-digit ranges are therefore a lesser form: treat both as acceptable, with the elided form preferred.
- **Months.** Abbreviated in the examples (Jan., Feb., Apr., Aug., Sept., Oct., Nov., Dec.) except May, June and July; this settles the earlier month-abbreviation item at example level.
- **Translations and quotations (2.57, 5.31, 6.75).** A translated word or phrase goes in double quotation marks inside parentheses, or in single quotation marks without parentheses; in prose, give an original-language title with its translation at first reference; in Works Cited a translation of a title is usually unnecessary and, if given, goes in square brackets after the original; never supply an own translation without the original quotation; give the source of both quotation and translation; if the translation is the author's own, put "my trans." in the parenthetical citation.
- **Indirect sources (6.77).** "qtd. in" before the indirect source in the parenthetical citation, and the indirect source (not the one quoted) goes in Works Cited; not needed if the prose makes the secondhand status clear.
- **Works Cited examples.** Original publication year as an optional element after the title ("The Inferno. Translated by John Ciardi. 1965. Signet Classic, 2001."); a repeated author is replaced by a dash; translator and editor as contributors after the title ("Translated by ..., edited by ..."); special issues, nonconsecutive pagination ("pp. 1+"), double issues ("nos. 3-4"), and URLs given without "https://".
- **Not shown.** Translator-first entries, and Plato and Aristotle (Stephanus and Bekker) numbering.

## C5. Conflicts and items now closed
- C5 (MLA poetry block threshold): closed, more than three lines.
- A9 (MLA page-range elision): closed in favour of elision [MLA9 examples].
- A10 (MLA months): closed [MLA9 examples].
- Chicago `[U]` items closed: the author-date reference list and in-text rules; the wording "Edited by" and "Translated by" in reference lists; abbreviating frequently cited works (the earlier section number was 13.65 with 13.64); original-publication information for translated books; italics for abbreviations were already closed in addendum B.

## C6. Still unconfirmed
1. Two-edition (A/B) and academy-edition ("Ak.") numbering for modern classics, in either Chicago system or MLA.
2. Chicago author-date handling of ancient works and standard divisions.
3. Newsletter posts as a named category in either style (blogs are covered).
4. MLA translator-first entries; MLA treatment of Plato and Aristotle numbering by name.
5. CMOS 18 on "ibid." and short forms (only the frequently-cited-works abbreviation was supplied).

None blocks Phase 1: each stays `[U]` and the reviewer says "check your style guide".
