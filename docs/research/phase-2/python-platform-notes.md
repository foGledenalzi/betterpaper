# Research note: seven stdlib-only Python 3.9+ scripts on Windows, macOS and Linux (betterpaper Phase 2)

Researched 2026-10-08. Labels: [R] read in full on an official page (URL or file given), [S] seen only in a search snippet, [T] tested here, [I] inferred, [U] unverified. All example text is invented. Feeds D19, G23-G26, file contracts sections 6 and 11, and the Phase 4 scripts.

## 0. Method and limits (read first)

- **Environment.** A Linux container only: no Windows, macOS, zsh or PowerShell. Everything about those is [R], [S], [I] or [U], never [T]. Interpreters tested: CPython 3.9.25 (a uv standalone build found at `~/.local/bin/python3.9`), 3.11.17 and 3.13.16 (the default `python3`). Claude Code 2.1.293.
- **Python docs.** docs.python.org is blocked by the egress proxy (403). I read the `.rst` sources of the official docs from `python/cpython` on raw.githubusercontent.com (branches 3.9, 3.10, 3.11, 3.13, main) and call them [R] with the file name, for example "windows.rst (3.9)". Claude Code pages (`setup`, `tools-reference`, `permissions` under `https://code.claude.com/docs/en/<page>.md`) were downloaded; I read the Windows, Bash, PowerShell and read-only-command sections. learn.microsoft.com and zsh.sourceforge.io are blocked: those facts are [S] or [U].
- **Tests.** Several hundred local interpreter runs plus 11 `claude -p` runs (model haiku, default permission mode, about 0.03 USD). Prototypes (not in the repo, rebuild from this note): scratchpad `python-platform-notes/{preamble,compat,paths,text,ut,probe}`. The code block in section 2 is the tested file `preamble/snippet_tool.py`.

## 1. Finding a working Python from the shell tools

**Which shell runs the command [R].** Native Windows with Git for Windows: the Bash tool is Git Bash and the PowerShell tool is also available (on by default for claude.ai and Console accounts). Without Git for Windows: PowerShell only. WSL, Linux, macOS: Bash (setup.md "Set up on Windows"; tools-reference.md "PowerShell tool"). The Bash tool sources `~/.zshrc`, `~/.bashrc` or `~/.profile` "depending on your shell" [R, tools-reference.md "Bash tool behavior"], so on macOS it is probably zsh [I]. Environment variables do not persist between Bash calls [R], so the chosen command must be written into each command line. Before v2.1.214, Python printing non-ASCII through the PowerShell tool could crash with `UnicodeEncodeError` [R].

**What each platform gives you.**

| Platform | Facts | Label |
|---|---|---|
| Windows, python.org installer | `py` launcher is on PATH for system-wide installs, not for per-user installs unless chosen; `python.exe` is on PATH only if "Add Python to PATH" is ticked; no `python3.exe` is documented for it [I] | [R] windows.rst (3.9) |
| Windows, Store package | `python`, `python3`, `python3.x` aliases (3.9 docs); typing `python` can "open the Store app" when nothing is installed (main docs) | [R] windows.rst (3.9, main) |
| Windows, stub with arguments | prints "Python was not found; run without arguments to install...", exit code probably 9009 | [S] two forum threads; exit code single-source |
| Windows, new Python install manager | `python`, `py`, `pymanager` and a `python3` that "is not meant to be widely used". `-V:` may be omitted when the tag starts with 3, so `py -3` should still work [I]. **With no runtime installed, any launch command (even `py -3 --version`) tries to download and install the latest one** (`PYTHON_MANAGER_AUTOMATIC_INSTALL`) | [R] windows.rst (main) |
| macOS | `/usr/bin/python3` is a shim; without the Command Line Tools it prints a note and opens an install dialog, still exiting non-zero | [S] Apple developer forum threads |
| Linux | `python3` normal; `python` often absent (minimal Debian and Ubuntu); old enterprise distros may ship `python3` below 3.9 | [I] |
| Git Bash arguments | MSYS rewrites POSIX-looking arguments passed to native Windows programs; drive-letter paths are exempt; `MSYS_NO_PATHCONV=1` disables it | [S] CloudBees and other guides |

**Permission facts for the probe [T] (Linux, `claude -p`, default mode, no allow rules unless stated).** `python3 --version` and `python --version` ran without a prompt. `python3 -V`, `python3.9 --version`, `py -3 --version`, `command -v python3` and `python3 -c "..."` each required approval. A single rule `--allowedTools 'Bash(py -3 --version)'` let the whole chain below run with `is_error=False`; without it the harness named the `py -3 --version` part. A command not found is reported as text (`py: command not found`), not a crash. The chain's last command decides the error flag, so end with `echo "[end]"`. `PowerShell(...)` rules are separate and untested [R, U].

**Recommended probe (one Bash-tool call; the same text is intended for the PowerShell tool).**

```
echo "[python3]"; python3 --version; echo "[python]"; python --version; echo "[py -3]"; py -3 --version; echo "[end]"
```

- [T] Run through `bash` and `dash` with fake commands on PATH (a Store-style stub printing the message and exiting 49, a Python 2 style `python` printing to stderr, a `py` reporting 3.8, a 3.9 `python` beside a 3.12 `py`, and none at all): always exit 0, one labelled line per candidate, nothing hangs. Also run through the real Bash tool (`claude -p`) with real commands: `python3` and `python` present, `py` absent. Add `Bash(py -3 --version)` (and a `PowerShell(py -3 --version)` twin [U]) to the skill's `allowed-tools` (same rule syntax as the `--allowedTools` flag used in the test [I]); the other two need no rule.
- **Choice rule for the skill.** Take the first block whose line matches `^Python 3\.(9|[1-9][0-9])\.`. Stubs, Python 2, "command not found" and 3.8 never match, so the accepted order python3, python, py -3 (G23) is safe on every platform [I]. If none match: stop and say "Python 3.9 or later not found" with install pointers; do not retry with other spellings.
- **Why this shape [S/I].** No variable expansion (zsh does not word-split an unquoted `$cmd`, so `py -3` held in a variable fails [S]); brackets inside double quotes (an unquoted `[python3]` is a glob, and zsh errors on a glob with no match [S for the error, I for this case]); no `&&`/`||` (absent in PowerShell 5.1 [I]); no `2>&1` (the Bash tool already returns stderr [T]; PowerShell wraps redirected native stderr as error records [U]); no `command -v` and no `-c` (approval needed [T]); no `VAR=value` prefix (not PowerShell syntax [I]).
- **Side effect.** On Windows with only the new install manager and no runtime, "any launch command will try to install the requested version" [R windows.rst (main)], so `python --version` or `py -3 --version` may start a download. Splitting the probe does not avoid it (it happens only when nothing else works); say so in the README [I].
- **What to store as `python_cmd`.** The bare spelling, one of the closed set `python3`, `python`, `py -3` (optionally `python3.N` if the user supplies it). Not `sys.executable`: it is machine-specific, often holds spaces (`C:\Program Files\...`), and no longer matches the `Bash(python3 ...)` allow patterns. Before interpolating the value into a command, match it against `^(python3|python|py -3)$`: `RUBRIC.md` is data an essay folder can alter [I]. Invoke as `<python_cmd> "<script>" args` with the path in double quotes. The cached value is a hint: re-probe when a call fails (exit 127/9009 or no output). File contracts section 1 has no `python_cmd` key, and a workspace synced across the user's three systems cannot hold one correct value; see Decisions 1.

## 2. The script preamble

Every script starts with this ([T] file `snippet_tool.py`; compiles on 3.9 and passes the section 3 checker):

```python
"""Invented demo tool: prints a word count and the first line of a text file."""
from __future__ import annotations
import argparse, os, sys, tempfile
from pathlib import Path

if sys.version_info < (3, 9):  # keep this guard parseable on old interpreters
    sys.stderr.write("error: Python 3.9 or later is required\n")
    raise SystemExit(2)
EXIT_OK, EXIT_FAIL, EXIT_BAD_INPUT = 0, 1, 2
MAX_BYTES = 2 * 1024 * 1024

class BadInput(Exception):
    """Input the user can fix."""

def use_utf8_streams() -> None:
    for stream in (sys.stdout, sys.stderr):
        reconfigure = getattr(stream, "reconfigure", None)  # StringIO and some wrappers have none
        if reconfigure:
            try:
                reconfigure(encoding="utf-8", errors="backslashreplace", newline="\n")
            except (OSError, ValueError):
                pass

def read_text(path: Path, max_bytes: int = MAX_BYTES) -> str:
    if not path.is_file():  # also rejects directories, FIFOs and devices
        raise BadInput(f"{path} is not a regular file")
    try:
        with path.open("rb") as handle:
            raw = handle.read(max_bytes + 1)  # bounded read
    except OSError as exc:
        raise BadInput(f"cannot read {path}: {exc.strerror}") from None
    if len(raw) > max_bytes:
        raise BadInput(f"{path} is larger than {max_bytes} bytes")
    encoding = "utf-16" if raw.startswith((b"\xff\xfe", b"\xfe\xff")) else "utf-8-sig"
    try:
        text = raw.decode(encoding)  # strict: never errors="replace" for a draft or a source
    except UnicodeDecodeError as exc:
        raise BadInput(f"{path} is not valid {encoding} (byte {exc.start}); re-save it as UTF-8") from None
    if "\x00" in text:
        raise BadInput(f"{path} contains NUL characters")
    return text.replace("\r\n", "\n").replace("\r", "\n")

def write_text(path: Path, text: str) -> None:  # LF only; atomic; temp file in the same folder
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
        fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".part")
        with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as handle:
            handle.write(text)
        os.replace(tmp, str(path))  # os.rename raises on Windows if the target exists
    except OSError as exc:
        raise BadInput(f"cannot write {path}: {exc.strerror}") from None

def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)  # bad arguments: argparse itself exits 2
    parser.add_argument("input", type=Path)  # ... more arguments ...
    args = parser.parse_args(argv)
    try:
        text = read_text(args.input)
        ...  # work; text.split("\n"), never splitlines()
        return EXIT_OK  # or EXIT_FAIL when a check fails
    except BadInput as exc:
        sys.stderr.write(f"error: {exc}\n")
        return EXIT_BAD_INPUT

if __name__ == "__main__":
    use_utf8_streams()
    try:
        code = main()
    except Exception as exc:  # a bug must not look like "failed check" (exit 1)
        sys.stderr.write(f"internal error: {type(exc).__name__}: {exc}\n")
        code = EXIT_BAD_INPUT
    sys.exit(code)
```

**Evidence.**
- **Matrix [T].** 3 interpreters (3.9, 3.11, 3.13) x 5 environments (default; `LC_ALL=C PYTHONUTF8=0 PYTHONCOERCECLOCALE=0` giving ASCII stdout; `PYTHONIOENCODING=cp1252`; `PYTHONIOENCODING=ascii`; `PYTHONUTF8=1`) x 10 inputs (UTF-8 with BOM and CRLF, UTF-16 with BOM, cp1252 bytes, NUL, empty, over the cap, VT and U+2028 inside a line, lone CR, directory, missing). Exit codes were identical everywhere (0, 0, 2, 2, 0, 2, 0, 0, 2, 2 in the order listed) and the stdout bytes were identical across all 15 combinations for the four readable inputs. `-X utf8` and `-X utf8=0` with `LC_ALL=C` also worked on 3.9 [T]. A script without the preamble (`open(p).read()`, `print`), run on 3.13, failed in all three legacy environments with `UnicodeDecodeError` or `UnicodeEncodeError`, and in the default one it printed the BOM as a character [T].
- **Why the container hides the Windows problem.** In a POSIX locale Python already enables UTF-8 mode (`sys.flags.utf8_mode` was 1 with no variable set) [T, R cmdline.rst PYTHONUTF8]. On Windows UTF-8 mode is off by default and the docs promise UTF-8 only for console I/O (PEP 528) and the file system, not for redirected streams or the default encoding of `open()` [R windows.rst (3.9) "UTF-8 mode"]. A pipe, which is what the Bash tool uses, therefore falls back to the ANSI code page [I]. The reconfigure plus an explicit `encoding=` on every `open()` removes the dependence; `PYTHONUTF8=1` is not a substitute: a `VAR=value` command prefix was denied under `Bash(python3 *)` (claude-code-skills.md section 2, [T] there).
- **`reconfigure`** exists from 3.7; when `encoding` is given and `errors` is not, errors reset to strict [R io.rst]; hence the explicit `errors`. It is guarded for `io.StringIO` and other replaced streams (unit tests) [T]. `backslashreplace` keeps a stray lone surrogate from crashing a report.
- **argparse.** `ArgumentParser.error()` prints usage to stderr and exits with status 2 [R argparse.rst]. [T] on 3.9 and 3.13 (unit tests): an unknown flag exits 2 and `--max-words x` raises `SystemExit(2)`; [T] on 3.13 only: no argument gives 2 and `--help` gives 0. `exit_on_error=False` (added in 3.9 [R]) is not needed. An uncaught exception exits 1, which the contract reads as "failed check", so the `__main__` wrapper maps it to 2.
- **Input.** `utf-8-sig` strips a UTF-8 BOM only [R codecs.rst]. UTF-16 with BOM is accepted because the old Windows Notepad "Unicode" choice writes it; current Notepad defaults to UTF-8 without BOM, and ANSI remains a Save As choice [S]. Reading bytes with `read(cap + 1)` bounds memory on any file; `is_file()` stops a FIFO from blocking forever and `/dev/zero` from being read [T]. Universal newlines are applied by hand after decoding.
- **Output.** `newline="\n"` stops Windows turning `\n` into `\r\n` (`newline=None` translates to `os.linesep` [R functions.rst `open`]); only Linux was tested, where both are the same, so the Windows effect is [R]. `os.replace` is atomic and overwrites; `os.rename` raises `FileExistsError` on Windows if the target exists [R os.rst].
- **Lines.** `str.splitlines()` also splits on `\x0b \x0c \x1c \x1d \x1e \x85 U+2028 U+2029` [R stdtypes.rst]; Word and Docs paste these, so paragraph and line numbers would shift. Use `split("\n")` after newline normalisation [T].
- **POSIX-only or privilege-dependent [R].** `fcntl` (platform Unix), `signal.alarm` (Unix), `os.symlink` (Windows needs Developer Mode or `SeCreateSymbolicLinkPrivilege`, otherwise `OSError`), `os.chmod` (on Windows only the read-only flag), `NamedTemporaryFile` reopened by name while open (not on Windows; tempfile.rst). Also avoid `os.fork`, `pwd`, `grp`, `os.getuid`, `os.mkfifo`, `shlex.quote` for Windows commands and `shell=True`. Pass `subprocess` a list built from `sys.executable`. `Path.resolve()` on Windows before 3.10 is reported to return a relative path for a missing file [S, fix version not confirmed]; use `os.path.abspath` for paths that may not exist [I].
- **Not tested:** the Windows console and pipe behaviour, a `.py` run through `py -3` on Windows, Store-Python redirection of writes in `TEMP` ("private copy", windows.rst (3.9) Known Issues [R]): keep workspaces out of `TEMP`.

## 3. Python 3.9 traps and a check that uses only the standard library

| Feature (added) | On real 3.9.25 [T] | `ast.parse(feature_version=(3, 9))` run on 3.13 [T] |
|---|---|---|
| `match` statement (3.10) [R whatsnew 3.10] | SyntaxError | caught |
| `except*`, `ExceptionGroup` (3.11) [R] | SyntaxError, NameError | syntax caught; name missed |
| `type X = ...`, `def f[T]()` (3.12) [R] | SyntaxError | caught |
| f-string reusing its own quote or holding a backslash in `{}` (PEP 701, 3.12) [R] | SyntaxError | **missed** |
| `int \| None` in an annotation or `isinstance(x, A \| B)` (3.10) [R] | TypeError when the `def` runs | missed (plain `\|`); annotations fixed by `from __future__ import annotations` |
| `zip(..., strict=True)`, `int.bit_count()`, `itertools.pairwise`, `bisect(key=)`, `@dataclass(slots=True)`, `TemporaryDirectory(ignore_cleanup_errors=)`, `open(encoding="locale")`, `Path.hardlink_to`, `sys.stdlib_module_names`, `assertNoLogs`, `statistics.correlation` (3.10) [R] | TypeError, AttributeError, ImportError, LookupError | missed |
| `tomllib`, `enum.StrEnum`, `datetime.UTC`, `typing.Self`, `contextlib.chdir`, regex possessive `a++` and atomic `(?>...)`, wider `datetime.fromisoformat` (3.11) [R] | ModuleNotFoundError, ImportError, `re.error`, ValueError on a trailing `Z` | missed |
| `itertools.batched`, `Path.walk` (3.12) [R] | ImportError, AttributeError | missed |
| Parenthesised `with (a as x, b as y):` ("officially allowed" in 3.10 [R]) | **runs** on 3.9.25 | passes |
| `str.removeprefix`, `dict \| dict`, `zoneinfo`, `list[int]` annotations (all 3.9 [R whatsnew 3.9]); `Path.is_relative_to`; walrus (3.8) | fine | pass |

Other traps: `PurePath.is_reserved()` raises a DeprecationWarning on 3.13 and goes in 3.15 [T], so keep your own reserved-name set. `python -m unittest` that finds no tests exits 0 on 3.9 and 3.11 but 5 on 3.13 [T]; a wrong start folder therefore "passes" on 3.9.

**Check, three layers.** (1) The only complete one: run the unit tests and `python3.9 -m compileall` on a real 3.9 in CI on all three systems (setup-python availability on each runner not checked [U]). (2) A stdlib checker, prototype `compat/check_py39.py` (195 lines; exit 0 clean, 1 findings, 2 bad input): `ast.parse(feature_version=(3, 9))` for syntax, then an `ast.NodeVisitor` over the table above plus portability findings (imports of `fcntl pwd grp termios resource`, `os.fork getuid symlink`, `signal.SIGALRM`, `os.linesep`, `str.splitlines`, hard-coded `/tmp` or `C:\`, `open()`, `read_text()` or `write_text()` without `encoding=`, f-string fields with a backslash or the outer quote). [T] On 44 snippets (3.10+ features and 3.9-safe ones) its flags matched what real 3.9.25 does, with no misses and no false positives (the portability snippets are flagged by design); it reports nothing on `snippet_tool.py`. It must run on the newest interpreter, because `feature_version` can only go down ([R] ast.rst: best effort, lowest (3, 7) on 3.13, highest the running version). (3) Say "Python 3.9 or later" once, in the README and in the guard.

## 4. Paths

- **Slug.** The accepted `[a-z0-9-]+` allows `con`, `nul`, `aux`, `prn`, `com1`-`com9`, `lpt1`-`lpt9`. On Windows those names are reserved even with an extension ([R] pathlib.rst `is_reserved`; [T] `NUL.txt`, `aux.md` reserved, `com10` and `aux-notes` not; [S] Microsoft naming page via secondary sources). A leading `-` would look like an option to argparse [I]. Recommended rule `^[a-z0-9]([a-z0-9-]{0,58}[a-z0-9])?$`, no `--`, not in the reserved set [T 19 sample slugs]. ASCII lowercase also removes every case-folding and normalisation question for the folder name.
- **Length.** Longest fixed workspace path: `betterpaper/<60-char slug>/reviewer-notes/draft-12/primary-text-reviewer.md` = 121 characters [T computed]. Windows limits a path to 260 characters (the count includes the terminating NUL [I]); Python opens longer paths only if `LongPathsEnabled` is set by registry or group policy, and has supported long paths since 3.6 [R windows.rst (3.9)]. So the working-folder prefix, with separator, may be at most 137 characters [I]; a OneDrive-style prefix I composed was 102. `init` should warn above 137, and `sources/` file names (user-chosen) stay unbounded.
- **Recorded paths** (STATE.md, SOURCES.md, `extra_anchor_dirs`): workspace-relative with forward slashes, parsed with `PurePosixPath`. Reject a value that has a drive, a root, `..`, a control character, any of `<>:"|?*`, a trailing dot or space, or a reserved stem, by testing `PureWindowsPath` and `PurePosixPath` together ([T] helper: 14 samples correct, including `C:x`, `\\srv\s\f`, `//c/x`, `sources/nul.txt`). The flavours differ: a backslash is one name on POSIX, a separator on Windows; `C:foo` is drive-relative; `/foo` is not absolute on Windows [T].
- **Case.** `PureWindowsPath("Draft-1.MD") == PureWindowsPath("draft-1.md")` is true, false on POSIX [T]. Never create two names that differ only in case; compare with `casefold()` only after NFC.
- **Unicode normalisation of file names.** HFS+ stores names decomposed (NFD); APFS keeps the spelling it was given and matches either form, but case-sensitive APFS does not [S]. Linux keeps NFC and NFD as two files [T]. Therefore never compare names byte for byte: normalise both sides to NFC (`unicodedata.normalize`), and match recorded names against a directory listing by that key. User-chosen names under `sources/` and `feedback/` are where this bites; the slug is immune.
- **Spaces, backslashes, drive letters.** Quote every path in the command line; take `${CLAUDE_PLUGIN_ROOT}` paths as given (forward slashes on Windows, exact drive form [U], sibling note). In Git Bash a drive-letter argument is exempt from MSYS rewriting; `/c/Users/x` written inside a file is not understood by Windows Python [S/I]. Do not store absolute paths.

## 5. Unit-test portability

- **Commands [T] (3.9 and 3.13).** All ran the 5 tests: `python -m unittest` inside the scripts folder; `python -m unittest discover -s plugins/p/scripts` from the repo root; the same with `-p "test_*.py" -t plugins/p/scripts`. `python -m unittest plugins/.../test_x.py` failed with `ModuleNotFoundError` because the start folder was not on `sys.path`; a bare `python -m unittest` at the repo root ran 0 tests. Fix the one command in Verify steps and compare "Ran N tests" with an expected N.
- **Rules.** `tempfile.TemporaryDirectory()` with `addCleanup`, a folder name containing a space, files closed before cleanup (an open file raises `PermissionError` on Windows; `ignore_cleanup_errors` needs 3.10) [R tempfile.rst (3.10)]. Run scripts as `[sys.executable, str(script), ...]` with the path from `Path(__file__).resolve()`, decode child output as UTF-8 bytes, and include a case that sets `PYTHONIOENCODING=cp1252 PYTHONUTF8=0` to prove the preamble [T: 5 tests passed on 3.9 and 3.13, also under `-X dev -W error`, which turns unclosed-file `ResourceWarning` into failures]. No symlink or permission tests (root ignores `chmod` [I]; Windows needs privilege for `os.symlink` [R]): build error cases from a directory, a missing file, bad bytes and an oversize file. Add `__pycache__/` to `.gitignore`. Test scripts import the script under test directly and hold no data files outside `fixtures/` beside them.

## 6. Untrusted text files

**Policy.** Treat every draft, source, feedback and imported file as data to be measured, never obeyed. Cleaning must happen once, before reviewers read the draft and before any check compares text: a sanitiser only helps if its output is what the model receives [S, security write-ups on hidden-text injection]. So `drafts/draft-N.md` is the cleaned copy and the original stays where the author keeps it [I].

| Role | Decode policy | Cap [I] |
|---|---|---|
| Draft, source excerpt, anchor text, RUBRIC, STATE, SOURCES, grades JSON | Strict. UTF-8 with or without BOM, or UTF-16 with BOM. Anything else: exit 2 naming the file, the byte offset and "re-save as UTF-8". Never `errors="replace"`: U+FFFD would turn a copying slip into a false MISMATCH. NUL = refuse | 2 MiB text (about 350,000 words) |
| `feedback/` files (echo input only) | `errors="replace"` allowed, but print "N undecodable bytes in <file>" and carry "echo check incomplete" into the report | 2 MiB |
| `.docx`, `.html` input to the importer | Zip and XML limits are in `docx-html-import-notes.md` (DOCTYPE and ENTITY refused; 20 MB per member; member count) | 20 MiB file, 5 MiB html |

Also cap one line at 1 MiB (flag), use only linear scans on user text (no nested quantifiers in `re`), and never write an archive member to disk.

**Code points the precheck should strip or flag.** Category and name checked with `unicodedata` on 3.9 (Unicode 13.0) and 3.13 (15.1): identical except U+180F, which 3.9 does not know [T]. Use explicit lists, not `category()`, so results do not depend on the interpreter. `str.strip()`, `str.split()` and `\s` do not touch ZWSP, U+2060 or U+FEFF [T].

| Code points | Names | Cat | Action | Why |
|---|---|---|---|---|
| U+E0000-E007F | Tag characters (U+E0041 = TAG LATIN CAPITAL LETTER A) | Cf | **strip + injection flag** | Mirror ASCII, draw nothing, are read by models ("ASCII smuggling") [S] |
| U+202A-202E, U+2066-2069 | LRE RLE PDF LRO RLO, LRI RLI FSI PDI | Cf | **strip + flag** | Reorder what a reader sees ("Trojan Source") [S]; no use in Markdown prose |
| U+200E, U+200F, U+061C | LRM RLM ALM | Cf | flag; strip only if no RTL letters | Legitimate beside Arabic or Hebrew quotations |
| U+200B, U+2060, U+FEFF mid-text, U+180E, U+2061-2064, U+206A-206F | ZWSP, word joiner, ZWNBSP, MVS, invisible operators, deprecated controls | Cf | **strip + count** | Copy-paste debris; hide text and split words |
| U+200C, U+200D | ZWNJ, ZWJ | Cf | flag; strip for comparison only | Legitimate in Persian, Indic scripts and emoji |
| U+00AD | SOFT HYPHEN | Cf | strip (count) | Word and PDF hyphenation; mammoth emits it for Word soft hyphens [sibling note] |
| U+034F, U+FE00-FE0F, U+E0100-E01EF, U+180B-180D, U+180F | CGJ, variation selectors | Mn | strip for comparison; flag U+E0100+ | Invisible modifiers; U+FE0E and U+FE0F stay beside emoji |
| U+115F, U+1160, U+3164, U+FFA0, U+2800, U+17B4, U+17B5 | Hangul fillers, braille blank, Khmer inherent vowels | Lo, So, Mn | flag + strip in English text | Render blank |
| U+FFF9-FFFB, U+FFFC | Interlinear annotation, object replacement | Cf, So | strip + flag | FFFC marks an image or object lost in conversion |
| U+FFFD | REPLACEMENT CHARACTER | So | **flag** | Decoding loss upstream; quote checks near it are unreliable |
| U+FFFE, U+FFFF, U+FDD0-FDEF; U+E000-F8FF and planes 15-16 | Noncharacters; private use | Cn, Co | flag, keep | Private use is a typical PDF symbol-font or OCR artefact |
| U+0000-0008, 000E-001F (ESC = 001B), 007F, 0080-009F | C0 and C1 controls except TAB, LF | Cc | **strip + flag**; NUL refuses the file | ESC begins terminal sequences |
| U+000B, U+000C, U+0085, U+2028, U+2029 | VT, FF, NEL, LS, PS | Cc, Zl, Zp | convert to `\n`; PS to `\n\n` | Word and Docs soft breaks; `splitlines()` splits on them [R, T] |
| U+00A0, U+1680, U+2000-200A, U+202F, U+205F, U+3000 | NBSP and other spaces | Zs | to a space in comparison; no flag | Ordinary Word output |
| A word mixing Latin with Cyrillic or Greek letters | Homoglyph | - | flag, keep | Lookalike substitution [I]; Greek words on their own are normal |

Report counts per class and the first five positions as line:column, never the characters. `scan` prototype: 8 expected hits on a 2-line sample [T]. The "injection-like text found" line of the plan fires on any strip-class hit and on imperative text addressed to a grader, which needs a separate list.

**Printing untrusted text.** Escape every `Cc, Cf, Co, Cn, Zl, Zp` character in anything printed (`<U+202E>`) and cap excerpts at the 15 words of the contract, so ANSI escapes and hidden text cannot ride out through script output [T prototype; the Claude Code UI behaviour is [U]].

**Comparison form (deterministic; prototype `text/normalise.py`).** Steps in order: newlines to `\n`; table below; `NFKC`; the table again (NFKC turns U+2011 into U+2010); join line-break hyphenation; collapse whitespace runs to one space. Only explicit tables and `unicodedata` are used, no locale.

| Class | Code points | Becomes |
|---|---|---|
| Single quotes, apostrophes | U+2018 U+2019 U+201A U+201B U+2032 U+02BC U+FF07 U+2039 U+203A | `'` |
| Double quotes | U+201C U+201D U+201E U+201F U+2033 U+FF02 U+00AB U+00BB | `"` |
| Hyphens and dashes | U+2010-2015 (U+2011 also via NFKC), U+2212, U+FE58, U+FE63, U+FF0D, U+2E3A, U+2E3B; runs of `--` | `-` |
| Line-break hyphenation | letter, then `-` or U+2010 or U+00AD, then newline, then letter | letters joined |
| Ellipsis | U+2026 (NFKC), `. . .`, `[\u2026]`, `[...]` | `...` |
| Spaces, ligatures, fullwidth forms | NBSP and other Zs (NFKC), U+FB01 etc. (NFKC); any whitespace run | one space; letters |

Leave U+00B4 and U+0060 alone: NFKC turns U+00B4 into a space plus a combining accent. [T] 13 cases pass, the function is idempotent, and the corpus hash is identical on 3.9.25, 3.11.17 and 3.13.16. Costs: NFKC also folds superscript digits (`word\u00b2` to `word2`), the trademark sign and numero sign; applied to both sides it only makes matching more lenient. Matching stays case-sensitive for the cited-span check; the echo check folds case [I].
- **Two tiers.** Tier 1 is the form above. Tier 2, `squash`, also drops every space and hyphen (the prototype casefolds as well; make that a flag), so spacing around a dash and a compound broken across lines (`well-` newline `known` becomes `wellknown` in tier 1 but equals `well-known` in tier 2) stop mattering. The cited-span check accepts a hit at tier 2 without casefolding: it is a presence test where leniency is cheap and a wrongly dropped finding is not [I]. The integrity test counts a difference only if it survives tier 2 with casefolding; a tier-1-only difference is formatting and never feeds the split [I], in line with A47.

## 7. Decisions needed (owner), with a recommendation

1. **`python_cmd`.** Recommend: keep G23 (probe order, closed set) but treat the stored value as a hint, re-probe on failure, validate against `^(python3|python|py -3)$`, and either add the key to file contracts section 1 or hold it per session. A per-machine value in a synced `RUBRIC.md` will be wrong on one of three systems.
2. **Unexpected exceptions exit 2, not 1.** Recommend yes, with the prefix `internal error:` (contract keeps {0, 1, 2}); the alternative is a fourth code.
3. **Stored draft is the cleaned copy** (strip-class code points removed, report lists counts and positions). Recommend yes.
4. **Slug rule.** Recommend tightening `[a-z0-9-]+` to the regex in section 4 (amends A39/G) and warning when the working-folder prefix exceeds 137 characters.
5. **Compatibility gate.** Recommend a repo-only `tools/check_py39.py` plus CI running the unit tests on a real 3.9 on Windows, macOS and Linux; without CI, the checker in the Phase 4 Verify step plus one manual run on a 3.9.
6. **`feedback/` decoding.** Recommend `errors="replace"` with a visible warning there only; strict everywhere else.
7. **Windows install-manager side effect.** Recommend documenting it in the README (prerequisites: Python 3.9 or later installed first); no code change.
8. **Caps.** Recommend the 2 MiB text and 1 MiB line caps above; the plan sets none.

## 8. Open questions

- PowerShell 5.1 and 7: does the probe text run unchanged, and what do `PowerShell(py -3 --version)` rules match? [U]
- zsh and macOS: the probe was reasoned, not run [U]. Windows: the stub's real exit code, `sys.stdout.encoding` on a pipe under Git Bash and under PowerShell, and the `newline="\n"` effect [U].
- Whether Microsoft Store Python's private-copy rule reaches a workspace under Documents [U].
