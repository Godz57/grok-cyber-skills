#!/usr/bin/env bash
set -euo pipefail
KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MODE="${1:-global}"
UPDATE=0
[[ "${1:-}" == "update" || "${2:-}" == "update" ]] && UPDATE=1
[[ "${1:-}" == "update" ]] && MODE="global"
[[ "${1:-}" == "project" ]] && MODE="project"

if [[ "$MODE" == "project" ]]; then
  BASE="$(pwd)/.grok"
  echo "Install mode: PROJECT -> $BASE"
else
  BASE="${HOME}/.grok"
  echo "Install mode: GLOBAL -> $BASE"
fi

SKILLS="$BASE/skills"
COMMANDS="$BASE/commands"
TOOLS="$BASE/tools"
TOOLKIT="$TOOLS/cyber-skills"
DST="$SKILLS/cyber"
REPO="https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git"

mkdir -p "$SKILLS" "$COMMANDS" "$TOOLS" "$DST"
cp -R "$KIT_ROOT/skills/cyber/." "$DST/"
echo "  skill: cyber"

for f in "$KIT_ROOT"/commands/*.md; do
  cp -f "$f" "$COMMANDS/"
  echo "  command: $(basename "$f")"
done

if [[ ! -f "$TOOLKIT/index.json" ]]; then
  echo "  cloning library (large)..."
  git clone --depth 1 "$REPO" "$TOOLKIT"
else
  echo "  toolkit present: $TOOLKIT"
  if [[ "$UPDATE" -eq 1 ]]; then
    git -C "$TOOLKIT" pull --ff-only || true
  fi
fi

if [[ -f "$TOOLKIT/index.json" ]]; then
  python3 -c "import json;d=json.load(open('$TOOLKIT/index.json'));print(f\"  index: {d.get('total_skills')} skills (v{d.get('version')})\")" 2>/dev/null || true
fi

echo ""
echo "Done. Mode D router only."
echo "Try: /cyber-status | /cyber-find memory forensics"
