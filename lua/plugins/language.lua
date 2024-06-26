return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
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
   }
}
