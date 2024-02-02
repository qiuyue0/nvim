require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  },
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
    ensure_installed = { "jedi_language_server" }
})

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local lspconfig = require("lspconfig") 
-- lspconfig.lua_ls.setup {
--   capabilities = capabilities,
-- }
-- after local capabilities = ....
-- start server
require'lspconfig'.jedi_language_server.setup{}
