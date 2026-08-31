# AI inline completion

Copilot-style ghost-text completion in Neovim, served entirely locally.

## Why it exists

Inline, multi-line code suggestions without sending source to a cloud
provider. Runs against a local model on the AMD GPU.

## Architecture

Two independent completion layers, deliberately kept separate:

- **minuet-ai.nvim** — AI suggestions rendered as **virtual text** (its own
  ghost-text frontend). This is _not_ wired through blink as a source: doing so
  truncates multi-line completions and makes the AI compete for the popup menu.
- **blink.cmp** — keeps handling LSP / buffer / snippet popups, unchanged.

minuet uses Neovim's builtin `vim.system`, so **plenary is not required**.

## Backend

- **Ollama** (`/usr/bin/ollama`, system service) serving **`qwen2.5-coder:1.5b`**
  (~986 MB Q4). Qwen2.5-Coder is FIM-trained at every size.
- minuet talks to it via the `openai_fim_compatible` provider at
  `http://localhost:11434/v1/completions`. `api_key = 'TERM'` is a dummy env var
  (Ollama needs no key) that always resolves.
- GPU: AMD Radeon RX 7700/7800 XT — Ollama drives it via ROCm automatically.

To scale up later: bump `context_window` (512 → larger) and swap the model tag
to `qwen2.5-coder:3b` / `:7b` — the 7B Q4 (~4.7 GB) still fits the card.

## One-time setup

```sh
sudo systemctl enable --now ollama   # start + persist the daemon
ollama pull qwen2.5-coder:1.5b       # fetch the model
```

## Keymaps (minuet virtualtext, Alt = <A->)

| Key     | Action                  |
|---------|-------------------------|
| `<A-A>` | accept full suggestion  |
| `<A-a>` | accept one line         |
| `<A-z>` | accept N lines (prompts)|
| `<A-]>` | next suggestion         |
| `<A-[>` | previous suggestion     |
| `<A-e>` | dismiss                 |

Config lives in `nvim/.config/nvim/lua/plugins.lua` (the `minuet.setup` block).
