return 
{
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim"
	},
	config = function()
		local nm = require("utils.alias").nm
		
		-- NeoTree
		nm("<C-r>", "<cmd>Neotree toggle<cr>")
		nm("<space>r", "<cmd>Neotree focus<cr>")
	end
}