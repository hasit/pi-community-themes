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

## Package info

This repository is a pi package and exposes themes from:

- `themes/*.json`

## Contributing

1. Add your theme JSON file under `themes/`.
2. Ensure each theme has a unique `name`.
3. Include the `$schema` field for validation/autocomplete.
4. Open a PR.

Theme docs: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/themes.md
