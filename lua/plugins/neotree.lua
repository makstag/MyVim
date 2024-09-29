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
		require("neo-tree").setup({
			popup_border_style = "rounded",
			window = {
				mappings = {
					["<s-Tab>"] = "prev_source",
					["<Tab>"] = "next_source"
				},
			},
			source_selector = {
			    winbar = true,
			    sources = {
			        { source = "filesystem" },
			        { source = "buffers" },
			        { source = "document_symbols" },
			    }
			},
			default_component_configs = {
			    name = { highlight_opened_files = "all" }
			},
			sources = {
			    "filesystem",
			    "buffers",
			    "document_symbols",
			},
			buffers = { bind_to_cwd = false	},
			filesystem = {
			    filtered_items = {
			        visible = true,
			        hide_gitignored = false,
			        hide_hidden = false,
			        hide_dotfiles = false,
			    },
			    follow_current_file = {
			        enabled = true,
			        leave_dirs_open = true
			    }
			}
		})

		local nm = require("utils.alias").nm
		
		-- NeoTree
		nm("<C-r>", "<cmd>Neotree toggle<cr>", "<C-r> open/close tree. switch to panel <TAB>, <S-TAB>")
		nm("<space>r", "<cmd>Neotree focus<cr>", "<space>r open tree")
	end
}