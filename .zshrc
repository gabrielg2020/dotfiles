# Source ~/.profile
source ~/.profile

# Reset PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/.local/bin

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"

# Oh-My-Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/gabriel.omp.json)"

# Remind to update oh-my-zsh evert 7 days.
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Completion dots (...)
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Set aliases
alias zshconfig="vim ~/.zshrc"
alias restartzsh="source ~/.zshrc"
alias vim=nvim
alias windows="sudo efibootmgr --bootnext 0000 && reboot"
alias p="cd $HOME/projects"
alias bt="sudo systemctl restart bluetooth && bluetui"
alias t=tmux

# GPG
GPG_TTY=${tty}

# makepkg
export BUILDDIR=$HOME/build
export PKGDIR=$HOME/packages

# Go
export PATH=$PATH:$GOPATH/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
