local M = {}

M.setup = function(opts)
  vim.api.nvim_create_autocmd({ 'LspAttach', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('lsp-cd', {}),
    callback = function(o)
      local clients = vim.lsp.get_clients { bufnr = o.buf }
      for _, client in pairs(clients) do
        vim.cmd.lcd client.root_dir
      end
    end,
  })
end

return M
