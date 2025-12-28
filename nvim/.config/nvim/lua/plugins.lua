-- plugin declarations
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = gh('vague2k/vague.nvim') },
	{ src = gh('neovim/nvim-lspconfig') },
	{ src = gh('stevearc/oil.nvim') },
	{ src = gh('echasnovski/mini.pick') },
	{ src = gh('mason-org/mason.nvim') },
	{ src = gh('mason-org/mason-lspconfig.nvim') },
	{ src = gh('saghen/blink.cmp') },
})

-- mason
require 'mason'.setup()
local mason = require('mason-lspconfig')
mason.setup()

-- blink
local blink = require('blink.cmp')
blink.setup({
	-- todo: figure out why the rust binary is failing to be pulled...
	fuzzy = { implementation = "lua" },
})
local capabilities = blink.get_lsp_capabilities()

-- setup lsps
for _, server_name in ipairs(mason.get_installed_servers()) do
	-- tell the lsp that it can use the features from blink.cmp
	vim.lsp.config(server_name, {
		capabilities = capabilities
	})
	-- find all server installed via mason and enable them in lsp
	vim.lsp.enable(server_name)
end

-- file picker
require 'mini.pick'.setup()
require 'oil'.setup()

-- Theme
vim.cmd('colorscheme vague')
vim.cmd(':hi statusline guibg=NONE')
