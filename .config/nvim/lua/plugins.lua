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

    -- save my last cursor position
    require('plugins.lastplace').lastplace(),

    -- commenting out lines
    require('plugins.comment').comment(),

    require('plugins.splitjoin').splitjoin(),

    require('plugins.formatter').formatter(),

    -- fzf extension for telescope with better speed
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- fuzzy finder framework
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require('telescope').setup({
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
        })

        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require('telescope').load_extension('fzf')

        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require('telescope').load_extension('ui-select')
      end,
    },

    -- lsp-config
    {
      'neovim/nvim-lspconfig',
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require('lspconfig').lua_ls.setup({
          capabilities = capabilities,
          on_init = function(client)
            -- Make the server aware of Neovim runtime files
            -- client.config.settings.Lua.workspace.library = { vim.env.VIMRUNTIME }
            -- or for everything:
            client.config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file('', true)
            client.notify('workspace/didChangeConfiguration', {
              settings = client.config.settings,
            })
          end,
        })

        require('lspconfig').gopls.setup({
          capabilities = capabilities,
          flags = { debounce_text_changes = 200 },
          settings = {
            gopls = {
              usePlaceholders = true,
              gofumpt = true,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              experimentalPostfixCompletions = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-node_modules' },
              semanticTokens = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        })
        require('lspconfig').golangci_lint_ls.setup({
          capabilities = capabilities,
        })
      end,
    },

    -- Alternate between files, such as foo.go and foo_test.go
    {
      'rgroli/other.nvim',
      keys = {
        { ':A', '<cmd>Other<cr>', { noremap = true, silent = true } },
        { ':AV', '<cmd>OtherVSplit<cr>', { noremap = true, silent = true } },
        { ':AS', '<cmd>OtherSplit<cr>', { noremap = true, silent = true } },
      },
      config = function()
        require('other-nvim').setup({
          mappings = {
            'rails', --builtin mapping
            {
              pattern = '(.*).go$',
              target = '%1_test.go',
              context = 'test',
            },
            {
              pattern = '(.*)_test.go$',
              target = '%1.go',
              context = 'file',
            },
          },
        })
      end,
    },

    -- Highlight, edit, and navigate code
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = { 'go', 'gomod', 'lua', 'vimdoc', 'vim', 'bash' },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<space>', -- maps in normal mode to init the node/scope selection with enter
              node_incremental = '<space>', -- increment to the upper named parent
              node_decremental = '<bs>', -- decrement to the previous node
              scope_incremental = '<tab>', -- increment to the upper scope (as defined in locals.scm)
            },
          },
          autopairs = {
            enable = true,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['iB'] = '@block.inner',
                ['aB'] = '@block.outer',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']]'] = '@function.outer',
              },
              goto_next_end = {
                [']['] = '@function.outer',
              },
              goto_previous_start = {
                ['[['] = '@function.outer',
              },
              goto_previous_end = {
                ['[]'] = '@function.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        })
      end,
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({
          check_ts = true,
        })
      end,
    },

    -- autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        luasnip.config.setup({})

        require('cmp').setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          window = {
            documentation = cmp.config.window.bordered(),
          },
          view = {
            entries = {
              name = 'custom',
              selection_order = 'near_cursor',
            },
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Insert,
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer', keyword_length = 5 },
            { name = 'path' },
          },
        })

        require('cmp').setup.cmdline('/', {
          sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' },
          }, {
            { name = 'buffer' },
          }),
        })

        require('cmp').setup.cmdline(':', {
          sources = cmp.config.sources({
            { name = 'path' },
          }, {
            { name = 'cmdline' },
          }),
        })
      end,
    },
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
