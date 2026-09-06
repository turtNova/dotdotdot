local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("anon", fmt([[
    ({}) => {{{}}}
    ]], {
            c(1, {
                i(nil, 'params'),
                t('')
            }),
            i(0),
        })
    )
}
