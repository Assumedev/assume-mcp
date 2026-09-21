#!/usr/bin/env bash
# Sync marketplace plugin assets from the canonical Assume monorepo.
# Usage:
#   ./scripts/sync-plugin-from-assume.sh
#   ASSUME_REPO=/path/to/assume ./scripts/sync-plugin-from-assume.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ASSUME_REPO="${ASSUME_REPO:-}"
CANONICAL_REPO="https://github.com/CodewithABG/assume"
CANONICAL_BRANCH="${CANONICAL_BRANCH:-main}"

if [[ -z "$ASSUME_REPO" ]]; then
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  git clone --depth 1 --branch "$CANONICAL_BRANCH" "$CANONICAL_REPO" "$TMP/assume"
  ASSUME_REPO="$TMP/assume"
fi

cp "$ASSUME_REPO/.cursor-plugin/plugin.json" "$ROOT/.cursor-plugin/plugin.json"
cp "$ASSUME_REPO/.cursor-plugin/logo.svg" "$ROOT/.cursor-plugin/logo.svg"

# This repo's marketplace listing URL differs from the product monorepo.
node -e "
const fs = require('fs');
const path = process.argv[1];
const doc = JSON.parse(fs.readFileSync(path, 'utf8'));
doc.repository = 'https://github.com/Assumedev/assume-mcp';
fs.writeFileSync(path, JSON.stringify(doc, null, 2) + '\n');
" "$ROOT/.cursor-plugin/plugin.json"

echo "Synced plugin.json and logo.svg from $CANONICAL_REPO ($CANONICAL_BRANCH)"
