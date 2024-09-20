local icons = require("utils.icons")
local M = {}

M.with = function(handlers)
    local h = {}
    for _, handler in ipairs(handlers) do
        h = vim.tbl_extend("keep", h, handler)
    end
    return h
end

M.setup = function()
    local define = vim.fn.sign_define
    define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = icons.diagnostics.error, numhl = "" })
    define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = icons.diagnostics.warning, numhl = "" })
    define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = icons.diagnostics.hint, numhl = "" })
    define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = icons.diagnostics.information, numhl = "" })

    local config = {
        virtual_text = false,  -- appears after the line
        virtual_lines = true, -- appears under the line
        signs = { active = signs },
        flags = { debounce_text_changes = 200 },
        update_in_insert = false, -- when insert, don't show diagnostic
        underline = true, -- it is annoying me!!!
        severity_sort = true,
        float = {
            focus = false,
            focusable = false,
            style = "minimal",
            border = "shadow",
            source = "always",
            header = "",
            prefix = ""
        }
    }
    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { "shadow" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { "shadow" })
end

local function lsp_highlight_document(client, bufnr)
    local api = vim.api

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        api.nvim_create_autocmd("CursorHold", 
        {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight"
        })
        api.nvim_create_autocmd("CursorMoved", 
        {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References"
        })
        api.nvim_create_autocmd({"TextChangedI", "TextChangedP"},
        {
            callback = function()
                local line = vim.api.nvim_get_current_line()
                local cursor = vim.api.nvim_win_get_cursor(0)[2]

                local current = string.sub(line, cursor, cursor + 1)
                if current == "." or current == "," or current == " " then
                		require("cmp").close() 
                	end
                	
                	local before_line = string.sub(line, 1, cursor + 1)
			local after_line = string.sub(line, cursor + 1, -1)
			if not string.match(before_line, "^%s+$") then
				if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
					require("cmp").complete()
				end
			end
            end,
            pattern = "*"
        })
    end
end

local function lsp_keymaps(bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local opts = { noremap = true, silent = true }
    local lb = vim.lsp.buf
    
    map(bufnr, "n", "gD", "<cmd>lua lb.declaration()<cr>", opts)
    map(bufnr, "n", "gd", "<cmd>lua lb.definition()<cr>", opts)
    map(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
    map(bufnr, "n", "gi", "<cmd>lua lb.implementation()<cr>", opts)
    map(bufnr, "n", "<leader>[", "<cmd>lua lb.signature_help()<cr>", opts)

    map(bufnr, "n", "<space>rn", "<cmd>Lspsaga rename<cr>", opts)
    map(bufnr, "n", "gr", "<cmd>lua lb.references()<cr>", opts)
    map(bufnr, "n", "<space>ga", "<cmd>Lspsaga code_action<cr>", opts)
    map(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    map(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    map(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)

    local ft = vim.bo[bufnr].filetype
    if ft == "sh" or ft == "lua" then
        map(bufnr, "n", "<leader>li", function()
            local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
            local msgs = vim.diagnostic.get(bufnr)
            local last, result = unpack({ "error", "" })
            if ft == "lua" then
                result = "---@diagnostic disable-next-line"
            else
                for _, d in pairs(msgs) do
                    if d.lnum == (row - 1) and d.code ~= last then
                        result = (result ~= "") and result .. "," .. d.code or "#shellcheck disable=" .. d.code
                        last = tostring(d.code)
                    end
                end
            end
            if result ~= "" then
                vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { result })
            end
        end, opts)
    end
    
    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    map(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<cr>", opts)
    map(bufnr, "n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)

    -- Only jump to error
    map(
        bufnr, 
        "n", 
        "[E",
        "<cmd>lua require('lspsaga.diagnostic').goto_prev { severity = vim.diagnostic.severity.ERROR }<cr>",
        opts
    )
    map(
        bufnr, 
        "n", 
        "]E", 
        "<cmd>lua require('lspsaga.diagnostic').goto_next { severity = vim.diagnostic.severity.ERROR }<cr>",
        opts
    )

    map(bufnr, "n","<space>o", "<cmd>Lspsaga outline<cr>", opts)
    map(bufnr, "n", "<A-d>", "<cmd>Lspsaga open_floaterm<cr>", opts)
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    -- map(bufnr, "n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<cr>", opts)
    -- close floaterm
    map(bufnr, "t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<cr>]], opts)

    map(bufnr, "n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)

    map(
        bufnr,
        "n",
        "<C-u>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>",
        opts
    )
    map(
        bufnr,
        "n",
        "<C-d>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>",
        opts
    )

    vim.cmd [[ command! Format execute "lua lb.format({async = true })" ]]
end

local lsp_signature = require("lsp_signature")

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
    
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    
    lsp_signature.on_attach({ floating_window = false, timer_interval = 500 })
end

local capabilities = require("plugins.lsp.capability")
local cmp = require("cmp_nvim_lsp")

-- See :h deprecated
-- update_capabilities is deprecated, use default_capabilities instead.
M.capabilities = cmp.default_capabilities(capabilities)
M.capabilities.textDocument.semanticHighlighting = true
M.capabilities.offsetEncoding = "utf-8"

M.lspsnips = {}

return M
