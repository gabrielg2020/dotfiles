# Tmux Configuration Reference

## Prefix Key

The prefix key has been remapped from the default `Ctrl-b` to `Ctrl-f`.

All keybindings below require pressing the prefix key first, unless otherwise stated.

## Keybindings

### Session & General

| Keybinding | Action |
|------------|--------|
| `Ctrl-f r` | Reload tmux configuration |
| `Ctrl-f d` | Detach from session |
| `Ctrl-f $` | Rename session |

### Windows

| Keybinding | Action |
|------------|--------|
| `Ctrl-f c` | Create new window |
| `Ctrl-f ,` | Rename current window |
| `Ctrl-f n` | Next window |
| `Ctrl-f p` | Previous window |
| `Ctrl-f 0-9` | Switch to window number |
| `Ctrl-f &` | Kill current window |

### Panes

#### Navigation

| Keybinding | Action |
|------------|--------|
| `Ctrl-f h` | Move to left pane |
| `Ctrl-f j` | Move to pane below |
| `Ctrl-f k` | Move to pane above |
| `Ctrl-f l` | Move to right pane |

#### Splitting

| Keybinding | Action |
|------------|--------|
| `Ctrl-f \|` | Split pane horizontally (opens in current directory) |
| `Ctrl-f -` | Split pane vertically (opens in current directory) |

#### Resizing

| Keybinding | Action |
|------------|--------|
| `Ctrl-f H` | Resize pane left (repeatable) |
| `Ctrl-f J` | Resize pane down (repeatable) |
| `Ctrl-f K` | Resize pane up (repeatable) |
| `Ctrl-f L` | Resize pane right (repeatable) |

#### Other Pane Commands

| Keybinding | Action |
|------------|--------|
| `Ctrl-f x` | Kill current pane |
| `Ctrl-f z` | Toggle pane zoom |
| `Ctrl-f q` | Show pane numbers |

### Copy Mode

| Keybinding | Action |
|------------|--------|
| `Ctrl-f [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Copy selection to clipboard (in copy mode) |
| `Enter` | Copy selection and exit copy mode |
| `Ctrl-c` | Copy selection to clipboard (in copy mode) |
| `q` | Exit copy mode |

Mouse selection is enabled and automatically copies to the system clipboard.

## Plugins

### TPM (Tmux Plugin Manager)

Plugin manager for tmux. Install plugins with `Ctrl-f I`, update with `Ctrl-f U`, remove with `Ctrl-f alt-u`.

**Repository:** [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)

### tmux-sensible

Sensible default settings for tmux that everyone can agree on.

**Repository:** [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)

### tmux-sidebar

A sidebar with a directory tree for the current path. Toggle with `Ctrl-f Tab` or `Ctrl-f Backspace`.

**Repository:** [tmux-plugins/tmux-sidebar](https://github.com/tmux-plugins/tmux-sidebar)

### tmux-cpu

Displays CPU and RAM usage in the status bar.

**Repository:** [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

## Features

- **Mouse support enabled** - Click to switch panes, resize panes, and select text
- **Windows and panes start at 1** - More ergonomic for keyboard navigation
- **Vi-mode for copy mode** - Familiar keybindings for Vim users
- **Cross-platform clipboard** - Automatically detects macOS (pbcopy) or Linux (xclip)
- **True colour support** - Better colour rendering for modern terminal applications
- **Fast escape time** - Reduced delay for better responsiveness with Vim/Neovim
