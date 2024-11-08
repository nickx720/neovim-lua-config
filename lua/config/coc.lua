local M = {}

function M.setup()
  -- Define a function to check for backspace
  local function check_backspace()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  -- Use <Tab> to navigate coc completion pop-up, or refresh if no pop-up is visible
  vim.api.nvim_set_keymap('i', '<Tab>',
    'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<Plug>(coc-refresh)"', { expr = true, silent = true })

  -- Use <S-Tab> to navigate coc completion pop-up backwards
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<C-h>"', { expr = true, silent = true })

  -- Use <CR> to accept selected completion item or notify coc.nvim to format
  vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"',
    { expr = true, silent = true })

  -- Use <C-Space> to trigger completion
  vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { silent = true })
  -- GoTo code navigation mappings
  vim.api.nvim_set_keymap('n', '<F3>', '<Plug>(coc-definition)', { silent = true })

  vim.api.nvim_set_keymap('n', '<F4>', '<Plug>(coc-type-definition)', { silent = true })
  vim.api.nvim_set_keymap('n', '<F5>', '<Plug>(coc-implementation)', { silent = true })
  vim.api.nvim_set_keymap('n', '<F6>', '<Plug>(coc-references)', { silent = true })

  -- Symbol renaming
  vim.api.nvim_set_keymap('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true, noremap = true })

  -- Code lens
  vim.api.nvim_set_keymap('n', '<Leader>cl', '<Plug>(coc-codelens-action)', { silent = true, noremap = true })

  -- Code format
  vim.cmd([[autocmd BufWritePre * silent! call CocAction('format')]])
  -- Show type
  -- Use K to show documentation in preview window
  vim.api.nvim_set_keymap('n', 'K', ':lua show_documentation()<CR>', { silent = true })

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
