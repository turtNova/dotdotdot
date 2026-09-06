return {
    {
        "neovim/nvim-lspconfig",
        priority = 5,
        lazy = false,
    },
    {
        "mason-org/mason.nvim",
        priority = 4,
        lazy = false,
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        priority = 3,
        opts = {
            ensure_installed = {
                'lua_ls',
                'html',
                'cssls',
                'roslyn_ls',
                'ts_ls',
                'pyright',
                'clangd',
                'rust_analyzer',
                'svelte',
                'pyright',
            }
        },
    },
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {},
    },
    {
        "lopi-py/luau-lsp.nvim",
        lazy = false,
        -- ft = "luau"
        opts = {
            types = {
                definition_files = {
                    ["@roblox"] = '/home/turt/Documents/Misc/globalTypes.d.luau'
                },
            },
            platform = {
                type = "roblox",
            },
            sourcemap = {
                enabled = true,
                autogenerate = true, -- automatic generation when the server is initialized
                rojo_project_file = "default.project.json",
                sourcemap_file = "sourcemap.json",
            },
            plugin = {
                enabled = true,
                port = 3667,
            },
            fflags = {
                enable_new_solver = true, -- enables the fflags required for luau's new type solver
                sync = true, -- sync currently enabled fflags with roblox's published fflags
                override = { -- override fflags passed to luau
                    LuauTableTypeMaximumStringifierLength = "100",
                },
            },
        },
    },
}
