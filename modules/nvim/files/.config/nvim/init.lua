--[[
                                .          .
                              ';;,.        ::'
                            ,:::;,,        :ccc,
                           ,::c::,,,,.     :cccc,
                           ,cccc:;;;;;.    cllll,
                           ,cccc;.;;;;;,   cllll;
                           :cccc; .;;;;;;. coooo;
                           ;llll;   ,:::::'loooo;
                           ;llll:    ':::::loooo:
                           :oooo:     .::::llodd:
                           .;ooo:       ;cclooo:.
                             .;oc        'coo;.
                               .'         .,.
--]]

vim.g.mapleader = ","

vim.opt.cmdheight = 1 --[[ The height of the bottom row where :commands are
                           typed. If it's 0, then it only appears when
                      --]]
vim.opt.showmode = false --[[ Whether to show current mode in cmd window.
                              This is redundant because we use lualine.
                         --]]
vim.opt.number = true
vim.opt.relativenumber = true -- Line numbers are relative
-- vim.opt.colorcolumn = '80' -- Draw a marker at the 80-column mark
-- Instead of setting colorcolumn to a fixed value, let's pull the
-- max_line_length from editorconfig.
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function(args)
    local bufnr = args.buf
    local ec = vim.b[bufnr].editorconfig

    if ec and ec.max_line_length then
      vim.opt_local.colorcolumn = tostring(ec.max_line_length)
    end
  end,
})
vim.opt.inccommand = "nosplit"
vim.opt.clipboard = "unnamedplus"

-- Highlight yanked text
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {timeout=400}")

-- Persistent undos
vim.opt.undofile = true

-- Splits
--[[ For whatever reason, it just seems more natural to me to have splits open
     in the sequentially "next" position, rather than replacing the current
     position.
--]]
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Whitespace
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "▸ " }

-- Mouse
vim.opt.mouse = "a"

-- Search
vim.opt.ic = true -- Ignore case when searching

-- Jumping
vim.opt.jumpoptions = "view"

-- Skip intro screen
vim.opt.shortmess:append("I")

-- Some custom keymaps
vim.keymap.set(
  "n",
  "gx",
  [[:silent! execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "gs",
  ":AerialToggle<CR>",
  { noremap = true, desc = "Symbols outline" }
)
-- The mapping below fixes a bug in Neovim where <S-Space> in :terminal sends a `;2u` character instead of a space.
-- TODO: Remove this once the bug is fixed upstream
vim.keymap.set("t", "<S-Space>", "<Space>", { noremap = true })

-- Set up Powershell if we're in Windows
if os.getenv("OS") == "Windows_NT" then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup("plugins")
