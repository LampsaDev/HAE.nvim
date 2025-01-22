# **Hae aka Quick web search provider**

Simple Neovim plugin for searching the web.
Checks whats under the cursor and uses it as search

## _Commands_

- HaeGoogle
  -> Opens default browser and search selected text or word under cursor from Google
- HaeAI
  -> Opens browser and starts chat with AI about selected text or the text under cursor
- HaeError
  -> Searches the error on current line from web

## _Install using lazy_

```lua
return {
  "LampsaDev/HAE.nvim"
  lazy = false,
  config = function(
  require("HAE"
  end,
}
```

## _Default binds_

- \<leader\>SS -> Search from Google
- \<leader\>SA -> Search from ChatGPT
- \<leader\>Se -> Search current error from Google
- \<leader\>SE -> Search current error from ChatGPT
