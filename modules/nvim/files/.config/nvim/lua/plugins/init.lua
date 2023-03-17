return {
  -- Tmux-specific plugins
  --[[ This plugin allows for seamlessly combining tmux pane navigation with
       neovim pane navigation
  --]]
  {
    'christoomey/vim-tmux-navigator',
    init = function() vim.g.tmux_navigator_no_mappings = 1 end,
    config = function()
      vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true} )
      vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true} )
      vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true} )
      vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true} )
    end,
  },
  {
    'preservim/vimux',
    cond = function() return os.getenv('TERM_PROGRAM') == 'tmux' end,
    keys = {
      { '<F9>', ':VimuxPromptCommand<CR>', desc = 'Prompt for a Vimux command' },
      { '<F10>', ':VimuxRunLastCommand<CR>', desc = 'Run last Vimux command' },
    },
  },

  --[[ Editorconfig allows for a central place to set style rules for different
       file types. Details at https://editorconfig.org/
  --]]
  'editorconfig/editorconfig-vim',

  -- Color schemes
  -- Love me some alien fruit salad
  {
    'phha/zenburn.nvim',
    lazy = false,
    priority = 1000,
    config = true,
  },

  -- Debugging
  'mfussenegger/nvim-dap',

  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
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
        'sql',
        'yaml'
      }
    end,
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  },

  {
    'numToStr/Comment.nvim',
    config = true
  },

  -- Terraform
  'hashivim/vim-terraform',

  -- Diagnostics
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true,
    keys = {
      { '<leader>xx', ':TroubleToggle<CR>', silent = true, noremap = true, desc = "toggle Trouble" },
      { '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', silent = true, noremap = true, desc = "Trouble workspace diagnostics" },
      { '<leader>xd', ':TroubleToggle document_diagnostics<CR>', silent = true, noremap = true, desc = "Trouble document diagnostics" },
      { '<leader>xl', ':TroubleToggle loclist<CR>', silent = true, noremap = true, desc = "Trouble loclist" },
      { '<leader>xq', ':TroubleToggle quickfix<CR>', silent = true, noremap = true, desc = "Trouble quickfix" },
      -- TODO: Figure out how to use TroubleToggle for lsp_refrerences etc.
    }
  },

  -- File Navigation
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      require('nvim-tree').setup()
      vim.keymap.set('n', '<C-Bslash>', ':NvimTreeToggle<CR>', { silent = true } )
      vim.keymap.set('n', '<C-t>', ':NvimTreeFindFile<CR>', { silent = true })
    end
  },

  -- Help navigation
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup {
      }
    end
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup{
        open_mapping = [[<C-`>]],
        float_opts = {
          border = 'double',
          -- winblend = 10,
        }
      }
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  },

  -- Silicon (generate images)
  {
    'krivahtoo/silicon.nvim',
    build = './install.sh',
    cond = function() return vim.fn.has('win32') == 0 end,
    cmd = "Silicon",
    config = function()
      require('silicon').setup({
        theme = 'zenburn',
        background = '#fff0',
        shadow = {
          blur_radius = 30,
          color = '#000',
          offset_x = 10,
          offset_y = 10
        },
        line_number = true,
        round_corner = true
      })
    end
  },
}
