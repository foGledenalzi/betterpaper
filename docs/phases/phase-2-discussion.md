# Phase 2 discussion: workspace init, templates, tracker rules, minimal demo

Date: 2026-10-06

## Interactive answers

| Question | Answer | Consequence |
|---|---|---|
| Demo sources | All invented | Invented treatise, two invented editions, fake catalogue page; no licensing or accuracy risk; exact answer key (D17). |
| Ledger and tracker storage | Hybrid | Tables for human-facing parts; fenced `jsonl` blocks for tracker, quotation ledger and citation ledger; grammar in file contracts section 11 (D18). |
| Platforms | Windows, macOS and Linux | Scripts use `pathlib`, UTF-8 output, LF or CRLF input; the Python command is probed, never assumed (D19; mechanism in the grey-area sheet, row 23). |
| Draft formats | Word, Google Docs, Markdown or text, PDF or LaTeX, online links (Medium, Substack) | A seventh script, `import_draft.py`, converts `.docx` and saved `.html`; PDF by text extraction; URLs by WebFetch with a paste fallback (D20). |
| `.docx` and Google Docs intake | Add a standard-library importer | `import_draft.py` joins the Phase 4 script list; footnotes become `[^n]` notes; hidden text is dropped with a warning. |
| Citation by hyperlink | Add a link-citation style | Fourth style `links` and `references/web-links.md` with a new `[H]` house-rule tag (D21). |

## Grey-area sheet
`docs/phases/phase-2-open-decisions.md` holds 26 rows with recommended defaults (G1-G26): init interview and flags, workspace limits, imported history, privacy notice, locator numbering, declared thesis, assignment brief, spelling variety, tracker row size, anchor usability, `--confirm` behaviour, cross-essay anchors, demo size and labelling, Python probe, version floor. **Status: accepted as written (user, 2026-10-06: "Defaults fine for now").**

## Research subphase (next, after the sheet is answered)
1. Claude Code skill facts to confirm against the docs: `allowed-tools` syntax for `python`, `python3` and `py -3` patterns; `disable-model-invocation`; `argument-hint`; whether a skill may ask questions with the question tool; `${CLAUDE_SKILL_DIR}` and `${CLAUDE_PLUGIN_ROOT}` behaviour on Windows; script executability in a plugin.
2. `.docx` internals for `import_draft.py`: footnotes and endnotes parts, hidden-text property, quote style names, tracked changes, hyperlinks.
3. Link-citation conventions for online essays (Medium has no native footnotes; Substack has footnotes) and link-text accessibility guidance, as the grounds for the `[H]` rules in `web-links.md`.
4. Standard-library coverage for Python 3.9 on all three platforms (console encoding, path handling, newline handling).

## Build order (Phase 2)
`references/tracker-rules.md`; five templates; `references/web-links.md`; `skills/init/SKILL.md`; the demo (workflow with an independent answer-key check); Verify and push.

## Research status (2026-10-08)
Four notes in `docs/research/phase-2/`: `claude-code-skills.md` (tested with the installed CLI and independently re-verified; Windows parts are documented, not run), `docx-html-import-notes.md`, `link-citation-conventions.md` and `python-platform-notes.md`. Decisions drawn from them are recorded as A57-A68 in `DECISIONS.md`. Main consequences: script-prefix Python permissions instead of the broad pattern; `Edit(betterpaper/**)` instead of `Write(...)`; `Read(/${CLAUDE_PLUGIN_ROOT}/**)`; no Python command stored in `RUBRIC.md`; no draft intake by URL (WebFetch summarises); `omitClaudeMd: true` on agents; a stub agent that listed Bash was fixed.

