# pi-community-themes

Community-curated themes for [pi](https://github.com/badlogic/pi-mono).

## Install

Install directly from GitHub:

```bash
pi install git:https://github.com/hasit/pi-community-themes
```

Or pin to a tag/ref:

```bash
pi install git:https://github.com/hasit/pi-community-themes@v0.3.0
```

## Usage

After install, open `/settings` in pi and select one of the installed themes.

## Available themes

### atom-one

- `atom-one-light` ([preview](assets/previews/atom-one-light.png))
- `atom-one-dark` ([preview](assets/previews/atom-one-dark.png))

### catppuccin

- `catppuccin-latte` ([preview](assets/previews/catppuccin-latte.png))
- `catppuccin-frappe` ([preview](assets/previews/catppuccin-frappe.png))
- `catppuccin-macchiato` ([preview](assets/previews/catppuccin-macchiato.png))
- `catppuccin-mocha` ([preview](assets/previews/catppuccin-mocha.png))

### dracula

- `dracula` ([preview](assets/previews/dracula.png))

### gruvbox

- `gruvbox-light-soft` ([preview](assets/previews/gruvbox-light-soft.png))
- `gruvbox-light-medium` ([preview](assets/previews/gruvbox-light-medium.png))
- `gruvbox-light-hard` ([preview](assets/previews/gruvbox-light-hard.png))
- `gruvbox-dark-soft` ([preview](assets/previews/gruvbox-dark-soft.png))
- `gruvbox-dark-medium` ([preview](assets/previews/gruvbox-dark-medium.png))
- `gruvbox-dark-hard` ([preview](assets/previews/gruvbox-dark-hard.png))

### nord

- `nord` ([preview](assets/previews/nord.png))

### solarized

- `solarized-light` ([preview](assets/previews/solarized-light.png))
- `solarized-dark` ([preview](assets/previews/solarized-dark.png))

## Package info

This repository is a pi package and exposes themes from:

- `themes/*.json`

## Contributing

1. Add your theme JSON file under `themes/`.
2. Ensure each theme has a unique `name`.
3. Include the `$schema` field for validation/autocomplete.
4. Open a PR.

Theme docs:
<https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/themes.md>
