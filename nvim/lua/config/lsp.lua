-- Below text inline hints
-- vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })

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
