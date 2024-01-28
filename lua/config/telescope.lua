local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local function nkeymap(key, map)
	keymap("n", key, map, opts)
end
local function vkeymap(key, map)
	keymap("v", key, map, opts)
end
local function ikeymap(key, map)
	keymap("i", key, map, opts)
end

local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers" 
local action_state = require "telescope.actions.state" 
local conf = require "telescope.config".values
local builtin = require "telescope.builtin"

local telescope = require "telescope"

nkeymap("<C-f>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nkeymap("<C-g>", "<cmd>lua require('telescope.builtin').git_files()<cr>") -- fast than find files when in git repo

vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
nkeymap("<leader>f1", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>")
nkeymap("<leader>f2", "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<cr>")
nkeymap("<leader>f3", "<cmd>lua require('telescope.builtin').find_files({hidden=true, no_ignore=true})<cr>")
nkeymap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nkeymap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")

-- see https://www.reddit.com/r/neovim/comments/oli7fb/permanent_recent_files_using_telescope/
-- only keeps track of the opened files in the current session.
-- nkeymap("<C-p>", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
nkeymap("<leader>fh", ":<cmd>Telescope<CR>")

-- lsp
nkeymap("<leader>ff", "<cmd>Telescope lsp_document_symbols<cr>")

-- frecency
vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope frecency<CR>", opts)

-- TODO
nkeymap("<leader>fd", ":TodoTelescope<cr>")

-- history command
nkeymap("<leader>fc", "<cmd>Telescope command_history<CR>")

-- jumps list
nkeymap("<leader>fj", "<cmd>lua require('telescope.builtin').jumplist()<cr>")

telescope.setup
{
	defaults = 
	{

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = 
		{
			i = 
			{
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-h>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = 
			{
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = 
	{
                find_files = { hidden = true }
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = 
	{
		-- see https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
		["fzf"] = 
		{
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		["ui-select"] =
		{
		    require("telescope.themes").get_dropdown{}
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
               --   codeactions = false,
               -- }
		}
	},
	-- builtin configs
	builtin = { git_branches = {} }
}

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
