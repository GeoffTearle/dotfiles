----------------
--- plugins ---
----------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    -- file explorer
    require('plugins.tree').neotree(),

    -- colour theme
    require('plugins.monokai-pro').monokaipro(),
    require('plugins.rainbow-delimiters').rainbow_delimiters(),
    require('plugins.indent-blankline').indent_blankline(),

    -- save my last cursor position
    require('plugins.lastplace').lastplace(),

    -- commenting out lines
    require('plugins.comment').comment(),

    require('plugins.splitjoin').splitjoin(),

    require('plugins.formatter').formatter(),

    -- fzf extension for telescope with better speed
    require('plugins.telescope').fzfnative(),
    -- fuzzy finder framework
    require('plugins.telescope').uiselect(),
    require('plugins.telescope').telescope(),

    -- lsp-config
    require('plugins.lspconfig').lspconfig(),

    -- Alternate between files, such as foo.go and foo_test.go
    require('plugins.other').other(),

    -- Highlight, edit, and navigate code
    require('plugins.treesitter').treesitter(),

    require('plugins.autopairs').autopairs(),

    -- autocompletion
    require('plugins.cmp').cmp(),
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set(
      'n',
      '<leader>s',
      '<cmd>belowright split | lua vim.lsp.buf.definition()<CR>',
      opts
    )

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Move to go file
-- Run gofmt/gofmpt, import packages automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('setGoFormatting', { clear = true }),
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
      async = false,
    })
    vim.lsp.buf.format({ async = true })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('FormatAutoGroup', { clear = true }),
  callback = function()
    local status_ok = pcall(vim.cmd, 'FormatWrite')
    if not status_ok then
      return
    end
  end,
})
