# Duplo Analyser GitHub Action

> ⚡️ Lightning fast duplicate code detection! Supports all text formats with
> special handling of comments for common languages.

## Overview

**Duplo Analyser** is a GitHub Action for detecting duplicate code blocks in
your repository. It scans source files and identifies similar code snippets
based on configurable parameters.

## Usage

Add the following step to your GitHub Actions workflow:

```yaml
- name: Run Duplo Analyser
  uses: dlidstrom/duplo-analyser@v1
  with:
    directory: '.'
    include-pattern: '.*'
    exclude-pattern: '.^'
    minimum-lines: "10"
    minimum-line-length: "3"
    max-files: "100"
    ignore-preprocessor-directives: "true"
```

## Inputs

| Input Name | Description | Required | Default |
|------------|------------|----------|---------|
| `directory` | Top directory to search for files | ✅ Yes | `.` |
| `include-pattern` | Regular expression for including filenames (case-insensitive) | ✅ Yes | `.*` |
| `exclude-pattern` | Regular expression for excluding filenames (case-insensitive) | ✅ Yes | `. ^` |
| `minimum-lines` | Minimum number of lines required for duplicate detection | ✅ Yes | `10` |
| `minimum-line-length` | Minimum number of characters per line (shorter lines are ignored) | ✅ Yes | `3` |
| `max-files` | Maximum number of files to report (useful for large duplicate sets) | ✅ Yes | `100` |
| `ignore-preprocessor-directives` | Removes preprocessor directives before duplicate detection | ✅ Yes | `true` |
| `version` | Version of Duplo to use | ✅ Yes | `v1.1.1` |

## Example Workflow

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
          directory: '.'
          include-pattern: '.*'
          exclude-pattern: '.^'
          minimum-lines: "10"
          minimum-line-length: "3"
          max-files: "100"
          ignore-preprocessor-directives: "true"
```

## Output

The action prints duplicate code blocks to the workflow logs, allowing you to
identify and refactor repeated code.

## How It Works

1. **Platform-Specific Setup:**
   - Sets the executable path based on the operating system.
2. **Caching:**
   - Caches the Duplo binary to speed up future runs.
3. **Downloading Duplo (If Not Cached):**
   - Fetches the specified version of Duplo and unzips it.
4. **File Analysis:**
   - Uses `find` to locate files based on include/exclude patterns.
   - Runs Duplo on the matching files.

## License

This action is open-source and available under the [MIT License](LICENSE).
