local ls = require "luasnip"

-- My added snippets
-- see https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders

require "luasnip.loaders.from_lua".load { paths = "~/.config/nvim/snippets/" }
require "luasnip".config.setup { store_selection_keys = "<A-p>" }

vim.cmd([[command! LuaSnipEdit :lua require "luasnip.loaders.from_lua".edit_snippet_files()]])

local types = require "luasnip.util.types"
ls.config.set_config
{
	history = false, -- keep around last snippet local to jump back
	updateevents = "TextChanged, TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts = 
	{
		[types.choiceNode] = { active = { virt_text = { { "●", "GruvboxOrange" } }	} }
	},
}

-- More Settings --

vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])

-- leave current close the jump session.
function leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
    then
        ls.unlink_current()
    end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[autocmd ModeChanged * lua leave_snippet()]])
