local M = {}

function M.setup()
  -- Define a function to check for backspace
  local function check_backspace()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  -- Use <Tab> to navigate coc completion pop-up, or refresh if no pop-up is visible
  vim.keymap.set('i', '<Tab>',
    'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<Plug>(coc-refresh)"', { expr = true, silent = true })

  -- Use <S-Tab> to navigate coc completion pop-up backwards
  vim.keymap.set('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<C-h>"', { expr = true, silent = true })

  -- Use <CR> to accept selected completion item or notify coc.nvim to format
  vim.keymap.set('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"',
    { expr = true, silent = true })

  -- Use <C-Space> to trigger completion
  vim.keymap.set('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true })
  -- GoTo code navigation mappings
  vim.keymap.set('n', '<F3>', '<Plug>(coc-definition)', { silent = true })

  vim.keymap.set('n', '<F4>', '<Plug>(coc-type-definition)', { silent = true })
  vim.keymap.set('n', '<F5>', '<Plug>(coc-implementation)', { silent = true })
  vim.keymap.set('n', '<F6>', '<Plug>(coc-references)', { silent = true })

  -- Enable autosave on coc-go
  -- Automatically organize imports for Go files before saving
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      vim.fn.CocAction('runCommand', 'editor.action.organizeImport')
    end,
  })

  -- Symbol renaming
  vim.keymap.set('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true, noremap = true })

  -- Code lens
  vim.keymap.set('n', '<Leader>cl', '<Plug>(coc-codelens-action)', { silent = true, noremap = true })

  -- Code format
  vim.cmd([[autocmd BufWritePre * silent! call CocAction('format')]])
  -- Show type
  -- Use K to show documentation in preview window
  vim.keymap.set('n', 'K', ':lua show_documentation()<CR>', { silent = true })

  function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim', 'help' }, filetype) then
      vim.cmd('h ' .. vim.fn.expand('<cword>'))
    else
      vim.fn.CocActionAsync('doHover')
    end
  end
end

return M
