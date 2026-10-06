# MLA 9: how to check citation form

Load this file when `style: mla` in RUBRIC.md selects it. MLA is the Modern Language Association; the manual behind every rule here is the MLA Handbook, 9th edition. The source-verifier (the reviewer that checks quotations and citation form) uses this file to check form, and the orchestrator (the main agent that merges the returns and writes the report) uses it to word the Citation problems section (the report section that lists form defects).

- It never tells anyone what to write: name the rule a form breaks, offer a blank template, and stop. The author writes the citation.
- In templates `*...*` marks italics, `[brackets]` are blanks, and every sample string is invented.
- Terms: the Works Cited list is the alphabetical list of sources at the end of the essay; a container is the larger work that holds a source (a journal holds an article, an anthology a chapter, a website a page, a database a journal).

## 1. Tags

Every rule carries exactly one tag, listed here from firmest to weakest.

| Tag | Source of the rule | If the essay deviates |
|---|---|---|
| [C18] | CMOS 18 excerpt (the Chicago Manual of Style, 18th edition); not used here unless a rule is cross-referenced | not applicable |
| [MLA9] | MLA Handbook, 9th edition: a passage read in a supplied excerpt, or a page cited through a library guide | report it |
| [DC] | that library guide (a college library's guide to MLA 9, a secondary source) | report it |
| [D] | Purdue deck (a writing-lab slide deck on MLA 9, a secondary source, partly MLA 8-era) | report only a clear deviation |
| [S] | search summary (a rule reported by search-result summaries of official or university pages, never read in full) | report only a clear deviation |
| [U] | unconfirmed (no supplied source states it) | never an error: say "check your style guide" |

A clear deviation is one the rule's text excludes. It is not a case where the style choices in section 4 allow two forms.

## 2. How to use this file

1. Check form only. Whether a quotation matches its source is a status in the quotation ledger (the table of every attributed quotation, in SOURCES.md; see adjudication.md). MLA expects a quotation reproduced exactly, with no change to spelling, capitalisation, interior punctuation, italics or accents [MLA9]; the ledger records any difference, not this file. What a source means is the primary-text-reviewer's call (the reviewer for how the essay reads its primary works). Charge every form defect to Use of sources (the criterion for quotation accuracy, attribution and citation form) and list it under Citation problems.
2. Judge against MLA 9 only. Never hold an MLA essay to Chicago habits. Report a pattern from another style (E19) once per essay.
3. One finding per pattern: first locator, count of instances, the rule in your own words, the tag, and "MLA Handbook, 9th ed." as the manual (rules.md requires the manual and edition behind any style rule you cite).
4. Help is the rule plus a blank template from section 5. Never fill a template from the author's works, authors, titles, years or pages, and never rewrite the author's entry or parenthetical. Mark any page or other locator "check against your edition". The one filled example (section 6) shows form only and is the only filled citation a report may carry.
5. An item tagged [U] (section 7) is never an error and has no grade effect: write "check your style guide" and name the point. Treat any form this file does not cover the same way.
6. Where section 4 lists style choices, accept every form; flag a mix inside one essay only where the Note column says so. A "minor" item goes last among the form findings and is marked minor.
7. Text extracted from a PDF or word-processor file can lose italics, indentation, hanging indents (every line after the first indented) and spacing. Report such a defect only when the extracted text itself shows it; otherwise say once that layout could not be checked.
8. Never report as a quotation defect a translation the author declares as their own with the original supplied (`my trans.`), or a published translation the author modified and flagged. Both are near-matches that adjudication.md keeps out of the integrity test (the test that can cap the grade).

## 3. Six checks to run on every draft

1. Edition consistency: log each work's edition and the pages cited for it in the citation ledger (a table in STATE.md). Every cited page must fit the one edition that work's entry names (E8, E23).
2. Chapter and page cross-check: a page cited for an article or chapter lies inside the page range its entry gives (E12, E14).
3. Completeness: each entry carries every core element its source offers, in order (E10 to E14, E17).
4. Dates: the main date is that of the version consulted; an original year is an optional supplement (C2); months and seasons follow section 5 (E25, E26).
5. Titles by work type: italics for books, websites and containers, quotation marks for articles, chapters and pages (E18).
6. Placeholder scan: unfilled brackets, `xx`, `TK` or `??` left in an entry or parenthetical.

## 4. Error list

E means report as an error of form. C means style choice. L means leave to the author. "Minor" is defined in section 2, point 6.

### Errors

| # | Look for | The rule behind it | Tag |
|---|---|---|---|
| E1 | In an author-page parenthetical, a comma between the author and the page, `p.` or `pp.` before the page, or a year, as in `([Last], p. [page])` | Surname, space, page or range, with no year and no `p.` (those belong to another style); a short title or initial joins only where E4 or E5 applies | [DC] |
| E2 | Three or more authors all named in a parenthetical or in the list | First author plus et al. (in the list: first author inverted, a comma, et al.); running prose may name every author or say "and others" | [DC] |
| E3 | `&` between two authors | Join two authors with `and` | [S] |
| E4 | Two works by one author cited by surname alone | A short title follows the surname: italics for a book, quotation marks for an article | [DC] |
| E5 | Two cited authors share a surname and are cited by surname alone | Add the first initial; the full first name if the initials also match | [DC] |
| E6 | A page or paragraph number for a source that has none, or counted paragraphs | Cite the author alone (a shortened title if no author); no parenthetical when the sentence names the author | [DC] |
| E7 | A source read through another author's quotation cited as if read directly (no `qtd. in`, meaning quoted in, where the prose does not show it is secondhand); or a list entry for the quoted author's original in place of the source read | `qtd. in` goes before the indirect source in the parenthetical, and the list holds only the source read (Chicago notes-bibliography lists both sources) | [MLA9] |
| E8 | A parenthetical with no list entry, or a list entry never cited | Every citation points to one entry and every entry is cited | [DC] |
| E9 | A list not titled Works Cited, or not alphabetical by first element (a leading A, An or The ignored) | The list is titled Works Cited and runs alphabetically by the first element of each entry, ignoring a leading article | [DC] |
| E10 | An entry missing a core element its source offers (not an optional one from section 4), or with elements out of order | The element order in section 5 | [D] |
| E11 | Wrong separators inside an entry | A period closes the author, the source title, each container and the entry; commas join elements inside a container | [DC] |
| E12 | A journal entry without `vol.`, `no.` or `pp.` where the source gives them | The labels are required, not optional | [S] |
| E13 | A translated work whose entry names no translator | `Translated by [First Last]` sits after the title and before the publisher (every translated entry in the sources names one; none calls its absence an error) | [D] |
| E14 | A chapter entry that opens with the editor, lacks `edited by` or the chapter's page range, or a parenthetical that names the editor | The entry opens with the chapter's author, and the parenthetical cites that author | [DC] |
| E15 | Minor: a DOI (digital object identifier, an article's permanent code) written as `doi:`, `DOI:` or a bare number | Write it as an `https://doi.org/` link; with no DOI use a stable link, else the URL | [DC] |
| E16 | Minor: the protocol prefix (the `https` start) kept on a URL that is not a DOI link | The prefix is usually omitted unless the URL is a hyperlink | [DC] |
| E17 | Minor: a web entry with neither a publication date nor an access date | Give an access date when the page is undated or likely to change | [DC] |
| E18 | A book, website or container title not in italics, or an article, chapter or page title not in quotation marks | Italics versus quotation marks follow the type of work | [D] |
| E19 | Another system's pattern used for citing: a year inside the parenthetical or straight after the author in the list, or notes standing in for parentheticals | MLA 9 cites with author-page parentheticals and a Works Cited list (a wrong list heading is E9) | [S] |
| E20 | A prose quotation clearly over four lines run in, a block clearly shorter, a block in quotation marks, or a period after a block's closing parenthesis | Over four lines: set off, no marks, citation after the final punctuation; four lines or fewer run in | [MLA9] |
| E21 | Verse longer than three lines run in; run-in verse of two or more lines with no slash at the breaks; a verse block in added quotation marks | Verse over three lines is blocked; run-in verse marks breaks with a slash | [MLA9] |
| E22 | A bilingual quotation (original and translation printed together) whose translation has neither a cited source nor `my trans.`; an own translation printed without the original | Give the source of both quotation and translation; never offer an own translation without the original | [MLA9] |
| E23 | A classical or divided work cited with no list entry naming the translation or edition used | The entry names the translation or edition behind the divisions | [MLA9] |
| E24 | Lines cited as `l.` or `ll.` | Write `line` or `lines`, because the abbreviations are easily read as numerals | [MLA9] |
| E25 | Minor: months in a clearly inconsistent mix of abbreviated and written out, or May, June or July abbreviated | Section 5, Dates and numbers | [MLA9] |
| E26 | Minor: a capitalised season in a date; if the essay capitalises seasons throughout, say so once rather than per entry | Seasons are lowercase in MLA 9 (the older form was capitalised) | [DC] |

### Style choices (accept every form; flag a mix only where the note says so)

| # | Accept | Note | Tag |
|---|---|---|---|
| C1 | Page ranges elided to the last two digits of the second number, or written in full; two-digit ranges whole | Elided is preferred, full is acceptable; flag only a mix of the two in one essay | [MLA9] |
| C2 | An original publication year after the title and any translator, present or absent | Optional supplement; the main date is the version consulted; never flag | [MLA9] |
| C3 | City of publication, present or absent | The deck lists it as optional; the library guide says modern books drop it; never flag | [D] |
| C4 | A repeated author shown as a dash or as the repeated name | Either is accepted; never flag | [S] |
| C5 | `qtd. in` absent where the prose already shows the source is secondhand | Not needed then; never flag | [MLA9] |
| C6 | An access date on a dated, stable page | Optional there; never flag | [DC] |
| C7 | A translation placed after its quotation or before it throughout; double marks inside parentheses or single marks without | Flag only inconsistency | [MLA9] |
| C8 | Verse and plays cited by division and line with no page; bare line numbers once the citation has shown they are lines | Never flag the numbering | [MLA9] |
| C9 | A prose work in many editions cited as page, semicolon, division | Accept | [S] |

### Leave to the author

| # | Point | What to do | Tag |
|---|---|---|---|
| L1 | A foreign-language quotation left untranslated (every reader knows the language, the instructor says to omit it, or the meaning is plain) | Never report it; the call is the author's | [MLA9] |
| L2 | A translation of a foreign title added to a list entry in square brackets after the original, or left out | Never report either | [MLA9] |

## 5. Blank templates

Give an element only when the source offers it and leave every other slot out. Mark every page or locator "check against your edition".

### Entries (Works Cited)

| Form | Blank template | Tag |
|---|---|---|
| Core elements, in order | `[Author]. [Title of source]. [Title of container], [other contributors], [version], [number], [publisher], [publication date], [location].` | [D] |
| Punctuation and omission | A period closes the author, the source title, each container and the entry; commas join elements inside a container. A database or platform that holds the source is a second container with its own title and location. Omit what the source does not offer, with no blank slot | [DC] |
| Book | `[Last], [First]. *[Title: subtitle]*. [edition, only if not the first], [Publisher], [year].` In text: `([Last] [page])` | [DC] |
| Translated book | `[Last], [First]. *[Title]*. Translated by [First Last], [Publisher], [year of the edition consulted].` An optional bare `[original year].` may follow the title and translator | [MLA9] |
| Chapter in an edited collection or anthology | `[Last], [First]. "[Chapter title]." *[Book title]*, edited by [First Last], [Publisher], [year], pp. [first]-[last].` In text: the chapter's author, not the editor | [DC] |
| Journal article | `[Last], [First]. "[Article title]." *[Journal]*, vol. [n], no. [n], [date as the issue gives it], pp. [first]-[last].` | [DC] |
| Journal article with a DOI or link | Direct: add `, https://doi.org/[DOI]` after the pages. Through a database: `... pp. [first]-[last]. [Database], https://doi.org/[DOI].` No DOI: a stable link, else the URL, without its protocol prefix | [DC] |
| Three or more authors | `[Last], [First], et al.` | [DC] |
| Web source | `[Author]. "[Page title]." *[Website]*, [day] [month] [year], [URL without its protocol prefix]. Accessed [day] [month] [year].` The access date is for an undated or changeable page | [DC] |
| Double issue, split pagination | `nos. [n]-[n]` for a double issue; `pp. [first]+` when the pages are not consecutive | [MLA9] |

### In text, quotations and translations

| Form | Blank template | Tag |
|---|---|---|
| Author-page | `([Author] [page])`; author named in the sentence: `([page])` only; two authors: `([Author] and [Author] [page])` | [DC] |
| Told apart | Three or more authors: `([Author] et al. [page])`. Two works by one author: `([Author], *[Short title]* [page])` or `([Author], "[Short title]" [page])`. One surname shared: `([Initial]. [Author] [page])`. No page: `([Author])` | [DC] |
| Own parts, page plus division, two sources | `par.`, `sec.` or `ch.` plus the number when the source numbers its parts; `([Author] [page]; ch. [n])`; `([Author] [page]; [Author] [page])` | [S] |
| Indirect source (`qtd. in`) | The quoted author is named in the sentence; the parenthetical reads `(qtd. in [Author of the source read] [page])`. The list holds the source read only, never the quoted author's original | [MLA9] |
| Classical or divided work | Epic: `([Author, unless the prose names the author] bk. [n], lines [first]-[last])`. Play: `(*[Short title]* [act].[scene].[lines])`. List, translated work: `[Author]. *[Title]*. Translated by [First Last], [Publisher], [year].` List, play in an anthology: `[Author]. *[Play]*. *[Anthology]*, edited by [First Last], [Publisher], [year], pp. [first]-[last].` Name the translation or edition used. Give the division as well when each division restarts at line 1 | [MLA9] |
| Prose block quotation | New line, whole block indented half an inch, no quotation marks; end with the quotation's own final punctuation, then `([Author] [page])` with no period after it. Four lines or fewer run in within double quotation marks | [MLA9] |
| Verse run in (up to three lines) | `"[line one] / [line two]"`, the slash spaced before and after, and `//` for a stanza break; cite as for prose | [MLA9] |
| Verse block (more than three lines) | Set off and indented half an inch with no added marks; reproduce unusual indents and spacing of the source as closely as possible; a line too long for the margin takes a hanging indent; the citation follows the last line, on a new line at the right margin if it does not fit | [MLA9] |
| Quotation in translation | `"[first text]" ("[second text]"; [citation of the first]; [citation of the second])`, or without parentheses `"[first text]" '[second text]' ([citation of the first]; [citation of the second])`. The translation follows the quotation (or precedes it throughout) and the citations keep that order. Cite the source of both. The same marks serve a translated word or phrase | [MLA9] |
| Own translation | `my trans.` stands where the translation's source would; the original passage is always supplied beside it | [MLA9] |
| Titles in another language | At first reference give the original title and its translation, one in parentheses, each styled by work type, the translated title capitalised as an English title. A published translation used alone needs no original title. In the list a translated title is usually unnecessary; if given it goes in square brackets after the original, styled the same | [MLA9] |

### Dates and numbers

| Item | Form | Tag |
|---|---|---|
| Months | Abbreviate every month except May, June and July (Jan., Feb., Mar., Apr., Aug., Sept., Oct., Nov., Dec.); a full date runs `[day] [month] [year]` | [MLA9] |
| Seasons | Lowercase, as in `winter [year]` | [DC] |
| Page ranges | Last two digits of the second number when it has more than two (`412-27`); two-digit ranges whole (`32-35`); full second numbers (`412-427`) are an acceptable lesser form | [MLA9] |

## 6. Example of form only

The work, names, publisher, year and page are invented. Use them to see the pattern, never as the author's citation. Page 58: check against your edition.

- Entry: `Tanvick, Oriel. *The Silt Registers*. Translated by Pell Dorrance, Marlowe Reach Press, 1931.`
- In text: `(Tanvick 58)`

## 7. Unconfirmed items

No supplied source settles these. Each is never an error and has no grade effect: write "check your style guide", name the point, and report no form defect for it.

| # | Point | Handling | Tag |
|---|---|---|---|
| U1 | A translator-first entry (the translator opens the entry and the author follows the title); the sources show only the author-first form | Never flag either opening | [U] |
| U2 | Standard passage numbers of ancient philosophy (the Stephanus and Bekker systems, a number plus a letter and sometimes line numbers) cited by name; only the general rule for divided works is supported | Never flag the numbers or their form | [U] |
| U3 | Two-edition numbering (first and second edition) and academy-edition numbering (the prefix `Ak.`) for modern classics | Never flag the letters, the prefix or a page-free citation | [U] |
| U4 | Newsletter posts as a named category | Never flag; use the web template and report no element as missing | [U] |
| U5 | AI-generated content: no MLA rule was supplied | Never flag. Only when the essay itself says it used an AI tool, write "check your style guide" and name the point, and report no element as missing; when it says nothing, check nothing | [U] |
