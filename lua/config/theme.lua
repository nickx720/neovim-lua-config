

local M = {}

function M.setup()
		-- Enable true color support
		vim.o.termguicolors = true
		vim.cmd[[colorscheme tokyonight-night]]
end

return M
