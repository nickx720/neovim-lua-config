

local M = {}

function M.setup()
		-- Enable true color support
		vim.o.termguicolors = true
		local theme = require("tokyonight")

		theme.setup({
				transparent = true,
				style = "storm",
		})
		vim.cmd[[colorscheme tokyonight-storm]]
end

return M
