return {
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
        vim.keymap.set({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>",
        {buffer=bufnr})
        vim.keymap.set({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>",
        {buffer=bufnr})
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, {desc="Gitsigns stage buffer", buffer=bufnr})

        -- Text object
        vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>",
        {buffer=bufnr, silent=true})
      end
    }
  end
}
