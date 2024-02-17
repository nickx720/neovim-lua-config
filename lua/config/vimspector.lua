local M = {}

function M.setup()
  -- Vimspector mapp
  vim.api.nvim_set_keymap('n', '<F7>', ':lua require("vimp").call("vimspector#Launch")()<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '', ':lua require("vimp").call("vimspector#Reset")()<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<F8>', ':lua require("vimp").call("vimspector#Continue")()<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<F9>', ':lua require("vimp").call("vimspector#ToggleBreakpoint")()<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<F10>', ':lua require("vimp").call("vimspector#ClearBreakpoints")()<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<F12>', '<Plug>VimspectorRestart', {})
  vim.api.nvim_set_keymap('n', '<Leader>dh', '<Plug>VimspectorStepOut', {})
  vim.api.nvim_set_keymap('n', '<Leader>dl', '<Plug>VimspectorStepInto', {})
  vim.api.nvim_set_keymap('n', '<Leader>dj', '<Plug>VimspectorStepOver', {})
end

return M
