local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    print("nvim-cmp not found!")
    return
end

local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    print("luasnip not found!")
    return
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
	    luasnip.lsp_expand(args.body) -- For `luasnip` users.
	end,
    },
    mapping = cmp.mapping.preset.insert({
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-k>"] = cmp.mapping.select_prev_item(),
	['<C-b>'] = cmp.mapping.scroll_docs(-1),
	['<C-f>'] = cmp.mapping.scroll_docs(1),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

	["<Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
		cmp.select_next_item()
		-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
		-- that way you will only jump inside the snippet region
	    elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	    elseif has_words_before() then
		cmp.complete()
	    else
		fallback()
	    end
	end, { "i", "s" }),

	["<S-Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
		cmp.select_prev_item()
	    elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	    else
		fallback()
	    end
	end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "path" },
	{ name = "buffer" },
    }),
    formatting = {
	format = function(entry, vim_item)
	    vim_item.menu = ({
		nvim_lsp = "[lsp]",
		luasnip = "[luasnip]",
		path = "[path]",
		buffer = "[buffer]",
	    })[entry.source.name]
	    return vim_item
	end
    },
})
