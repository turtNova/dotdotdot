return {
    {
        "sphamba/smear-cursor.nvim",
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = true,
    },
    {
        "vim-airline/vim-airline",
        lazy = false,
        config = function()
            vim.cmd [[let g:airline#extensions#tabline#enabled = 1]]
            vim.cmd [[let g:airline#extensions#tabline#formatter = 'unique_tail_improved']]
        end,
    },
}
