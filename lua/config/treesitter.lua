local M = {}

function M.setup()
  -- Install parsers
  require('nvim-treesitter').install { 'lua', 'javascript', 'typescript', 'rust', 'comment' }

  -- Enable treesitter highlighting and indentation for all filetypes
  vim.api.nvim_create_autocmd('FileType', {
    callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  vim.opt.foldmethod = 'manual'
end

return M
