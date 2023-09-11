function bind_common_keys(_, bufnr)
  local default_bufopts = { noremap = true, silent = true, buffer = bufnr }
  local function Map(mode, lhs, rhs, desc, bufopts)
    return vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', bufopts or default_bufopts, {desc = desc}))
  end
  Map('n', '<c-]>', vim.lsp.buf.definition, 'Go to definition')
  Map('n', 'K', vim.lsp.buf.hover, 'Display hover information about the symbol under the cursor')
  Map('n', 'gh', vim.lsp.buf.signature_help, 'Display signature help')
  Map('n', 'ga', vim.lsp.buf.code_action, 'Show code actions')
  Map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
  Map('n', 'gl', vim.lsp.buf.incoming_calls, 'List incoming calls')
  Map('n', 'gd', vim.lsp.buf.type_definition, 'Go to type definition')
  Map('n', 'gr', vim.lsp.buf.type_definition, 'List references')
  Map('n', '<leader>r', vim.lsp.buf.rename, 'Rename symbol')
  Map('n', 'gs', ':SymbolsOutline<CR>', 'Symbols outline')
  Map('n', 'gw', vim.lsp.buf.workspace_symbol, 'List workspace symbols')
  Map('n', '[x', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
  Map('n', ']x', vim.diagnostic.goto_next, 'Go to next diagnostic')
  Map('n', ']s', vim.diagnostic.show, 'Show diagnostic')
  Map('n', ']s', vim.diagnostic.show, 'Show diagnostic')
  Map('n', ']r', vim.diagnostic.open_float, 'Float diagnostic')

  local id = vim.api.nvim_create_augroup("SharedLspFormatting", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = id,
    pattern = "*",
    callback = function()
      vim.lsp.buf.format({async = false})
    end,
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
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    opts = {
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "", hl = "@type" },
        Interface = { icon = "", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "", hl = "@type" },
        Key = { icon = "", hl = "@type" },
        Null = { icon = "", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "", hl = "@type" },
        Event = { icon = "", hl = "@type" },
        Operator = { icon = "", hl = "@operator" },
        TypeParameter = { icon = "", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      }
    },
  },
  {
    'simrat39/rust-tools.nvim',
    ft='rust',
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = true,
  },
}

