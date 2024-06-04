local sidebar = "coc-explorer"
require "bufferline".setup {
    options = {
        offsets = {
            {
                filetype = sidebar,
                highlight = "Directory",
                text_align = "center"
            }
        },
        left_mouse_command = function(bufnr)
            if vim.bo.filetype ~= sidebar then
                vim.cmd("buffer " .. bufnr)
            end
        end,
        middle_mouse_command = function(bufnr)
            require "bufdelete".bufdelete(bufnr, true)
        end,
    },
}