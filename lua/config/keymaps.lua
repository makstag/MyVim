local opts = { noremap = true, silent = true }
local km = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
km.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

km.set("n", "<C-k>", "<C-w>k")
km.set("n", "<C-h>", "<C-w>h")
km.set("n", "<C-j>", "<C-w>j")
km.set("n", "<C-l>", "<C-w>l")
km.set("n", "<Leader>j", ":bprevious<CR>", opts)
km.set("n", "<Leader>k", ":bnext<CR>", opts)
km.set("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR>", opts)
km.set("n", "<Leader>y", ":%y<CR>")
km.set("n", "k", "gk", opts)
km.set("n", "j", "gj", opts)
km.set("n", "<Leader>l", ":vsplit term://zsh <CR>", opts)
km.set("t", "<Leader><Esc>", "<C-\\><C-n>", opts)
km.set("n", "<Leader>v", ":edit ~/.config/nvim/init.lua<CR>", opts)

local lang_maps = {
	cpp = { build = "g++ % -o %:r", exec = "./%:r" },
	typescript = { exec = "bun %" },
	javascript = { exec = "bun %" },
	python = { exec = "python %" },
	java = { build = "javac %", exec = "java %:r" },
	sh = { exec = "./%" },
	go = { build = "go build", exec = "go run %" },
	rust = { exec = "cargo run" },
}
for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
		)
	end
	vim.api.nvim_create_autocmd(
		"FileType",
		{ command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
	)
end

km.set("n", "<C-r>", "<Cmd>NvimTreeToggle<CR>", opts)
km.set("n", "<C-s>", "<Cmd>:w<CR>", opts)
km.set("n", "<C-q>", "<Cmd>:q<CR>", opts)
km.set("n", "<C-z>", "<Cmd>:u<CR>", opts)

-- Copy - Paste
km.set("n", "<C-y>", "<Cmd>:+y<CR>", opts)
km.set("v", "<C-y>", "<Cmd>:+y<CR>", opts)
km.set("n", "<C-p>", "<Cmd>:+gP<CR>", opts)
km.set("v", "<C-p>", "<Cmd>:+gP<CR>", opts)
