-- Linting based rules for tabs and spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.scrolloff = 5
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

-- Auto close
vim.api.nvim_set_keymap('i', '"<space>', '""<left>', { noremap = true })
vim.api.nvim_set_keymap('i', "'<space>", "''<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '`<space>', '``<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '(<space>', '()<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '[<space>', '[]<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{<space>', '{}<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<<CR>', '<><left>', { noremap = true })

-- Set Mouse support
vim.opt.mouse = "a"

-- Moving selected text up and down
vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv-gv", { noremap = true })
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<CR>gv-gv", { noremap = true })


-- Remove trailing whitespace and newlines at file save (only if no editorconfig)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if not vim.b.editorconfig then
      vim.cmd("%s/\\s\\+$//e")
      vim.cmd("%s/\\n\\+\\%$//e")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.c", "*.h"},
  callback = function()
    if not vim.b.editorconfig then
      vim.cmd("%s/\\%$/\\r/e")
    end
  end,
})



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

local function show_hotkeys()
  local lines = {
    "Neovim Hotkeys",
    "",
    "Normal mode",
    "F1          Show this hotkey help",
    "F2          Toggle netrw",
    "F3          Go to definition",
    "F4          Go to type definition",
    "F5          Go to implementation",
    "F6          Show references",
    "F7          Toggle breakpoint",
    "F8          Show line diagnostics",
    "K           Hover documentation",
    "[d          Previous diagnostic",
    "]d          Next diagnostic",
    "<C-f>       File search",
    "<C-A-f>     Ripgrep search",
    "<Leader>rn  Rename symbol",
    "<Leader>cl  Run code lens action",
    "<Leader>di  DAP step into",
    "<Leader>dO  DAP step out",
    "<Leader>do  DAP step over",
    "<Leader>da  DAP continue / run with args",
    "<Leader>du  Toggle DAP UI",
    "<Leader>de  Eval under cursor/selection",
    "<Leader>sx  Swap parameter with next",
    "<Leader>sX  Swap parameter with previous",
    "]m          Next function start",
    "]M          Next function end",
    "]]          Next class start",
    "][          Next class end",
    "[m          Previous function start",
    "[M          Previous function end",
    "[[          Previous class start",
    "[]          Previous class end",
    "<Leader>cf  Peek function definition",
    "<Leader>cF  Peek class definition",
    "",
    "Visual mode",
    "K           Move selection up",
    "J           Move selection down",
    "",
    "Insert mode",
    "<Tab>       Next completion item / refresh",
    "<S-Tab>     Previous completion item",
    "<CR>        Confirm completion / enter",
    "<C-Space>   Trigger completion",
    "\"<Space>    Insert paired double quotes",
    "'<Space>    Insert paired single quotes",
    "`<Space>    Insert paired backticks",
    "(<Space>    Insert paired parentheses",
    "[<Space>    Insert paired brackets",
    "{<Space>    Insert paired braces",
    "<<CR>       Insert paired angle brackets",
    "",
    "Press q or <Esc> to close",
  }

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false

  local height = #lines
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width + 4,
    height = height + 2,
    row = math.max(1, math.floor((vim.o.lines - height) / 2) - 1),
    col = math.max(1, math.floor((vim.o.columns - width) / 2) - 2),
    style = "minimal",
    border = "rounded",
    title = " Hotkeys ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })

  vim.keymap.set("n", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })
end

vim.keymap.set("n", "<F1>", show_hotkeys, { silent = true, desc = "Show hotkey help" })


-- Bindings for quick file search
vim.api.nvim_set_keymap('n', '<C-f>', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-A-f>', ':Rg<CR>', { noremap = true })

vim.keymap.set("n", "<F8>", vim.diagnostic.open_float, { silent = true, desc = "Line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })

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

-- Vim Fugitive Settings
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  callback = function()
    vim.cmd("cwindow")
  end,
})
