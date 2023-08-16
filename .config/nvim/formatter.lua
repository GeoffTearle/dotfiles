local M = {}

M.formatter = function()
  return {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup({
        -- All formatter configurations are opt-in
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      })
    end,
  }
end

return M
