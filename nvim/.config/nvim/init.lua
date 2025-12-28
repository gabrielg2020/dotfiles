-- opts
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
-- keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
-- plugins
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = gh('vague2k/vague.nvim') },
	{ src = gh('neovim/nvim-lspconfig') },
	{ src = gh('stevearc/oil.nvim') },
	{ src = gh('echasnovski/mini.pick') },
})

-- lsp
vim.lsp.enable({ "lua_ls", "ts_ls", "tailwindcss", "eslint" })

-- file picker
require "mini.pick".setup()
require "oil".setup()

-- theme
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- omni-complete
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")
