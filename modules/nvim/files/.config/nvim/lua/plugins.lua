-- Install Packer manually if it's not already present. Obviously we can't use
-- Packer itself on the initial install, so we just manually `git clone` it.
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function(use)
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Tmux-specific plugins
  --[[ This plugin allows for seamlessly combining tmux pane navigation with
       neovim pane navigation
  --]]
  use {
    "christoomey/vim-tmux-navigator",
    setup = function() vim.g.tmux_navigator_no_mappings = 1 end,
    config = function()
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true} )
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true} )
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true} )
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true} )
    end,
  }
  use {
    "preservim/vimux",
    cond = "os.getenv('TERM_PROGRAM') == 'tmux'",
    config = function()
      vim.keymap.set("n", "<F9>", ":VimuxPromptCommand<CR>")
      vim.keymap.set("n", "<F10>", ":VimuxRunLastCommand<CR>")
    end,
  }
  --[[ Editorconfig allows for a central place to set style rules for different
       file types. Details at https://editorconfig.org/
  --]]
  use "editorconfig/editorconfig-vim"

  -- Color scheme
  -- Love me some alien fruit salad
  use {
    "phha/zenburn.nvim",
    config = function() require("zenburn").setup() end
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require("plugin.lualine") end,
  }

  -- Debugging
  use 'mfussenegger/nvim-dap'

  -- LSP-related
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  }
  use "simrat39/rust-tools.nvim"
  require("lsp")
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { "onsails/lspkind-nvim" },
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  -- For these languages, Markdown code blocks will be highlighted as the
  -- appropriate language.
  vim.g.markdown_fenced_languages = {
    'bash=sh',
    'javascript',
    'js=javascript',
    'json=javascript',
    'typescript',
    'ts=typescript',
    'php',
    'html',
    'css',
    'rust',
    'sql'
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Terraform
  use "hashivim/vim-terraform"

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugin.git") end
  }

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  require("plugin.cmp")

  -- Navigation
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
      {"nvim-lua/plenary.nvim"}, -- Lua development module
      {"BurntSushi/ripgrep"},    -- character finding
      {"sharkdp/fd"}             -- fast file replacement
    },
    config = function() require("plugin.telescope") end,
  }

  -- Diagnostics
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        {silent = true, noremap = true}
      )
    end
  }

  
  -- File navigation
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      require("nvim-tree").setup()
      vim.keymap.set("n", "<C-Bslash>", ":NvimTreeToggle<CR>", { silent = true } )
      vim.keymap.set("n", "<C-t>", ":NvimTreeFindFile<CR>", { silent = true })
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Silicon (generate images)
  use {
    "krivahtoo/silicon.nvim",
    run = "./install.sh",
    cond = "vim.fn.has('win32') == 0",
    config = function()
      require("silicon").setup({
        theme = "zenburn",
        background = "#fff0",
        shadow = {
          blur_radius = 30,
          color = "#000",
          offset_x = 10,
          offset_y = 10
        },
        line_number = true,
        round_corner = true
      })
    end
  }

  -- Automatically pull Packer if it's not already installed
  if packer_bootstrap then
    require("packer").sync()
  end
end)
