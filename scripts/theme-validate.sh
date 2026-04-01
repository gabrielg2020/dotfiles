#!/usr/bin/env bash
# Validate theme JSON schema

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEMES_DIR="${DOTFILES_ROOT}/themes"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

validate_theme_file() {
    local theme_file=$1
    local theme_name=$(basename "$theme_file" .json)

    echo "Validating ${theme_name}..."

    # Check JSON syntax
    if ! jq empty "$theme_file" 2>/dev/null; then
        echo -e "  ${RED}ERROR${NC}: Invalid JSON"
        return 1
    fi

    # Check required fields
    local required_fields=("name" "fonts" "colors" "terminal" "opacity")
    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$theme_file" >/dev/null 2>&1; then
            echo -e "  ${RED}ERROR${NC}: Missing required field: $field"
            return 1
        fi
    done

    # Check font fields
    local required_fonts=("terminal" "ui")
    for font in "${required_fonts[@]}"; do
        if ! jq -e ".fonts.$font" "$theme_file" >/dev/null 2>&1; then
            echo -e "  ${RED}ERROR${NC}: Missing required font: $font"
            return 1
        fi
    done

    # Check color format (should be hex without #)
    local colors=$(jq -r '.colors | to_entries[] | .value' "$theme_file")
    for color in $colors; do
        if ! [[ $color =~ ^[0-9a-fA-F]{6}$ ]]; then
            echo -e "  ${YELLOW}WARN${NC}: Invalid color format: $color (expected RRGGBB)"
        fi
    done

    # Check terminal colors
    for i in {0..15}; do
        if ! jq -e ".terminal.color$i" "$theme_file" >/dev/null 2>&1; then
            echo -e "  ${YELLOW}WARN${NC}: Missing terminal color: color$i"
        fi
    done

    echo -e "  ${GREEN}OK${NC}"
    return 0
}

if [[ $# -eq 0 ]]; then
    # Validate all themes
    has_errors=0
    for theme in "${THEMES_DIR}"/*.json; do
        if [[ -f "$theme" && "$(basename "$theme")" != "current.json" ]]; then
            if ! validate_theme_file "$theme"; then
                has_errors=1
            fi
        fi
    done
    exit $has_errors
else
    # Validate specific theme
    validate_theme_file "${THEMES_DIR}/$1.json"
fi
