-- plugin declarations
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = gh('vague2k/vague.nvim') },
	{ src = gh('neovim/nvim-lspconfig') },
	{ src = gh('stevearc/oil.nvim') },
	{ src = gh('echasnovski/mini.pick') },
	{ src = gh('echasnovski/mini.pairs') },
	{ src = gh('echasnovski/mini.comment') },
	{ src = gh('echasnovski/mini.diff') },
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
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "v1.8.0",
		}
	},
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

-- file explorer
require 'oil'.setup()

-- minis
require 'mini.pick'.setup()    -- selection picker
require 'mini.comment'.setup() -- block commenting
require 'mini.pairs'.setup()   -- autopairs
require 'mini.diff'.setup()    -- diff lines

-- theme
vim.cmd('colorscheme vague')
vim.cmd(':hi statusline guibg=NONE')
