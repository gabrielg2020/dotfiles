# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

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


