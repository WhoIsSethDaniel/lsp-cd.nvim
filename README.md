# lsp-cd.nvim

Change the directory automatically using LSP.

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
  -- Default: empty table
  ignore = { 'gopls' },

  -- only use the clients in this list for determining the directory
  -- that should be changed.
  -- Default: empty table
  only = { 'lua_ls' },

  notify = {
    -- notify when this plugin changes the directory.
    -- Default: false
    on_dir_change = true,

    -- notify when the plugin would have changed directory,
    -- but the client's root directory is nil.
    -- Default: false
    on_nil_root_dir = true,
  },
}
```

## Suggestions / Complaints / Help

Please feel free to start a [discussion](https://github.com/WhoIsSethDaniel/lsp-cd.nvim/discussions) or
file a [bug report](https://github.com/WhoIsSethDaniel/lsp-cd.nvim/issues).
