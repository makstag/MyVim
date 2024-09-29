return
{
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = false,
				java = false,
				
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = false
			},
			prompt_func_param_type = {
				go = false,
				java = false,
				
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = false
			},
			printf_statements = {
				cpp = { 'std::cout << "%s" << "\n";' }
			},
			print_var_statements = {
				cpp = { 'printf("a custom statement %%s %s", %s);' }
			},
			extract_var_statements = {
				cpp = "%s = %s // poggers"
			},
			show_success_message = true  -- shows a message with information about the refactor on success
			                             -- i.e. [Refactor] Inlined 3 variable occurrences
		})
		
		local nm = require("utils.alias").nm
		local xm = require("utils.alias").xm
		
		xm("<space>re", ":Refactor extract ", "")
		xm("<space>rf", ":Refactor extract_to_file ", "")
		
		xm("<space>rv", ":Refactor extract_var ", "")
		
		vim.keymap.set({ "n", "x" }, "<space>ri", ":Refactor inline_var", { noremap = true, silent = true, desc = "" })
		
		nm("<space>rI", ":Refactor inline_func", "")
		
		nm("<space>rb", ":Refactor extract_block", "")
		nm("<space>rbf", ":Refactor extract_block_to_file", "")
		
		--debug
		-- You can also use below = true here to to change the position of the printf
		-- statement (or set two remaps for either one). This remap must be made in normal mode.
		nm("<space>rp",	function() require("refactoring").debug.printf({ below = false }) end, "")
		
		-- Print var
		
		vim.keymap.set({"x", "n"}, "<space>rv", function() require("refactoring").debug.print_var() end, { noremap = true, silent = true, desc = "" })
		-- Supports both visual and normal mode
		
		nm("<space>rc", function() require("refactoring").debug.cleanup() end, "")
		-- Supports only normal mode
	end
}