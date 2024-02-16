-- Linting based rules for tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.scrolloff=5

-- Auto close
vim.api.nvim_set_keymap('i', '"<space>', '""<left>', {noremap = true})
vim.api.nvim_set_keymap('i', "'<space>", "''<left>", {noremap = true})
vim.api.nvim_set_keymap('i', '`<space>', '``<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '(<space>', '()<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '[<space>', '[]<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '{<space>', '{}<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<<CR>', '<><left>', {noremap = true})

-- Set Mouse support
vim.opt.mouse = "a"

-- Moving selected text up and down
vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv-gv", {noremap = true})
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<CR>gv-gv", {noremap = true})


-- Remove trailing whitespace and newlines at file save
vim.cmd([[
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
  autocmd BufWritePre *.c,*.h %s/\%$/\r/e
]])

-- Opens images in neovim
vim.cmd([[
  autocmd BufEnter *.png,*.jpg,*.gif exec "! ~/.iterm2/imgcat " .. vim.fn.expand("%") | :bw
]])

-- Replacing NERDTree with NetRw
-- Set netrw options
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20
vim.g.NetrwIsOpen = 0

-- Define function to toggle netrw
function ToggleNetrw()
  if vim.g.NetrwIsOpen == 1 then
    local i = vim.fn.bufnr("$")
    while i >= 1 do
      if vim.fn.getbufvar(i, "&filetype") == "netrw" then
        vim.cmd("silent bwipeout " .. i)
      end
      i = i - 1
    end
    vim.g.NetrwIsOpen = 0
  else
    vim.g.NetrwIsOpen = 1
    vim.cmd("silent Lexplore")
  end
end

-- Define mapping for <F2> to call ToggleNetrw function
vim.api.nvim_set_keymap('n', '<F2>', ':lua ToggleNetrw()<CR>', { silent = true })


-- Bindings for quick file search
vim.api.nvim_set_keymap('n', '<C-f>', ':Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-A-f>', ':Rg<CR>', {noremap = true})

-- Print numbers
vim.opt.number = true
-- UTF 8
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
-- Show title
vim.opt.title = true
-- Highlight Line
vim.opt.cursorline = true
-- Ruler
vim.opt.ruler = true
-- Wildmenu
vim.opt.wildmenu = true

-- Disable Providers Neovim
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
