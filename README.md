# dotfiles

```
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
```

Personal configuration for CachyOS (Arch) running Hyprland, managed with GNU Stow.

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [Oh-My-Zsh](https://ohmyz.sh/) - Zsh framework
- [oh-my-posh](https://ohmyposh.dev/) - Prompt
- [Neovim](https://neovim.io/) nightly via [bob](https://github.com/MordechaiHadad/bob)
- [Kitty](https://sw.kovidgoyal.net/kitty/), [tmux](https://github.com/tmux/tmux), [Hyprland](https://hypr.land/) 0.55+ (Lua config)
- waybar, rofi, swaync, hyprlock, hypridle, awww, cliphist, fastfetch, qt6ct/qt5ct

## Setup

Create the untracked local files before stowing:

```bash
touch ~/.zshrc.local   # machine-specific shell config
touch ~/.secrets       # sensitive environment variables
```

Stow each package you want from the repo root:

```bash
stow zsh nvim kitty tmux hypr waybar rofi swaync fastfetch qt
stow -D <package>      # remove one
```

## Structure

Each directory is a Stow package mirroring `$HOME`:

```
dotfiles/
├── zsh/            .zshrc, theme/ (oh-my-posh)
├── nvim/           .config/nvim
├── kitty/          .config/kitty
├── tmux/           .config/tmux
├── hypr/           .config/hypr — hyprland.lua + lua/ modules, hyprlock, hypridle
├── waybar/         .config/waybar
├── rofi/           .config/rofi
├── swaync/         .config/swaync
├── fastfetch/      .config/fastfetch
├── qt/             .config/qt6ct, .config/qt5ct
├── plymouth/       boot splash theme — not stowed, install with scripts/plymouth-install.sh
└── scripts/        wallpaper.sh, osd.sh, plymouth-install.sh, waybar helpers
```

## Theme

One hand-crafted theme, **noir**: near-black monochrome chrome with muted pastel
colour reserved for code. Each app has a `themes/` directory (or colour file) and
an include/source/require line pointing at `noir`; older themes remain alongside
as one-line switchable fallbacks.
