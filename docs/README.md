# Dotfiles 使用说明

本文按仓库中的配置文件逐项说明用途，并汇总 Vim/Neovim 的常用键位。

## 安装

在仓库根目录运行 `bash install.sh`。脚本会把支持的配置链接到 `$HOME`，已有目标会移入 `~/dotfiles_old`。Neovim 配置会链接到 `~/.config/nvim`；Vim、VS Code 和 shell 配置也由脚本处理。

Neovim 首次启动时会由 lazy.nvim 下载插件。全文检索需要在 `PATH` 中安装 `ripgrep`（提供 `rg`）；符号搜索需要对应的 LSP 服务器已安装并连接到当前项目。`.claude/settings.json` 和 `.bash_prompt` 当前不在安装脚本的链接列表中。

## Vim 与 Neovim 键位

两种编辑器的 Leader 键均为逗号 `,`。Neovim 在 Vim 原有基础上继续保留 LSP、Telescope 和插件快捷键。

| 操作 | 键位 | 说明 |
| --- | --- | --- |
| 插入模式回普通模式 | `jj` | 插入模式输入两个 `j` |
| 快速上下移动 | `E` / `W` | 向下/向上移动 5 行 |
| 跳到行首/行尾 | `Ctrl+h` / `Ctrl+l` | 普通模式下移动光标 |
| 窗口间移动 | `Space+h/j/k/l` | 左/下/上/右切换分屏 |
| 分屏高度调整 | `,j` / `,k` | 增高/降低当前分屏 |
| 分屏宽度调整 | `,h` / `,l` | 加宽/缩窄当前分屏 |
| 新建上/下方水平分屏 | `,u` / `,o` | 在当前窗口上方/下方打开分屏 |
| 新建左/右侧垂直分屏 | `,p` / `,i` | 在当前窗口左侧/右侧打开分屏 |
| 新建标签页 | `tu` | 新建空标签页 |
| 当前缓冲区复制到标签页 | `tU` | 新建标签页并载入当前文件 |
| 下一个/上一个标签页 | `tn` / `tp` | 切换标签页 |
| 向后/向前移动标签页 | `tmn` / `tmp` | 调整当前标签页顺序 |
| 关闭标签页 | `tc` | 关闭当前标签页 |

Neovim 另外提供：

| 操作 | 键位 |
| --- | --- |
| 搜索文件 | `,ff` |
| 全文搜索 | `,fg` |
| 搜索光标下单词 | `,fc` |
| 搜索缓冲区 | `,fb` |
| 当前文件符号 | `,fs` |
| 工作区符号 | `,fS` |
| Telescope 窗口增高/降低 | `Ctrl+Up` / `Ctrl+Down` |
| Telescope 窗口加宽/缩窄 | `Ctrl+Right` / `Ctrl+Left` |
| LSP 跳转定义/引用/声明/实现 | `gd` / `gr` / `gD` / `gi` |
| LSP 重命名/格式化 | `,rn` / `,cf` |
| 文件树/ Git 状态/大纲 | `,n` 或 `F9` / `F8` / `F7` |
| 浮动终端 | `Alt+j` |
| 切换会话 | `,ss` |

Telescope 窗口默认约占屏幕宽度的 90%、高度的 85%。方向键每次调整 5%；宽度最小 40%、高度最小 30%，最大为屏幕的 100%。这些快捷键在 Telescope 插入模式和普通模式均可用。Neovim 的 `,h` 会加宽、`,l` 会缩窄，与 Vim 的分屏尺寸方向一致。

`,n` 用于切换 Vim 的 NERDTree 或 Neovim 的 Neo-tree；`,y` 调用外部 `ici` 命令翻译光标下单词，该命令需自行安装。Vim 启动时会自动打开 NERDTree。

## 文件说明

### 根目录与 Shell

- `.bashrc`：交互式 Bash 配置，包括 vi 编辑模式及 `[INSERT]`/`[NORMAL]` 状态提示、常用别名、补全、Node/Rust 环境和 WakaTime 初始化。首次执行时可能安装 WakaTime 相关组件。
- `.bash_profile`：登录 Bash 配置；设置 Tab 补全行为，并加载 `.bashrc`。
- `.bash_prompt`：可选的 Solarized 风格 Bash 提示符脚本，包含 Git 分支和工作区状态显示；当前未由安装脚本链接，也未由 `.bashrc` 加载。
- `.zshrc`：Zsh 配置，使用 Oh My Zsh 的 `robbyrussell` 主题，加载 vi 模式及若干插件，并设置 `la` 别名。
- `.gitconfig`：Git 用户名、邮箱和 `lg` 图形化提交历史别名。
- `.tmux.conf`：tmux 配置，包括 vi 复制模式、分屏/窗口导航与调整、鼠标支持、状态栏、滚动历史，以及 `Ctrl+r` 重载配置。
- `install.sh`：安装依赖并为 Vim、Neovim、VS Code 和 shell 配置创建符号链接；旧目标会备份到 `~/dotfiles_old`。

### Vim

- `.vimrc`：Vim 基础选项、逗号 Leader、编辑/窗口/标签页快捷键、vim-plug 插件列表、NERDTree、Coc、状态栏及 Git/语法高亮配置。
- `.vim/coc-settings.json`：Coc.nvim 补全显示、格式化文件类型和 CMake/Bash 语言服务器设置。

### Neovim

- `.config/nvim/init.lua`：Neovim 入口，初始化基础设置、lazy.nvim、插件/语言配置和最终快捷键设置。
- `.config/nvim/.gitignore`：忽略 Lua 编译产物、lazy.nvim 锁文件和本地私有插件配置。
- `.config/nvim/lua/basic.lua`：编辑器选项，包括行号、搜索、缩进、折叠、备份和语法高亮。
- `.config/nvim/lua/settings.lua`：窗口、标签页、保存和 Vim 兼容键位的实际映射。
- `.config/nvim/lua/custom_keys.lua`：集中定义 Leader 键、插件快捷键、搜索、分屏尺寸和 LSP 快捷键。
- `.config/nvim/lua/custom_opts.lua`：文件树标题、标签栏样式、终端尺寸/透明度和启动页内容等外观选项。
- `.config/nvim/lua/languages/rust.lua`：Rust 工具和 rust-tools 的语言配置。
- `.config/nvim/lua/plugins/autocmp/config.lua`：nvim-cmp 补全来源、确认/导航键和补全窗口样式。
- `.config/nvim/lua/plugins/coding.lua`：自动补全括号、标签配对和 nvim-cmp 插件声明。
- `.config/nvim/lua/plugins/colorschemes.lua`：主题插件声明。
- `.config/nvim/lua/plugins/dashboard-nvim/config.lua`：启动页的展示内容和快捷操作。
- `.config/nvim/lua/plugins/find.lua`：Telescope 文件、文本、缓冲区及 LSP 符号搜索，并配置弹窗尺寸和调整键位。
- `.config/nvim/lua/plugins/git.lua`：Git 标记和 Diffview 插件配置。
- `.config/nvim/lua/plugins/highlight.lua`：Tree-sitter 语法高亮和颜色值高亮设置。
- `.config/nvim/lua/plugins/lsp.lua`：Mason、LSP 配置管理器和格式化工具的插件声明/初始化。
- `.config/nvim/lua/plugins/lspconfig/config.lua`：LSP 诊断、跳转、重命名、格式化和代码操作映射。
- `.config/nvim/lua/plugins/lualine/config.lua`：状态栏主题及分支、差异、诊断、文件名等显示内容。
- `.config/nvim/lua/plugins/neo-tree/config.lua`：Neo-tree 文件系统、缓冲区和 Git 状态视图及其操作键。
- `.config/nvim/lua/plugins/nvim-web-devicons/config.lua`：文件类型图标和特定文件/扩展名图标覆盖。
- `.config/nvim/lua/plugins/smart-split/config.lua`：分屏尺寸调整动作；快捷键在 `custom_keys.lua` 定义。
- `.config/nvim/lua/plugins/start_screen.lua`：启动页插件声明和加载时机。
- `.config/nvim/lua/plugins/terminal.lua`：浮动终端插件、尺寸和边框设置。
- `.config/nvim/lua/plugins/utils.lua`：通知、分屏调整、缓冲区删除和会话管理等工具插件。
- `.config/nvim/lua/plugins/view.lua`：状态栏、文件树、大纲、标签栏和输入界面插件声明。
- `.config/nvim/misc/recommended/markdown.lua`：Markdown 预览插件的可选配置示例；当前入口未自动加载此文件。

### VS Code 与 Claude

- `vscode/settings.json`：VS Code 文件关联、UTF-8 编码和 C/C++ IntelliSense 设置。
- `vscode/c_cpp_properties.json`：C/C++ include 路径、编译器、语言标准和 IntelliSense 模式。
- `vscode/.clang-format`：C++ 格式化风格，采用 LLVM 风格并设置 4 空格缩进、80 列宽等规则。
- `.claude/settings.json`：Claude Code 模型、界面状态栏、权限和交互偏好；当前安装脚本不会链接此文件。