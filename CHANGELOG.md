# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added (Unreleased)

- Added five popular theme families:
  - `catppuccin`
  - `dracula`
  - `gruvbox`
  - `nord`
  - `solarized`
- Added six variants for each new family:
  `light`, `lighter`, `lightest`, `dark`, `darker`, `darkest`.

### Updated (Unreleased)

- Regenerated previews for all theme files after adding new families.
- Expanded README theme catalog with grouped family sections and preview links.

### Removed (Unreleased)

- None.

## [v0.2.3] - 2026-02-06

### Added (v0.2.3)

- Added `atom-one-darker` and `atom-one-darkest` themes.

### Updated (v0.2.3)

- Renamed `atom-one-light-soft` to `atom-one-lighter`.
- Renamed `atom-one-light-crisp` to `atom-one-lightest`.
- README theme list now uses only the standard naming set:
  `light`, `lighter`, `lightest`, `dark`, `darker`, `darkest`.
- Release script now validates naming convention and family completeness.
- Release script dry-run output formatting was corrected.

### Removed (v0.2.3)

- Removed `atom-one-light-soft` and `atom-one-light-crisp` theme files.
- Removed old preview files tied to removed names.

## [v0.2.2] - 2026-02-06

### Added (v0.2.2)

- Deterministic preview generator: `scripts/generate_previews.py`.
- npm script for preview generation: `npm run preview:generate`.

### Updated (v0.2.2)

- Regenerated all theme previews to be theme-specific.
- Preview generation now derives palette and layout accents
  from each theme token set.

### Removed (v0.2.2)

- None.

## [v0.2.1] - 2026-02-06

### Added (v0.2.1)

- Theme preview assets using per-theme naming.

### Updated (v0.2.1)

- README theme list links each theme directly to its preview image.
- README no longer includes internal release workflow notes.
- Release script uses CHANGELOG-only release notes
  and validates per-theme previews.
- Markdown formatting was normalized across project docs.

### Removed (v0.2.1)

- None.

## [v0.2.0] - 2026-02-06

### Added (v0.2.0)

- New light-theme variants:
  - `atom-one-light-soft`
  - `atom-one-light-crisp`
- Release automation script: `scripts/release.sh`.

### Updated (v0.2.0)

- `atom-one-light-soft` QA refinements for clearer spacing:
  - `text`: `#373d4c`
  - `muted`: `#697284`
  - `border`: `#ccd4e1`
  - `accent` intentionally unchanged for cross-variant consistency.
- README theme list expanded to include all available variants.
- `package.json` adds `npm run release` script.

### Removed (v0.2.0)

- None.

## [v0.1.0] - 2026-02-06

### Added (v0.1.0)

- Initial pi package structure for community themes.
- `atom-one-dark` and `atom-one-light` themes.
- Initial package preview image (`assets/preview.png`).

### Updated (v0.1.0)

- None.

### Removed (v0.1.0)

- None.
