-- return {
--    {
--       "rebelot/kanagawa.nvim",
--       lazy = false,
--       priority = 1000,
--       config = function()
--          vim.cmd("colorscheme kanagawa")
--       end,
--    },
-- }
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  }
}
