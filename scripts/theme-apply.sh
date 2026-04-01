#!/usr/bin/env bash
# Apply the current theme without switching
# Useful after template modifications

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CURRENT_THEME="${DOTFILES_ROOT}/themes/current.json"

# Colors
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [[ ! -L "$CURRENT_THEME" ]]; then
    echo -e "${RED}[ERROR]${NC} No current theme set. Run theme-switch.sh first."
    exit 1
fi

THEME_NAME=$(basename "$(readlink -f "$CURRENT_THEME")" .json)

echo -e "${BLUE}[INFO]${NC} Re-applying current theme: ${THEME_NAME}"
"${DOTFILES_ROOT}/scripts/theme-switch.sh" "$THEME_NAME"
