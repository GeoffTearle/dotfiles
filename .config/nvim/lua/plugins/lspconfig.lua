local M = {}

M.lspconfig = function()
  return {
    'neovim/nvim-lspconfig',

    dependencies = {
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },

    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require('neodev').setup()

      require('lspconfig').lua_ls.setup({
        capabilities = capabilities,
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
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
  }
end

return M
