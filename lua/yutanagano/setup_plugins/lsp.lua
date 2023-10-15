local status_ok, lsp_zero = pcall(require, 'lsp-zero')
if not status_ok then
    print("lsp-zero not found!")
    return
end

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "pylsp", "rust_analyzer" },
  handlers = {
    lsp_zero.default_setup,
    pylsp = function()
	require("lspconfig").pylsp.setup({
	    settings = {
		pylsp = {
		    plugins = {
			rope_autoimport = {
			    enabled = true
			}
		    }    
		}
	    }
	})
    end,
  },
})
