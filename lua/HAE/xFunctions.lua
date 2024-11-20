local M = {}

function M.split(input, delimiter)
	local result = {}
	for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

function M.get_command()
	local line = vim.api.nvim_get_current_line()

	-- Check if "/x" exists
	if not string.find(line, "/x") then
		print("Wait for modifier like 's', 'e', or any valid modifier")
		return nil
	end

	local parts = vim.split(line, "/x", { trimempty = true })
	local command = {}

	-- Determine `before`
	if parts[1]:match("%s$") then
		command.before = ""
	else
		local before_split = vim.split(parts[1], "%s+", { trimempty = true })
		command.before = before_split[#before_split]
	end

	-- Determine `modifier` and `content`
	if parts[2]:match("^%s") then
		command.modifier = ""
		command.content = parts[2]:match("^%s*(.*)") or ""
	else
		local modifier_content_split = vim.split(parts[2], "%s+", { trimempty = true })
		command.modifier = modifier_content_split[1] or ""
		command.content = table.concat(modifier_content_split, " ", 2)
	end

	return command
end

function M.replace()
	local xcommand = M.get_command()
	if not xcommand or not xcommand.before or not xcommand.content then
		print("Invalid command format for replacing.")
		return
	end
	local old_text = xcommand.before
	local new_text = xcommand.content
	local command = string.format("s/%s/x/%s", old_text, new_text)
	if xcommand.modifier == "a" or xcommand.modifier == "A" then
		command = string.format("%%s/%s/%s", old_text, new_text)
	end

	vim.cmd(command)
end

return M
