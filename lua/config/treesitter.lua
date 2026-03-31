local M = {}

function M.setup()
  local parsers = { 'lua', 'javascript', 'typescript', 'rust', 'go', 'json', 'comment' }

  -- Install parsers
  require('nvim-treesitter').install(parsers)

  vim.opt.foldmethod = 'manual'
end

return M
