--[[
=============================   OPTIONS   =============================
--]]
local opt = vim.opt
local o = vim.o
local g = vim.g

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.g.mapleader = ' '
vim.opt.ignorecase = true

local indent_width = 4
local chars = {
    trail = '',
    space = '·',
    tab = '-->',
    -- eol = '¬',
}
-- alt options
local chars_alt = {
    '',
    '•',
    '·',
    '_',
    '¬',
}

vim.opt.shiftwidth = indent_width
vim.opt.tabstop = indent_width
vim.opt.softtabstop = indent_width
vim.opt.expandtab = true
vim.opt.listchars = chars
vim.opt.fillchars = { eob = ' ' }
vim.opt.list = true
