#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="$ROOT_DIR/skills/neuroartist-media"
SKILL_FILE="$SKILL_DIR/SKILL.md"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

info() {
  echo "==> $*" >&2
}

info "Checking skill layout"
[[ -d "$SKILL_DIR" ]] || fail "Missing skill directory: $SKILL_DIR"
[[ -f "$SKILL_FILE" ]] || fail "Missing SKILL.md: $SKILL_FILE"
[[ -d "$SKILL_DIR/references" ]] || fail "Missing references directory"
[[ -f "$ROOT_DIR/README.md" ]] || fail "Missing README.md"
[[ -f "$ROOT_DIR/PUBLISHING.md" ]] || fail "Missing PUBLISHING.md"
[[ -f "$ROOT_DIR/LICENSE" ]] || fail "Missing LICENSE"
[[ -f "$ROOT_DIR/package.json" ]] || fail "Missing package.json"

info "Checking required reference files"
for file in prompting.md model-selection.md workflows.md examples.md install.md; do
  [[ -f "$SKILL_DIR/references/$file" ]] || fail "Missing references/$file"
done

info "Checking frontmatter"
python3 - "$SKILL_FILE" <<'PY'
import re
import sys
from pathlib import Path

skill_file = Path(sys.argv[1])
text = skill_file.read_text(encoding="utf-8")
match = re.match(r"^---\n(.*?)\n---\n", text, re.S)
if not match:
    raise SystemExit("ERROR: SKILL.md must start with YAML frontmatter")

frontmatter = match.group(1)

def field(name: str) -> str | None:
    m = re.search(rf"^{re.escape(name)}:\s*(.+)$", frontmatter, re.M)
    if not m:
        return None
    return m.group(1).strip().strip('"').strip("'")

name = field("name")
description = field("description")
license_value = field("license")
compatibility = field("compatibility")

if not name:
    raise SystemExit("ERROR: missing required frontmatter field: name")
if not description:
    raise SystemExit("ERROR: missing required frontmatter field: description")
if len(description) > 1024:
    raise SystemExit("ERROR: description exceeds 1024 characters")
if len(name) > 64:
    raise SystemExit("ERROR: name exceeds 64 characters")
if not re.fullmatch(r"[a-z0-9]+(-[a-z0-9]+)*", name):
    raise SystemExit(f"ERROR: invalid skill name: {name}")
if skill_file.parent.name != name:
    raise SystemExit(
        f"ERROR: directory name {skill_file.parent.name!r} does not match skill name {name!r}"
    )
if not license_value:
    raise SystemExit("ERROR: missing recommended frontmatter field: license")
if compatibility and len(compatibility) > 500:
    raise SystemExit("ERROR: compatibility exceeds 500 characters")

body_lines = text[match.end():].splitlines()
if len(body_lines) > 500:
    raise SystemExit("ERROR: SKILL.md body exceeds 500 lines")

print("Frontmatter OK")
PY

info "Checking package metadata"
python3 - "$ROOT_DIR/package.json" <<'PY'
import json
import sys
from pathlib import Path

package_file = Path(sys.argv[1])
data = json.loads(package_file.read_text(encoding="utf-8"))

if data.get("name") != "@croissanstudio/neuroartist-api-skill":
    raise SystemExit("ERROR: unexpected package name")
if data.get("version") != "1.0.0":
    raise SystemExit("ERROR: package version must match current skill version")
if data.get("license") != "Apache-2.0":
    raise SystemExit("ERROR: package license must be Apache-2.0")
keywords = set(data.get("keywords", []))
if "agent-skill" not in keywords:
    raise SystemExit("ERROR: package keywords must include agent-skill")
files = set(data.get("files", []))
if "skills/" not in files:
    raise SystemExit("ERROR: package files must include skills/")

print("Package metadata OK")
PY

info "Checking for obvious secrets"
if command -v rg >/dev/null 2>&1; then
  if rg -n --glob '!scripts/validate.sh' "(na_live_|NEUROARTIST_API_KEY=|FAL_KEY=|sk-[A-Za-z0-9])" "$ROOT_DIR"; then
    fail "Potential secret-like value found"
  fi
else
  if grep -R -n -E "(na_live_|NEUROARTIST_API_KEY=|FAL_KEY=|sk-[A-Za-z0-9])" "$ROOT_DIR" | grep -v "scripts/validate.sh"; then
    fail "Potential secret-like value found"
  fi
fi

if [[ "${RUN_SKILLS_REF:-0}" == "1" ]]; then
  info "Running optional skills-ref validator"
  if command -v npx >/dev/null 2>&1; then
    npx --yes skills-ref validate "$SKILL_DIR"
  else
    fail "npx is required for RUN_SKILLS_REF=1"
  fi
fi

info "Validation passed"
