local nm = require("utils.alias").nm
local vm = require("utils.alias").vm
local tm = require("utils.alias").tm
local xm = require("utils.alias").xm

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

nm("<C-k>", "<C-w>k", "<C-k> go to the up window")
nm("<C-h>", "<C-w>h", "<C-h> go to the left window")
nm("<C-j>", "<C-w>j", "<C-j> go to the down window")
nm("<C-l>", "<C-w>l", "<C-l> go to the right window")
nm("<space>j", "<cmd>:bprevious<cr>", "<space>j go to the previous tab")
nm("<space>k", "<cmd>:bnext<cr>", "<space>k go to the next tab")
nm("<space>q", "<cmd>:bprevious<cr>:bdelete #<cr>", "<space>q go to the previous tab and close current")
nm("<space>y", "<cmd>:%y<cr>", "<space>y copy all lines in the file")
nm("<C-t>", "<cmd>:23split term://zsh<cr>", "<C-t> open terminal in normal mode")
tm("<Esc>", "<C-\\><C-n>", "<Esc> close terminal mode in terminal")
nm("<space>v", "<cmd>:edit ~/.config/nvim/init.lua<cr>", "<space>v open config neovim file")

nm("<C-s>", "<cmd>:w<cr>", "<C-s> save file")
nm("<C-q>", "<cmd>:q<cr>", "<C-q> quit file")
nm("<C-a>", "<cmd>:qa!<cr>", "<C-a> quit all files and don't saves")
nm("<C-z>", "<cmd>:u<cr>", "<C-z> cancel operations")

-- Edit Operation
xm("<space>p", '"_dP', "<space>p replace without yanking")
nm("<space>d", '"_d', "<space>d delete without yanking") -- e.g <leader>dd deletes the current line without yanking it
nm("<space>D", '"_D', "<space>D delete until EOL without yanking")
nm("<space>c", '"_c', "<space>c change without yanking")
nm("<space>C", '"_C', "<space>C change until EOL without yanking")

nm("<C-y>", '"+y', "<C-y> copy in normal mode")
vm("<C-y>", '"+y', "<C-y> copy in visual mode")
nm("<C-p>", '"+p', "<C-p> paste in normal mode")
vm("<C-p>", '"+p', "<C-p> paste in visual mode")

-- Resize Windows
nm("<C-Left>", "<C-w><", "<C-Left> increase the window size to the left")
nm("<C-Right>", "<C-w>>", "<C-Right> increase the window size to the right")
nm("<C-Up>", "<C-w>+", "<C-Up> increase the window size to the up")
nm("<C-Down>", "<C-w>-", "<C-Down> increase the window size to the down")
