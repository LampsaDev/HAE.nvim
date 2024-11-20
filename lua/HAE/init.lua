local xFunctions = require("HAE/xFunctions")
local haeFunctions = require("HAE/haeFunctions")

-- Keymaps for Hae functionality
vim.keymap.set("n", "<leader>SE", ":HaeErrorAI<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Se", ":HaeError<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>SS", ":HaeGoogle<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>SS", ":HaeGoogle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>SA", ":HaeAI<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>SA", ":HaeAI<CR>", { noremap = true, silent = true })

-- Keymap for /x replacement functionality
vim.keymap.set("i", "<C-x>", function()
	xFunctions.replace()
end, { noremap = true, silent = true })

-- User commands for Hae functionality
vim.api.nvim_create_user_command("HaeError", function()
	haeFunctions.search_error(false)
end, { range = true })

vim.api.nvim_create_user_command("HaeErrorAI", function()
	haeFunctions.search_error(true)
end, { range = true })

vim.api.nvim_create_user_command("HaeGoogle", function()
	haeFunctions.search_google()
end, { range = true })

vim.api.nvim_create_user_command("HaeAI", function()
	haeFunctions.search_ai()
end, { range = true })

-- User command for /x replacement
vim.api.nvim_create_user_command("HaeReplace", function()
	xFunctions.replace()
end, { range = true })
