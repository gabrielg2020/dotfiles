-- Noir theme configuration
-- Vague's muted pastel syntax on a transparent background, so the
-- terminal's blurred near-black shows through — colour lives in the code.
require('vague').setup({
	transparent = true,
})
vim.cmd('colorscheme vague')
vim.cmd(':hi statusline guibg=NONE')
