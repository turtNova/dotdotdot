-- for f in readdir(expand('%:h'), { v -> v =~ '.json$' })
-- let name = fnamemodify(f, ':r:r')
-- let t = printf('%s = script.%s,', name, name)
-- call append(line('.'), t)
-- endfor
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local function file_to_event(format)
    local path = vim.fn.expand('%:p:h')
    local lines = {}

    local handle = vim.uv.fs_scandir(path)
    if handle then
        while true do
            local name, type = vim.uv.fs_scandir_next(handle)
            if not name then break end

            if type == "file" and name:match("%.json$") then
                local clean = name:gsub("%.model%.json$", "")
                local line = string.format(format, clean, clean)
                table.insert(lines, line)
            end
        end
    end

    return lines
end

local function filename_to_module()
    local name = vim.fn.expand('%:t:r')

    local lines = {
        "--!strict",
        "local " .. name .. " = {}",
        "",
        "return " .. name,
    }

    return lines
end

return {
    s("evt", {
        c(1, {
            f(function() return file_to_event("%s = script.%s,") end, {}),
            f(function() return file_to_event("%s: RemoteEvent,") end, {}),
        }),
    }),
    s("mod", {
        f(filename_to_module)
    })
}
