#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for TheWidlarzGroup/react-native-video
# Runs on existing source tree with CWD at docs/ (docusaurusRoot).
# Installs deps at root level, then builds the Docusaurus site.

# --- Ensure bun is available ---
if ! command -v bun &>/dev/null; then
    if [ -f "$HOME/.bun/bin/bun" ]; then
        export PATH="$HOME/.bun/bin:$PATH"
    else
        echo "[INFO] Installing bun..."
        curl -fsSL https://bun.sh/install | bash
        export PATH="$HOME/.bun/bin:$PATH"
    fi
fi
echo "[INFO] Using bun: $(bun --version)"

# --- We are in docs/ — go to root for workspace install ---
DOCS_DIR="$(pwd)"
ROOT_DIR="$(cd .. && pwd)"

cd "$ROOT_DIR"
echo "[INFO] Installing workspace dependencies at root..."
bun install --frozen-lockfile

cd "$DOCS_DIR"

# --- Build Docusaurus site ---
echo "[INFO] Building Docusaurus site..."
bun run build

echo "[DONE] Build complete."
