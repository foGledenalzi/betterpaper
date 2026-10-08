# Research note: `.docx` and saved-HTML import for `import_draft.py` (betterpaper Phase 2)

Researched 2026-10-07; re-verified and extended 2026-10-08 (retry). Generic only; every example text below is invented. Labels: [R] read in full on an official page, [S] seen only in a search snippet, [T] tested here, [I] inferred, [U] unverified. Test files and the prototype live in the session scratchpad, not in the repo.

## 0. Method and access limits (read first)

- **Rendered official sites were blocked [T].** The egress proxy refused (403 on CONNECT) learn.microsoft.com, ecma-international.org, docs.python.org, developer.mozilla.org, html.spec.whatwg.org, support.google.com, developers.google.com, help.medium.com, support.substack.com, medium.com and substack.com; on 2026-10-08 curl and WebFetch again failed for learn.microsoft.com and docs.python.org (EGRESS_BLOCKED), and for www.libreoffice.org. GitHub issue pages and the GitHub API are closed for repositories not enabled for the session, so I did not read any upstream issue text and did not attach a repository. I read the official docs' **source files** on raw.githubusercontent.com instead: "MS docs" = `OfficeDev/open-xml-docs` markdown, "CPython docs" = `python/cpython` `Doc/library/*.rst` (branches 3.9 and main), "MDN" = `mdn/content`, "WHATWG" = `whatwg/html` `source`. The ECMA-376 / ISO 29500 text itself was **not** obtained; claims about it are [S] or second-hand through the MS docs.
- Also read as implementations (evidence of how other tools behave, not of the standard): mammoth.js `body-reader.js`, `notes-reader.js`, `docx-reader.js` and the README head; pandoc `Docx.hs` and `Docx/Parse.hs` (parts); defuddle's Substack and Medium extractors and footnote code (parts); one Substack scraper's extraction function.
- Fixtures: 27 `.docx` files from the pandoc and mammoth test suites (made by Word 14 to 16 on Windows and Mac, by LibreOffice 3.5 and 6.2, or unknown) and 3 saved Medium pages from the Mozilla Readability test corpus. I dumped **structure only** (element, class and attribute names) and never read or recorded article text [T].
- Handling: downloads sit in their own `w-*` directories, were read as text or with `python3 -I`, and nothing from them was executed. `pandoc` and `soffice` ran only on files I generated myself.
- Environment: Python 3.9.25 (uv build installed by me), 3.11, 3.12, 3.13.16; pandoc 3.1.3; LibreOffice 24.2.7.2. **Not tested:** Windows, macOS, real Google Docs, live Substack or Medium pages.

## 1. OOXML facts

| Topic | Fact | Label, source |
|---|---|---|
| Package | A `.docx` is a zip of XML parts: `[Content_Types].xml`, `_rels/.rels`, `word/document.xml` (`w:body` > `w:p` > `w:r` > `w:t`), optional `footnotes.xml`, `endnotes.xml`, `comments.xml`, `styles.xml`, `settings.xml`, `numbering.xml`, headers, footers | [R] MS docs, Structure of a WordprocessingML document (parts beyond its table: [T] fixtures) |
| Main part | Find it through the `officeDocument` relationship in `_rels/.rels` (mammoth does; fallback `word/document.xml`). A decoy `word/document.xml` next to a differently targeted real part gives other text to a tool that hardcodes the name | [R] mammoth `docx-reader.js`; [T] S09c |
| Per-part rels | Each part has its own `.rels`: a hyperlink in a footnote resolves in `word/_rels/footnotes.xml.rels`, not in the document's | [R] mammoth reads rels per part; [T] D08b (same rId, two targets) |
| Note link | `w:footnoteReference w:id=N` in a run points at `w:footnote w:id=N` in `footnotes.xml`; endnotes the same with `w:endnoteReference` and `endnotes.xml` | [T] 7 files made by Word, pandoc and LibreOffice |
| Note ids | Ids are labels, not ordinals. Word 14 and 15 files: -1 separator, 0 continuationSeparator, then 1, 2. pandoc 3.1.3: 0 and -1, then 20 and 22. LibreOffice 24.2: 0 and 1, then 2 and 3 | [T] inspected files (pandoc `notes.docx`, mammoth `footnotes.docx`, my generated files) |
| Reserved notes | `w:type` is `normal` (default), `separator`, `continuationSeparator` or `continuationNotice`; special notes are also listed in `w:footnotePr` / `w:endnotePr` in `settings.xml`. Decide by `w:type`, never by id | [S] ST_FtnEdn snippet; [T] listed in Word and LibreOffice files |
| Note body | First run of a note holds `w:footnoteRef` (the auto-number glyph: drop it), then a run starting with a space; several paragraphs allowed. `w:customMarkFollows` (custom mark) not tested | [T] fixtures; [R] mammoth ignores footnoteRef; [U] custom mark |
| Unreferenced notes | A note nobody references is not displayed in Word, so it is an invisible-text route | [I] |
| Run properties | `w:rPr` is the first child of `w:r`; `w:b`, `w:i`, `w:vanish` are on/off elements: no `w:val` = true; `true`, `1`, `on` = true; `false`, `0`, `off` = false | [R] MS docs, Working with runs and Remove hidden text; [R] python-docx font analysis |
| Toggle properties | b, bCs, caps, emboss, i, iCs, imprint, outline, shadow, smallCaps, strike, vanish are toggles: in a style, "on" flips the inherited state and "false" leaves it; as direct formatting the value is absolute. LibreOffice follows this for italic (Emphasis inside an italic style renders normal) but keeps text hidden when both paragraph and character style set vanish, and when the paragraph style hides it while a run says `w:val="false"` (its HTML export marks that paragraph `display: none`) | [R] MS docs (vanish) and python-docx list; [T] LibreOffice 24.2 HTML export, re-run 2026-10-08; Word not available |
| Hidden text | `w:vanish` in a run's `rPr` hides it. `RunProperties` may also sit in `ParagraphProperties`, where it describes the paragraph mark, not the text (pandoc still prints the paragraph's text). Style-level hiding must be resolved (paragraph style, character style, docDefaults) | [R] MS docs; [I] mark-only reading; [T] D12 |
| Other invisible routes | `w:specVanish` = paragraph mark always hidden (run-in headings): text stays visible. `w:webHidden` hides in web layout only (LibreOffice HTML export hides it, pandoc shows it). White `w:color FFFFFF`, 1 pt `w:sz 2` and `vertAlign` leave the text in `w:t`. Old properties inside `w:rPrChange` are history, not state | [R] python-docx font analysis (element names and clause numbers only); [T] LibreOffice, pandoc, D14, D15 |
| Tools that leak | pandoc 3.1.3 prints run-level `w:vanish` text (markdown output); LibreOffice 24.2 `--convert-to txt` prints it too, while its HTML export wraps it in `display: none`; neither pandoc's nor mammoth's docx reader source mentions `vanish`; mammoth's README says it does no sanitisation | [T] fixture built 2026-10-08 (run `vanish` between two visible runs); [R] sources and README |
| Tracked changes | `w:ins` wraps inserted runs (keep); `w:del` wraps deleted runs whose text is `w:delText` (drop); `w:moveTo` keep, `w:moveFrom` drop; a deleted paragraph mark (`pPr/rPr/del`) joins the paragraph to the next; `pPrChange` and `rPrChange` hold the previous properties | [R] MS docs, Accept all revisions; [R] mammoth, pandoc source |
| Hyperlinks | `w:hyperlink r:id` > relationship of type `.../hyperlink`, `TargetMode="External"`; `w:anchor` = bookmark; both together = URL plus `#anchor`; field forms: `w:fldSimple w:instr='HYPERLINK "url"'` and complex fields (`fldChar` begin, `w:instrText`, separate, result runs, end). `w:instrText` is not `w:t` and must not be printed. The URL and the `w:tooltip` are invisible channels [I] | [T] pandoc `links.docx`; [R] mammoth, pandoc source |
| Run content | `w:br` (no type or textWrapping = line break; page, column), `w:cr`, `w:tab`, `w:noBreakHyphen`, `w:softHyphen`, `w:sym` (font plus char, e.g. Symbol F0DA) are run children, not text. mammoth maps soft hyphen to U+00AD and no-break hyphen to U+2011, which breaks verbatim quote matching | [R] mammoth; [T] `unicode.docx`; [I] consequence |
| Smart quotes | Stored as literal Unicode in `w:t`; nothing to convert (G11 normalises at comparison time) | [T] fixtures; [I] |
| Styles | Word: id `Heading1`, name `heading 1` (lowercase); `Title`, `Subtitle`; `Quote`; `IntenseQuote` ("Intense Quote"); `BlockText` ("Block Text"); `ListParagraph`; character styles `FootnoteReference`, `Hyperlink`, `Emphasis`, `Strong`. pandoc-made files capitalise names ("Heading 1") and add `FirstParagraph`. pandoc's rule: heading = name `heading N`, case-insensitive; quote = style inherited from Quote, Block Text, Block Quote, Block Quotation or Intense Quote (indentation only optionally). Custom styles chain through `w:basedOn`; `w:outlineLvl` can mark a heading | [T] fixtures; [R] pandoc `Docx.hs`, `Styles.hs`; [U] outlineLvl details |
| Lists | `w:numPr` (`w:ilvl`, `w:numId`) in the paragraph or in its style (List Bullet); bullet versus decimal lives in `numbering.xml` | [T] `lists.docx`, `simple-list.docx`; [I] numbering.xml |
| Comments | `w:commentRangeStart/End` plus a run with `w:commentReference` in the body; text is in `comments.xml`. Ignoring means never opening that part | [T] `comments.docx` |
| Text boxes | `w:txbxContent` inside `mc:AlternateContent` (Choice = DrawingML, Fallback = VML copy) or `w:pict`; iterating every `w:t` double-counts them. pandoc and mammoth read Fallback only; mammoth appends the box as a paragraph after its host | [R] mammoth README and source, pandoc source; [T] `text-box.docx` |
| Content controls | `w:sdt` > `w:sdtPr` + `w:sdtContent`, block or inline; read `sdtContent` | [R] mammoth, pandoc source; [T] D21 |
| Imported content | `w:altChunk` pulls an external HTML, RTF or docx part into the body; its text is not in `document.xml` | [S] ECMA-376 17.17.2.1 via a Microsoft API snippet |
| Other containers | `w:smartTag`, `w:customXml` are transparent; equations (`m:t`) and `w:ruby` carry text outside the `w:t` flow | [R] pandoc, mammoth; [T] D24 |

## 2. Google Docs `.docx` (mostly unconfirmed)

- No Google export was available and no public fixture turned up (five searches on 2026-10-07; on 2026-10-08 four more web searches and five GitHub issue searches; official Google help pages blocked). **No row below is settled**; each is a search snippet or a search tool's paraphrase of a page I could not open.
- [R] The mammoth README names Google Docs among the producers of the `.docx` files it targets, so a Word-shaped package is expected.
- [S] Low-grade snippets say a download carries comments and suggestions as comments and tracked changes, so the `w:ins` / `w:del` rules apply. [U] Google Docs has no hidden-text feature, so `w:vanish` in a "Google" file means it was edited elsewhere.
- **Headings.** [S] A library FAQ (https://libanswers.dominican.edu/Reference/faq/210474) says Heading 1 and 2 often do not show in Word's style list after a Drive download, and an ONLYOFFICE forum thread (https://community.onlyoffice.com/t/heading-styles-missing/1215) says the headings are recognised but cannot be reached from the style list. [U] The style ids (`Heading1`...) are unconfirmed. [I] Resolve headings by `w:name`, the `basedOn` chain and `outlineLvl`, never by the gallery or one hard-coded id (D02 does).
- **Quotes.** [S] Writing guides for Google Docs tell people to indent (Format, Align and indent, about 0.5 in); one search summary could not confirm that Docs has a "Block quote" paragraph style. [U] So style-based detection probably finds no blockquote and those paragraphs import as plain text. [I] Do not guess by indentation: pandoc offers it only as an option [R].
- **Notes.** [S] A LibreOffice bug (https://www.libreoffice.org/bugzilla/show_bug.cgi?id=152203, blocked here; summary only) reports footnotes in a Docs-exported `.docx` landing in the wrong order because the importer paired text by position in the file, with fixes and regressions in later bugs (153255, 153804). [I] A Google `footnotes.xml` may not be in reading order: pair by `w:id` and number by reference order (D08 does). [S] Zotero forum staff replies say Docs has footnotes but no endnotes, while a 2014 blog says exported notes were endnotes cross-referenced by links: conflicting, so handle both kinds and never assume one part (D09).
- **Links.** [S] One StackExchange answer (mirror: https://backiee.wasmer.app/https_webapps_stackexchange_com/a/43146, undated) says `.docx`, `.odt`, `.rtf`, `.txt` and `.html` downloads keep the real URL and only PDF gets a redirect; [S] a defanging tool (https://zff.dev/hrbrmstr/defang-google-docs) says HTML and EPUB exports wrap external links as `https://www.google.com/url?q=<target>&sa=D&source=editors&ust=...&usg=...`. The two sources disagree on HTML and neither covers `.docx`: [U] whether `.docx` links are `w:hyperlink` or fields, and whether targets are wrapped. [I] Unwrap a `google.com/url?q=` target in `.docx` as well as HTML (cheap, host-checked); the prototype does it for HTML only [T] H06. [R] defuddle's Google Docs HTML markup: inline `sup[id^="ftnt_ref"] > a[href^="#ftnt"]`, definition `p[id^="ftnt"]` with a back-link `a[href*="#ftnt_ref"]` [T] H09.
- **Not found at all:** run-property style of Google output (for example explicit `w:val="0"` toggles): [U]; the importer accepts `false`, `0` and `off` anyway (D03). A mammoth issue titled "Google Docs - Export Word - Style issue" exists [S, title only; its text could not be read].
- Action: write tests on Word-shaped structure only; the owner supplies one real Google export (private, never committed) and we run a names-only structure dump on it before any Google claim is settled.

## 3. Safety when parsing untrusted XML and zips (stdlib only)

| Attack | Result here | Mitigation | Label |
|---|---|---|---|
| Billion laughs, quadratic blowup | `ET.fromstring` on 3.9.25 (expat 2.6.3) and 3.13 (2.6.1): ParseError "limit on input amplification factor". The 3.9 docs say expat >= 2.4.1 is safe; the main docs say expat < 2.7.2 may be vulnerable | Do not rely on the bundled expat: refuse any DOCTYPE or ENTITY first | [R] CPython docs xml.rst (3.9, main); [T] |
| External entity, external DTD | ET does not expand (ParseError undefined entity); a DTD `SYSTEM` reference parses silently, nothing fetched | Same refusal (a DOCTYPE has no place in OOXML) | [R] docs; [T] |
| Hiding the DOCTYPE | A byte scan for `<!DOCTYPE` misses a UTF-16 part | Pre-pass with `xml.parsers.expat` handlers (`StartDoctypeDeclHandler`, `EntityDeclHandler`, `NotationDeclHandler`, `UnparsedEntityDeclHandler`, `ExternalEntityRefHandler`) that raise, then `ET.fromstring`; expat does the decoding | [T] S02; handlers removed = S01-S04 fail |
| Deep nesting | 100,000 nested elements parse in ET, but any recursive walker and `ET.tostring` raise RecursionError | Count depth in the same pre-pass, refuse beyond 100 (real bodies nest under 20) | [T] S08 |
| Zip bomb | 100 MB of spaces deflates to 103 KB | Refuse on `ZipInfo.file_size` over 20 MB or ratio over 200 before reading; read with `read(cap + 1)`; only open the parts the importer names | [T] S05; [I] the thresholds |
| Lying zip headers | Declared size too small: `zipfile` truncates, then fails the CRC; too large: caught by the cap | Treat `BadZipFile` as exit 2 | [T] S11 |
| Duplicate member names | `zipfile` returns the **last** duplicate, pandoc reads the **first**, LibreOffice produced no output: a parser differential | Refuse duplicates (case-insensitive) | [T] S09b |
| Path escape | Nothing is extracted, but refuse names with `..`, a leading `/`, a backslash or a drive prefix; CPython docs warn against extracting untrusted archives without inspection | Refuse the archive | [R] zipfile.rst (3.9); [T] S06 |
| Member count, nested zips | A 1,100-member zip and a 300-segment member name are cheap to build | Refuse over 1,000 members; never open nested archives, `altChunk` parts or `r:link` targets | [T] S07, S09; [R] mammoth README warns about external files |

Rule [I]: no network access and no file access beyond the one input path and the optional `--out` path.

## 4. Saved HTML (Substack, Medium)

- **Substack body.** [R] defuddle: the rendered post body is `div.body.markup`; server-rendered HTML may hold it only inside a `window._preloads` JSON string (`body_html`).
  - [I] A stdlib importer should not parse that script JSON (untrusted); treat such a page as a script shell and ask the user to save the rendered page.
  - [R] A scraper uses `div.available-content`, `h1.post-title`, `h3.subtitle` and `h2.paywall-title` (paywall marker).
  - [U] Live markup (hosts blocked): my fixtures follow these selectors, so they test the importer, not Substack.
- **Substack footnotes.** [R] defuddle source: inline `a.footnote-anchor` (id `footnote-anchor-N`); definition `div.footnote[data-component-name="FootnoteToDOM"]` holding `a.footnote-number` (id `footnote-N`) and `.footnote-content`. [S] The editor has a Footnote button. [T] H02.
- **Medium.**
  - [S] No native footnotes; superscript is digits only (typed with `^`), so authors fake notes with `sup` digits and a trailing list: keep the digits as plain text.
  - [T] Three saved pages. Two use an older DOM: `article.postArticle > section > div.section-inner > p.graf--p`, `h3`/`h4` with `graf--*` classes, `figure.graf--figure`, `a.markup--anchor`, `blockquote.graf--pullquote`. One has hashed class names, so only tags are stable: `article`, `h1`, `h2`, `p`, `blockquote`, `em`, `strong`, `a`, `li`, `figure`; it also carries `div aria-hidden="true"`, `noscript` and `img role=presentation`.
  - [R] defuddle's Medium extractor: `article.meteredContent` or `article`, `[data-testid="storyTitle"]`, `.pw-subtitle-paragraph`, promo links to `medium.com/plans`, UI strings such as "Member-only story" and "Press enter or click to view image in full size".
  - [I] Pull quotes repeat a body sentence.
- **Hidden elements.** [R] WHATWG and MDN: `hidden` with any value (empty, `hidden`, `until-found`, even invalid) is not rendered; CSS `display` can override it. [R] MDN: `aria-hidden="true"` only removes content from the accessibility tree, the text stays visible. [R] defuddle drops `[hidden]`, `[aria-hidden="true"]` (except math, svg, paywall) and `.hidden`, and avoids substring-matching `display: none` in styles (false positives). Class-based hiding (stylesheet rules, `.sr-only`) cannot be seen without a CSS engine [I].
- **Parser behaviour.** [T] `html.parser` on 3.9.25, 3.11, 3.13: comments (also unclosed), CDATA and processing instructions go to their own handlers, never to text; `<noscript>` content is parsed as ordinary tags; `script` and `style` bodies are raw text up to the first end tag; `title` and `textarea` bodies are raw text. [R] The `scripting` argument exists only in patched releases (3.9.25 and later): do not pass it. Older 3.9.x behaviour [U].
- **Drop by tag:** script, style, noscript, template, head, iframe, svg, canvas, object, embed, video, audio, nav, footer, aside, form, button, select, textarea, input, dialog, title, math, plus comments, plus anything hidden by `hidden`, `aria-hidden="true"`, inline `display:none`, `visibility:hidden`, `opacity:0` or `font-size:0` (CSS comments and spacing normalised first), each with a warning and a character count [T] H03, H04.
- **Container:** `div.available-content`, `div.body.markup`, then the largest `article`, `main`, `body` [T]. **Real-page smoke test [T]:** the three Medium pages convert without error (83, 28 and 194 blocks; 13, 7 and 24 links), no text read.
- **Paywall or shell.** [I] If fewer than 60 words of non-heading text remain: marker text (a subscription prompt, Member-only story, create an account to read, sign in to read) = "paywall or preview only"; scripts present and no article container = "script shell"; otherwise "no article text found"; exit 2 with that reason, which matches the PLAN's "ask the user to paste or save the page" fallback [T] H05.

## 5. Mapping and test cases

| Source | Markdown | Notes |
|---|---|---|
| Body paragraphs, in order | text lines separated by one blank line | empty paragraphs skipped |
| Title, Heading N, outline level | `#` to `######` | Subtitle = `##`; emphasis from the style itself ignored |
| Quote, Intense Quote, Block Text, Block Quote(ation), or a style based on them | `> text`, per line | the style's own italics not turned into `*` |
| List paragraph (`numPr`, direct or from style) | `- ` plus two spaces per level | numbered lists become bullets (numbering.xml not read) |
| Italic, bold (direct, character style, toggle-aware with the paragraph style) | `*..*`, `**..**`, `***..***` | equal neighbours merged; edge spaces moved outside |
| Underline, strike, caps, small caps, sub or superscript | plain text, stored case | |
| Hyperlink | `[text](url)` | http, https, mailto, `#anchor`; other schemes: text only plus warning; `( )` and spaces percent-encoded |
| Footnote or endnote reference | `[^n]`, n by first reference across both kinds | a repeat reuses n plus warning |
| Note text | `[^n]: text` at the end; extra paragraphs indented four spaces | missing: `[note text missing]` plus warning |
| Separators, unreferenced notes | dropped | warning for unreferenced |
| `w:vanish` text | dropped plus warning | hidden at any level (direct, character style, paragraph style) stays hidden, even over a direct `false`, which gets its own warning (decision 3) |
| White, tiny (<= 2 pt), webHidden text | kept plus warning; `w:specVanish` (paragraph mark) changes nothing | decision 1 |
| `w:ins`, `w:moveTo` / `w:del`, `w:moveFrom`, `delText` | kept / dropped | deleted paragraph mark joins the next paragraph |
| Table / image, drawing, pict, object | `[table omitted]` / `[image omitted]` | alt text dropped with the image |
| Text box, `altChunk`, equation, unknown container with text | `[text box omitted]`, `[embedded content omitted]`, warning with count | check: body `w:t` characters minus emitted minus omitted must be 0, else warn |
| `w:br`, `w:cr` / tab / no-break hyphen / soft hyphen / `w:sym` | two spaces plus newline / space / `-` / nothing / nothing plus warning | |
| Comments, headers, footers, `docProps`, custom XML | never read | |
| Markdown specials in text | `\ * _ [ ]` and the backtick escaped; line-leading `# > - + 1.` escaped | decision 4 |
| HTML `em i cite` / `strong b` / `a` / `blockquote` / `ul ol li` / `br` | `*` / `**` (not in headings) / link, Google redirect unwrapped / `> ` / `- ` `1. ` / hard break | scripts, nav, comments dropped silently; hidden elements with warning |
| HTML note refs | Substack anchors, `sup > a[href="#id"]` to an existing id, Google `ftnt_ref` > `[^n]` plus appended definition | definition removed from the body; dangling anchor: no marker |
| HTML figure, img / table | `[image omitted]` / `[table omitted]` | alt and title attributes dropped |

**Test cases.** The 32 rows below (about 45 cases) are implemented in the scratchpad prototype (48 unit tests) and pass on 3.9.25, 3.11, 3.12 and 3.13 [T]. Inputs are invented. "Exit 2" means bad input.

| ID | Input | Expected |
|---|---|---|
| D01-02 | three paragraphs; Title, Heading1 (name `heading 1`), a style based on Heading1, id `Heading2` with no styles part | `One.` `Two.` `Three.`; `# Top`, `# Sec`, `# Custom`, `## Sub` |
| D03-04 | `w:i`, `w:i w:val="false"`, `"0"`, `"off"`, bold+italic; two adjacent italic runs; a bold run ending in a space | `*a* b c d ***e***`; `*abcd* next **word** end` |
| D05 | italic paragraph style, one run with character style Emphasis | `*plain* toggled` (emphasis toggles off); style alone: `*only style*` |
| D06 | Quote, IntenseQuote, BlockText, a style based on Quote with one direct-italic word | `> q1`, `> q2`, `> q3`, `> a *b* c` |
| D07 | `r:id` link, anchor link, `fldSimple` link, complex-field link, `javascript:` link | `[site](https://e.example/a?b=%28c%29)`, `[inner](#sec1)`, two field links, `[bad](#)`, 5 links, 1 warning |
| D08 | references to ids 7 then 3; separators -1 and 0 present | `A[^1] B[^2]`, `[^1]: seven`, `[^2]: three`, 0 warnings |
| D08b, D09 | same rId in document and footnote rels; endnote id 1 then footnote id 1 | footnote link uses the footnote rels; one counter `[^1]` end, `[^2]` foot |
| D10 | reference to absent id 42 and to separator id 0; real note 1 unreferenced | `[^1]` and `[^2]` both `[note text missing]`, 2 warnings plus "never referenced" |
| D11 | a note with imperative text, never referenced | text absent from output, warning |
| D12 | `w:vanish` on / `false` / `0` / `on`; hidden character style; hidden paragraph style; direct `false` under a hidden paragraph style; both styles | `seen shown a`, 3 hidden-text warnings; the direct-`false` paragraph is dropped with "hidden by style but run says false"; both styles = hidden |
| D13 | `w:vanish` run inside a footnote | `ok end`, warning |
| D14 | white text, 1 pt text; `w:webHidden` on and `w:val="0"`; `w:specVanish` on the paragraph mark | all kept; warnings for white, tiny and the one web-hidden run (`w x y` stays whole) |
| D15 | `w:ins`, `w:del` with `delText`, `moveFrom`, `moveTo`, `rPrChange` holding old vanish and italic | `keep added moved-in fmt` |
| D16 | first paragraph's mark deleted | `first second` as one paragraph |
| D17 | table, drawing, text box (Choice and Fallback copies) | `[table omitted]`, `[image omitted]`, `[text box omitted]` once, no "not accounted" warning |
| D18, D23 | curly quotes, tab, `w:br`, soft hyphen, no-break hyphen; zero-width and bidi characters | `“Quoted” it’s tab  \nlinesoft-hard`; controls kept in place plus warning |
| D19 | `numPr` levels 1 and 0; List Bullet with `numPr` in the style | `  - one`, `- two`; `- x`, `- y` |
| D20-21 | comment range, reference and `comments.xml` text; block and inline content controls | comment text absent; control text kept |
| D22 | text holding `*`, `_`, a literal `[^1]`, a backtick and a backslash; paragraphs starting `# ` and `1. ` | every special escaped, so no accidental emphasis, note or list |
| D24 | `w:ruby` holding text | omitted, warning with the count |
| S01, S04 | DOCTYPE with an internal entity; external `SYSTEM` entity | exit 2 "DOCTYPE or entity" |
| S02 | the same DOCTYPE in a UTF-16 part | exit 2 (a byte scan finds nothing) |
| S03 | billion laughs in `footnotes.xml` | exit 2 before parsing |
| S05, S11 | 60 MB padded `document.xml`; header size patched to 10 and to 10^9 | exit 2 each (cap or CRC) |
| S06, S07 | members `../x`, `/abs/x`, `a\..\x`, `C:x`; 1,100 members | exit 2 each |
| S08 | 150 nested `w:ins` | exit 2 "nesting deeper", no RecursionError |
| S09, S09b, S09c | nested `.docx` member and 300-segment name; two `word/document.xml`; root rel targets `word/main2.xml` with a decoy `document.xml` | nested ignored; exit 2; text of `main2.xml` |
| S10 | empty file, truncated zip, text file, no `w:body` | exit 2 each |
| H01-02 | h2, em, strong, link, blockquote, ul, ol; Substack anchors with `div.footnote` blocks | `## Head`, `*em*`, `**strong**`, link, `> `, `- `, `1. `; `[^1] [^2]`, each definition once |
| H03-04 | `hidden`, `aria-hidden`, `DISPLAY : none !important`, a CSS comment inside the property name, `visibility:hidden`, hidden parent, `font-size:0`; script, style, noscript, comment, nav, footer | all absent, 7 warnings; none of the dropped text appears |
| H05-06 | paywall teaser; script shell; Medium-like `article` with figure and Google redirect link | exit 2 "paywall", exit 2 "script shell"; `[image omitted]`, unwrapped link |
| H07-09 | 5,000 nested divs; `sup > a[href="#missing"]` with mis-nested `b` and `i`; `sup > a#ftnt_ref1` with `p#ftnt1` | exit 2; no marker, no crash; `[^1]` plus definition |

## 6. Builder design and prototype record

- **Builders (about 110 lines, copied into each test module; no binary is committed).**
  - `docx(body, footnotes=, endnotes=, styles=, hyperlinks=, extra_parts=, raw_document=)` writes `[Content_Types].xml`, `_rels/.rels`, `word/document.xml`, `word/_rels/document.xml.rels` and the optional parts into `io.BytesIO` through `zipfile.ZipFile(..., "w")` and returns bytes.
  - String-template helpers: `r(text, i=, b=, vanish=, rstyle=, extra=)` (None = absent, True = bare element, False = `w:val="false"`, a string = raw value), `p(*runs, style=, ppr_extra=)`, `fn_ref(id, kind)`, `note(id, runs, type_)`, `notes_xml`, `STD_NOTES` (the two separators), `style(...)`, `styles_xml`, `html_page(body)`. Text inside uses invented sentences only.
- **Adversarial inputs, all built at test time.**
  - `raw_document=` takes raw bytes (the UTF-16 DOCTYPE); `extra_parts` takes hostile member names, a nested `.docx` built with `zipfile`, or 1,100 filler members.
  - A bomb is a padded string (100 MB deflates to about 100 KB); duplicate names come from `zipfile` under `warnings.catch_warnings()`; a lying header is `struct.pack_into` on the central-directory size field; the decoy test rewrites `_rels/.rels`.
- **Harness.** Import the script's convert function for speed; use `subprocess` for exit codes, stdout and the stderr summary. `python3 -I` cannot be combined with `-m unittest` because the current directory leaves the path [T]; run tests as `python3 -m unittest` from the scripts folder per the Phase 4 contract. Write temp files with `tempfile.TemporaryDirectory()`.
- **Prototype record [T].**
  - 48 tests pass on 3.9.25, 3.11, 3.12 and 3.13 (re-run 2026-10-08 after two changes below).
  - Ten mutations each make at least one test fail: all declaration handlers removed, vanish drop, depth cap, size cap, member-path check, unreferenced-note drop, direct-children-only `rPr` lookup, style toggle, and (added 2026-10-08) the webHidden branch and the style-over-direct-false rule. Removing only one declaration handler does not, because they overlap.
  - Changes made on retry: the importer's `w:vanish` rule became conservative (style wins over a direct `false`, because LibreOffice keeps that text hidden and Word is untested), and `w:webHidden` now gets the warning the mapping table promised; the first version had neither.
  - Smoke: all 27 downloaded `.docx` files convert on 3.9.25 and 3.13; pandoc- and LibreOffice-written files round-trip to the source Markdown; 20,000 paragraphs (4.8 MB of XML) take 1.0 s on 3.13 and 1.4 s on 3.9.

## 7. Risks found

- pandoc and mammoth both pass hidden text through, and so does LibreOffice's plain-text export; any shortcut that shells out to a converter silently reopens the injection route [T, R].
- A style-hidden paragraph with a run that says `false` is a conflict whose Word rendering is untested here; a rare, suspicious construct, so the importer drops and warns [T LibreOffice, U Word].
- Interpreters differ on duplicate zip entries and style toggles, so an importer that disagrees with Word shows the grader text the author never sees (parser differential) [T].
- Separator ids, note ids and style names vary by generator; hard-coded `-1`, `0`, `Heading1` or `heading 1` breaks on pandoc and LibreOffice files [T].
- The invisible channels left open: hyperlink URLs and tooltips, `w:placeholder` text, bookmark names, `docProps`, headers and footers (never emitted, but URLs are) [I].
- Medium pull quotes would import as blockquotes and duplicate a body sentence; hashed class names make them undetectable [I, T].
- Unlinked superscript digits glue onto words and can break exact quote matching [I]. `w:customMarkFollows` and `numbering.xml` bullet or decimal detection are untested [U].
- Older 3.9.x patch releases lack the html.parser fixes and the `scripting` argument [R, U]; expat bundled with older Python installers may lack the amplification limit [R], which is why the DOCTYPE refusal comes first.
- Live Substack markup, real Google Docs output and Windows newline behaviour (`sys.stdout.reconfigure(encoding="utf-8", newline="\n")`) are unverified [U].

## 8. Sources read (raw files on raw.githubusercontent.com unless noted)

- [R] MS docs: `OfficeDev/open-xml-docs/main/docs/word/` `structure-of-a-wordprocessingml-document.md`, `working-with-runs.md`, `how-to-remove-hidden-text-from-a-word-processing-document.md`, `how-to-accept-all-revisions-in-a-word-processing-document.md` (rendered at https://learn.microsoft.com/en-us/office/open-xml/word/ plus the same name, blocked here).
- [R] CPython docs: `python/cpython/3.9/Doc/library/` `xml.rst`, `zipfile.rst`, `html.parser.rst`, and `main/Doc/library/` `xml.rst`, `html.parser.rst` (rendered at https://docs.python.org/3/library/xml.html, blocked).
- [R] MDN: `mdn/content/main/files/en-us/web/html/reference/global_attributes/hidden/index.md` and `.../web/accessibility/aria/reference/attributes/aria-hidden/index.md`. [R] WHATWG: `whatwg/html/main/source`, section "The hidden attribute" (https://html.spec.whatwg.org/multipage/interaction.html#the-hidden-attribute, blocked).
- [R] python-docx: `python-openxml/python-docx/master/docs/dev/analysis/features/text/font.rst`. Implementations: `mwilliamson/mammoth.js/master/` `README.md`, `lib/docx/body-reader.js`, `notes-reader.js`, `docx-reader.js`; `jgm/pandoc/main/src/Text/Pandoc/Readers/` `Docx.hs`, `Docx/Parse.hs`, `Docx/Parse/Styles.hs`; `kepano/defuddle/main/src/` `extractors/substack.ts`, `extractors/medium.ts`, `elements/footnotes.ts`, `constants.ts`; `timf34/Substack2Markdown/main/substack_scraper.py`.
- Fixtures: `jgm/pandoc/main/test/docx/*.docx`, `mwilliamson/mammoth.js/master/test/test-data/*.docx`, `mozilla/readability/main/test/test-pages/medium-1`, `medium-2`, `medium-3` (`source.html`); structure dumps only.
- [S] snippets: ST_FtnEdn values (Microsoft API reference, mirrored at https://webapp.docx4java.org/OnlineDemo/ecma376/WordML/ST_FtnEdn.html); altChunk (https://learn.microsoft.com/en-us/dotnet/api/documentformat.openxml.wordprocessing.altchunk); Medium superscript (https://help.medium.com/hc/en-us/articles/215194537-Edit-post); Google HTML link wrapping (https://zff.dev/hrbrmstr/defang-google-docs); Google footnotes as endnotes (https://blog.ouseful.info/2014/12/04/exporting-markdown-and-xml-from-google-docs/); suggestions in downloads (https://nira.com/track-changes-google-docs/); Substack footnote button (https://on.substack.com/p/how-to-use-the-substack-editor); Docs has no endnotes (https://forums.zotero.org/discussion/comment/325268); the Google items in section 2 (library FAQ, ONLYOFFICE thread, LibreOffice bug 152203, link answers) are search-tool summaries of pages I could not open.

## 9. Decisions needed (recommendation first)

1. **White, tiny and webHidden text:** keep and warn (recommended; the precheck's injection check can then see it, and white-on-dark shading would otherwise lose real text) or drop with warning (safer against injection, silently shortens the draft).
2. **`aria-hidden="true"` subtrees:** drop with a warning and a character count (as the brief says), although MDN says `aria-hidden` text can still be visible, so some real text may be lost.
3. **Vanish across style levels:** hidden if any level hides it, even over a direct `false`, with its own warning (recommended; LibreOffice's HTML export agrees [T]; wrongly dropped text is rare and flagged) versus "direct `false` wins" or the spec's toggle (both would show a grader text that Word may hide; Word could not be tested).
4. **Escaping:** the importer escapes `\ * _ [ ]` and the backtick; require one shared normaliser (unescape `\X`, strip emphasis markers and `[^n]`) in `check_cited_spans.py` and `echo_check.py`, and record it in the file contracts. Without it a quote containing `*` or `_` fails verbatim matching.
5. **Output channels and exit codes:** the contract prints `paragraphs: N, notes: M, links: L, warnings: W` and writes Markdown to stdout by default; send the summary and warnings to stderr so stdout stays pure Markdown. Define `paragraphs` as non-heading, non-quote text blocks (G7). Paywall, shell, unsafe XML and unreadable zips exit 2 with a one-line reason.
6. **Text boxes:** omit with a warning (recommended; boxes can sit off-page) versus mammoth's append-after-host.
7. **Paragraph-style emphasis:** ignored in heading and quote paragraphs, applied toggle-aware elsewhere (recommended).
8. **Quotes by style name only,** no indentation heuristic (Google Docs and indent-only quotes arrive as plain paragraphs and shift paragraph numbers).
9. **Owner action:** one real Google-exported `.docx` and one saved Substack page (private, structure dump only) before the Google and Substack rows move from [U] to settled.
