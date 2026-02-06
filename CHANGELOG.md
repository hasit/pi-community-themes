# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### 🛠 Fixed
- Release script summary no longer exits non-zero when optional flags are omitted.

## [v0.2.0] - 2026-02-06

### ✨ Added
- New light-theme variants:
  - `atom-one-light-soft`
  - `atom-one-light-crisp`
- Release automation script: `scripts/release.sh`.

### ✅ Updated
- `atom-one-light-soft` QA refinements for clearer spacing:
  - `text`: `#373d4c`
  - `muted`: `#697284`
  - `border`: `#ccd4e1`
  - `accent` intentionally unchanged for cross-variant consistency.
- `README.md` theme list expanded to include all available variants.
- `README.md` release workflow documentation (CHANGELOG-driven flow).
- `package.json` adds `npm run release` script.

### Preview
- `assets/previews/v0.2.0.png`

## [v0.1.0] - 2026-02-06

### Added
- Initial pi package structure for community themes.
- `atom-one-dark` and `atom-one-light` themes.
- Initial package preview image (`assets/preview.png`).
