local M = {}

M.comment = function()
	return {
		"numToStr/Comment.nvim",
		config = function()
			require('Comment').setup()
		end
	}
end

return M
