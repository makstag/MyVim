return 
{
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
		}
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				-- see https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
				["fzf"] = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case" -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				["ui-select"] =	{
				    require("telescope.themes").get_dropdown()
				    -- pseudo code / specification for writing custom displays, like the one
		               -- for "codeactions"
		               -- specific_opts = {
		               --   [kind] = {
		               --     make_indexed = function(items) -> indexed_items, width,
		               --     make_displayer = function(widths) -> displayer
		               --     make_display = function(displayer) -> function(e)
		               --     make_ordinal = function(e) -> string
		               --   },
		               --   -- for example to disable the custom builtin "codeactions" display
		               --      do the following
		               --   codeactions = false
		               -- }
				}
			},
			-- builtin configs
			builtin = { git_branches = {} }
		})
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		local nm = require("utils.alias").nm		
		nm("<space>ff", "<cmd>Telescope find_files<cr>", "")
		nm("<space>fg", "<cmd>Telescope live_grep<cr>", "")
		nm("<space>fb", "<cmd>Telescope buffers<cr>", "")
		nm("<space>fs", "<cmd>Telescope git_status<cr>", "")
		nm("<space>fc", "<cmd>Telescope git commits<cr>", "")
	end
}