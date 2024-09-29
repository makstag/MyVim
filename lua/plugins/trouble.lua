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
		
		local nm = require("utils.alias").nm
		nm("<space>xx", "<cmd>Trouble diagnostics toggle<cr>", "")
		nm("<space>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "")
		nm("<space>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "")
		nm("<space>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "")
		nm("<space>xL", "<cmd>Trouble loclist toggle<cr>", "")
		nm("<space>xQ", "<cmd>Trouble qflist toggle<cr>", "")
	end
}