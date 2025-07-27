local M = {}

local should_change_dir = function(client, opts)
  if vim.fn.getcwd() == client.root_dir then
    return false
  end
  if opts.ignore and vim.tbl_contains(opts.ignore, client.name) then
    return false
  end
  if opts.only then
    if vim.tbl_contains(opts.only or {}, client.name) then
      return true
    end
    return false
  end
  return true
end

M.setup = function(opts)
  opts = opts or {}
  opts.notify = opts.notify or {}
  vim.validate('ignore', opts.ignore, 'table', true)
  vim.validate('only', opts.only, 'table', true)
  vim.validate('notify.on_dir_change', opts.notify.on_dir_change, 'boolean', true)
  vim.validate('notify.on_nil_root_dir', opts.notify.on_nil_root_dir, 'boolean', true)

  vim.api.nvim_create_autocmd({ 'LspAttach', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('lsp-cd', {}),
    callback = function(o)
      local clients = vim.lsp.get_clients { bufnr = o.buf }
      for _, client in pairs(clients) do
        if should_change_dir(client, opts) then
          if client.root_dir then
            if opts.notify.on_dir_change then
              vim.notify(string.format('[lsp-cd] changed directory to %s', client.root_dir), vim.log.levels.INFO)
            end
            vim.cmd.lcd(client.root_dir)
          elseif opts.notify.on_nil_root_dir then
            vim.notify(string.format('[lsp-cd] %s root_dir is nil', client.name), vim.log.levels.WARN)
          end
        end
      end
    end,
  })
end

return M
