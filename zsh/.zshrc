# Detect OS and source appropriate config
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    source ~/.zshrc.mac
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Arch)
    source ~/.zshrc.arch
fi

# Source local config (machine-specific)
source ~/.zshrc.local
