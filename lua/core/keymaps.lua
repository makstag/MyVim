local nm = require("utils.alias").nm
local vm = require("utils.alias").vm
local tm = require("utils.alias").tm

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

nm("<C-k>", "<C-w>k", "go to the down window")
nm("<C-h>", "<C-w>h", "go to the left window")
nm("<C-j>", "<C-w>j", "go to the up window")
nm("<C-l>", "<C-w>l", "go to the right window")
nm("<space>j", "<cmd>:bprevious<cr>", "go to the previous tab")
nm("<space>k", "<cmd>:bnext<cr>", "go to the next tab")
nm("<space>q", "<cmd>:bprevious<cr>:bdelete #<cr>", "go to the previous tab and close current")
nm("<space>y", "<cmd>:%y<cr>", "copy all lines in the file")
nm("<C-t>", "<cmd>:25split term://zsh <cr>", "open terminal in normal mode")
tm("<Esc>", "<C-\\><C-n>", "close insert mode in terminal")
nm("<space>v", "<cmd>:edit ~/.config/nvim/init.lua<cr>", "open config neovim file")

nm("<C-s>", "<cmd>:w<cr>", "save file")
nm("<C-q>", "<cmd>:q<cr>", "quit file")
nm("<C-a>", "<cmd>:qa!<cr>", "quit all files and don't saves")
nm("<C-z>", "<cmd>:u<cr>", "cancel operations")

-- Copy - Paste
nm("<C-y>", "<cmd>:+y<cr>", "copy in normal mode")
vm("<C-y>", "<cmd>:+y<cr>", "copy in visual mode")
nm("<C-p>", "<cmd>:+gP<cr>", "paste in normal mode")
vm("<C-p>", "<cmd>:+gP<cr>", "paste in visual mode")

-- Resize Windows
nm("<C-Left>", "<C-w><", "increase the window size to the left")
nm("<C-Right>", "<C-w>>", "increase the window size to the right")
nm("<C-Up>", "<C-w>+", "increase the window size to the up")
nm("<C-Down>", "<C-w>-", "increase the window size to the down")