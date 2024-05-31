local M = {}

M.with = function(handlers)
    local _handlers = {}
    for _, handler in ipairs(handlers) do
        _handlers = vim.tbl_extend("keep", _handlers, handler)
    end
    return _handlers
end

-- TODO: backfill this to template
M.setup = function()
    local signs = 
    {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = 
    {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = 
        {
            active = signs,
        },
        update_in_insert = false, -- when insert, don't show diagnostic
        underline = true, -- it is annoying me!!!
        severity_sort = true,
        float = 
        {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }
    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, 
    {
        border = "rounded",
        width = 60
    })
end

local function lsp_highlight_document(client, bufnr)
    local api = vim.api

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
        api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
        api.nvim_create_autocmd("CursorHold", 
        {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
        api.nvim_create_autocmd("TermOpen", {
            callback = function()
                -- disable line numbers
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                -- always start in insert mode
                vim.cmd("stopinsert")
            end,
            pattern = "*"
        })
        api.nvim_create_autocmd(
            {"TextChangedI", "TextChangedP"},
            {
                callback = function()
                local line = vim.api.nvim_get_current_line()
                local cursor = vim.api.nvim_win_get_cursor(0)[2]

                local current = string.sub(line, cursor, cursor + 1)
                if after_line == "" or current == "#" then
                    require "cmp".complete()
                end
            end,
            pattern = "*"
        })
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)

    -- replaced by lspsaga.nvim:A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI.
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>[", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ga", "<cmd>Lspsaga code_action<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
    
    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)

    -- Only jump to error
    vim.api.nvim_buf_set_keymap(
        bufnr, 
        "n", 
        "[E",
        "<cmd>lua require 'lspsaga.diagnostic'.goto_prev { severity = vim.diagnostic.severity.ERROR }<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr, 
        "n", 
        "]E", 
        "<cmd>lua require 'lspsaga.diagnostic'.goto_next { severity = vim.diagnostic.severity.ERROR }<cr>",
        opts
    )

    vim.api.nvim_buf_set_keymap(bufnr, "n","<leader>o", "<cmd>Lspsaga outline<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-d>", "<cmd>Lspsaga open_floaterm<cr>", opts)
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<cr>", opts)
    -- close floaterm
    vim.api.nvim_buf_set_keymap(bufnr, "t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<cr>]], opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<C-u>",
        "<cmd>lua require 'lspsaga.action'.smart_scroll_with_saga(-1, '<c-u>')<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<C-d>",
        "<cmd>lua require 'lspsaga.action'.smart_scroll_with_saga(1, '<c-d>')<cr>",
        opts
    )

    vim.cmd([[ command! Format execute "lua vim.lsp.buf.format({async = true })" ]])
end

-- client is LSP client, buffer?
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
end

local capabilities = require "config.lsp.capability"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

-- See :h deprecated
-- update_capabilities is deprecated, use default_capabilities instead.
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
M.capabilities.textDocument.semanticHighlighting = true
M.capabilities.offsetEncoding = "utf-8"

return M
