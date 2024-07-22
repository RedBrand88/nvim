return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
      },
      --this may need to be removed
      -- on_attach = function(client)
      --   if client.server_capabilities.documentFormattingProvider then
      --     vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
      --   end
      -- end,
    })
  end,
}

