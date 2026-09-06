--[[
help text-object-define
to restart a buffer:
:bufdo e
--]]

-- vim.cmd("set keymap=dvorak")

require("config.options")
require("config.lazy")
require("config.lsp")
require("mappings")

-- custom tmux session support
local tmux = vim.env.Z_TMUX_CODE
if tmux ~= nil then
    vim.keymap.set('n', '<leader>p', '<Cmd>silent! make<CR>', { silent = true })
    vim.o.shellpipe = "2>&1|tmux display-message -t code:nvim.2 -I|tee"
    vim.o.makeef = ""
else
    vim.keymap.set('n', '<leader>p', '<Cmd>make<CR>', { silent = true })
end

local makeprg = {
    rust   = "cargo run -q",
    python = "python %",
    c      = "gcc -Wall -o out.c %",
}

-- autocmd that checks current file type and sets the makeprg accordingly
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local lang = args.match
        if makeprg[lang] ~= nil then
            vim.o.makeprg = makeprg[lang]
        end
    end
})

-- Custom functions
vim.api.nvim_create_user_command("EditVim", function()
    vim.cmd('tabedit ~/.config/nvim/init.lua')
end, {})

-- vim.api.nvim_create_autocmd('FileType', {
--     callback = function(args)
--         for i, arg in pairs(args) do
--             print(i, arg)
--         end
--     end,
-- })

-- vim.cmd('hi statusline guibg=NONE')

-- vim.lsp.config('roslyn_ls', {
--     cmd = {
--         'dotnet',
--         '/home/turt/source/roslyn/lib/net10.0/Microsoft.CodeAnalysis.LanguageServer.dll',
--         '--logLevel', -- this property is required by the server
--         'Information',
--         '--extensionLogDirectory', -- this property is required by the server
--         vim.fs.joinpath(vim.uv.os_tmpdir(), 'roslyn_ls/logs'),
--         '--stdio',
--     },
-- })
