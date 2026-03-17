return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jedi_language_server" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config("jedi_language_server", {})
      vim.lsp.enable("jedi_language_server")
    end,
  },
}
