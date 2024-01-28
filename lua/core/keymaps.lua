local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
keymap({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<leader>j", "<Cmd>:bprevious<CR>", opts)
keymap("n", "<leader>k", "<Cmd>:bnext<CR>", opts)
keymap("n", "<leader>q", "<Cmd>:bprevious<CR>:bdelete #<CR>", opts)
keymap("n", "<leader>y", "<Cmd>:%y<CR>")
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)
keymap("n", "<leader>l", "<Cmd>:vsplit term://zsh <CR>", opts)
keymap("t", "<leader><Esc>", "<C-\\><C-n>", opts)
keymap("n", "<leader>v", "<Cmd>:edit ~/.config/nvim/init.lua<CR>", opts)

keymap("n", "<C-r>", "<Cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<C-s>", "<Cmd>:w<CR>", opts)
keymap("n", "<C-q>", "<Cmd>:q<CR>", opts)
keymap("n", "<C-a>", "<Cmd>:qa<CR>", opts)
keymap("n", "<C-z>", "<Cmd>:u<CR>", opts)

-- Copy - Paste
keymap("n", "<C-y>", "<Cmd>:+y<CR>", opts)
keymap("v", "<C-y>", "<Cmd>:+y<CR>", opts)
keymap("n", "<C-p>", "<Cmd>:+gP<CR>", opts)
keymap("v", "<C-p>", "<Cmd>:+gP<CR>", opts)
