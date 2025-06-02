# Core environment variables
export EDITOR="nvim"
export GPG_TTY=$(tty)

# Build directories
export BUILDDIR=$HOME/build
export PKGDIR=$HOME/packages

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

