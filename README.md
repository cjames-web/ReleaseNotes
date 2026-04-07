# ReleaseNotes

This repository is the internal record of all version releases for S&N Infrastructure's Appenate forms. Every time a form or form space is updated, a release note is added here documenting what changed, why it changed, and which forms were affected.

---

## What's in This Repo

Each release note is a Markdown file named after its version number (e.g. `RELEASE_NOTES_Ver1.35.md`). Files are organized by form space so it's easy to track the history of a specific form over time.

---

## How to Add a Release Note

1. Create a new branch from `main` named after the version (e.g. `release/ver-1.36`)
2. Navigate to the correct form space and form folder — create the folders if they don't exist yet
3. Add a new Markdown file following the naming convention: `RELEASE_NOTES_Ver<X.XX>.md`
4. Fill in the release note using the standard template (see below)
5. Open a pull request into `main` and request a review before merging

---

## Conventions

- Version numbers follow the format `Ver X.XX` (e.g. `Ver 1.35`)
- Each release note covers one form space and form per file
- All release notes are authored and reviewed internally before merging
- Commit messages should be short and descriptive (e.g. `Add Ver 1.35 release note for Glo / SPLICE POINT`)

---

## Contact

For questions about a specific release, reach out to the author listed in the release note file.
