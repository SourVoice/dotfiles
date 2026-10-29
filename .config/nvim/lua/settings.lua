local keys = require("custom_keys")
local opts = require("custom_opts")

local map = vim.keymap.set
local option = {noremap = true, silent = true }

map('n', keys.jump_left_window, '<C-W>h', option)
map('n', keys.jump_down_window, '<C-W>j', option)
map('n', keys.jump_up_window, '<C-W>k', option)
map('n', keys.jump_right_window, '<C-W>l', option)

-- Keep the core movement and window shortcuts aligned with .vimrc.
map({'n', 'v', 's', 'x', 'o'}, '<C-[>', '<Esc>', option)
map({'n', 'v', 'o'}, '<C-a>', '<Nop>', option)
map({'n', 'v', 'o'}, '<C-x>', '<Nop>', option)
map('n', 'Q', '<Nop>', option)
map({'n', 'v', 'o'}, '<C-h>', '^', option)
map({'n', 'v', 'o'}, '<C-l>', '$', option)
map({'n', 'v', 'o'}, 'E', '5j', option)
map({'n', 'v', 'o'}, 'W', '5k', option)

map('n', '<leader>u', '<Cmd>aboveleft split<CR>', option)
map('n', '<leader>o', '<Cmd>belowright split<CR>', option)
map('n', '<leader>p', '<Cmd>leftabove vsplit<CR>', option)
map('n', '<leader>i', '<Cmd>rightbelow vsplit<CR>', option)

map('n', 'tu', '<Cmd>tabnew<CR>', option)
map('n', 'tU', '<Cmd>tab split<CR>', option)
map('n', 'tn', '<Cmd>tabnext<CR>', option)
map('n', 'tp', '<Cmd>tabprevious<CR>', option)
map('n', 'tmn', '<Cmd>+tabmove<CR>', option)
map('n', 'tmp', '<Cmd>-tabmove<CR>', option)
map('n', 'tc', '<Cmd>tabclose<CR>', option)
map('n', '<leader>n', '<Cmd>Neotree position=left source=filesystem action=show toggle=true<CR>', option)
map('n', '<leader>y', function()
    local word = vim.fn.expand('<cword>')
    local result = vim.fn.system({'ici', word})
    vim.notify('--=' .. word .. '==--\n' .. result)
end, option)

-- Supported by bufdelete
-- vim.cmd([[cnoreabbrev q Bdelete]])

-- Supported by bufferline
map('n', keys.pick_tab, ':BufferLinePick<CR>', option)

-- Supported by nvim-tree
map('n', keys.file_explorer, ':Neotree position=left source=filesystem action=show toggle=true<CR>', option)
map('n', keys.git_status, ':Neotree position=float source=git_status action=show toggle=true<CR>', option)

-- Supported by aerial
map('n', keys.outline, ':AerialToggle! right<CR>', option)

-- Supported by diffview
map('n', keys.diff_open, ':DiffviewOpen<CR>', option)
map('n', keys.diff_close, ':DiffviewClose<CR>', option)

-- Supported by floaterm
map('n', keys.terminal, ':ToggleTerm<CR><C-\\><C-n>a', option)
map('t', keys.terminal, '<C-\\><C-n>:ToggleTerm<CR>', option)

-- Supported by nvim-session-manager
map('n', keys.switch_session, ':SessionManager load_session<CR>', option)

-- Function to set up the save shortcut
--
local function setup_save_shortcut()
    local is_mac = vim.fn.has("mac") == 1
    local is_linux = vim.fn.has("unix") == 1 and not is_mac
    local is_windows = vim.fn.has("win32") == 1

    -- Define key mappings
    local map = function(mode, lhs, rhs)
        vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap=true})
    end

    if is_mac then
        map('n', '<D-s>', ':w<CR>')
        map('v', '<D-s>', ':w<CR>')
        map('i', '<D-s>', '<Esc>:w<CR>a')
    elseif is_linux then
        map('n', '<C-s>', ':w<CR>')
        map('v', '<C-s>', ':w<CR>')
        map('i', '<C-s>', '<Esc>:w<CR>a')
    elseif is_windows then
        map('n', '<C-s>', ':w<CR>')
        map('v', '<C-s>', ':w<CR>')
        map('i', '<C-s>', '<Esc>:w<CR>a')
    end
end

setup_save_shortcut()

-- Setup autocmd
local hardhacker_config_group = vim.api.nvim_create_augroup('HardHackerConfigGroup', {})

vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = "SessionLoadPost",
    group = hardhacker_config_group,
    callback = function()
        vim.api.nvim_command("Neotree position=left source=filesystem action=show toggle=true")
    end,
})
