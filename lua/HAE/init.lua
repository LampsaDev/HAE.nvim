local M = {}

Selected = nil

function M.get_visual_selection()
	local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
	local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
	local lines = vim.fn.getline(start_row, end_row)
	if #lines == 0 then
		return vim.fn.expand("<cword>")
	end
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_col, end_col)
	else
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
	end
	return table.concat(lines, " ")
end

function M.url_encode(str)
	return str:gsub("[^%w%-_%.~]", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

function M.get_line_diagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local line = cursor_pos[1] - 1 -- Convert to 0-indexed line

	local diagnostics = vim.diagnostic.get(bufnr)

	local line_diagnostics = {}
	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.lnum == line then
			table.insert(line_diagnostics, diagnostic.message)
		end
	end

	return line_diagnostics
end

function M.search_google()
	local query
	if Selected then
		query = Selected
	else
		query = M.get_visual_selection()
	end
	M.search("https://www.google.com/search?q=", query, "")
	print("Opening google search for: " .. query)
	Selected = nil
end

function M.search_ai()
	local query
	if Selected then
		query = Selected
	else
		query = M.get_visual_selection()
	end
	M.search("https://chatgpt.com/?q=", query, "")
	print("Opening ai search for: " .. query)
	Selected = nil
end

function M.search_error(ai)
	local filetype = vim.bo.filetype
	if filetype then
		filetype = " in " .. filetype
	end
	local query = M.get_line_diagnostics()
	if #query == 0 then
		print("No diagnostics found.")
		return
	end
	Selected = table.concat(query, "\n") .. filetype
	for i, v in ipairs(query) do
		print(v)
	end
	if ai then
		M.search_ai()
	else
		M.search_google()
	end
end

function M.search(search_start, query, search_end)
	if query == "" then
		print("No text Selected!")
		return
	end
	-- Replace spaces with '+' for the Google search URL
	local search_url = search_start .. M.url_encode(query) .. search_end
	-- Open the default web browser
	vim.fn.system({ "xdg-open", search_url })
	return query
end

vim.api.nvim_create_user_command("SearcherAI", function()
	M.search_ai()
end, { range = true })

vim.api.nvim_create_user_command("SearcherGoogle", function()
	M.search_google()
end, { range = true })

vim.api.nvim_create_user_command("SearcherError", function()
	M.search_error(false)
end, { range = true })

vim.api.nvim_create_user_command("SearcherErrorAI", function()
	M.search_error(true)
end, { range = true })

vim.keymap.set("n", "<leader>SE", ":SearcherErrorAI<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Se", ":SearcherError<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>SS", ":SearcherGoogle<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>SS", ":SearcherGoogle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>SA", ":SearcherAI<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>SA", ":SearcherAI<CR>", { noremap = true, silent = true })

return M
