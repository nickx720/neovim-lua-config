

local M = {}

function M.setup()
		-- Enable true color support
		vim.o.termguicolors = true
		local theme = require("tokyonight")

		theme.setup({
				transparent = true,
		})
		vim.cmd[[colorscheme tokyonight-night]]
end

return M
