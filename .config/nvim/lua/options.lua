---------------
--- options ---
---------------
-- disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- Enable 24-bit RGB colors

vim.opt.ignorecase = true -- Search case insensitive...
vim.opt.smartcase = true -- ... but not it begins with upper case

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmode = true

vim.opt.smartindent = true
-- Enable break indent
vim.o.breakindent = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show line numbers relative to cursor

vim.opt.showmatch = true -- Highlight matching parenthesis
vim.opt.splitright = true -- Split windows right to the current windows
vim.opt.splitbelow = true -- Split windows below to the current windows
vim.opt.autowrite = true -- Automatically save before :next, :make etc.
vim.opt.autochdir = true -- Change CWD when I open a file

vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
vim.opt.swapfile = false -- Don't use swapfile


vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. 'undo'

-- Indent Settings
-- settings to insert spaces all the time.
vim.opt.expandtab = false -- expand tabs into spaces
vim.opt.shiftwidth = 2 -- number of spaces to use for each step of indent.
vim.opt.tabstop = 4 -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true
