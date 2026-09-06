return {
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },
    {
        "jiangmiao/auto-pairs",
        lazy = false,
        config = function()
        end,
    },
    {
        "kylechui/nvim-surround",
        lazy = false,
        opts = {},
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "prettierd"
            }
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').install({
                'html',
                'javascript',
                'typescript',
                'css',
                'rust',
                'zig'
            })
            ---@param buf integer
            ---@param language string
            local function treesitter_try_attach(buf, language)
                -- Check if a parser exists and load it
                if not vim.treesitter.language.add(language) then return end
                -- Enable syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)

                -- Enable treesitter based folds
                -- For more info on folds see `:help folds`
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'

                -- Check if treesitter indentation is available for this language, and if so enable it
                -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
                local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

                -- Enable treesitter based indentation
                if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
            end

            local available_parsers = require('nvim-treesitter').get_available()

            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                    if vim.tbl_contains(installed_parsers, language) then
                        -- Enable the parser if it is already installed
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
                        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
                    else
                        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                        treesitter_try_attach(buf, language)
                    end
                end,
            })
        end
    },
    {
        "mfussenegger/nvim-lint",
        lazy = false,
        config = function()
            require('lint').linters_by_ft = {
                python = { 'ruff' },
                typescript = { 'eslint_d' },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    require('lint').try_lint()
                end
            })
        end,
    },
    {
        "saghen/blink.cmp",
        lazy = false,
        priority = 500,
        opts = {
            keymap = {
                preset = 'default',
                ['<TAB>'] = { 'select_and_accept' },
            },
            completion = {
                documentation = { auto_show = true }
            },
            sources = {
                providers = {
                    path = {
                        opts = {
                            show_hidden_files_by_default = true,
                        }
                    }
                }
            }
        },
        build = function() require('blink.cmp').build():pwait() end,
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        config = function()
            local ls = require("luasnip")
            ls.setup({
                -- Tell LuaSnip to force update dynamic nodes immediately on text changes
                -- updateevents = "TextChanged,TextChangedI",
            })

            require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
            require("luasnip").filetype_extend("typescript", { "javascript", "svelte" })

            vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
        keys = {

        },
        build = "make install_jsregexp",
    },
    {
        "stevearc/conform.nvim",
        config = function()
            local prettier = { "prettierd", "prettier", stop_after_first = true }
            require('conform').setup({
                formatters_by_ft = {
                    javascript = prettier,
                    typescript = prettier,
                    svelte = prettier,
                    lua = { "stylua" },
                    python = { "black" },
                    go = { "gofmt" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true, -- falls back to vim.lsp.buf.format if no conform formatter defined
                },
            })
        end,
    },
}
-- cmdline = {
--     enabled = true,
--     sources = function()
--         local type = vim.fn.getcmdtype()
--         -- Search forward and backward (/ and ?)
--         if type == '/' or type == '?' then return { 'buffer' } end
--         -- Commands (:)
--         if type == ':' then return { 'cmdline', 'path' } end
--         return {}
--     end
-- }
