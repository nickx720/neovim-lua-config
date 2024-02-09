local M = {}

function M.setup()
		-- Indicate first time installation
		local packer_bootstrap = false

		-- packer.nvim configuration
		local conf = {
				profile = {
						enable = true,
						threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
				},

				display = {
						open_fn = function()
								return require("packer.util").float { border = "rounded" }
						end,
				},
		}

		-- Check if packer.nvim is installed
		-- Run PackerCompile if there are changes in this file
		local function packer_init()
				local fn = vim.fn
				local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
				if fn.empty(fn.glob(install_path)) > 0 then
						packer_bootstrap = fn.system {
								"git",
								"clone",
								"--depth",
								"1",
								"https://github.com/wbthomason/packer.nvim",
								install_path,
						}
						vim.cmd [[packadd packer.nvim]]
				end
				vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
		end

		-- Plugins
		local function plugins(use)
				use { "wbthomason/packer.nvim" }

				-- Load only when require
				use { "nvim-lua/plenary.nvim", module = "plenary" }

				-- Vim Git
				use {
						"tpope/vim-fugitive"
				}

				-- Vimspector
				use {
						"puremourning/vimspector",
						event = "BufRead",
						config = function()
								require("config.vimspector").setup()
						end,
				}

				-- FZF Installer
				use {
						'junegunn/fzf.vim',
						requires = { 'junegunn/fzf', run = ':call fzf#install()' }
				}

				-- Tree Sitter
				use {
						'nvim-treesitter/nvim-treesitter',
						run = function()
								local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
								ts_update()
						end,
						config = function()
								require("config.treesitter").setup()
						end,
				}

				-- Tree sitter Text object Manipulation
				use({
						"nvim-treesitter/nvim-treesitter-textobjects",
						after = "nvim-treesitter",
						requires = "nvim-treesitter/nvim-treesitter",
				})

				-- Theme
				use {
						'folke/tokyonight.nvim',
						config = function()
								require("config.theme").setup()
						end,
				}

				-- Nvim Icons
				use("nvim-tree/nvim-web-devicons")

				-- Status Bar Lualine Match with Theme
				use {
						'nvim-lualine/lualine.nvim',
						event = "BufEnter",

				config = function()
								require("config.lualine")
						end,
						requires = { 'nvim-tree/nvim-web-devicons', opt = true, }
				}

				-- LSP
				use {'neoclide/coc.nvim', branch = 'release',
				config = function()
								require("config.coc").setup()
				end,}

				-- ALE
				use {'dense-analysis/ale',
						config = function()
								require("config.coc").setup()
				end,}

				-- Bootstrap Neovim
				if packer_bootstrap then
						print "Restart Neovim required after installation!"
						require("packer").sync()
				end
		end

		-- Init and start packer
		packer_init()
		local packer = require "packer"
		packer.init(conf)
		packer.startup(plugins)
end

return M
