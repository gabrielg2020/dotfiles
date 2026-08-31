-- Blue Matrix theme configuration
-- Custom colorscheme based on Blue Matrix theme

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.background = 'dark'
vim.g.colors_name = 'blue-matrix'

-- Colors from Blue Matrix theme
local colors = {
  bg = '#101116',
  fg = '#00a2ff',
  black = '#101116',
  red = '#ff5680',
  green = '#00ff9c',
  yellow = '#fffc58',
  blue = '#00b0ff',
  purple = '#d57bff',
  cyan = '#76c1ff',
  white = '#c7c7c7',
  bright_black = '#686868',
  bright_red = '#ff6e67',
  bright_green = '#5ffa68',
  bright_yellow = '#fffc67',
  bright_blue = '#6871ff',
  bright_purple = '#d682ec',
  bright_cyan = '#60fdff',
  bright_white = '#ffffff',
  selection_bg = '#c1deff',
  cursor = '#76ff9f',
  panel = '#181a22', -- floats and popups: a step lighter than bg
}

-- Editor highlights
vim.api.nvim_set_hl(0, 'Normal', { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.white, bg = colors.panel })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.blue, bg = colors.panel })
vim.api.nvim_set_hl(0, 'FloatTitle', { fg = colors.cyan, bg = colors.panel, bold = true })
vim.api.nvim_set_hl(0, 'NormalNC', { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, 'Cursor', { fg = colors.bg, bg = colors.cursor })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.bright_black })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.bright_black })
vim.api.nvim_set_hl(0, 'Visual', { bg = colors.blue, fg = colors.bg })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = colors.blue, fg = colors.bg })
vim.api.nvim_set_hl(0, 'Search', { bg = colors.yellow, fg = colors.bg })
vim.api.nvim_set_hl(0, 'IncSearch', { bg = colors.bright_yellow, fg = colors.bg })

-- Syntax highlighting
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.bright_black, italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'String', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Character', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Number', { fg = colors.bright_yellow })
vim.api.nvim_set_hl(0, 'Boolean', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Float', { fg = colors.bright_yellow })
vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.white })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Statement', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'Operator', { fg = colors.fg })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, 'Error', { fg = colors.red })
vim.api.nvim_set_hl(0, 'Todo', { fg = colors.yellow, bold = true })

-- UI elements
vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.fg, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = colors.bright_black, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.white, bg = colors.panel })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.bg, bg = colors.blue })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = colors.panel })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.bright_black })
vim.api.nvim_set_hl(0, 'TabLine', { fg = colors.bright_black, bg = colors.bg })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = colors.bg })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = colors.fg, bg = colors.bg })

-- Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.red })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = colors.bright_black, italic = true })

-- Treesitter captures
-- The groups above cover the legacy syntax fallbacks; these add the
-- distinctions treesitter can make that regex syntax cannot.
vim.api.nvim_set_hl(0, '@variable', { fg = colors.white })
vim.api.nvim_set_hl(0, '@variable.parameter', { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, '@variable.member', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@variable.builtin', { fg = colors.bright_purple, italic = true })
vim.api.nvim_set_hl(0, '@property', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@field', { fg = colors.cyan })

vim.api.nvim_set_hl(0, '@constant', { fg = colors.bright_green })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = colors.bright_green, bold = true })
vim.api.nvim_set_hl(0, '@constant.macro', { fg = colors.bright_green })

vim.api.nvim_set_hl(0, '@function', { fg = colors.purple })
vim.api.nvim_set_hl(0, '@function.call', { fg = colors.purple })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = colors.bright_purple })
vim.api.nvim_set_hl(0, '@function.method', { fg = colors.purple })
vim.api.nvim_set_hl(0, '@constructor', { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, '@module', { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, '@label', { fg = colors.bright_purple })

vim.api.nvim_set_hl(0, '@keyword', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@keyword.return', { fg = colors.red })
vim.api.nvim_set_hl(0, '@keyword.import', { fg = colors.bright_purple })
vim.api.nvim_set_hl(0, '@keyword.exception', { fg = colors.red })

vim.api.nvim_set_hl(0, '@type', { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = colors.bright_blue, italic = true })

vim.api.nvim_set_hl(0, '@string', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@string.escape', { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, '@string.special', { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, '@number', { fg = colors.bright_yellow })
vim.api.nvim_set_hl(0, '@boolean', { fg = colors.cyan })

vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = colors.white })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = colors.white })
vim.api.nvim_set_hl(0, '@punctuation.special', { fg = colors.bright_cyan })

vim.api.nvim_set_hl(0, '@comment', { fg = colors.bright_black, italic = true })
vim.api.nvim_set_hl(0, '@comment.todo', { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, '@comment.note', { fg = colors.cyan, bold = true })
vim.api.nvim_set_hl(0, '@comment.warning', { fg = colors.bright_yellow, bold = true })
vim.api.nvim_set_hl(0, '@comment.error', { fg = colors.red, bold = true })

vim.api.nvim_set_hl(0, '@markup.heading', { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, '@markup.strong', { bold = true })
vim.api.nvim_set_hl(0, '@markup.italic', { italic = true })
vim.api.nvim_set_hl(0, '@markup.link', { fg = colors.cyan, underline = true })
vim.api.nvim_set_hl(0, '@markup.raw', { fg = colors.green })
vim.api.nvim_set_hl(0, '@markup.list', { fg = colors.purple })
vim.api.nvim_set_hl(0, '@diff.plus', { fg = colors.green })
vim.api.nvim_set_hl(0, '@diff.minus', { fg = colors.red })

-- LSP semantic tokens
-- These outrank treesitter, so the broad token types are cleared deliberately:
-- gopls tags every package-level identifier as `variable`, which would flatten
-- the @property and @variable.parameter distinctions above back into one
-- colour. Only the modifiers are kept — they carry what parsing cannot derive,
-- namely that an identifier is genuinely immutable.
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})
vim.api.nvim_set_hl(0, '@lsp.type.property', {})
vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
vim.api.nvim_set_hl(0, '@lsp.typemod.variable.readonly', { fg = colors.bright_green })
vim.api.nvim_set_hl(0, '@lsp.typemod.property.readonly', { fg = colors.bright_green })
