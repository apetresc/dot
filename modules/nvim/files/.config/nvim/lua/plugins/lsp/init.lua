function bind_common_keys(_, bufnr)
  local default_bufopts = { noremap = true, silent = true, buffer = bufnr }
  local function Map(mode, lhs, rhs, desc, bufopts)
    return vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", bufopts or default_bufopts, { desc = desc }))
  end
  Map("n", "<c-]>", vim.lsp.buf.definition, "Go to definition")
  Map("n", "K", vim.lsp.buf.hover, "Display hover information about the symbol under the cursor")
  Map("n", "gh", vim.lsp.buf.signature_help, "Display signature help")
  Map("n", "ga", vim.lsp.buf.code_action, "Show code actions")
  Map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  Map("n", "gl", vim.lsp.buf.incoming_calls, "List incoming calls")
  Map("n", "gd", vim.lsp.buf.type_definition, "Go to type definition")
  Map("n", "gr", vim.lsp.buf.type_definition, "List references")
  Map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
  Map("n", "gw", vim.lsp.buf.workspace_symbol, "List workspace symbols")
  Map("n", "[x", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  Map("n", "]x", vim.diagnostic.goto_next, "Go to next diagnostic")
  Map("n", "]s", vim.diagnostic.show, "Show diagnostic")
  Map("n", "]s", vim.diagnostic.show, "Show diagnostic")
  Map("n", "]r", vim.diagnostic.open_float, "Float diagnostic")

  local id = vim.api.nvim_create_augroup("SharedLspFormatting", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = id,
    pattern = "*",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

function bind_debug_keys(_, bufnr)
  local default_bufopts = { noremap = true, silent = true, buffer = bufnr }
  local function Map(mode, lhs, rhs, desc, bufopts)
    return vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", bufopts or default_bufopts, { desc = desc }))
  end
  local dap = require("dap")
  Map("n", "<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason").setup()
      mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        handlers = {
          function(server)
            lspconfig[server].setup({
              on_attach = bind_common_keys,
            })
          end,
          ["rust_analyzer"] = function()
            -- We don't let lspconfig do the setup for rust_analyzer because we
            -- want to use the rustaceanvim plugin for rust.
            --return true
          end,
        },
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      show_guides = true,
      manage_folds = true,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          -- I recommend these options. See :help conform.format for details.
          lsp_format = "fallback",
          timeout_ms = 500,
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            bind_common_keys(client, bufnr)
            bind_debug_keys(client, bufnr)
          end,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = true,
  },
}
