local M = {}

function M.setup()
  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function lazy_init()
    local fn = vim.fn
    local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
  end



  -- Plugins Installed
  local plugins = {
    { -- Plenary
      "nvim-lua/plenary.nvim" },
    { -- VIM Git
      "tpope/vim-fugitive" },
    { -- FZF Installer
      'junegunn/fzf.vim',
      dependencies = { 'junegunn/fzf', build = ':call fzf#install()' }
    },
    { -- TreeSitter
      'nvim-treesitter/nvim-treesitter',
      event = "BufReadPre",
      build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require("config.treesitter").setup()
      end,
    },
    { -- TreeSitter Text Objects
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    { -- Theme
      'folke/tokyonight.nvim',
      config = function()
        require("config.theme").setup()
      end,
    },
    { -- Status bar lualine for the theme
      'nvim-lualine/lualine.nvim',
      event = "BufEnter",
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("config.lualine")
      end,
    },
    { -- LSP
      'neoclide/coc.nvim',
      branch = 'release',
      config = function()
        require("config.coc").setup()
      end,
    },
    { -- DAP
      'mfussenegger/nvim-dap',
      config = function()
        require("config.dap").setup()
      end,
      keys = require("config.dap").keys,
      dependencies = require("config.dap").dependencies
    },
    {
      -- Nvim - metals
      'scalameta/nvim-metals',
      dependencies = require("config.nvim-metals").dependencies,
      config = function(self, metals_config)
        require("config.nvim-metals").setup(self, metals_config)
      end,
      ft = require("config.nvim-metals").ft,
      opts = require("config.nvim-metals").opts,

    },
  }
  -- Init and start Lazy nvim
  lazy_init()
  local lazy = require "lazy"
  lazy.setup(plugins)
end

return M
