local M = {}

function M.setup()
  local parsers = { 'lua', 'javascript', 'typescript', 'rust', 'go', 'json', 'comment' }

  -- Install parsers
  require('nvim-treesitter').install(parsers)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = parsers,
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
  })

  vim.opt.foldmethod = 'manual'
end

return M
