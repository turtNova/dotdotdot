return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim", version = '*',
        lazy = false,
        opts = {},
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end,
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
    },
    {
        "brianhuster/live-preview.nvim",
        lazy = true,
        opts = {},
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
    },
    {
        "nemanjamalesija/smart-paste.nvim",
        lazy = false,
        opts = {},
    },
}
