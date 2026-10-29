return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function()
            local action_state = require('telescope.actions.state')
            local function resize_picker(prompt_bufnr, dimension, amount)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local minimum = dimension == 'width' and 0.4 or 0.3
                picker.layout_config[dimension] = math.max(minimum, math.min(1,
                    picker.layout_config[dimension] + amount))
                picker:full_layout()
            end

            require('telescope').setup({
                defaults = {
                    layout_config = {
                        width = 0.9,
                        height = 0.85,
                    },
                    mappings = {
                        i = {
                            ['<C-Up>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'height', 0.05)
                            end,
                            ['<C-Down>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'height', -0.05)
                            end,
                            ['<C-Right>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'width', 0.05)
                            end,
                            ['<C-Left>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'width', -0.05)
                            end,
                        },
                        n = {
                            ['<C-Up>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'height', 0.05)
                            end,
                            ['<C-Down>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'height', -0.05)
                            end,
                            ['<C-Right>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'width', 0.05)
                            end,
                            ['<C-Left>'] = function(prompt_bufnr)
                                resize_picker(prompt_bufnr, 'width', -0.05)
                            end,
                        },
                    },
                },
            })

            local option = {noremap = true, silent = true }

            local keys = require("custom_keys")
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', keys.find_files, builtin.find_files, option)
            vim.keymap.set('n', keys.live_grep, builtin.live_grep, option)
            vim.keymap.set('n', keys.search_cursor, builtin.grep_string, option)
            vim.keymap.set('n', keys.find_buffer, builtin.buffers, option)
            vim.keymap.set('n', keys.find_document_symbols, builtin.lsp_document_symbols, option)
            vim.keymap.set('n', keys.find_workspace_symbols, builtin.lsp_dynamic_workspace_symbols, option)
        end,
    },
}
