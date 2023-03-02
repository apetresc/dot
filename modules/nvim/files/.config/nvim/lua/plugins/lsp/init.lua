function bind_common_keys(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gl', vim.lsp.buf.incoming_calls, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', 'gs', "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
  vim.keymap.set('n', 'gs', "<Cmd>SymbolsOutline<CR>", bufopts)
  vim.keymap.set('n', 'gw', vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '[x', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']x', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', ']r', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', ']s', vim.diagnostic.show, bufopts)

  local id = vim.api.nvim_create_augroup("SharedLspFormatting", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = id,
    pattern = "*",
    command = "lua vim.lsp.buf.formatting_sync()",
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
    end
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require("mason").setup()
      mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function (server_name)
          require("lspconfig")[server_name].setup {
            on_attach = bind_common_keys,
          }
        end,
        ["rust_analyzer"] = function ()
          local rt = require("rust-tools")
          rt.setup({
            server = {
              on_attach = function(_, bufnr)
                bind_common_keys(_, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, bufopts)
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, bufopts)
              end,
            },
          })
        end
      })
    end
  },
  {
    'simrat39/rust-tools.nvim',
    ft='rust',
  },
}

