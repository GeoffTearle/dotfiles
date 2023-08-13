---------------
--- keymaps ---
---------------

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

--Leader Key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode

map("n", "<Leader>;", "A;", opts)
map("n", "<C-a>;", "ggVG", opts)

-- Better split switching
map('', '<C-j>', '<C-W>j')
map('', '<C-k>', '<C-W>k')
map('', '<C-h>', '<C-W>h')
map('', '<C-l>', '<C-W>l')

-- Yanking a line should act like D and C
map('n', 'Y', 'y$')

-- File-tree mappings
map("", "\\", ":Neotree reveal<CR>")
