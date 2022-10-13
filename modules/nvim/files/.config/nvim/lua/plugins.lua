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
    cond = "os.getenv('TERM_PROGRAM') == 'tmux'",
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
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require("plugin.lualine") end,
  }

  -- LSP-related
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  }
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

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function()
      require('gitsigns').setup()
    end
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

  use {
    "scrooloose/nerdtree",
    config = function()
      vim.keymap.set("n", "<C-Bslash>", ":NERDTreeToggle<CR>", { silent = true } )
      -- reveal open buffer in NERDTree
      vim.keymap.set("n", "<C-t>", ":NERDTreeFind<CR>", { silent = true })
    end
  }

  -- Automatically pull Packer if it's not already installed
  if packer_bootstrap then
    require("packer").sync()
  end
end)
