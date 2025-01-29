return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local lsp = require('lsp-zero')
    local cmp = require('cmp')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )

    ---@diagnostic disable-next-line: unused-local
    lsp.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp.default_keymaps({ buffer = bufnr })

      vim.keymap.set('n', '<leader>vf', '<cmd>lua vim.lsp.buf.format()<CR>', { buffer = bufnr });
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = bufnr });
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr });
    end)

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = { 'ts_ls', 'lua_ls', 'cssls', 'gopls' },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["ts_ls"] = function()
          local success, lspconfig = pcall(require, "lspconfig")
          if not success then
            vim.notify("lspconfig is not installed", vim.log.levels.ERROR)
            return
          end
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = function(fname)
              return require 'lspconfig'.util.root_pattern('package.json', 'tsconfig.json', '.git')(fname) or
                  vim.loop.cwd()
            end
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  path = vim.split(package.path, ';'),
                },
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,

        ["gopls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup {
            capabilities = capabilities,
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
            on_attach = function(client, bufnr)
              lsp.default_keymaps({ buffer = bufnr })
              vim.cmd([[
                augroup GoFormat
                  autocmd!
                  autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync()
                augroup END
              ]])
            end
          }
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = 'rounded',
        }),
        documentation = cmp.config.window.bordered({
          border = 'rounded',
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
