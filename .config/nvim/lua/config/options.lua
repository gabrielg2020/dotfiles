-- tabs & spacing
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true
-- lines
vim.opt.wrap = false
vim.opt.linebreak = true
-- improved searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy --type text/plain",
    ["*"] = "wl-copy --type text/plain --primary",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline --primary",
  },
  cache_enabled = 1,
}
