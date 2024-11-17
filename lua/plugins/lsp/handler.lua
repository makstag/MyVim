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
        virtual_text = true,  -- appears after the line
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
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    local autocmds = vim.api.nvim_clear_autocmds

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        augroup("__lsp_document_highlight__", { clear = true })
        autocmds({ buffer = bufnr, group = "__lsp_document_highlight__" })
        autocmd("CursorHold", 
        {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "__lsp_document_highlight__",
            desc = "Document Highlight"
        })
        autocmd("CursorMoved", 
        {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "__lsp_document_highlight__",
            desc = "Clear All the References"
        })
    end

    autocmd({"TextChangedI", "TextChangedP"},
    {
        callback = function()
	    local line = vim.api.nvim_get_current_line()
	    local cursor = vim.api.nvim_win_get_cursor(0)[2]

	    local current = string.sub(line, cursor, cursor + 1)
	    local after_line = string.sub(line, cursor + 1, -1)
	    if after_line == "" and current == "#" then
                require("cmp").complete() 
            end                	
        end,
        pattern = "*"
    })
    augroup("__formatter__", { clear = true })
    autocmd("BufWritePost", {
        group = "__formatter__",
        callback = function()
        vim.cmd("FormatWrite")
        end,
        pattern = "*"
    })
    augroup("__lint__", { clear = true })
    autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = "__lint__",
        callback = function()
            require("lint").try_lint()
        end
    })
end

local function lsp_keymaps(bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local function opts(description)
		return { noremap = true, silent = true, desc = description }
    end
    local lb = vim.lsp.buf
    
    map(bufnr, "n", "gD", "<cmd>lua lb.declaration()<cr>", opts("gD go to the function declaration"))
    map(bufnr, "n", "gd", "<cmd>lua lb.definition()<cr>", opts("gd go to the function definition"))
    map(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts("K show documentation"))
    map(bufnr, "n", "gi", "<cmd>lua lb.implementation()<cr>", opts("gi lists all the implementations for the symbol under the cursor in the quickfix window"))
    map(bufnr, "n", "<space>[", "<cmd>lua lb.signature_help()<cr>", opts("<space>[ displays signature information about the symbol under the cursor in a floating window"))

    map(bufnr, "n", "<space>rn", "<cmd>Lspsaga rename<cr>", opts("<space>rn rename"))
    map(bufnr, "n", "gr", "<cmd>lua lb.references()<cr>", opts("gr lists all the references to the symbol under the cursor in the quickfix window"))
    map(bufnr, "n", "<space>ga", "<cmd>Lspsaga code_action<cr>", opts("<space>ga perform a specific action for a section of code"))
    map(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts("gl show line diagnostic"))
    map(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts("[g  to jump prev diagnostics"))
    map(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts("]g  to jump next diagnostics"))
    
    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    map(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<cr>", opts("gh find the symbol definition implement reference"))
    map(bufnr, "n", "<space>cd", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts("<space>cd show cursor diagnostics"))

    -- Only jump to error
    map(
        bufnr, 
        "n", 
        "[E",
        "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
        opts("[E to jump prev over error with specific severity diagnostic")
    )
    map(
        bufnr, 
        "n", 
        "]E", 
        "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
        opts("]E to jump next over error with specific severity diagnostic")
    )

    map(bufnr, "n","<space>o", "<cmd>Lspsaga outline<cr>", opts("<space>o show outline current file"))
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    map(bufnr, "n", "<A-d>", "<cmd>Lspsaga term_toggle lazygit<cr>", opts("<A-d> open lazygit in float terminal"))

    map(bufnr, "n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts("<space>q Add buffer diagnostics to the location list"))

    map(
        bufnr,
        "n",
        "<C-u>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>",
        opts("<C-u> scroll down")
    )
    map(
        bufnr,
        "n",
        "<C-d>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>",
        opts("<C-d> scroll up")
    )

    vim.cmd [[ command! Format execute "lua lb.format({ async = true })" ]]
end

local lsp_signature = require("lsp_signature")

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
    
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    
    lsp_signature.on_attach({
	bind = true,
	hint_enable = false,
	hint_inline = function() return "eol" end,
	hi_parameter = "LspSignatureActiveParameter",
	handler_opts = { border = "shadow" },
	always_trigger = false, 
	timer_interval = 500
    })
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
