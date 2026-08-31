-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.laststatus = 3
vim.o.fillchars = 'horiz:─,horizup:┴,horizdown:┬,vert:│,vertleft:┤,vertright:├,verthoriz:┼'
vim.cmd("set completeopt+=noselect")

-- keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Save and source config' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Write file' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>-', ':split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>x', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>H', '<C-w>5<', { desc = 'Resize window left' })
vim.keymap.set('n', '<leader>L', '<C-w>5>', { desc = 'Resize window right' })
vim.keymap.set('n', '<leader>J', '<C-w>5+', { desc = 'Resize window down' })
vim.keymap.set('n', '<leader>K', '<C-w>5-', { desc = 'Resize window up' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>df', ':DiffviewOpen<CR>', { desc = 'Open diff view' })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>fr', function() require('findreplace').open() end, { desc = 'Find and replace (buffer)' })
vim.keymap.set('v', '<leader>fr', function() require('findreplace').open_visual() end, { desc = 'Find and replace selection' })
vim.keymap.set('n', '<leader>fR', ':GrugFar<CR>', { desc = 'Find and replace (project)' })
vim.keymap.set('v', '<leader>fR', ':GrugFarWithVisualSelection<CR>', { desc = 'Find and replace selection (project)' })
vim.keymap.set('n', '<leader>cdf', ':DiffviewClose<CR>', { desc = 'Close diff view' })
vim.keymap.set('n', '<leader><leader>', ':Pick files<CR>', { desc = 'Pick files' })
vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Pick help' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', { desc = 'Delete to clipboard' })
vim.keymap.set('n', '<leader>fp', function()
  local filepath = vim.fn.expand('%:p')
  vim.fn.setreg('+', filepath)
  print('Copied: ' .. filepath)
end, { desc = 'Copy current file path' })

-- filetypes
vim.filetype.add({
	extension = {
		njk = 'jinja',
	}
})

-- autocmds
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		vim.keymap.set({ 'n', 'v', 'x' }, 'j', 'gj', { buffer = true })
		vim.keymap.set({ 'n', 'v', 'x' }, 'k', 'gk', { buffer = true })
		vim.keymap.set({ 'n', 'v', 'x' }, '<Down>', 'gj', { buffer = true })
		vim.keymap.set({ 'n', 'v', 'x' }, '<Up>', 'gk', { buffer = true })
	end,
})
