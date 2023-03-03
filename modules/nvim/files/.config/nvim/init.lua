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
vim.opt.colorcolumn = '80' -- Draw a marker at the 80-column mark
vim.opt.inccommand = 'nosplit'
vim.opt.clipboard = 'unnamedplus'

-- Highlight yanked text
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {timeout=400}'

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
vim.opt.listchars = { trail = '·', tab = '▸ ' }

-- Mouse
vim.opt.mouse = "a"

-- Search
vim.opt.ic = true -- Ignore case when searching

-- Jumping
vim.opt.jumpoptions = "view"

<<<<<<< Updated upstream
=======
-- Skip intro screen
vim.opt.shortmess:append("I")

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

>>>>>>> Stashed changes
-- Plugins
require('plugins')

