return 
{
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" }
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true
			},
			attach_to_untracked = true,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local nm = require("utils.alias").nm
				
				-- Navigation
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then return "]c" end
					vim.schedule(function() gs.next_hunk() end)
					return "<Ignore>"
				end, { expr=true, desc = ""})
				
				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then return "[c" end
					vim.schedule(function() gs.prev_hunk() end)
					return "<Ignore>"
				end, { expr=true, desc = ""})
				
				-- Actions
				vim.keymap.set({ "n", "v" }, "<space>hs", ":Gitsigns stage_hunk<CR>", {  noremap = true, silent = true, desc = "" })
				vim.keymap.set({ "n", "v" }, "<space>hr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "" })
				nm("<space>hS", gs.stage_buffer, "")
				nm("<space>ha", gs.stage_hunk, "")
				nm("<space>hu", gs.undo_stage_hunk, "")
				nm("<space>hR", gs.reset_buffer, "")
				nm("<space>hp", gs.preview_hunk, "")
				nm("<space>hb", function() gs.blame_line{full=true} end, "")
				nm("<space>tB", gs.toggle_current_line_blame, "")
				nm("<space>hd", gs.diffthis, "")
				nm("<space>hD", function() gs.diffthis("~") end, "")
				
				-- Text object
				vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { noremap = true, silent = true, desc = "" })
			end
		})
	end
}
