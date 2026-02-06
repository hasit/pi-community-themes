#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./scripts/release.sh <version> [options]

Example:
  ./scripts/release.sh 0.2.0 \
    --commit-message "release: v0.2.0 community theme expansion" \
    --push --gh-release --smoke-test

What this script does:
  1) Verifies clean git working tree
  2) Creates named preview: assets/previews/v<version>.png
  3) Updates package.json version + pi.image URL to tag-pinned preview
  4) Updates pinned README install tag
  5) Promotes CHANGELOG [Unreleased] section into new version entry
  6) Commits and tags v<version>
  7) Optionally pushes and creates GitHub release (notes pulled from CHANGELOG)
  8) Optional smoke test with pinned install command

Options:
  --preview-source <path>  Source image for named preview
                           (default: assets/preview.png)
  --commit-message <msg>   Release commit message
                           (default: "release: v<version> community theme expansion")
  --push                   Push commit + tag to origin (default: off)
  --gh-release             Create GitHub release with gh CLI (default: off)
  --smoke-test             Run: pi install git:https://github.com/<owner>/<repo>@v<version>
  --dry-run                Print actions without mutating state
  -h, --help               Show this help
EOF
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "❌ Missing required command: $1" >&2
    exit 1
  }
}

is_clean_tree() {
  git diff --quiet && git diff --cached --quiet && [[ -z "$(git ls-files --others --exclude-standard)" ]]
}

VERSION="${1:-}"
[[ -z "$VERSION" || "$VERSION" == "-h" || "$VERSION" == "--help" ]] && usage && exit 0
shift || true

if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Version must be semver without v-prefix, e.g. 0.2.0" >&2
  exit 1
fi

TAG="v$VERSION"
PREVIEW_SOURCE="assets/preview.png"
COMMIT_MESSAGE="release: $TAG community theme expansion"
DO_PUSH=0
DO_GH_RELEASE=0
DO_SMOKE_TEST=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --preview-source)
      PREVIEW_SOURCE="$2"; shift 2 ;;
    --commit-message)
      COMMIT_MESSAGE="$2"; shift 2 ;;
    --push)
      DO_PUSH=1; shift ;;
    --gh-release)
      DO_GH_RELEASE=1; shift ;;
    --smoke-test)
      DO_SMOKE_TEST=1; shift ;;
    --dry-run)
      DRY_RUN=1; shift ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      echo "❌ Unknown option: $1" >&2
      usage
      exit 1 ;;
  esac
done

require_cmd git
require_cmd python3

if (( DO_GH_RELEASE == 1 )); then
  require_cmd gh
fi

if (( DO_SMOKE_TEST == 1 )); then
  require_cmd pi
fi

if [[ ! -f package.json || ! -f README.md || ! -f CHANGELOG.md ]]; then
  echo "❌ Run this from repo root and ensure package.json, README.md, CHANGELOG.md exist" >&2
  exit 1
fi

if ! is_clean_tree; then
  echo "❌ Git tree must be clean before running release script" >&2
  git status --short
  exit 1
fi

if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "❌ Tag already exists: $TAG" >&2
  exit 1
fi

if [[ ! -f "$PREVIEW_SOURCE" ]]; then
  echo "❌ Preview source not found: $PREVIEW_SOURCE" >&2
  exit 1
fi

OWNER_REPO=$(python3 - <<'PY'
import json, re
from pathlib import Path
pkg = json.loads(Path('package.json').read_text())
url = pkg.get('repository', {}).get('url', '')
m = re.search(r'github\.com[:/](?P<slug>[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+?)(?:\.git)?$', url)
if not m:
    raise SystemExit('Could not parse GitHub owner/repo from package.json repository.url')
print(m.group('slug'))
PY
)

PREVIEW_DEST="assets/previews/$TAG.png"

if (( DRY_RUN == 1 )); then
  echo "[dry-run] tag: $TAG"
  echo "[dry-run] owner/repo: $OWNER_REPO"
  echo "[dry-run] preview copy: $PREVIEW_SOURCE -> $PREVIEW_DEST"
  echo "[dry-run] update: package.json version + pi.image"
  echo "[dry-run] update: README pinned tag"
  echo "[dry-run] update: CHANGELOG.md by promoting [Unreleased] to [$TAG]"
  echo "[dry-run] commit: $COMMIT_MESSAGE"
  echo "[dry-run] tag: $TAG"
  (( DO_PUSH == 1 )) && echo "[dry-run] push: origin current-branch + $TAG"
  (( DO_GH_RELEASE == 1 )) && echo "[dry-run] gh release create $TAG with notes from CHANGELOG section [$TAG]"
  (( DO_SMOKE_TEST == 1 )) && echo "[dry-run] smoke test: pi install git:https://github.com/$OWNER_REPO@$TAG"
  exit 0
fi

mkdir -p assets/previews
cp "$PREVIEW_SOURCE" "$PREVIEW_DEST"

python3 - "$VERSION" "$TAG" "$OWNER_REPO" "$PREVIEW_DEST" <<'PY'
import datetime
import json
import re
import sys
from pathlib import Path

version, tag, owner_repo, preview_dest = sys.argv[1:]

# package.json
pkg_path = Path('package.json')
pkg = json.loads(pkg_path.read_text())
pkg['version'] = version
pkg.setdefault('pi', {})['image'] = f'https://raw.githubusercontent.com/{owner_repo}/{tag}/{preview_dest}'
pkg_path.write_text(json.dumps(pkg, indent=2) + '\n')

# README pinned install tag
readme_path = Path('README.md')
readme = readme_path.read_text()
pattern = re.compile(rf'(pi install git:https://github\.com/{re.escape(owner_repo)}@)v\d+\.\d+\.\d+')
updated, count = pattern.subn(rf'\1{tag}', readme, count=1)
if count == 0:
    raise SystemExit('Could not find pinned install tag line in README.md to update')
readme_path.write_text(updated)

# CHANGELOG: promote Unreleased
changelog_path = Path('CHANGELOG.md')
changelog = changelog_path.read_text()
marker = '## [Unreleased]'
if marker not in changelog:
    raise SystemExit('CHANGELOG.md must contain a "## [Unreleased]" section')
if f'## [{tag}]' in changelog:
    raise SystemExit(f'CHANGELOG already contains {tag}')

start = changelog.index(marker) + len(marker)
next_header = changelog.find('\n## [', start)
if next_header == -1:
    next_header = len(changelog)

unreleased_body = changelog[start:next_header].strip()
if not unreleased_body:
    raise SystemExit('CHANGELOG [Unreleased] section is empty; add release notes there first')

date = datetime.date.today().isoformat()
entry_body = unreleased_body + f'\n\n### Preview\n- `{preview_dest}`'
entry = f'## [{tag}] - {date}\n\n{entry_body}\n\n'

before = changelog[:changelog.index(marker)]
after = changelog[next_header:].lstrip('\n')
new_changelog = before + marker + '\n\n' + entry + after
changelog_path.write_text(new_changelog)
PY

git add package.json README.md CHANGELOG.md "$PREVIEW_DEST"
git commit -m "$COMMIT_MESSAGE"
git tag -a "$TAG" -m "$TAG"

if (( DO_PUSH == 1 )); then
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  git push origin "$CURRENT_BRANCH"
  git push origin "$TAG"
fi

if (( DO_GH_RELEASE == 1 )); then
  NOTES_TMP=$(mktemp)
  python3 - "$TAG" "$NOTES_TMP" <<'PY'
import re
import sys
from pathlib import Path

_, tag, out = sys.argv
text = Path('CHANGELOG.md').read_text()
pat = re.compile(rf'^## \[{re.escape(tag)}\] - .*?\n\n(?P<body>.*?)(?=^## \[|\Z)', re.S | re.M)
m = pat.search(text)
if not m:
    raise SystemExit(f'Could not find changelog section for {tag}')
Path(out).write_text(m.group('body').strip() + '\n')
PY
  gh release create "$TAG" --title "$TAG" --notes-file "$NOTES_TMP"
  rm -f "$NOTES_TMP"
fi

if (( DO_SMOKE_TEST == 1 )); then
  pi install "git:https://github.com/$OWNER_REPO@$TAG"
fi

echo "✅ Release prepared: $TAG"
echo "   Commit: $(git rev-parse --short HEAD)"
echo "   Tag:    $TAG"
if (( DO_PUSH == 1 )); then
  echo "   Pushed: origin"
fi
if (( DO_GH_RELEASE == 1 )); then
  echo "   Release: created via gh"
fi
if (( DO_SMOKE_TEST == 1 )); then
  echo "   Smoke:   pi install completed"
fi
