local M = {}

M.rainbow_delimiters = function()
  return {
    'hiphish/rainbow-delimiters.nvim',
    config = function()

      local rainbow_delimiters = require('rainbow-delimiters')

      require('rainbow-delimiters.setup')({
        strategy = {
          -- [''] = rainbow_delimiters.strategy['global'],
          -- vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          -- [''] = 'rainbow-delimiters',
          -- lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
          'RainbowDelimiterRed',
        },
      })
    end,
  }
end

return M
