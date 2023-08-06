local opts = { noremap = true, silent = true }
local map = vim.keymap.set

--Leader Key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode

map("n", "<Leader>;", "A;", opts)
map("n", "<C-a>;", "ggVG", opts)
