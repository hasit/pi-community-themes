# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added

- Theme preview assets using per-theme naming:
  - `assets/previews/atom-one-dark.png`
  - `assets/previews/atom-one-light.png`
  - `assets/previews/atom-one-light-soft.png`
  - `assets/previews/atom-one-light-crisp.png`

### Changed

- README theme list now links each theme directly to its preview image.
- README no longer includes internal release workflow notes.
- Release script now uses CHANGELOG-only release notes and validates per-theme previews.
- Markdown formatting was normalized across project docs.

## [v0.2.0] - 2026-02-06

### Added in v0.2.0

- New light-theme variants:
  - `atom-one-light-soft`
  - `atom-one-light-crisp`
- Release automation script: `scripts/release.sh`.

### Updated

- `atom-one-light-soft` QA refinements for clearer spacing:
  - `text`: `#373d4c`
  - `muted`: `#697284`
  - `border`: `#ccd4e1`
  - `accent` intentionally unchanged for cross-variant consistency.
- README theme list expanded to include all available variants.
- `package.json` adds `npm run release` script.

### Preview

- `assets/previews/v0.2.0.png`

## [v0.1.0] - 2026-02-06

### Added in v0.1.0

- Initial pi package structure for community themes.
- `atom-one-dark` and `atom-one-light` themes.
- Initial package preview image (`assets/preview.png`).
