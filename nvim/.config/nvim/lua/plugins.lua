-- plugin declarations
local gh = function(x) return 'https://github.com/' .. x end

-- nvim-treesitter only guarantees the parser versions pinned in its own
-- parser.lua, so a plugin update without a :TSUpdate leaves the queries and
-- the compiled parsers mismatched. Must be registered before vim.pack.add.
vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		if ev.data.spec.name ~= 'nvim-treesitter' or ev.data.kind ~= 'update' then
			return
		end
		if not ev.data.active then
			vim.cmd.packadd('nvim-treesitter')
		end
		vim.cmd('TSUpdate')
	end,
})

vim.pack.add({
	{ src = gh('vague2k/vague.nvim') },
	{ src = gh('neovim/nvim-lspconfig') },
	{ src = gh('stevearc/oil.nvim') },
	{ src = gh('nvim-tree/nvim-tree.lua') },
	{ src = gh('MagicDuck/grug-far.nvim') },
	{ src = gh('echasnovski/mini.pick') },
	{ src = gh('echasnovski/mini.pairs') },
	{ src = gh('echasnovski/mini.comment') },
	{ src = gh('echasnovski/mini.diff') },
	{ src = gh('echasnovski/mini.surround') },
	{ src = gh('echasnovski/mini.indentscope') },
	{ src = gh('sindrets/diffview.nvim') },
	{ src = gh('mason-org/mason.nvim') },
	{ src = gh('mason-org/mason-lspconfig.nvim') },
	{ src = gh('saghen/blink.cmp') },
	{ src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
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
	completion = {
		menu = { border = 'rounded' },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 75,
			window = {
				border = 'rounded',
				max_width = 65,
				max_height = 12,
			},
		},
	},
	-- parameter tooltip when typing inside a function call; kept to a slim
	-- strip so monster generic signatures (zod!) do not flood the screen
	signature = {
		enabled = true,
		window = {
			border = 'rounded',
			max_width = 80,
			max_height = 3,
		},
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

-- per-server settings, merged over the shared blink.cmp capabilities
local server_overrides = {
	-- jinja-lsp also drives the jinja filetype mapped from .njk
	jinja_lsp = { filetypes = { 'jinja', 'html' } },
	-- gopls ships semantic tokens disabled. Treesitter cannot tell a constant
	-- from a struct field in a selector like http.StatusNotFound — both parse
	-- as @property — so the language server is the only source for that.
	gopls = { settings = { gopls = { semanticTokens = true } } },
}

-- setup lsps
for _, server_name in ipairs(mason.get_installed_servers()) do
	-- tell the lsp that it can use the features from blink.cmp
	vim.lsp.config(server_name, vim.tbl_deep_extend('force',
		{ capabilities = capabilities },
		server_overrides[server_name] or {}))
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

-- project-wide find and replace panel
require 'grug-far'.setup({
	transient = true, -- close the panel buffer when hidden
})

-- sidebar file tree; directory buffers stay with oil
require 'nvim-tree'.setup({
	hijack_netrw = false,
	hijack_directories = { enable = false },
	renderer = {
		icons = {
			-- no nvim-web-devicons installed, so keep to built-in glyphs
			show = { file = false, folder = false, folder_arrow = true, git = true },
		},
	},
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
require 'diffview'.setup()         -- source control diff view
require 'mini.comment'.setup()     -- block commenting
require 'mini.pairs'.setup()       -- autopairs
require 'mini.surround'.setup()    -- surround actions
require 'mini.diff'.setup()        -- diff lines
require 'mini.indentscope'.setup() -- indent scoping

-- treesitter
-- Parsers mirror the language servers installed via mason, plus the filetypes
-- this config itself is written in. Installation is asynchronous.
require 'nvim-treesitter'.install({
	'bash', 'css', 'diff', 'gitcommit', 'go', 'gomod', 'html', 'javascript',
	'jinja', 'json', 'lua', 'markdown', 'markdown_inline', 'odin', 'prisma',
	'python', 'query', 'regex', 'scss', 'sql', 'toml', 'tsx', 'typescript',
	'vim', 'vimdoc', 'yaml',
})

-- Highlighting comes from Neovim, not the plugin — the plugin only supplies
-- parsers and queries. Guard on language.add so filetypes without an
-- installed parser fall back to regex syntax instead of erroring.
vim.api.nvim_create_autocmd('FileType', {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(ev.buf, lang)
		end
	end,
})

-- theme
-- Switch between themes by changing the require line:
-- - themes.vague
-- - themes.blue-matrix
require('themes.blue-matrix')
