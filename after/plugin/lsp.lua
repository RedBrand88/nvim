local lsp = require("lsp-zero")

lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format() end, opts)
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    -- ['tsserver'] = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
    ['lua_ls'] = { 'lua' },
    -- ['gopls'] = { 'Go' },
    -- ['jdtls'] = { 'java' },
    ['jsonls'] = { 'JSON' },
    ['cssls'] = { 'css' },
  }
})

lsp.setup_servers({ 'tsserver', 'lua_ls', 'jsonls', 'cssls' })

lsp.set_sign_icons({
  error = 'E',
  warn = 'W',
  hint = 'H',
  info = 'I'
})


require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'eslint', 'lua_ls', 'jsonls', 'cssls' },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

lsp.set_preferences({
  suggest_lsp_servers = false,
})

-- local lsp_zero = require('lsp-zero')

-- lsp.on_attach(function(_, bufnr)
--     local opts = { buffer = bufnr, remap = false }

--     vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format() end, opts)
--     vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
-- end)
