local M = {}

M.autopairs = function()
  return {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end,
  }
end

return M
