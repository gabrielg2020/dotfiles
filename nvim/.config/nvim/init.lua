vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
				{src = gh('vague2k/vague.nvim')},
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
