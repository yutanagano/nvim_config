-- Declare LSP servers and formatters to install

local lsp_servers = {
	-- server_name = {
	--   cmd = {},
	--   filetypes = {},
	--   capabilities = {},
	--   settings = {},
	--   on_init = function(client) end,
	-- },
	lua_ls = {
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
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off",
				},
			},
		},
	},
	texlab = {},
	marksman = {},
	gopls = {},
	rust_analyzer = {},
}

local formatter_servers = {
	"stylua",
	"black",
}

-- Install all declared servers with Mason

local mason_to_install = vim.tbl_keys(lsp_servers)
vim.list_extend(mason_to_install, formatter_servers)

require("mason-tool-installer").setup({ ensure_installed = mason_to_install })

-- Set up all LSP servers with Mason and lspconfig

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server_settings = lsp_servers[server_name] or {}
			server_settings.capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, server_settings.capabilities or {})
			require("lspconfig")[server_name].setup(server_settings)
		end,
	},
})
