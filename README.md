# pi-community-themes

Community-curated themes for [pi](https://github.com/badlogic/pi-mono).

## Install

Install directly from GitHub:

```bash
pi install git:https://github.com/hasit/pi-community-themes
```

Or pin to a tag/ref:

```bash
pi install git:https://github.com/hasit/pi-community-themes@v0.2.3
```

## Usage

After install, open `/settings` in pi and select one of the installed themes.

## Available themes

### atom-one

- `atom-one-light` ([preview](assets/previews/atom-one-light.png))
- `atom-one-lighter` ([preview](assets/previews/atom-one-lighter.png))
- `atom-one-lightest` ([preview](assets/previews/atom-one-lightest.png))
- `atom-one-dark` ([preview](assets/previews/atom-one-dark.png))
- `atom-one-darker` ([preview](assets/previews/atom-one-darker.png))
- `atom-one-darkest` ([preview](assets/previews/atom-one-darkest.png))

### catppuccin

- `catppuccin-light` ([preview](assets/previews/catppuccin-light.png))
- `catppuccin-lighter` ([preview](assets/previews/catppuccin-lighter.png))
- `catppuccin-lightest` ([preview](assets/previews/catppuccin-lightest.png))
- `catppuccin-dark` ([preview](assets/previews/catppuccin-dark.png))
- `catppuccin-darker` ([preview](assets/previews/catppuccin-darker.png))
- `catppuccin-darkest` ([preview](assets/previews/catppuccin-darkest.png))

### dracula

- `dracula-light` ([preview](assets/previews/dracula-light.png))
- `dracula-lighter` ([preview](assets/previews/dracula-lighter.png))
- `dracula-lightest` ([preview](assets/previews/dracula-lightest.png))
- `dracula-dark` ([preview](assets/previews/dracula-dark.png))
- `dracula-darker` ([preview](assets/previews/dracula-darker.png))
- `dracula-darkest` ([preview](assets/previews/dracula-darkest.png))

### gruvbox

- `gruvbox-light` ([preview](assets/previews/gruvbox-light.png))
- `gruvbox-lighter` ([preview](assets/previews/gruvbox-lighter.png))
- `gruvbox-lightest` ([preview](assets/previews/gruvbox-lightest.png))
- `gruvbox-dark` ([preview](assets/previews/gruvbox-dark.png))
- `gruvbox-darker` ([preview](assets/previews/gruvbox-darker.png))
- `gruvbox-darkest` ([preview](assets/previews/gruvbox-darkest.png))

### nord

- `nord-light` ([preview](assets/previews/nord-light.png))
- `nord-lighter` ([preview](assets/previews/nord-lighter.png))
- `nord-lightest` ([preview](assets/previews/nord-lightest.png))
- `nord-dark` ([preview](assets/previews/nord-dark.png))
- `nord-darker` ([preview](assets/previews/nord-darker.png))
- `nord-darkest` ([preview](assets/previews/nord-darkest.png))

### solarized

- `solarized-light` ([preview](assets/previews/solarized-light.png))
- `solarized-lighter` ([preview](assets/previews/solarized-lighter.png))
- `solarized-lightest` ([preview](assets/previews/solarized-lightest.png))
- `solarized-dark` ([preview](assets/previews/solarized-dark.png))
- `solarized-darker` ([preview](assets/previews/solarized-darker.png))
- `solarized-darkest` ([preview](assets/previews/solarized-darkest.png))

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
