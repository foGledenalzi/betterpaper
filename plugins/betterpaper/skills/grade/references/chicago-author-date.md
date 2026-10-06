# Chicago author-date: citation form checks

Use this file when `style: chicago-author-date` is set in RUBRIC.md. **Author-date** style cites each source in the text by the author's last name and the year, in parentheses, and ends the essay with a **reference list** (alphabetical full entries, with the year right after the author's name). This file tells the source-verifier (the reviewer that checks quotations and citation form, see rules.md) how to check the *form* of citations. It never tells anyone what to write.

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

Read the text citations and the reference list in this order and record the results in the citation ledger (the source-verifier's table of edition, chapter and page pairs, dates and title forms for each work). Judge form only: whether a quotation is accurate is checked separately, in the quotation ledger (the table of every attributed quotation and its status).

1. System: confirm the draft cites by author and year in parentheses with a reference list; a numbered note that cites a source is a system mix (a blend of two citation systems; row 1).
2. Text and list agree both ways: every citation has an entry, every entry is cited, years match, cited journal pages fall inside the entry's range (rows 2, 3, 4).
3. Edition consistency: one edition, publisher and year for each work; the year is the year of the edition used.
4. Completeness against the templates in section 5, and same author and year told apart by letters (row 12).
5. Title formatting by work type (row 21); if the draft shows no italics anywhere (a text-conversion artefact), do not flag; say that italics could not be checked.
6. Placeholders: leftover bracketed slots, "TK" (to come), "xx", "??" or "citation needed".

When a point is missing here or tagged `[U]`, write "check your style guide". Show only the blank templates in section 5, mark any page "check against your edition", and never fill a slot from the author's own works (rules.md).

## 3. Rules and error list: flag these

| # | Rule, and what to flag | Tag | Weight |
|---|---|---|---|
| 1 | Sources are cited in the text by author and year; flag numbered notes or author-page parentheticals used for source citation (notes may add substantive comment only) | `[C18]` | error |
| 2 | Each text citation has a list entry under the same name and year; flag a citation with no entry (exceptions: section 4, choice 8) or a year that differs between text and list | `[C18]` | error |
| 3 | A list entry that no text citation points to | `[S]` | minor |
| 4 | A page cited from a journal article must fall inside the article's page range in its list entry | `[C18]` | error |
| 5 | No comma between name and year; a comma before a locator (a page, section or other part number); n.d. (no date) and forthcoming take a comma before them in text | `[C18]` | minor |
| 6 | p. or pp. before a locator | `[S]` | minor |
| 7 | The citation usually sits just before punctuation, and after a block quotation (a long quotation set off with no quotation marks) the parenthesis follows the final punctuation with no period after it | `[C18]` | minor |
| 8 | Several sources in one parenthesis are separated by semicolons; later works by one author are cited by year alone; "see also" items come last | `[C18]` | minor |
| 9 | Authors with one surname are told apart by initial in the text | `[C18]` | minor |
| 10 | More than two authors: the first plus et al. (meaning "and others"; roman type, no comma). Flag more than two names in full; accept the older limit (more than three) if used throughout, flag a mix | `[C18]` | minor |
| 11 | Two works whose et al. forms look alike are told apart by the first two authors or a short title | `[C18]` | minor |
| 12 | Same author(s), same year: letters a, b, c follow the year in text and list, entries ordered by title, for authored, edited or translated works alike. Flag a missing letter or a mismatch; letters cannot be used when the same authors appear in a different order | `[C18]` | error |
| 13 | Undated source: lowercase n.d. in text and list, with `n.d.-a`, `n.d.-b` (and `forthcoming-a`) to tell several apart; flag a missing n.d. or a year the source does not state | `[C18]` | error |
| 14 | The year follows the author's name directly in a list entry; flag a year at the end (the notes-bibliography position) | `[C18]` | error |
| 15 | The list is usually headed "References" or "Works Cited"; flag "Bibliography" | `[C18]` | minor |
| 16 | The list is alphabetical; works by one author run in ascending order of year (oldest first) | `[C18]` | minor |
| 17 | Up to six authors are listed in full, only the first inverted; more than six: the first three plus et al. Flag more than six in full; accept the older limit (up to ten) if used throughout | `[C18]` | minor |
| 18 | In the list, noun forms (ed., eds., trans., vol., and an edition number as in 2nd ed.) are abbreviated and verb forms (Edited by, Translated by) are spelled out; a text citation omits such terms (a `vol.` locator, section 5, is not one of them). ed. after a name is correct. Flag an abbreviated verb form in the list, or ed. or trans. in a text citation | `[C18]` | minor |
| 19 | A journal entry gives volume, issue in parentheses and the page range after a colon; a chapter entry omits its page range. Flag a journal entry with no page range | `[C18]` | error |
| 20 | A translated work names the translator after "Translated by"; the year is the year of the edition used. Flag a missing translator | `[C18]` | error |
| 21 | Book and journal titles in italics, article and chapter titles in quotation marks | `[C18]` | minor |
| 22 | A web source lists owner, page title, site and URL; an undated page also gives "Accessed" and the access date. Flag a missing element that the page itself shows | `[C18]` | error |
| 23 | A DOI (a permanent link code for an article) is written as an https://doi.org/ link; flag the prefix `doi:` or "DOI:" (the older form) | `[C18]` | minor |
| 24 | Only when the draft says it used an AI tool: how it was used is stated, specific content is cited where it occurs, and the citation gives tool, version and date generated ("edited" when edited), plus the developer in a note or list entry. Flag any gap | `[C18]` | error |
| 25 | "Quoted in": the original author and year are named in the text and only the source consulted (the secondary source) is listed. Flag a list entry for the original or an original not named in the text | `[C18]` | error |
| 26 | A quotation in English from a work in another language has credit for a published translation or a declaration that the translation is the author's own; a modified published translation is marked "translation modified" (square brackets round the changed words are recommended, not required). Flag any gap, or a passage retranslated from another translation | `[C18]` | error |
| 27 | An organisation cited by an abbreviation in text is listed under that abbreviation, with the full name in parentheses after it | `[C18]` | minor |
| 28 | A block quotation carries no quotation marks; flag one set in marks, or a run-in quotation (inside the paragraph, in quotation marks) over about 100 words | `[C18]` | minor |
| 29 | Page ranges do not mix elided (second number shortened, 418–27) and full (418–427) forms in one essay | `[C18]` | minor |
| 30 | A personal communication is cited in the text only, with "pers. comm." (personal communication) or the kind of message after the name; flag an unidentified person | `[C18]` | minor |
| 31 | "Preprint" is reserved for an item on a preprint server; an accepted but unpublished article is "forthcoming" (see the list templates) | `[C18]` | minor |

## 4. Style choices and matters for the author

Never flag a style choice; flag only a mix of two practices within one essay.

| # | Style choice | Tag |
|---|---|---|
| 1 | A repeated author name, or a long rule (the 3-em dash) for successive works by one author: repeating is recommended, the rule is allowed, it keeps ascending-year order and cannot replace ed. | `[C18]` |
| 2 | "in [Last] ([year])" rather than "in [Last] [year]" (the first is preferred) | `[C18]` |
| 3 | A name in the sentence with the year right after it (even after a possessive), or a full parenthetical citation | `[C18]` |
| 4 | A chapter page range left in a list entry (earlier editions required one) | `[C18]` |
| 5 | A hyphen where an en dash belongs in a page range | `[S]` |
| 6 | A place of publication given or left out | `[S]` |
| 7 | An access date for a formally published electronic source; a database name in place of a very long URL; a link to an archived copy | `[C18]` |
| 8 | Web pages, social media posts and personal communications cited in the text with no list entry | `[C18]` |
| 9 | Notes that add substantive comment, with their citations styled as in the text; a comment after a semicolon inside a parenthesis; square brackets for a parenthesis inside a citation | `[C18]` |
| 10 | The form `([Last of original] [year], quoted in [Last] [year], [page])` beside the form in section 5 | `[S]` |

Leave to the author, never as a form finding:
- Which sources to cite, which edition to use, and whether to cite in parentheses or in the sentence: check consistency and completeness, never the choice.
- Whether to translate a quoted foreign-language passage, or to print the original beside it: it depends on the readers. `[C18]`
- Layout that extracted text does not show: hanging indents, spacing, fonts.
- The wording of an own-translation or AI-use statement, provided the required facts appear.

## 5. Templates

Fill nothing from the author's sources. Asterisks mark italics; `[slot]` is a blank; `[[slot]]` is a blank inside literal square brackets (`[[in language]]` stands for the word "in" and a language name, printed in square brackets); `n.d.`, `et al.`, `ed.` are typed as shown.

**Text citations with locators.**

| Case | Template | Tag |
|---|---|---|
| Basic | `([Last] [year])` | `[C18]` |
| Page, range, separate pages | `([Last] [year], [page])`, `([Last] [year], [first]–[last])`, `([Last] [year], [page], [page])` | `[C18]` |
| Other locators | `([Last] [year], chap. [n])`, `sec. [n]`, `para. [n]`, `eq. [n]`; whole volume `vol. [n]`; volume and page `[vol]:[page]`; a note `[page]n[n]`; unnumbered web text `under "[heading]"` | `[C18]` |
| Two authors; more than two | `([Last] and [Last] [year])`; `([Last] et al. [year])` | `[C18]` |
| Name in the sentence | `[Last] ([year], [page])` or `[Last]'s ([year])` | `[C18]` |
| Same author, same year | `([Last] [year]a)`, `([Last] [year]b, [page])` | `[C18]` |
| Several sources; one author's later works | `([Last] [year]; [Last] and [Last] [year])`; `([Last] [year], [year])` | `[C18]` |
| Same surname | `([First initial]. [Last] [year])` | `[C18]` |
| No author | `([first words of the title, up to four] [year])`, the first word being the first that is not an initial article | `[C18]` |
| Organisation | `([Abbreviation] [year])` | `[C18]` |
| Undated, forthcoming | `([Last], n.d.)`, `([Last], forthcoming)` | `[C18]` |
| Added comment | `([Last] [year]; [comment])` | `[C18]` |
| Personal communication | `([First Last], pers. comm.)` or `([First Last], [kind of message] to author, [Month day, year])` | `[C18]` |

- The name in a text citation is the one that heads the list entry: an author, or an editor, translator or institution when one heads it; never ed. or trans. `[C18]`

**Reference-list entries.**

| Type | Template | Tag |
|---|---|---|
| Book | `[Last], [First]. [year]. *[Title: Subtitle]*. [Publisher].` | `[C18]` |
| Editor in place of an author | `[Last], [First], ed. [year]. *[Title]*. [Publisher].` (eds. for several) | `[C18]` |
| Two authors; up to six | `[Last], [First], and [First Last]. [year]. ...` (only the first inverted) | `[C18]` |
| Translated book | `[Last], [First]. [year of the edition used]. *[Title]*. Translated by [First Last]. [Publisher].` | `[C18]` |
| Chapter in an edited volume | `[Last], [First]. [year]. "[Chapter Title]." In *[Book Title]*, edited by [First Last]. [Publisher].` | `[C18]` |
| Journal article | `[Last], [First]. [year]. "[Article Title]." *[Journal]* [volume] ([issue]): [first page]–[last page]. https://doi.org/[DOI].` | `[C18]` |
| Web page | `[Owner]. [year]. "[Page Title]." [Site]. [URL].` Undated: `[Owner]. n.d. "[Page Title]." [Site]. Accessed [Month day, year]. [URL].` | `[C18]` |
| Blog post | `[Last], [First]. [year]. "[Post Title]." *[Blog Title]* (blog). [Host publication], [Month day]. [URL].` | `[C18]` |
| Social media post | `[Name] ([@handle]). [year]. "[opening words of the post]." [Platform], [Month day]. [URL].` | `[C18]` |
| Forthcoming article | `[Last], [First]. Forthcoming. "[Article Title]." *[Journal]* [volume].` (text: `([Last], forthcoming)`) | `[C18]` |
| Ahead-of-print article | `[Last], [First]. [year]. "[Article Title]." *[Journal]*, ahead of print, [Month day]. https://doi.org/[DOI].` | `[C18]` |
| Newsletter post | by analogy with a blog, never an error: `[Last], [First]. [year]. "[Post Title]." *[Newsletter Title]*. [Platform], [Month day]. [URL].` | `[U]` |

- A comment on a blog post or social media post is cited in the text, by reference to the post's entry. `[C18]`
- Drop "(blog)" when the blog's title already says so, and the host publication when there is none. `[C18]`
- An article consulted in print needs no URL or DOI; a DOI link is preferred to the address-bar URL. `[C18]`

**AI-generated content.** Apply this only when the draft itself says it used an AI tool; if the draft says nothing, check nothing, ask nothing and infer nothing (rules.md).
- Text: `[Content] was generated on [Month day, year] by [tool and version].` A conversation is usually kept out of the reference list. `[C18]`
- If listed, it goes under the developer's name with a public URL; the author-date form of that entry is unconfirmed and never flagged: `[Developer]. [year]. Response to "[prompt]," [tool and version], [Month day]. [URL].` `[U]`

**Quoted in (secondary citation).** Quoting at second hand is discouraged; use it only when the original is unavailable. `[C18]`
- Text: name the original author, work and year in the sentence, then `(quoted in [Last] [year], [page])`; list only the secondary source consulted. `[C18]`
- A ledger flag QUOTED-IN (wording found in an intermediary the author did not cite) calls for this form; it is never a style error by itself.

**Classical works** (cited by standard divisions): how they appear in author-date text citations, and whether the list needs an entry for a work cited only by division, is unconfirmed. Never flag a division number in place of a page, a missing year or a missing list entry for such a work (chicago-notes.md gives the notes-system form). Blank pattern, accept any consistent form: text `([Author], *[Title]* [book].[section].[line])`; list `[Author]. [year of the edition used]. *[Title]*. Translated by [translator]. [Publisher].` `[U]`
- A modern edition cited by page is a source like any other and needs its list entry (row 2). `[C18]`

**Block quotations.**
- About 100 words or more is the usual length for setting a quotation off; short quotations and fragments run in; two or more paragraphs, correspondence, lists and material needing special layout are set off; quotations being compared may all be set off. The rule is soft: flag only clear misses (row 28). `[C18]`
- Template: `[Lead-in sentence.]` then a new indented block `[Quoted passage.] ([Last] [year], [page])`, with no period after the closing parenthesis. `[C18]`
- Run-in verse of two or more lines marks each line break with a slash set off by spaces. `[C18]`

**Repeat citations.** Author-date has no short notes: every citation gives name and year. `[C18]`
- Same page of one source cited several times in a paragraph: one citation may follow the final reference or close the paragraph, before its last period. Different pages: a full citation first, then only the page, as `([page])`. `[C18]`
- ibid. and op. cit. in author-date essays are unconfirmed and never flagged. `[U]`

**Frequently cited works.** An organisation as author may be cited by an abbreviation with its list entry under the abbreviation: `[ABBREVIATION] ([Full Organisation Name]). [year]. *[Title]*. [Publisher].` `[C18]`
- The notes system's device, `[full citation] (hereafter cited as [abbreviation])`, has no confirmed author-date form: an essay that abbreviates a work this way gets "check your style guide". `[U]`

**Translated titles and quoted translations.**

| Case | Template | Tag |
|---|---|---|
| Non-English title with an English gloss (sentence case; no italics or marks on the gloss) | `[Last], [First]. [year]. *[Original title]* [[English translation]]. [Publisher].` | `[C18]` |
| Title given only in English translation | `*[English title]* [[in language]]` | `[C18]` |
| Original and translation both cited | `[translated entry] Originally published as *[original title]* ([Publisher], [year]).` | `[C18]` |
| Own translation | `(my translation)` after the quotation or in a note, or one statement that all translations are the author's | `[C18]` |
| Modified published translation | cite the translation, add `(translation modified)`, put changed words in square brackets | `[C18]` |

- Credit a machine translation by the service name and say what was edited. `[C18]`
- A passage must not be retranslated from another translation: locate the original or paraphrase. If a published translation does not suit, drop it and give every quoted passage a new translation. `[C18]`
- Record a wording difference caused by a declared own translation or a flagged modification as a near-match (a difference that never counts as a mismatch) with its type; adjudication.md sets the effect.

**Example of form only (invented source; page number invented: check against your edition).**
- Text: `(Perrin 1998, 64)`
- List: `Perrin, Hollis. 1998. "Weighing the Salt Tax." In *Coastal Fiscal Histories*, edited by Joss Ward. Marrow Press.`

## 6. Unconfirmed (`[U]`): never errors

For each item write "check your style guide" and name the point; never flag it, grade on it or rank it.
- How ancient works (standard divisions) appear in author-date citations and the list. `[U]`
- Two-edition (A and B) page numbers and academy-edition numbers (an "Ak." prefix) for modern classics. `[U]`
- Newsletter posts as a named category (the template above follows the blog form by analogy). `[U]`
- The Manual's sections on short forms and ibid. (a notes device), and any use of ibid. or op. cit. in an author-date essay. `[U]`
- The author-date form of a listed AI conversation entry. `[U]`
- An original publication year shown beside the edition year (a reprint or translation): accept it present or absent, in any consistent form. `[U]`
