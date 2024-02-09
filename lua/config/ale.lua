
local M = {}

function M.setup()
-- Enable ESLint only for JavaScript.
-- Enable ALE
vim.g.ale_enabled = 1

-- Configure linters for JavaScript, TypeScript, Rust, and Lua
vim.g.ale_linters = {
    javascript = { 'eslint' },
    typescript = { 'eslint' },
    rust = { 'rustc' },
    lua = { 'luacheck' }
}

-- Additional configuration for JSX/TSX
vim.g.ale_javascript_eslint_options = {
    ['--parser'] = 'esprima'
}
vim.g.ale_typescript_eslint_options = {
    ['--parser'] = '@typescript-eslint/parser'
}

-- Add JSX/TSX to filetypes for JavaScript and TypeScript
vim.cmd('autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx let b:ale_linters = {"javascript": ["eslint"], "typescript": ["eslint"]}')


end

return M
