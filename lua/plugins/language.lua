return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
   },
   {
      "numToStr/Comment.nvim",
      config = true,
   },
   {
      "williamboman/mason.nvim",
      lazy = false,
   },
   {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
   },
   {
      "neovim/nvim-lspconfig",
      lazy = false,
   },
   {
     'stevearc/conform.nvim',
     opts = {},
   },
}
