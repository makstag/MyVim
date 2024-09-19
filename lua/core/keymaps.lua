local alias = require("utils.alias")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

alias.nm("<C-k>", "<C-w>k")
alias.nm("<C-h>", "<C-w>h")
alias.nm("<C-j>", "<C-w>j")
alias.nm("<C-l>", "<C-w>l")
alias.nm("<leader>j", "<cmd>:bprevious<cr>")
alias.nm("<leader>k", "<cmd>:bnext<cr>")
alias.nm("<leader>q", "<cmd>:bprevious<cr>:bdelete #<cr>")
alias.nm("<leader>y", "<cmd>:%y<cr>")
alias.nm("<leader>l", "<cmd>:vsplit term://zsh <cr>")
alias.tm("<leader><Esc>", "<C-\\><C-n>")
alias.nm("<leader>v", "<cmd>:edit ~/.config/nvim/init.lua<cr>")

alias.nm("<C-s>", "<cmd>:w<cr>")
alias.nm("<C-q>", "<cmd>:q<cr>")
alias.nm("<C-a>", "<cmd>:qa!<cr>")
alias.nm("<C-z>", "<cmd>:u<cr>")

-- Copy - Paste
alias.nm("<C-y>", "<cmd>:+y<cr>")
alias.vm("<C-y>", "<cmd>:+y<cr>")
alias.nm("<C-p>", "<cmd>:+gP<cr>")
alias.vm("<C-p>", "<cmd>:+gP<cr>")

-- Resize Windows
alias.nm("<C-Left>", "<C-w><")
alias.nm("<C-Right>", "<C-w>>")
alias.nm("<C-Up>", "<C-w>+")
alias.nm("<C-Down>", "<C-w>-")
