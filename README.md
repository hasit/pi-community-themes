# pi-community-themes

Community-curated themes for [pi](https://github.com/badlogic/pi-mono).

## Install

Install directly from GitHub:

```bash
pi install git:https://github.com/hasit/pi-community-themes
```

Or pin to a tag/ref:

```bash
pi install git:https://github.com/hasit/pi-community-themes@v0.2.0
```

## Usage

After install, open `/settings` in pi and select one of the installed themes.

## Available themes

- `atom-one-dark` ([preview](assets/previews/atom-one-dark.png))
- `atom-one-light` ([preview](assets/previews/atom-one-light.png))
- `atom-one-light-crisp` ([preview](assets/previews/atom-one-light-crisp.png))
- `atom-one-light-soft` ([preview](assets/previews/atom-one-light-soft.png))

## Package info

This repository is a pi package and exposes themes from:

- `themes/*.json`

## Contributing

1. Add your theme JSON file under `themes/`.
2. Ensure each theme has a unique `name`.
3. Include the `$schema` field for validation/autocomplete.
4. Open a PR.

Theme docs: <https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/themes.md>
