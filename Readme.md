# 🚀 Duplo Analyser - GitHub Action

> ⚡️ Lightning fast duplicate code detection! Supports all text formats with
> special handling of comments for common languages.

[![test](https://github.com/dlidstrom/duplo-action/actions/workflows/build.yml/badge.svg)](https://github.com/dlidstrom/duplo-action/actions/workflows/build.yml)

## 📝 Overview

**Duplo Analyser** is a GitHub Action for detecting duplicate code blocks in
your repository. It scans source files and identifies similar code snippets
based on configurable parameters. In case any duplicate blocks are found the
action will fail the build.

🔋 This action is powered by [Duplo](https://github.com/dlidstrom/Duplo) - the fastest (?) duplicate detector on GitHub.

## 🚀 Usage

Add the following step to your GitHub Actions workflow:

```yaml
- name: Run Duplo Analyser
  uses: dlidstrom/duplo-analyser@v1
  with:
    directory: '.'
    include-pattern: '.*'
    minimum-lines: "10"
    minimum-line-length: "3"
    max-files: "100"
    ignore-preprocessor-directives: "true"
```

## 🔧 Inputs

| 🔹 Input Name | 📝 Description | 🏷️ Default |
|--------------|---------------|-----------|
| `directory` | 📂 Top directory from which to search for files. Only used with `include-pattern`. | `.` |
| `include-pattern` | 🔍 Regular expression for including filenames (case-insensitive). Mutually exlusive with `file-list`. | `.*` |
| `exclude-pattern` | 🚫 Regular expression for excluding filenames (case-insensitive). Only used with `include-pattern`. | `.^` |
| `file-list` | 📝 File with filenames to analyse. Mutually exclusive with `include-pattern`. | `''` |
| `minimum-lines` | 📏 Minimum number of lines required for duplicate detection | `10` |
| `minimum-line-length` | ✂️ Minimum number of characters per line (shorter lines are ignored) | `3` |
| `max-files` | 📊 Maximum number of files to report (useful for large duplicate sets) | `100` |
| `ignore-preprocessor-directives` | 🛑 Removes preprocessor directives before duplicate detection | `true` |
| `version` | 📌 Version of Duplo to use | `v1.1.1` |

## 🔄 Example Workflow

### 🔍 Using regular expressions

```yaml
name: Detect Duplicate Code
on: [push, pull_request]

jobs:
  duplication-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run Duplo Analyser
        uses: dlidstrom/duplo-analyser@v1
        with: # optionally override the defaults
          directory: '.'
          include-pattern: '.*'
          minimum-lines: "10"
          minimum-line-length: "3"
          max-files: "100"
          ignore-preprocessor-directives: "true"
```

Sample include patterns (note that the entire filename must match):

- **C/C++**: `'.*\.(h|cpp)$'`
- **JavaScript**: `'.*\.js$'` - or any other extension you need

The OR (`|`) operator only works inside groups `()`. Excluding files works in the same fashion.

> The `find` utility is used on all platforms, using [posix-extended syntax](https://www.gnu.org/software/findutils/manual/html_node/find_html/posix_002dextended-regular-expression-syntax.html).

### 📝 Using file list

```yaml
name: Detect Duplicate Code
on: [push, pull_request]

jobs:
  duplication-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run Duplo Analyser
        uses: dlidstrom/duplo-analyser@v1
        with:
          file-list: 'files.lst'
```

Using the file list option is useful when only analysing a specific subset of
files, for example the files that are changed in a PR. This allows for having
stricter rules for the files that are actively worked on.

## 📤 Output

The action prints duplicate code blocks to the workflow logs, allowing you to
identify and refactor repeated code.

## 🛠️ How It Works

1. **🖥️ Platform-Specific Setup:**
   - Sets the executable path based on the operating system.
2. **📦 Caching:**
   - Caches the Duplo binary to speed up future runs.
3. **📥 Downloading Duplo (If Not Cached):**
   - Fetches the specified version of Duplo and unzips it.
4. **📂 File Analysis:**
   - Uses `find` to locate files based on include/exclude patterns.
   - Runs Duplo on the matching files.

## 📜 License

This action is open-source and available under the [MIT License](LICENSE).
