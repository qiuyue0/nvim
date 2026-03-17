return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      local languages = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "bash",
        "cpp",
        "json",
        "javascript",
        "sql",
        "yaml",
      }
      local ft_map = {
        bash = "sh",
      }
      local ft_patterns = vim.tbl_map(function(lang)
        return ft_map[lang] or lang
      end, languages)

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, languages)

      if #missing > 0 then
        if vim.fn.executable("tree-sitter") == 1 then
          ts.install(missing)
        else
          vim.schedule(function()
            vim.notify(
              "nvim-treesitter: 缺少 tree-sitter CLI，无法自动安装解析器",
              vim.log.levels.WARN
            )
          end)
        end
      end

      local group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = ft_patterns,
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
