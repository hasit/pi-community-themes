# pi-community-themes

Community-curated themes for [pi](https://github.com/badlogic/pi-mono).

## Install

Install directly from GitHub:

```bash
pi install git:https://github.com/hasit/pi-community-themes
```

Or pin to a tag/ref:

```bash
pi install git:https://github.com/hasit/pi-community-themes@v0.1.0
```

## Usage

After install, open `/settings` in pi and select one of the installed themes.

## Available themes

- `atom-one-dark`
- `atom-one-light`
- `atom-one-light-crisp`
- `atom-one-light-soft`

## Package info

This repository is a pi package and exposes themes from:

- `themes/*.json`

## Contributing

1. Add your theme JSON file under `themes/`.
2. Ensure each theme has a unique `name`.
3. Include the `$schema` field for validation/autocomplete.
4. Open a PR.

## Release workflow

Use the release helper to keep version/tag/changelog/preview updates consistent.

1) Add release notes under `## [Unreleased]` in `CHANGELOG.md`.
2) Run:

```bash
./scripts/release.sh 0.2.0
```

Useful flags:
- `--push` to push commit + tag
- `--gh-release` to publish GitHub release notes with `gh` (pulled from `CHANGELOG.md`)
- `--smoke-test` to run pinned install validation
- `--dry-run` to preview all actions first

The script creates a named preview (`assets/previews/vX.Y.Z.png`), updates `package.json` + `README.md`, promotes `CHANGELOG [Unreleased]` into a versioned entry, then commits and tags.

Theme docs: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/themes.md
