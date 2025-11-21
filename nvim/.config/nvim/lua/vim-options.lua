vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.cmd("set number")

vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("i", "<C-v>", '"+p')
