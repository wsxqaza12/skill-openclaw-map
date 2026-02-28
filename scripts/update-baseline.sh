#!/usr/bin/env bash
# Regenerate .baseline/ snapshots from the currently installed OpenClaw.
# Run this after updating references/environment.md to keep the baseline in sync.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASELINE_DIR="$SCRIPT_DIR/../.baseline"
mkdir -p "$BASELINE_DIR"

# Version
npx openclaw --version > "$BASELINE_DIR/version.txt" 2>/dev/null || echo "unknown" > "$BASELINE_DIR/version.txt"

# CLI subcommands
npx openclaw --help 2>/dev/null | grep -E '^\s+\w' | awk '{print $1}' | sort > "$BASELINE_DIR/cli-commands.txt"

# Bundled docs tree
DOCS_DIR="$(npm root -g)/openclaw/docs"
if [ -d "$DOCS_DIR" ]; then
  find "$DOCS_DIR" -name '*.md' | sed "s|$DOCS_DIR/||" | sort > "$BASELINE_DIR/docs-tree.txt"
else
  echo "DOCS_DIR_NOT_FOUND" > "$BASELINE_DIR/docs-tree.txt"
fi

# Bundled skills
SKILLS_DIR="$(npm root -g)/openclaw/skills"
if [ -d "$SKILLS_DIR" ]; then
  ls "$SKILLS_DIR" | sort > "$BASELINE_DIR/bundled-skills.txt"
else
  echo "SKILLS_DIR_NOT_FOUND" > "$BASELINE_DIR/bundled-skills.txt"
fi

# Config keys
node -e "
  try {
    const base = require.resolve('openclaw/package.json').replace('/package.json', '');
    const fs = require('fs');
    const candidates = [
      base + '/lib/config/schema.js',
      base + '/dist/config/schema.js',
      base + '/src/config/schema.js'
    ];
    for (const c of candidates) {
      if (fs.existsSync(c)) {
        const m = require(c);
        const keys = Object.keys(m.properties || m.default?.properties || m).sort();
        console.log(keys.join('\n'));
        process.exit(0);
      }
    }
    console.log('SCHEMA_NOT_FOUND');
  } catch (e) {
    console.log('SCHEMA_EXTRACT_FAILED');
  }
" > "$BASELINE_DIR/config-keys.txt"

echo "Baseline updated in $BASELINE_DIR"
