local cpp = require("plugins.cmp.snippets.cpp")
local asm = require("plugins.cmp.snippets.asm")
local cmake = require("plugins.cmp.snippets.cmake")

local ls = require("luasnip")

ls.add_snippets("cpp", cpp)
ls.add_snippets("asm", asm)
ls.add_snippets("cmake", cmake)