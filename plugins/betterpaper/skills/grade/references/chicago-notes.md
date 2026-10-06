# Chicago notes-bibliography: citation form checks

Use this file when `style: chicago-notes` is set in RUBRIC.md (the default). **Notes-bibliography** style cites each source in a numbered note (a footnote or endnote) and ends the essay with an alphabetical bibliography. This file tells the source-verifier (the reviewer that checks quotations and citation form, see rules.md) how to check the *form* of citations. It never tells anyone what to write.

## 1. Tags and weights

Every style rule below ends with exactly one tag. Name the manual behind a rule as "the Chicago Manual of Style, 18th edition" (CMOS 18) and print the tag beside it: only `[C18]` means the Manual itself was read.

| Tag | Meaning | How to use the rule |
|---|---|---|
| `[C18]` | CMOS 18 excerpt: a passage of the Chicago Manual of Style, 18th edition (the Manual), read directly | flag at the listed weight |
| `[MLA9]` | MLA Handbook, 9th edition: a passage read in a supplied excerpt, or a page cited through a library guide | MLA only (mla.md); no rule here |
| `[DC]` | that library guide | MLA only (mla.md); no rule here |
| `[D]` | Purdue deck: a university writing-lab slide deck, a secondary source; where it clashes with `[C18]`, follow `[C18]` | flag a clear deviation at the listed weight |
| `[S]` | search summary: stated in a search-result summary of a guide or manual page, never read in full | flag a clear deviation at the listed weight |
| `[U]` | unconfirmed: found in no source read | never an error: write "check your style guide" and name the point |

A **weight** is `error` (a required element is missing, or the source cannot be found or matched) or `minor` (a slip of punctuation, placement or abbreviation that never hides the source). Charge both to Use of sources (the criterion for quotation and citation accuracy) and list them under Citation problems (a report section), outside the ranked list of major problems (adjudication.md). A **clear deviation** is one the rule's text excludes, not a case where a style choice (section 4) allows two forms. A line with no tag is procedure, not a style rule.

## 2. How to check

Read the notes and bibliography in this order and record the results in the citation ledger (the source-verifier's table of edition, chapter and page pairs, dates and title forms for each work). Judge form only: whether a quotation is accurate is checked separately, in the quotation ledger (the table of every attributed quotation and its status).

1. System: confirm the draft cites by notes, normally with a bibliography (section 4, choice 13); parenthetical citation in place of notes is a system mix (a blend of two citation systems; row 1).
2. Edition consistency: one edition, publisher and year for each work across every note and the bibliography.
3. Chapter and page cross-check: each cited page lies inside the range given for its chapter or article and belongs to the edition cited.
4. Completeness: each citation has every element its template needs, and each cited source has a bibliography entry (rows 4 and 9).
5. Dates: the year given is the year of the edition used; an original year is optional.
6. Title formatting by work type: italics (a pair of asterisks in Markdown) for books and journals, quotation marks for articles, chapters and poems. If the draft shows no italics anywhere (a text-conversion artefact), do not flag; say that italics could not be checked.
7. Placeholders: leftover bracketed slots, "TK" (to come), "xx", "??" or "citation needed".

When a point is missing here or tagged `[U]`, write "check your style guide". Show only the blank templates in section 5, mark any page "check against your edition", and never fill a slot from the author's own works (rules.md).

## 3. Error list: flag these

| # | Flag | Tag | Weight |
|---|---|---|---|
| 1 | A quotation, paraphrase or fact that needs a source has no note, or source citations are parenthetical (author-year or author-page) in place of notes (the abbreviation form for a frequently cited work, section 5, is allowed) | `[D]` | error for a missing citation, minor for parentheses used in place of notes |
| 2 | Note number placed before a mark of punctuation (it follows every mark except the dash, which it precedes), out of sequence, or far from the claim it supports | `[D]` | minor |
| 3 | Note number inside the quotation marks or a block quotation (a long quotation set off from the text with no quotation marks), or before the final punctuation of a block quotation | `[S]` | minor |
| 4 | First citation of a work lacks an element its template (section 5) needs (a place of publication is optional), or lacks a page on a quotation or specific claim; a short first note is accepted when a bibliography entry gives the work in full (section 4, choice 14) | `[S]` | error |
| 5 | A later note repeats the full citation of a work already cited in full | `[D]` | minor |
| 6 | A short note that keeps ed. or trans. after a name | `[C18]` | minor |
| 7 | Notes and bibliography disagree on one work (edition, publisher, year, translator or title); a short note matches no full citation; or a cited page lies outside the range given for its article or chapter or (when an opened source shows it) cannot belong to the edition cited | `[S]` | error |
| 8 | A note gives an article's whole page range as the page for one quotation or claim | `[S]` | minor |
| 9 | A source cited in a note has no bibliography entry (exceptions: section 4, choices 8 and 13) | `[D]` | error |
| 10 | Bibliography not alphabetical by the first author's last name, or the first author's name not inverted | `[D]` | minor |
| 11 | Note and bibliography forms mixed: inverted names or periods between elements in a note; commas and a parenthesised publisher in a bibliography entry | `[S]` | minor |
| 12 | A full or short note names more than two authors or editors in full: the form is the first only, then et al. (meaning "and others"; no comma before it). Accept up to three named when used throughout (the 17th edition's limit) and flag a mix; with no bibliography at all, the first full note may name up to six | `[C18]` | minor |
| 13 | A bibliography lists more than six authors in full: the form is the first three, then et al. Accept up to ten when used throughout (the 17th edition's limit) and flag a mix | `[C18]` | minor |
| 14 | p. or pp. before a locator (the page, section or division number) in a note | `[C18]` | minor |
| 15 | Page ranges mix elided (second number shortened, 418–27) and full (418–427) forms in one essay | `[C18]` | minor |
| 16 | A book or journal title not in italics, an article, chapter or poem title not in quotation marks, or an English title not in headline-style capitals (capitals on all main words) | `[D]` | minor |
| 17 | A translated work with no translator named in its note or bibliography entry | `[D]` | error |
| 18 | A quotation in English from a work in another language with no credit for a published translation and no declaration that the translation is the author's own; a modified published translation not marked "translation modified" (square brackets round the changed words are recommended, not required); a passage retranslated from another translation | `[C18]` | error |
| 19 | A web source lacking a page title or description, site or owner, or URL that the page itself shows, or with neither a publication or revision date nor an access date | `[C18]` | error |
| 20 | A DOI (a permanent link code for an article) not written as an https://doi.org/ link; the prefix `doi:` or "DOI:" is the older form | `[C18]` | minor |
| 21 | An access date, when used, not placed just before the URL or database name | `[C18]` | minor |
| 22 | A social media note that gives too little of the post's own words to pick it out (up to 280 characters are allowed) or omits the platform or date | `[C18]` | minor |
| 23 | "Preprint" used for anything but an item on a preprint server, or an accepted but unpublished article not marked "forthcoming" | `[C18]` | minor |
| 24 | Only when the draft says it used an AI tool: how it was used is not stated, specific content is not cited where it occurs, or a note lacks tool, developer, version or date generated ("edited" when edited) | `[C18]` | error |
| 25 | A "quoted in" note that omits the original source's own citation, or a bibliography that lists only one of the two sources | `[C18]` | error |
| 26 | A classical work cited by page with no edition identified | `[C18]` | error |
| 27 | Edition details of a classical work (translator, publisher, year) given in no note and no bibliography entry | `[C18]` | minor |
| 28 | An abbreviation for a frequently cited work used before "hereafter cited as" gives it, or two abbreviations for one work | `[C18]` | error |
| 29 | Verb forms abbreviated in a bibliography entry (Trans. or Ed. before a name), or spelled out in a note | `[C18]` | minor |
| 30 | A block quotation set in quotation marks, or a run-in quotation over about 100 words | `[C18]` | minor |

## 4. Style choices and matters for the author

Never flag a style choice; flag only a mix of two practices within one essay.

| # | Style choice | Tag |
|---|---|---|
| 1 | Footnotes or endnotes (footnotes are preferred) | `[D]` |
| 2 | A place of publication given or left out | `[S]` |
| 3 | A repeated author name, or a long rule (the 3-em dash) for successive works by one author; the rule cannot replace ed. | `[C18]` |
| 4 | A hyphen where an en dash belongs in a page range | `[S]` |
| 5 | An original year in a translated work's note, present or absent: after the edition's year in square brackets, or before "repr." with the reprint's details | `[C18]` |
| 6 | A chapter page range in the bibliography, present or absent | `[S]` |
| 7 | An access date for a formally published electronic source; a database name in place of a very long URL; a link to an archived copy | `[C18]` |
| 8 | Notes only, no bibliography entry: web pages, blog posts, social media posts, interviews, personal communications, AI-generated content, and classical works cited by division whose edition a note gives | `[C18]` |
| 9 | eds. for several editors in a note (a deck says never; the Manual uses it) | `[C18]` |
| 10 | A list of abbreviations for frequently cited works, present or absent (alphabetised by abbreviation, never replacing the full citation at first use) | `[C18]` |
| 11 | A quotation under 100 words set as a block, or one of 90 words run in (the 100-word rule is soft) | `[C18]` |
| 12 | A prompt added to an AI note, or several prompts summarised | `[C18]` |
| 13 | No bibliography at all, when the first note for each work is complete (row 9 is then not applied) | `[C18]` |
| 14 | Short notes from the first citation of a work that has a bibliography entry (the full first note is the traditional form) | `[U]` |
| 15 | A bibliography entry that no note cites, as in a list of works consulted | `[U]` |

Leave to the author, never as a form finding:
- Which sources to cite, which edition to use and whether to quote or paraphrase: check consistency and completeness, never the choice.
- Whether to translate a quoted foreign-language passage, or to print the original beside the translation: it depends on the readers. `[C18]`
- Layout that extracted text does not show: hanging indents, spacing, fonts, superscripts, where a note sits on the page.
- The codes chosen to abbreviate frequently cited works. `[U]`
- The wording of an own-translation or AI-use statement, provided the required facts appear.

## 5. Templates

Fill nothing from the author's sources. Asterisks mark italics; `[slot]` is a blank; `[[slot]]` is a blank inside literal square brackets (`[[in language]]` stands for the word "in" and a language name, printed in square brackets); `ed.`, `trans.`, `et al.` are typed as shown.

| Type | Note (page is the page used) | Bibliography entry | Tag |
|---|---|---|---|
| Book | `[First Last], *[Title: Subtitle]* ([Publisher], [year]), [page].` | `[Last], [First]. *[Title: Subtitle]*. [Publisher], [year].` | `[C18]` |
| Translated book | `[First Last], *[Title]*, trans. [First Last] ([Publisher], [year]), [page].` | `[Last], [First]. *[Title]*. Translated by [First Last]. [Publisher], [year].` | `[C18]` |
| Edited volume | `[First Last], ed., *[Title]* ([Publisher], [year]), [page].` | `[Last], [First], ed. *[Title]*. [Publisher], [year].` | `[C18]` |
| Chapter in an edited volume | `[First Last], "[Chapter Title]," in *[Book Title]*, ed. [First Last] ([Publisher], [year]), [page].` | `[Last], [First]. "[Chapter Title]." In *[Book Title]*, edited by [First Last]. [Publisher], [year].` | `[S]` |
| Journal article | `[First Last], "[Article Title]," *[Journal]* [volume], no. [issue] ([year]): [page], https://doi.org/[DOI].` | `[Last], [First]. "[Article Title]." *[Journal]* [volume], no. [issue] ([year]): [first page]–[last page]. https://doi.org/[DOI].` | `[C18]` |

- An article consulted in print needs no URL or DOI; a DOI link is preferred to the address-bar URL. `[C18]`
- An editor and translator together: `ed. and trans.` or `trans. and ed.` in a note (both orders occur in the Manual's examples; accept either). `[C18]`

**Online and unusual sources.**

| Type | Note | Bibliography entry | Tag |
|---|---|---|---|
| Web page | `"[Page Title]," [Site], [owner or sponsor], [publication or revision date, or "accessed" and the access date], [URL].` | rarely needed; under the owner: `[Owner]. "[Page Title]." [Updated or accessed date]. [URL].` | `[C18]` |
| Blog post | `[First Last], "[Post Title]," *[Blog Title]* (blog), [host publication], [Month day, year], [URL].` | `[Last], [First]. "[Post Title]." *[Blog Title]* (blog). [Host publication], [Month day, year]. [URL].` | `[C18]` |
| Comment on a blog post | `[Commenter as shown on the site], [Month day, year], comment on [Last], "[Short Post Title]."` | none | `[C18]` |
| Social media post | `[Name] ([@handle]), "[opening words of the post]," [Platform], [Month day, year], [URL].` | none | `[C18]` |
| Unpublished interview or personal communication | `[Interviewee], interview by [First Last], [Month day, year].` or `[First Last], [email message or similar] to author, [Month day, year].` (leave out private addresses) | none | `[C18]` |
| Newsletter post | `[First Last], "[Post Title]," *[Newsletter Title]*, [Platform], [Month day, year], [URL].` | by analogy with a blog; never an error | `[U]` |

- Drop "(blog)" when the blog's title already says so, and the host publication when there is none. `[C18]`

**AI-generated content.** Apply this only when the draft itself says it used an AI tool; if the draft says nothing, check nothing, ask nothing and infer nothing (rules.md).
- The author states in the text, a note or a preface how the tool was used, and cites specific quoted or paraphrased content where it occurs. `[C18]`
- Note: `Text generated by [tool and version], [developer], [Month day, year generated], [URL of a public copy, if one exists].` Add `edited for [purpose]` when edited; with a prompt: `Response to "[prompt]," [tool and version], [developer], [Month day, year generated].` `[C18]`
- A conversation is usually kept out of the bibliography; if listed, list it under the developer's name with a public URL. `[C18]`

**Quoted in (secondary citation).** Quoting at second hand is discouraged; use it only when the original is unavailable. `[C18]`
- Note: `[Note for the original source, as for its type], [page], quoted in [note for the secondary source, as for its type], [page].` Bibliography: list the original and the secondary source alike. `[C18]`
- A ledger flag QUOTED-IN (wording found in an intermediary the author did not cite) calls for this note form; it is never a style error by itself.

**Classical works** (ancient and medieval; also sacred works with numbered divisions).
- Cite by standard divisions (book, section, line, or the Stephanus and Bekker numbers printed in the margins of standard editions of Greek philosophical works), which stay the same in every edition and translation; omit page numbers except for a modern editor's introduction or notes, or a specific translation. Never flag standard numbering. `[C18]`
- Punctuation: periods between divisions with no space, an en dash for continuing numbers, a comma between author and title, none between title and number, commas between references to one source, semicolons between sources. `[C18]`

| Case | Template | Tag |
|---|---|---|
| First note, edition named | `[Author], *[Title]*, trans. [translator] ([Publisher], [year]), [book].[section].[line].` | `[C18]` |
| Later note | `[Author], *[Title]* [book].[section].[line].` or `[Author], *[Title]* [Stephanus or Bekker number].` | `[C18]` |
| Bibliography (a courtesy for the edition used) | `[Author]. *[Title]*. Translated by [translator]. [Publisher], [year].` | `[C18]` |

- A standard classical abbreviation replaces ibid. (a note that repeats the one before) in later notes; avoid it where it saves just two letters, and never where two writers could be meant. `[C18]`

**Block quotations** (a run-in quotation, by contrast, sits inside the paragraph in quotation marks).
- About 100 words or more is the usual length for setting a quotation off; short quotations and fragments run in; two or more paragraphs, correspondence with its salutation or signature, lists and material needing special layout are set off; quotations being compared may all be set off. Flag only clear misses (row 31). `[C18]`
- A block quotation takes no quotation marks, and marks inside it are double marks. `[C18]`
- Template: `[Lead-in sentence.]` then a new indented block `[Quoted passage.]` with the note number `[n]` after its final punctuation, outside any marks. `[S]`
- Run-in verse of two or more lines marks each line break with a slash set off by spaces. `[C18]`

**Short forms and repeat citations** (a short note cites a work already cited in full; later notes should be short). `[D]`

| Case | Short note | Tag |
|---|---|---|
| One author | `[Last], *[Short Title]*, [page].` | `[C18]` |
| Two authors | `[Last] and [Last], *[Short Title]*, [page].` | `[C18]` |
| More than two authors | `[Last] et al., *[Short Title]*, [page].` | `[C18]` |
| Article | `[Last], "[Short Title]," [page].` | `[C18]` |
| Chapter | `[Last], "[Short Chapter Title]," [page].` | `[S]` |
| Same source as the note just before (using or avoiding ibid. is never an error) | `Ibid., [page].` | `[U]` |

- Use the last name only (the editor's or translator's if listed first); drop ed. and trans.; give full names or initials only to tell authors with one surname apart; drop a leading article from the short title. `[C18]`

**Frequently cited works.** First note: `[full citation], [page] (hereafter cited as [abbreviation]).` Later notes: `[abbreviation], [page].` In text: `([abbreviation], [page])`. `[C18]`
- An abbreviated title may reorder or abbreviate words, unlike a short title; the abbreviation of an italic title is italic. `[C18]`

**Translated titles and quoted translations.**

| Case | Template | Tag |
|---|---|---|
| Non-English title with an English gloss (sentence case, no italics or marks on the gloss) | `*[Original title]* [[English translation]]` | `[C18]` |
| Title given only in English translation | `*[English title]* [[in language]]` | `[C18]` |
| Original and translation both cited (bibliography) | `[translated entry]. Originally published as *[original title]* ([Publisher], [year]).` | `[C18]` |
| Published translation credited | note as for a translated book | `[C18]` |
| Own translation | `(my translation)` after the quotation or in a note, or one statement that all translations are the author's | `[C18]` |
| Modified published translation | the note citing the translation, then `(translation modified)`; changed words in square brackets | `[C18]` |

- Credit a machine translation by the service name and say what was edited. `[C18]`
- A passage must not be retranslated from another translation: locate the original or paraphrase. If a published translation does not suit, drop it and give every quoted passage a new translation. `[C18]`
- Record a wording difference caused by a declared own translation or a flagged modification as a near-match (a difference that never counts as a mismatch) with its type; adjudication.md sets the effect.

**Example of form only (invented source; page numbers invented: check against your edition).**
- Note: `Orsolya Tench, "Gauges Without Gaugers: Reading Silent Tide Registers," *Annals of Tidal Works* 14, no. 2 (2009): 118, https://doi.org/10.9999/atw.2009.014.`
- Short note: `Tench, "Gauges Without Gaugers," 121.`
- Bibliography: `Tench, Orsolya. "Gauges Without Gaugers: Reading Silent Tide Registers." *Annals of Tidal Works* 14, no. 2 (2009): 112–29. https://doi.org/10.9999/atw.2009.014.`

## 6. Unconfirmed (`[U]`): never errors

For each item write "check your style guide" and name the point; never flag it, grade on it or rank it.
- Two-edition (A and B) page numbers and academy-edition numbers (an "Ak." prefix) for modern classics: never flag any form of these numbers or a missing page number. `[U]`
- Newsletter posts as a named category: the template above follows the blog form by analogy; accept any consistent blog-like form. `[U]`
- Short forms beyond the author-name rule (how far to shorten a title, author-only and title-only forms) and every rule about ibid., op. cit. and loc. cit. other than the classical-abbreviation rule in section 5 (Latin for "in the same place", "in the work cited" and "in the place cited"; the Manual's list of abbreviations calls the last two best avoided): whether, where and how to use them. `[U]`
- A short form of a "quoted in" note, and the bibliography wording when one person both edited and translated a work. `[U]`
- The digit rule for eliding page ranges beyond the Manual's examples, and how many lines of verse call for a block. `[U]`
