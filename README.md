# Super Upee Web Hae

## Not working at the moment and Will likely be splitted into 2 separate plugins
-> One for searches
-> One for /x functions

## _A simple Neovim plugin for searching the web and replacing text using /x commands. Includes functionality for:_

- Google and AI-based searches.
- Diagnostics-based error searches.
- /x commands for flexible and dynamic text replacement.

## _Commands_

### _Web Searches_

- HaeGoogle:
  -> Opens the default browser and searches the selected text or the word under the cursor using Google.
- HaeAI:
  -> Opens the browser and starts a chat with an AI about the selected text or the word under the cursor.

### _Diagnostics:_

- HaeError:
  -> Searches the error message on the current line from the web using Google.
- HaeErrorAI:
  -> Searches the error message on the current line from the web using an AI.

### _Text Replacement:_

- HaeReplace:
  -> Replaces text dynamically based on /x commands.

## _Install using Lazy_

### _Add the following configuration to your lazy.nvim setup:_

```lua
return {
  "LampsaDev/HAE.nvim",
  lazy = false,
  config = function()
    require("HAE.init")
  end,
}
```

## _Default Key Mappings_

### _Web Searches mappings:_

- \<leader\>SS: Search from Google.
- \<leader\>SA: Search from You.com AI.

### _Diagnostics mappings:_

- \<leader\>Se: Search current error from Google.
- \<leader\>SE: Search current error from You.com AI.

### _Text Replacement mappings:_

- \<C-x\> (in Insert mode): Run /x replacement functionality directly.

## _/x Syntax_

### _Format:_

- \<text-before\>/x\<modifier\> \<replacement-text\>

## _Examples:_

### _Replace old_text with new_text:_

- old_text/x new_text

### _Append text to an existing string for all instances in file:_

- original/xa appended_text

### _Replace text for all instances of original text in file:_

- original/xx appended_text

## _Features_

### _/x Functionality:_

- Dynamically replace text based on /x syntax.
- Automatically determines:
  - before: The word immediately preceding /x (if not separated by a space).
  - modifier: The character(s) immediately after /x.
  - content: The text following /x + modifier + whitespace.

### _Web Searches:_

- Open web searches in Google or You.com AI for selected text or diagnostics.

### _Diagnostics Integration:_

- Automatically pulls the error message from the current line for searches.

## _Todo_

- [] Add /x functionality for text replacement.
- [] Extend /x for inline searches and error marking.
- [] Enable searches from Insert mode using \<C-x\>.
  - [] Use /x to define search areas with modifiers like 's', 'e', 'a'.
  - [] If no markers are set, treat the whole line as the command.
- [] Easy text replacement via /x:
- [] textToReplace/x newText
- [] Enable saving commands with TODO-like syntax.
- [] Delete /x commands automatically after execution.
