# Neovim 配置迁移总结

## 迁移内容

### 1. **包管理器更新**
- ❌ 移除：Packer 配置（`plugins-setup.lua`）
- ✅ 添加：Lazy 配置集成到 `init.lua`
- 自动初始化 Lazy 并加载 `plugins/` 目录下的所有配置

### 2. **插件配置重组**

所有插件配置从直接调用改为 Lazy spec 格式：

#### UI 相关 (`ui.lua`)
- `folke/tokyonight.nvim` - 主题
- `nvim-lualine/lualine.nvim` - 状态栏
- `akinsho/bufferline.nvim` - Buffer 分割线

#### 文件浏览 (`nvim-tree.lua`)
- `nvim-tree/nvim-tree.lua` - 文件树

#### 代码高亮和解析 (`treesitter.lua`)
- `nvim-treesitter/nvim-treesitter` - 语法树
  - 现代化配置：移除过时的 `rainbow` 配置
  - 新增 `incremental_selection` 支持（快捷键：`<C-space>` 扩展选择）
  - 启用 `build = ":TSUpdate"` 自动更新

#### 语言服务协议 (`lsp.lua`)
- `williamboman/mason.nvim` - LSP 包管理
- `williamboman/mason-lspconfig.nvim` - LSP 配置管理
- `neovim/nvim-lspconfig` - LSP 客户端

#### 自动补全 (`cmp.lua`)
- `hrsh7th/nvim-cmp` - 补全框架
- 依赖：`cmp-nvim-lsp`, `LuaSnip`, `cmp_luasnip`, `friendly-snippets`, `cmp-path`

#### 编辑增强 (`editing.lua`)
- `numToStr/Comment.nvim` - 注释
- `windwp/nvim-autopairs` - 自动括号补全

#### Git 集成 (`git.lua`)
- `lewis6991/gitsigns.nvim` - Git 符号显示

#### 搜索 (`telescope.lua`)
- `nvim-telescope/telescope.nvim` - 模糊查找

#### 导航 (`tmux.lua`)
- `christoomey/vim-tmux-navigator` - Tmux 集成

### 3. **Treesitter 现代化更新**

**移除的配置：**
```lua
rainbow = {
  enable = true,
  extended_mode = true,
  max_file_lines = nil
}
```
（彩虹括号现在通过独立插件 `nvim-treesitter/nvim-rainbow-delimiters` 处理）

**新增的配置：**
```lua
incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<C-space>",
    node_incremental = "<C-space>",
    scope_incremental = false,
    node_decremental = "<bs>",
  },
}
```

**改进的高亮配置：**
```lua
highlight = {
  enable = true,
  additional_vim_regex_highlighting = false,
}
```

## 删除的文件

- ❌ `lua/plugins/plugins-setup.lua` - Packer 初始化文件
- ❌ `plugin/packer_compiled.lua` - Packer 编译缓存
- ❌ `plugin/` 目录整体

## 迁移后的优势

1. **更快的启动速度**：Lazy 使用延迟加载，只在需要时加载插件
2. **更灵活的配置**：每个插件拥有独立的 spec 文件，易于维护
3. **自动更新检查**：Lazy 内置检查器定期检查更新
4. **现代化的 Treesitter**：移除了过时的配置，使用官方推荐的方式
5. **更清晰的插件组织**：插件按功能分组到不同文件

## 下一步（可选）

如果需要彩虹括号功能，可以添加：
```lua
{
  "nvim-treesitter/nvim-rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("rainbow-delimiters").setup()
  end,
}
```

## 测试

启动 Neovim 并验证：
1. 所有插件正确加载
2. LSP 和自动补全正常工作
3. 搜索、注释、括号补全功能正常
