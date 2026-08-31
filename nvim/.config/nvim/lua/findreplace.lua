-- Centred floating find-and-replace for the current buffer.
-- Two boxes pop up in the middle of the editor: Find, then Replace.
-- Matching is literal (very nomagic), like an editor's replace dialog.
local M = {}

local function input_box(title, default, on_confirm)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = 'wipe'
	if default and default ~= '' then
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default })
	end
	local width = math.max(40, #(default or '') + 10)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = width,
		height = 1,
		row = math.floor(vim.o.lines / 2) - 1,
		col = math.floor((vim.o.columns - width) / 2),
		style = 'minimal',
		border = 'rounded',
		title = ' ' .. title .. ' ',
		title_pos = 'center',
	})
	local function close()
		vim.cmd.stopinsert()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end
	vim.keymap.set({ 'i', 'n' }, '<CR>', function()
		local text = (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or '')
		close()
		-- let the window teardown settle before acting on the result
		vim.schedule(function() on_confirm(text) end)
	end, { buffer = buf })
	vim.keymap.set({ 'i', 'n' }, '<Esc>', close, { buffer = buf })
	vim.cmd('startinsert!')
end

function M.open(prefill)
	input_box('Find', prefill, function(find)
		if find == '' then
			return
		end
		input_box('Replace', nil, function(replace)
			local view = vim.fn.winsaveview()
			local pattern = '\\V' .. vim.fn.escape(find, '/\\')
			local sub = vim.fn.escape(replace, '/\\&~')
			local ok, err = pcall(vim.cmd, '%s/' .. pattern .. '/' .. sub .. '/g')
			vim.fn.winrestview(view)
			if not ok then
				local msg = err:match('E486') and ('No matches for: ' .. find) or err
				vim.notify(msg, vim.log.levels.WARN)
			end
		end)
	end)
end

-- open with the current visual selection (first line of it) as the find text
function M.open_visual()
	local lines = vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() })
	vim.api.nvim_input('<Esc>')
	M.open(lines[1] or '')
end

return M
