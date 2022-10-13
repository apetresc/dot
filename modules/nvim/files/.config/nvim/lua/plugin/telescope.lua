if not pcall(require, "telescope") then
  return
end

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      -- This is needed to pass in `-L` to `rg` so that symlinks are followed
      find_command = { "rg", "--ignore", "-L", "--hidden", "--files" }
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

vim.keymap.set('n', '<leader>ec',
  function()
    require('telescope.builtin').find_files {
      prompt_title = "~ dotfiles ~",
      shorten_path = false,
      cwd = "~/.local/share/yada/apetresc/dot/modules/nvim/files/.config/nvim",
      width = .25,

      layout_strategy = 'horizontal',
      layout_config = {
        preview_width = 0.65,
      },
    }
  end,
  {desc = 'Edit Neovim config directory'})

vim.keymap.set('n', '<C-p>',
  function()
    require('telescope.builtin').find_files {
      prompt_title = "cwd files",
      cwd = ".",
    }
  end,
  {desc = 'Find files in the cwd'})

vim.keymap.set('n', '<C-S-p>',
  function()
    require('telescope.builtin').git_files()
  end,
  {desc = 'Find git-controlled files'})

