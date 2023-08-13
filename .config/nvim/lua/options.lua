---------------
--- options ---
---------------
-- disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.ignorecase = true -- Search case insensitive...
vim.opt.smartcase = true  -- ... but not it begins with upper case

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmode = true

vim.opt.smartindent = true

vim.opt.number = true                             -- Show line numbers
vim.opt.relativenumber = true                     -- Show line numbers relative to cursor

vim.opt.showmatch = true                          -- Highlight matching parenthesis
vim.opt.splitright = true                         -- Split windows right to the current windows
vim.opt.splitbelow = true                         -- Split windows below to the current windows
vim.opt.autowrite = true                          -- Automatically save before :next, :make etc.
vim.opt.autochdir = true                          -- Change CWD when I open a file

vim.opt.mouse = 'a'                               -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'                 -- Copy/paste to system clipboard
vim.opt.swapfile = false                          -- Don't use swapfile
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
-- I'm in the Spaces camp (sorry Tabs folks), so I'm using a combination of
-- settings to insert spaces all the time.
vim.opt.expandtab = false -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 4       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true
