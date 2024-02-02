vim.g.mapleader = " "

local keymap = vim.keymap

---- 插入模式下生效 ----
keymap.set("i","jk","<ESC>")

---- visual模式下生效 ----
-- 单行或多行移动
keymap.set("v","J",":m '>+1<CR>gv=gv")
keymap.set("v","K",":m '<-2<CR>gv=gv")

---- 正常模式下生效 ----
-- 窗口
keymap.set("n","<leader>sv","<C-w>v") -- 水平新增窗口
keymap.set("n","<leader>sh","<C-w>s") -- 垂直新增窗口
keymap.set("n","<leader>so","<C-w>o") -- 水平新增窗口
keymap.set("n","<leader>sc","<C-w>c") -- 垂直新增窗口
keymap.set("n","<leader>z",":set paste<CR>i") -- 粘贴模式

-- 取消高亮
keymap.set("n","<leader>nh",":nohl<CR>")


keymap.set("n","L",":bnext<CR>")
keymap.set("n","H",":bprevious<CR>")
---- 插件 ----
-- nvim-tree
keymap.set("n","<leader>e",":NvimTreeToggle<CR>")

