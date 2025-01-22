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
- \<leader\>SA -> Search from You.com ai
- \<leader\>Se -> Search current error from Google
- \<leader\>SE -> Search current error from You.com ai

## _Todo_

- Run Searches From Insert using \<C-x\>
  - use /x and /x to mark search area with modifiers like 's', 'e', 'a'
  - if no markers are set just treat whole line as command and take modifier ad followup key
  - for example: /xe How does this work?: /x + \<C-x\>
    -> This will add stuff within the markers to the beginning of the error search.
  - It is not necessary to mark end with /x if there's nothing after the search
- Easy way to replace using textToReplace/x newText + \<C-x\>
- Easy way to find using textToReplace/x + \<C-x\>
- Ability to save the commands to the line with todo syntax
- Deletes the command after running it.
