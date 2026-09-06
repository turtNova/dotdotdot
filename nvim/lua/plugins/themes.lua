return {
    {
        'tiagovla/tokyodark.nvim',
        lazy = true,
    },
    {
        'catppuccin/nvim',
        lazy = true,
    },
    {
        'navarasu/onedark.nvim',
        opts = { style = 'warm' },
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('onedark')
        end,
    },
    {
        'sainnhe/gruvbox-material',
        lazy = true,
    },
}
