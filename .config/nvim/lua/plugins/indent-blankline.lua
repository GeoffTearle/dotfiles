local M = {}

M.indent_blankline = function()
  return {
    'lukas-reineke/indent-blankline.nvim',
    opts = function(_, _)
      -- Other blankline configuration here
      -- return require('indent-rainbowline').make_opts(opts)
    end,
    dependencies = {
      'TheGLander/indent-rainbowline.nvim',
    },
  }
end

return M
