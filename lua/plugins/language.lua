-- Declare LSP servers and formatters to install

local lsp_servers = {
	-- server_name = {
	--   cmd = {},
	--   filetypes = {},
	--   capabilities = {},
	--   settings = {},
	--   on_init = function(client) end,
	-- },
	["lua-language-server"] = {
		alt = "lua_ls",
		opts = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						disable = { "missing-fields" },
					},
				},
			},
		},
	},
	pyright = {
		opts = {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		},
	},
	texlab = {},
	["markdown-oxide"] = {
		alt = "markdown_oxide",
		opts = {
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		},
	},
	gopls = {},
	["rust-analyzer"] = {
		alt = "rust_analyzer",
	},
	superhtml = {},
	["typescript-language-server"] = {
		alt = "ts_ls",
	},
	["css-lsp"] = {
		alt = "cssls",
	},
	tinymist = {},
}

local formatters = {
	"stylua",
	"ruff",
	"prettierd",
	"typstyle",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- set .configs as module to run opts on
		opts = {
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			-- indent = { enable = true },
		},
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false, config = true },
		},
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, vim.tbl_keys(lsp_servers))
			vim.list_extend(opts.ensure_installed, formatters)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			for server_name, server_settings in pairs(lsp_servers) do
				server_name = server_settings.alt or server_name
				server_settings = server_settings.opts or {}
				server_settings.capabilities = require("blink.cmp").get_lsp_capabilities(server_settings.capabilities)
				vim.lsp.config(server_name, server_settings)
				vim.lsp.enable(server_name)
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				markdown = { "prettierd" },
				typst = { "typstyle" },
				javascript = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				"${3rd}/busted/library",
				"${3rd}/luassert/library",
			},
		},
	},
}
