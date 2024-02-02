require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "bash", "cpp", "json", "javascript", "jsonc", "sql","yaml" },

  highlight = { enable = true },
  indent = { enable = true },

  rainbow = {
    enable = true,
	extended_mode = true,
    max_file_lines = nil
  }
}
