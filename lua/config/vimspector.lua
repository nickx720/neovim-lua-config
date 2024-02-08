local M = {}

function M.setup()
		-- Your vimspector configuration here
		-- For example:
		vim.g.vimspector_enable_mappings = 'HUMAN'
		vim.api.nvim_set_keymap('n', '<Leader>dd', ':lua require("vimspector").launch()<CR>', { silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>de', ':lua require("vimspector").reset()<CR>', { silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua require("vimspector").continue()<CR>', { silent = true })

		vim.api.nvim_set_keymap('n', '<Leader>dt', ':lua require("vimspector").toggle_breakpoint()<CR>', { silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>dT', ':lua require("vimspector").clear_breakpoints()<CR>', { silent = true })

		vim.api.nvim_set_keymap('n', '<Leader>dk', '<Plug>VimspectorRestart', {})
		vim.api.nvim_set_keymap('n', '<Leader>dh', '<Plug>VimspectorStepOut', {})
		vim.api.nvim_set_keymap('n', '<Leader>dl', '<Plug>VimspectorStepInto', {})
		vim.api.nvim_set_keymap('n', '<Leader>dj', '<Plug>VimspectorStepOver', {})

end

return M
