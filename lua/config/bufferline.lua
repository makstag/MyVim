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
local map = function(key, bufnr)
    local fn = function()
        if vim.bo.filetype ~= sidebar then
            require "bufferline".go_to_buffer(bufnr, true)
        end
    end

    vim.keymap.set("n", key, fn, { silent = true })
end
map("<M-1>", 1)
map("<M-2>", 2)
map("<M-3>", 3)
map("<M-4>", 4)
map("<M-5>", 5)
map("<M-6>", 6)
map("<M-7>", 7)
map("<M-8>", 8)
map("<M-9>", 9)
map("<M-0>", -1)
vim.cmd [[ nnoremap <silent> <leader>q :Bdelete<CR>]]