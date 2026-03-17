# Lazy 插件管理 - 快速参考

## 常用 Lazy 命令

```vim
" 显示所有加载的插件
:Lazy

" 同步插件（安装/更新/删除）
:Lazy sync

" 只安装缺失的插件
:Lazy install

" 更新所有插件
:Lazy update

" 检查插件更新
:Lazy check

" 显示插件配置详情
:Lazy profile
```

## 配置插件的基本结构

```lua
return {
  {
    "owner/plugin-name",
    -- 依赖
    dependencies = { "dep1", "dep2" },
    
    -- 加载条件
    event = { "BufReadPre", "BufNewFile" },  -- 事件触发
    cmd = "PluginCommand",                     -- 命令触发
    keys = { "<leader>x", desc = "..." },     -- 按键触发
    ft = "filetype",                           -- 文件类型触发
    lazy = false,                              -- 禁用延迟加载
    priority = 1000,                           -- 加载优先级
    
    -- 插件配置
    config = function()
      require("plugin-name").setup({...})
    end,
    
    -- 编译钩子
    build = ":PluginBuild",
  }
}
```

## 当前配置的文件组织

```
lua/plugins/
├── ui.lua          # 主题、状态栏、Buffer 栏
├── nvim-tree.lua   # 文件浏览器
├── treesitter.lua  # 代码语法高亮和解析
├── lsp.lua         # 语言服务协议
├── cmp.lua         # 自动补全
├── editing.lua     # 注释、括号补全
├── git.lua         # Git 集成
├── telescope.lua   # 模糊搜索
└── tmux.lua        # Tmux 导航
```

## 首次安装后需要执行（Treesitter）

`nvim-treesitter` 已改为不自动安装 parser，首次安装配置后请手动执行一次：

```vim
:TSInstall c lua vim vimdoc query python bash cpp json javascript sql yaml
```

后续更新 parser 可使用：

```vim
:TSUpdate
```

## 添加新插件的步骤

### 方式1：添加到现有分组文件
编辑相应的文件（如 `editing.lua`）并在 return 表中添加新的 spec：

```lua
return {
  -- ... 现有插件
  {
    "owner/new-plugin",
    event = "InsertEnter",
    config = function()
      require("new-plugin").setup()
    end,
  }
}
```

### 方式2：创建新的分组文件
创建 `lua/plugins/category.lua`：

```lua
return {
  {
    "owner/plugin1",
    config = function() end,
  },
  {
    "owner/plugin2",
    config = function() end,
  }
}
```

自动会被 `init.lua` 中的 `require("lazy").setup("plugins")` 加载。

## 常见事件类型

- `VeryLazy` - 延迟加载（启动完成后）
- `BufReadPre` - 读取文件前
- `BufNewFile` - 创建新文件
- `InsertEnter` - 进入插入模式
- 更多：`:h lazy-events`

## 调试技巧

查看插件加载时间：
```vim
:Lazy profile
```

显示加载错误：
```vim
:Lazy log
```

强制重新加载：
```vim
:Lazy reload <plugin-name>
```
