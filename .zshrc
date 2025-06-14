# Restart PATH (keeps PATH looking clean)
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/.local/bin

# Source ~/.profile
source ~/.profile

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

# Set aliases
alias zshconfig="vim ~/.zshrc"
alias restartzsh="source ~/.zshrc"
alias vim=nvim
alias windows="sudo efibootmgr --bootnext 0000 && reboot"
alias p="cd $HOME/projects"
alias bt="sudo systemctl restart bluetooth && bluetui"
alias t=tmux
alias tree='tree -I "node_modules|.git"'
