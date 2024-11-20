local M = {}
local xFunctions = require("xFunctions")

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

function M.get_line_diagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local line = cursor_pos[1] - 1

	local diagnostics = vim.diagnostic.get(bufnr)
	local line_diagnostics = {}

	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.lnum == line then
			table.insert(line_diagnostics, diagnostic.message)
		end
	end

	return line_diagnostics
end

function M.search(search_start, query, search_end)
	if query == "" then
		print("No text Selected!")
		return
	end
	local search_url = search_start .. xFunctions.url_encode(query) .. search_end
	vim.fn.system({ "xdg-open", search_url })
	return query
end

function M.search_google()
	local query = Selected or M.get_visual_selection()
	M.search("https://www.google.com/search?q=", query, "")
	print("Opening Google search for: " .. query)
	Selected = nil
end

function M.search_ai()
	local query = Selected or M.get_visual_selection()
	M.search("https://you.com/search?q=", query, "&fromSearchBar=true&tbm=youchat")
	print("Opening AI search for: " .. query)
	Selected = nil
end

function M.search_error(ai)
	local filetype = vim.bo.filetype and (" in " .. vim.bo.filetype) or ""
	local query = M.get_line_diagnostics()
	if #query == 0 then
		print("No diagnostics found.")
		return
	end
	Selected = table.concat(query, "\n") .. filetype
	for _, v in ipairs(query) do
		print(v)
	end
	if ai then
		M.search_ai()
	else
		M.search_google()
	end
end

return M
