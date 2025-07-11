local M = {}

local should_change_dir = function(opts, client)
  if vim.fn.getcwd() == client.root_dir then
    return false
  end
  if opts.ignore and vim.tbl_contains(opts.ignore or {}, client.name) then
    return false
  elseif opts.only then
    if vim.tbl_contains(opts.only or {}, client.name) then
      return true
    end
    return false
  else
    return true
  end
end

M.setup = function(opts)
  opts = opts or {}
  vim.validate('ignore', opts.ignore, 'table', true)
  vim.validate('only', opts.only, 'table', true)
  vim.validate('notify_on_dir_change', opts.notify_on_dir_change, 'boolean', true)

  vim.api.nvim_create_autocmd({ 'LspAttach', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('lsp-cd', {}),
    callback = function(o)
      local clients = vim.lsp.get_clients { bufnr = o.buf }
      for _, client in pairs(clients) do
        if should_change_dir(opts, client) then
          if opts.notify_on_dir_change then
            vim.notify(string.format('[lsp-cd] changed directory to %s', client.root_dir), vim.log.levels.INFO)
          end
          vim.cmd.lcd(client.root_dir)
        end
      end
    end,
  })
end

return M
