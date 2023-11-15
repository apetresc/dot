return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{
        -- Navigate between hunks
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set("n", "]h", function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=bufnr})
          vim.keymap.set("n", "[h", function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=bufnr})

          -- Actions
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {desc = "stage hunk"})
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {desc = "reset hunk"})
          vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "stage hunk"})
          vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "reset hunk"})
          vim.keymap.set('n', '<leader>hS', gs.stage_buffer, {desc = "stage buffer"})
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, {desc = "undo stage hunk"})
          vim.keymap.set('n', '<leader>hR', gs.reset_buffer_index, {desc = "reset buffer"})
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {desc = "preview hunk"})
          vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = "blame line"})
          vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, {desc = "toggle blame line"})
          vim.keymap.set('n', '<leader>hd', gs.diffthis, {desc = "diff this"})
          vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, {desc = "diff this (ignore whitespace)"})
          vim.keymap.set('n', '<leader>td', gs.toggle_deleted, {desc = "toggle deleted"})

          -- Text object
          vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc="select hunk"})
        end
      }
    end
  },
  {
    "chrisgrieser/nvim-tinygit",
    dependencies = "stevearc/dressing.nvim",
    opts = {
      commitMsg = {
        emptyFillIn = false,
        enforceConvCommits = {
          enabled = false,
        },
      },
    },
    keys = {
      { ',gC', function() require('tinygit').smartCommit() end, desc = "git commit" },
    },
  },
  
}
