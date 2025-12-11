return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" }, -- Lua development module
    },
    lazy = false,
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-?>"] = "which_key",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-h>"] = "select_horizontal",
            },
          },
          winblend = 20,
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
            find_command = {
              "rg",
              "--ignore",
              "-L",
              "--hidden",
              "-g",
              "!.git/",
              "--files",
            },
          },
          buffers = {
            mappings = {
              n = {
                ["<Del>"] = require("telescope.actions").delete_buffer,
              },
              i = {
                ["<Del>"] = require("telescope.actions").delete_buffer,
              },
            },
          },
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        },
      })

      vim.keymap.set("n", "<leader>ec", function()
        require("telescope.builtin").find_files({
          prompt_title = "~ dotfiles ~",
          shorten_path = false,
          cwd = "~/.local/share/yada/apetresc/dot/modules/nvim/files/.config/nvim",
          width = 0.25,

          layout_strategy = "horizontal",
          layout_config = {
            preview_width = 0.65,
          },
        })
      end, { desc = "Edit Neovim config directory" })

      vim.keymap.set("n", "<C-p>", function()
        require("telescope.builtin").find_files({
          prompt_title = "cwd files",
          cwd = ".",
        })
      end, { desc = "Find files in the cwd" })

      vim.keymap.set("n", "<C-S-p>", function()
        require("telescope.builtin").git_files()
      end, { desc = "Find git-controlled files" })

      vim.keymap.set("n", "<leader>fb", function()
        require("telescope.builtin").buffers({
          shorten_path = false,
        })
      end, { desc = "Find currently opened buffers" })

      vim.keymap.set("n", "<leader>fg", function()
        require("telescope.builtin").live_grep()
      end, { desc = "Find string in workspace" })

      vim.keymap.set("n", "<leader>gs", function()
        require("telescope.builtin").git_status()
      end, { desc = "git status" })

      vim.keymap.set("n", "<leader>gc", function()
        require("telescope.builtin").git_commits()
      end, { desc = "git commits" })
    end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("luasnip")
      vim.keymap.set("n", "<leader>ss", function()
        require("telescope").extensions.luasnip.luasnip()
      end, { desc = "List LuaSnip snippets" })
    end,
  },
}
