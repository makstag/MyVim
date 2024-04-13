local ft = require "guard.filetype"

-- Assuming you have guard-collection
ft("c, cpp"):fmt("clang-format")
       :lint("clang-tidy")

ft("lua"):fmt("stylua")

-- Call setup() LAST!
require "guard".setup
{
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
}