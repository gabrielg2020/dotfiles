# dotfiles

Personal configuration files for macOS and Arch Linux, managed with GNU Stow.

## Prerequisites

### Core Tools
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [Oh-My-Zsh](https://ohmyz.sh/) - Zsh framework
- [Homebrew](https://brew.sh/) (macOS only)

### Applications
- [Neovim](https://neovim.io/) - Text editor
  - Using nightly build via [bob](https://github.com/MordechaiHadad/bob) for the built-in package manager
  - Will likely move to stable once the built-in package manager is fully released or I'll stick with Lazy... who knows!
- [Kitty](https://sw.kovidgoyal.net/kitty/) - Terminal emulator
- [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer

### Development Dependencies
- [Node.js](https://nodejs.org/) - JavaScript runtime (managed via nvm)
- [Python](https://www.python.org/) - Python interpreter
- [Go](https://go.dev/) - Go programming language

## Setup

### Machine-Specific Configuration

Before stowing, create local configuration files for sensitive or machine-specific settings:

1. Create `~/.zshrc.local` for machine-specific shell configuration:
   ```bash
   touch ~/.zshrc.local
   ```

2. Create `~/.secrets` for sensitive environment variables:
   ```bash
   touch ~/.secrets
   ```

These files are gitignored and won't be tracked.

### Installing Configurations

From the dotfiles directory, use GNU Stow to symlink individual packages:

```bash
# Neovim configuration
stow nvim

# Kitty terminal
stow kitty

# Tmux configuration
stow tmux

# Zsh configuration
stow zsh
```

To remove a configuration:

```bash
stow -D <package-name>
```

## Structure

Each directory represents a Stow package that mirrors the home directory structure:

```
dotfiles/
├── nvim/.config/nvim/
├── kitty/.config/kitty/
├── tmux/.config/tmux/
└── zsh/
```

When you run `stow nvim`, it creates symlinks from `~/.config/nvim/` to `dotfiles/nvim/.config/nvim/`.
