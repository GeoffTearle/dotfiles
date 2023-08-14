local M = {}

M.other = function()
  return {
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
  }
end

return M
