local status_ok, lsp_zero = pcall(require, 'lsp-zero')
if not status_ok then
    print("lsp-zero not found!")
    return
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("mason not found!")
    return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    print("mason-lspconfig not found!")
    return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("lspconfig not found!")
    return
end

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

mason.setup({})
mason_lspconfig.setup({
  ensure_installed = { "pylsp", "rust_analyzer", "lua_ls", "texlab" },
  handlers = {
    lsp_zero.default_setup,
    
    pylsp = function()
	lspconfig.pylsp.setup({
	    settings = {
		pylsp = {
		    plugins = {
			rope_autoimport = { enabled = true },
			pycodestyle = {
			    ignore = { "E501", "E226", "E203", "W503" }
			},
		    },
		}
	    }
	})
    end,

  },
})


-- keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
