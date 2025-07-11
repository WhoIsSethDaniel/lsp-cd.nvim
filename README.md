# lsp-cd.nvim

Automatically change to the root directory of a project for a window if its
buffer has a language server attached.

## Requirements

You must have Neovim's LSP support configured for this to work properly.

## Configuration

You must call the `setup()` method for this plugin to work properly.

```lua
require('lsp-cd').setup()
```

You may pass options to `setup()`:

```lua
require('lsp-cd').setup {
  -- 'ignore' is evaluated first and 'only' is evaluated second.
  --
  -- 'ignore' is a list of client names that should never be used for
  -- changing the directory.
  ignore = { 'gopls' },

  -- only use the clients in this list for determining the directory
  -- that should be changed.
  only = { 'lua_ls' },
}
```
