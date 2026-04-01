#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEMES_DIR="${DOTFILES_ROOT}/themes"
TEMPLATES_DIR="${DOTFILES_ROOT}/templates"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }

usage() {
    cat <<EOF
Usage: $0 [THEME_NAME]

Switch to a different colorscheme across all applications.

Arguments:
  THEME_NAME    Name of the theme (e.g., vague, catppuccin)
                If omitted, shows available themes

Options:
  -h, --help    Show this help message

Examples:
  $0                  # List available themes
  $0 vague            # Switch to vague theme
  $0 catppuccin       # Switch to catppuccin theme
EOF
}

list_themes() {
    log_info "Available themes:"
    for theme in "${THEMES_DIR}"/*.json; do
        if [[ -f "$theme" && "$(basename "$theme")" != "current.json" ]]; then
            theme_name=$(basename "$theme" .json)
            if [[ -L "${THEMES_DIR}/current.json" ]] &&
               [[ "$(readlink -f "${THEMES_DIR}/current.json")" == "$theme" ]]; then
                echo "  * ${theme_name} (current)"
            else
                echo "    ${theme_name}"
            fi
        fi
    done
}

validate_theme() {
    local theme_name=$1
    local theme_file="${THEMES_DIR}/${theme_name}.json"

    if [[ ! -f "$theme_file" ]]; then
        log_error "Theme '${theme_name}' not found at ${theme_file}"
        return 1
    fi

    if ! jq empty "$theme_file" 2>/dev/null; then
        log_error "Theme '${theme_name}' is not valid JSON"
        return 1
    fi

    log_success "Theme '${theme_name}' validated"
    return 0
}

hex_to_rgba() {
    local hex=$1
    local alpha=$2
    echo "${hex}${alpha}"
}

load_theme_vars() {
    local theme_file=$1

    # Export theme metadata
    export THEME_NAME=$(jq -r '.name' "$theme_file")
    export THEME_DESCRIPTION=$(jq -r '.description // "No description"' "$theme_file")

    # Export fonts
    export THEME_FONT_TERMINAL=$(jq -r '.fonts.terminal' "$theme_file")
    export THEME_FONT_UI=$(jq -r '.fonts.ui' "$theme_file")

    # Export all colors (convert snake_case to UPPER_SNAKE_CASE)
    while IFS= read -r line; do
        local key=$(echo "$line" | cut -d: -f1 | tr -d '"' | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        local value=$(echo "$line" | cut -d: -f2 | tr -d ' "#,')
        export "THEME_${key}=${value}"
    done < <(jq -r '.colors | to_entries | .[] | "\(.key):\(.value)"' "$theme_file")

    # Export terminal colors
    while IFS= read -r line; do
        local key=$(echo "$line" | cut -d: -f1 | tr -d '"')
        local value=$(echo "$line" | cut -d: -f2 | tr -d ' "#,')
        export "THEME_${key^^}=${value}"
    done < <(jq -r '.terminal | to_entries | .[] | "\(.key):\(.value)"' "$theme_file")

    # Generate RGBA variants for Hyprland
    local active_border_alpha=$(jq -r '.opacity.active_border' "$theme_file")
    local inactive_border_alpha=$(jq -r '.opacity.inactive_border' "$theme_file")
    local shadow_alpha=$(jq -r '.opacity.shadow' "$theme_file")

    export THEME_STRING_RGBA=$(hex_to_rgba "${THEME_STRING}" "${active_border_alpha}")
    export THEME_KEYWORD_RGBA=$(hex_to_rgba "${THEME_KEYWORD}" "${active_border_alpha}")
    export THEME_LINE_RGBA=$(hex_to_rgba "${THEME_LINE}" "${inactive_border_alpha}")
    export THEME_BG_RGBA=$(hex_to_rgba "${THEME_BG}" "${shadow_alpha}")
}

render_template() {
    local template_file=$1
    local output_file=$2

    if [[ ! -f "$template_file" ]]; then
        log_warn "Template not found: ${template_file}"
        return 1
    fi

    log_info "Rendering ${output_file}"

    # Create output directory if it doesn't exist
    mkdir -p "$(dirname "$output_file")"

    # Use envsubst to substitute variables
    envsubst < "$template_file" > "$output_file"

    return 0
}

apply_theme() {
    local theme_name=$1
    local theme_file="${THEMES_DIR}/${theme_name}.json"

    log_info "Applying theme: ${theme_name}"

    # Load theme variables
    load_theme_vars "$theme_file"

    # Render all templates
    render_template \
        "${TEMPLATES_DIR}/kitty/kitty.conf.template" \
        "${DOTFILES_ROOT}/kitty/.config/kitty/kitty.conf"

    render_template \
        "${TEMPLATES_DIR}/hypr/hyprland.conf.template" \
        "${DOTFILES_ROOT}/hypr/.config/hypr/hyprland.conf"

    render_template \
        "${TEMPLATES_DIR}/waybar/style.css.template" \
        "${DOTFILES_ROOT}/waybar/.config/waybar/style.css"

    render_template \
        "${TEMPLATES_DIR}/waybar/colors/theme.css.template" \
        "${DOTFILES_ROOT}/waybar/.config/waybar/colors/vague.css"

    render_template \
        "${TEMPLATES_DIR}/waybar/config.template" \
        "${DOTFILES_ROOT}/waybar/.config/waybar/config"

    render_template \
        "${TEMPLATES_DIR}/rofi/theme.rasi.template" \
        "${DOTFILES_ROOT}/rofi/.config/rofi/vague.rasi"

    render_template \
        "${TEMPLATES_DIR}/swaync/style.css.template" \
        "${DOTFILES_ROOT}/swaync/.config/swaync/style.css"

    render_template \
        "${TEMPLATES_DIR}/nvim/lua/theme.lua.template" \
        "${DOTFILES_ROOT}/nvim/.config/nvim/lua/theme.lua"

    # Update current theme symlink
    ln -sf "${theme_file}" "${THEMES_DIR}/current.json"

    log_success "Theme files generated"
}

reload_applications() {
    log_info "Reloading applications"

    # Reload Hyprland
    if command -v hyprctl >/dev/null 2>&1; then
        log_info "Reloading Hyprland..."
        hyprctl reload || log_warn "Failed to reload Hyprland"
    fi

    # Reload Waybar
    if pgrep -x waybar >/dev/null; then
        log_info "Reloading Waybar..."
        pkill -SIGUSR2 waybar 2>/dev/null || {
            killall waybar 2>/dev/null
            setsid waybar >/dev/null 2>&1 &
        }
    fi

    # Reload SwayNC
    if pgrep -x swaync >/dev/null; then
        log_info "Reloading SwayNC..."
        swaync-client --reload-config || log_warn "Failed to reload SwayNC"
    fi

    # Kitty instances will pick up changes on new window creation
    if command -v kitty >/dev/null 2>&1; then
        log_info "Kitty will use new theme on next launch"
        # Send signal to all kitty instances to reload config
        pkill -SIGUSR1 kitty 2>/dev/null || true
    fi

    # Neovim - users need to restart or :source the config
    log_info "Neovim will use new theme on next launch"
    log_info "Or run :source ~/.config/nvim/lua/theme.lua in active sessions"

    log_success "Applications reloaded"
}

check_dependencies() {
    local missing_deps=()

    command -v jq >/dev/null 2>&1 || missing_deps+=("jq")
    command -v envsubst >/dev/null 2>&1 || missing_deps+=("envsubst (gettext)")

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_info "Install with: sudo pacman -S jq gettext"
        return 1
    fi

    return 0
}

main() {
    # Check dependencies
    if ! check_dependencies; then
        exit 1
    fi

    if [[ $# -eq 0 ]]; then
        list_themes
        exit 0
    fi

    case "${1:-}" in
        -h|--help)
            usage
            exit 0
            ;;
        *)
            local theme_name=$1
            if validate_theme "$theme_name"; then
                apply_theme "$theme_name"
                reload_applications
                log_success "Theme switched to: ${theme_name}"
                log_info "Note: Some applications may require restart for full effect"
            else
                log_error "Failed to switch theme"
                exit 1
            fi
            ;;
    esac
}

main "$@"
