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
		nm("<leader>e", "<CMD>Neotree toggle<CR>")
		nm("<leader>r", "<CMD>Neotree focus<CR>")
	end
}