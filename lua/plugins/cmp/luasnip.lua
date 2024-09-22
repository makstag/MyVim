local ls = require("luasnip")
local types = require("luasnip.util.types")
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

-- If you're reading this file for the first time, best skip to around line 190
-- where the actual snippet-definitions start.

-- Every unspecified option will be set to the default.
ls.setup({
	keep_roots = true,
	link_roots = true,
	link_children = true,
	
	region_check_events = "InsertEnter",
	-- Update more often, :h events for more info.
	update_events = "TextChanged, TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
	ext_opts = {
	 	[types.choiceNode] = {
	 		active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
	store_selection_keys = "<Tab>",
	parser_nested_assembler = function(_, snippetNode)
		local select = function(snip, no_move, dry_run)
		    if dry_run then
		    return
		    end
		    snip:focus()
		    -- make sure the inner nodes will all shift to one side when the
		    -- entire text is replaced.
		    snip:subtree_set_rgrav(true)
		    -- fix own extmark-gravities, subtree_set_rgrav affects them as well.
		    snip.mark:set_rgravs(false, true)
		
		    -- SELECT all text inside the snippet.
		    if not no_move then
		    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		    node_util.select_node(snip)
		    end
		end
		
		local original_extmarks_valid = snippetNode.extmarks_valid
		function snippetNode:extmarks_valid()
		    -- the contents of this snippetNode are supposed to be deleted, and
		    -- we don't want the snippet to be considered invalid because of
		    -- that -> always return true.
		    return true
		end
		
		function snippetNode:init_dry_run_active(dry_run)
		    if dry_run and dry_run.active[self] == nil then
		    dry_run.active[self] = self.active
		    end
		end
		
		function snippetNode:is_active(dry_run)
		    return (not dry_run and self.active) or (dry_run and dry_run.active[self])
		end
		
		function snippetNode:jump_into(dir, no_move, dry_run)
		    self:init_dry_run_active(dry_run)
		    if self:is_active(dry_run) then
		    -- inside snippet, but not selected.
		    if dir == 1 then
		        self:input_leave(no_move, dry_run)
		        return self.next:jump_into(dir, no_move, dry_run)
		    else
		        select(self, no_move, dry_run)
		        return self
		    end
		    else
		    -- jumping in from outside snippet.
		    self:input_enter(no_move, dry_run)
		    if dir == 1 then
		        select(self, no_move, dry_run)
		        return self
		    else
		        return self.inner_last:jump_into(dir, no_move, dry_run)
		    end
		    end
		end
		
		-- this is called only if the snippet is currently selected.
		function snippetNode:jump_from(dir, no_move, dry_run)
		    if dir == 1 then
		    if original_extmarks_valid(snippetNode) then
		        return self.inner_first:jump_into(dir, no_move, dry_run)
		    else
		        return self.next:jump_into(dir, no_move, dry_run)
		    end
		    else
		    self:input_leave(no_move, dry_run)
		    return self.prev:jump_into(dir, no_move, dry_run)
		    end
		end
		
		return snippetNode
	end,
	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end
})

vim.tbl_map(
      function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
      { "vscode", "snipmate", "lua" }
)

ls.filetype_extend("c", { "cdoc" })
ls.filetype_extend("cpp", { "cppdoc" })
ls.filetype_extend("make", { "make" })
