require("core.options")
require("core.keymaps")

-- Lazy 包管理器初始化
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载所有插件
require("lazy").setup("plugins", {
  checker = {
    enabled = true,
    concurrency = nil,
    notify = true,
    period = 60,
  },
})

