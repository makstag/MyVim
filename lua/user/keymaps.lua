local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set("n", "<Leader>w", "<C-w>k")
vim.keymap.set("n", "<Leader>a", "<C-w>h")
vim.keymap.set("n", "<Leader>s", "<C-w>j")
vim.keymap.set("n", "<Leader>d", "<C-w>l")
vim.keymap.set("n", "<Leader>j", ":bprevious<CR>", opts)
vim.keymap.set("n", "<Leader>k", ":bnext<CR>", opts)
vim.keymap.set("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR>", opts)
vim.keymap.set("n", "<Leader>y", ":%y<CR>")
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "<Leader>l", ":vsplit term://zsh <CR>", opts)
vim.keymap.set("t", "<Leader><Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("n", "<Leader>v", ":edit ~/.config/nvim/init.lua<CR>", opts)

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

vim.keymap.set("n", "<C-r>", "<Cmd>NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<C-s>", "<Cmd>:w<CR>", opts)
vim.keymap.set("n", "<C-q>", "<Cmd>:q<CR>", opts)
vim.keymap.set("n", "<C-z>", "<Cmd>:u<CR>", opts)
vim.keymap.set("n", "<Leader>f", "<Cmd>Telescope find_files>CR>", opts)
