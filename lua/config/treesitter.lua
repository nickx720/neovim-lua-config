local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "markdown",
      "tsx",
      "typescript",
      "javascript",
      "toml",
      "json",
      "yaml",
      "rust",
      "css",
      "html",
      "lua",
      "zig",
      "go"
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },

    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = nil,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    indent = { enable = true },

    -- vim-matchup
    matchup = {
      enable = true,
    },

    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<leader>sx"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>sX"] = "@parameter.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },

      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>cf"] = "@function.outer",
          ["<leader>cF"] = "@class.outer",
        },
      },
    },

    -- endwise
    endwise = {
      enable = true,
    },

    -- autotag
    autotag = {
      enable = true,
    },

    -- context_commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
  vim.opt.foldmethod  = 'expr'
  vim.opt.foldexpr    = 'nvim_treesitter#foldexpr()'

  -- Folding
  vim.wo.foldminlines = 5 -- Adjust the value as needed
  -- Define a Lua function to close the fold under the cursor
  function close_fold_under_cursor()
    -- Execute the 'zc' command to close the fold
    vim.cmd('normal! zc')
  end

  -- Map a keybinding to call the close_fold_under_cursor function
  vim.api.nvim_set_keymap('n', '<TAB>', ':lua close_fold_under_cursor()<CR>', { noremap = true, silent = true })
end

return M
