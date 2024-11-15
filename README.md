# Super Upee Web Searcher

## Commands

- SearcherGoogle -> Opens default browser and search selected text or word under cursor from SearcherGoogle
- SearcherAI -> Opens browser and starts chat with AI about selected text or the text under cursor
- SearcherError -> Searches the error on current line from web

## Install using lazy

return {
"LampsaDev/HAE.nvim",
lazy = false,
config = function()
require("HAE")
end,
}
