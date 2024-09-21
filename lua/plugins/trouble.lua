return 
{
	"folke/trouble.nvim",
	cmd = "Trouble",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			modes = {
				diagnostics = {
					auto_open = false,
					auto_close = true,
				}
			},
			warn_no_results = false,
			-- stylua: ignore
			icons = require("utils.icons").trouble
		})
	end,
	keys = {
		{
			"<space>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)"
		},
		{
			"<space>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)"
		},
		{
			"<space>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)"
		},
		{
			"<space>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)"
		},
		{
			"<space>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)"
		},
		{
			"<space>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)"
		}
	}
}