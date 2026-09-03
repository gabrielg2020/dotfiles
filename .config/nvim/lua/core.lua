-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.cmd("set completeopt+=noselect")

-- keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Save and source config' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Write file' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>qq', ':wqa<CR>', { desc = 'Save all and quit' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader><leader>', ':Pick files<CR>', { desc = 'Pick files' })
vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Pick help' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', { desc = 'Delete to clipboard' })
vim.keymap.set('n', '<leader>fp', function()
  local filepath = vim.fn.expand('%:p')
  vim.fn.setreg('+', filepath)
  print('Copied: ' .. filepath)
end, { desc = 'Copy current file path' })
