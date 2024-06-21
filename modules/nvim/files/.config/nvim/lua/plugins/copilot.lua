return {
  {
    'github/copilot.vim',
    enabled = false,
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = false,
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

