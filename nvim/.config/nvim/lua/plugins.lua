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
	{ src = gh('echasnovski/mini.indentscope') },
	{ src = gh('mason-org/mason.nvim') },
	{ src = gh('mason-org/mason-lspconfig.nvim') },
	{ src = gh('saghen/blink.cmp') },
	-- { src = gh('milanglacier/minuet-ai.nvim') }, -- AI inline completion (disabled)
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

-- minuet: AI inline completion as an independent ghost-text layer.
-- Backed by local Ollama running Qwen2.5-Coder; blink.cmp keeps handling
-- LSP/buffer/snippet popups, so the two do not compete for the menu.
-- DISABLED for now — re-enable by uncommenting the plugin in vim.pack.add above
-- and this setup block.
--[[
require('minuet').setup({
	provider = 'openai_fim_compatible',
	n_completions = 1,    -- one completion only — saves resources on a local model
	context_window = 512, -- start small; raise if the GPU has headroom
	provider_options = {
		openai_fim_compatible = {
			api_key = 'TERM', -- Ollama needs no key; TERM is a dummy env var that always exists
			name = 'Ollama',
			end_point = 'http://localhost:11434/v1/completions',
			model = 'qwen2.5-coder:1.5b',
			optional = {
				max_tokens = 256, -- room for multi-line suggestions
				top_p = 0.9,
			},
		},
	},
	virtualtext = {
		auto_trigger_ft = { '*' }, -- ghost text in every filetype
		keymap = {
			accept = '<A-A>',
			accept_line = '<A-a>',
			accept_n_lines = '<A-z>',
			prev = '<A-[>',
			next = '<A-]>',
			dismiss = '<A-e>',
		},
	},
})
--]]

-- setup lsps
for _, server_name in ipairs(mason.get_installed_servers()) do
	-- configure jinja-lsp specifically for jinja filetype
	if server_name == 'jinja_lsp' then
		vim.lsp.config(server_name, {
			capabilities = capabilities,
			filetypes = { 'jinja', 'html' },
		})
	else
		-- tell the lsp that it can use the features from blink.cmp
		vim.lsp.config(server_name, {
			capabilities = capabilities
		})
	end
	-- find all server installed via mason and enable them in lsp
	vim.lsp.enable(server_name)
end

-- helper to determine if hidden files should be shown
local is_exception = function(name)
	local exceptions = { '.github', '.env' }
	for _, exception in ipairs(exceptions) do
		if name == exception or vim.startswith(name, exception) then
			return true
		end
	end
	return false
end

-- file explorer
require 'oil'.setup({
	view_options = {
		is_hidden_file = function(name, bufnr)
			return not is_exception(name) and vim.startswith(name, '.')
		end,
	}
})

-- minis
local pick = require 'mini.pick'
pick.setup()        -- selection picker

-- override Pick files to show .github and .env files
pick.registry.files = function(local_opts)
	local_opts = vim.tbl_deep_extend('force', { tool = 'fd' }, local_opts or {})
	local cli_opts = {
		'--color=never', '--type=f',
		'--hidden',  -- show hidden files
		'--exclude=.git',  -- but exclude .git
		'--exclude=.wwebjs_auth',  -- exclude whatsapp web auth
		'--exclude=.wwebjs_cache',  -- exclude whatsapp web cache
		'--exclude=node_modules',  -- exclude node_modules
		'--exclude=__pycache__',  -- exclude python cache
		'--exclude=venv',  -- exclude python venv
    '--exclude=dist',  -- exclude distribution files
	}
	return pick.builtin.cli({ command = { 'fd', unpack(cli_opts) } }, local_opts)
end
require 'mini.comment'.setup()     -- block commenting
require 'mini.pairs'.setup()       -- autopairs
require 'mini.diff'.setup()        -- diff lines
require 'mini.indentscope'.setup() -- indent scoping

-- theme
-- Switch between themes by changing the require line:
-- - themes.vague
-- - themes.blue-matrix
require('themes.blue-matrix')
