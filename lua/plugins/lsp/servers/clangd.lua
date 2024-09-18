local h = require "plugins.lsp.handler"
local clangd_ext_handler = require "lsp-status".extensions.clangd.setup {}
local ls = require "luasnip"
local s = ls.snippet
local r = ls.restore_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

lspsnips = {}

return function(on_attach)
    return 
    {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = false
		 client.server_capabilities.document_range_formatting = false

            local orig_rpc_request = client.rpc.request
            function client.rpc.request(method, params, handler, ...)
                local orig_handler = handler
                if method == "textDocument/completion" then
                    -- Idiotic take on <https://github.com/fannheyward/coc-pyright/blob/6a091180a076ec80b23d5fc46e4bc27d4e6b59fb/src/index.ts#L90-L107>.
                    handler = function(...)
                        local err, result = ...
                        if not err and result then
                            local items = result.items or result
                            for _, item in ipairs(items) do
                                -- override snippets for kind `field`, matching the snippets for member initializer lists.
                                if item.kind == vim.lsp.protocol.CompletionItemKind.Field and item.textEdit.newText:match("^[%w_]+%(${%d+:[%w_]+}%)$") then
						    local snip_text = item.textEdit.newText
						    local name = snip_text:match("^[%w_]+")
						    local type = snip_text:match("%{%d+:([%w_]+)%}")
						    -- the snippet is stored in a separate table. It is not stored in the `item` passed to
						    -- cmp, because it will be copied there and cmps [copy](https://github.com/hrsh7th/nvim-cmp/blob/ac476e05df2aab9f64cdd70b6eca0300785bb35d/lua/cmp/utils/misc.lua#L125-L143) doesn't account
						    -- for self-referential tables and metatables (rightfully so, a response from lsp
						    -- would contain neither), both of which are vital for a snippet.
						    lspsnips[snip_text] = s("", {
						        t(name),
							   c(1, {
							       -- use a restoreNode to remember the text typed here.
								  {t"(", r(1, "type", i(1, type)), t")"},
								  {t"{", r(1, "type"), t"}"},
							   }, {restore_cursor = true})
						    })
						end
                            end
                        end
                        return orig_handler(...)
                    end
                end
                return orig_rpc_request(method, params, handler, ...)
            end
        end,
        cmd = {
            "clangd",
            "--background-index",
	       "-j=12",
	       "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
	       "--clang-tidy",
	       "--clang-tidy-checks=*",
	       "--all-scopes-completion",
	       "--cross-file-rename",
	       "--completion-style=detailed",
	       "--header-insertion-decorators",
	       "--header-insertion=iwyu",
	       "--pch-storage=memory"
	   },
	   handlers = h.with { clangd_ext_handler },
	   filetypes = { "c", "cpp", "cuda", "proto", "cc" },
	   init_options = {
		  clangdFileStatus = true,
		  usePlaceholders = true,
		  completeUnimported = true,
		  semanticHighlightings = true
        }
    }
end
