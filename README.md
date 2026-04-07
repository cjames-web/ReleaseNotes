# ReleaseNotes

Internal release notes repository for S&N Infrastructure's Appenate form spaces.

Every time a form or form space is updated, a release note is added here documenting what changed, why it changed, and which forms were affected.

## Form Spaces

- Tillman
- Glo
- Ripple
- CVEC
- APB
- Dominion
- Southern Company

## How to Add a Release Note

1. Create a new branch from `main` named after the version and form (e.g. `release/glo-splice-point-ver-1.36`)
2. Navigate to the correct form space folder under `docs/`
3. Create a subfolder for the form if it doesn't exist yet
4. Add a new Markdown file: `ver-X-XX.md`
5. Copy the front matter and template from an existing file
6. Open a pull request into `main` — the site updates automatically once merged

## Viewing the Site

Once GitHub Pages is enabled, the live site will be available at:
`https://<your-org>.github.io/ReleaseNotes`

## Conventions

- Version files are named `ver-X-XX.md` (e.g. `ver-1-35.md`)
- Each file covers one form within one form space
- `nav_order` in front matter controls the sort order — use `1` for the newest release
- Commit messages should be descriptive (e.g. `Add Ver 1.35 release note — Glo / SPLICE POINT`)
