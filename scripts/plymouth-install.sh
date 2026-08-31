#!/usr/bin/env bash
# Install the noir Plymouth theme system-wide and rebuild the initramfs.
# Run with sudo after editing anything in plymouth/noir/.

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEME="noir"

if [[ $EUID -ne 0 ]]; then
    echo "Run with sudo: sudo $0" >&2
    exit 1
fi

rm -rf "/usr/share/plymouth/themes/${THEME}"
cp -r "${DOTFILES_ROOT}/plymouth/${THEME}" "/usr/share/plymouth/themes/${THEME}"
plymouth-set-default-theme -R "${THEME}"
echo "Installed ${THEME} and rebuilt initramfs"
