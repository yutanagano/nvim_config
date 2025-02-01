require("kanagawa").setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  },
  overrides = function (colors)
    local theme = colors.theme
    return {
      ["@markup.list.markdown"] = { fg = theme.syn.special2 },
      ["@markup.heading.markdown"] = { fg = theme.syn.identifier, bold = true },
      ["@markup.heading.2.markdown"] = { fg = theme.syn.identifier, bold = true },
      ["@markup.heading.3.markdown"] = { fg = theme.syn.string, bold = true },
      ["@markup.heading.4.markdown"] = { fg = theme.syn.type, bold = true },
      -- ["@lsp.type.class.markdown"] = { fg = theme.syn.fun },
      LineNr = { fg = theme.syn.constant },
      LineNrAbove = { fg = theme.ui.nontext },
      LineNrBelow = { fg = theme.ui.nontext },
    }
  end
})
vim.cmd("colorscheme kanagawa")
