local icons = require"utils.icons"
local M = {}

M.with = function(handlers)
    local h = {}
    for _, handler in ipairs(handlers) do
        h = vim.tbl_extend("keep", h, handler)
    end
    return h
end

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.information }
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false,  -- appears after the line
        virtual_lines = false, -- appears under the line
        signs = { active = signs },
        flags = { debounce_text_changes = 200 },
        update_in_insert = false, -- when insert, don't show diagnostic
        underline = true, -- it is annoying me!!!
        severity_sort = true,
        float = {
            focus = false,
            focusable = false,
            style = "minimal",
            border = "shadow", -- rounded
            source = "always",
            header = "",
            prefix = "",
        }
    }
    vim.diagnostic.config(config)
    local border = { border = "shadow", width = 60 }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border)
end

local function lsp_highlight_document(client, bufnr)
    local api = vim.api

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
        api.nvim_create_autocmd("CursorHold", 
        {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        api.nvim_create_autocmd("CursorMoved", 
        {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
        api.nvim_create_autocmd("TermOpen", 
        {
            callback = function()
                -- disable line numbers
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                -- always start in insert mode
                vim.cmd("stopinsert")
            end,
            pattern = "*"
        })
        api.nvim_create_autocmd({"TextChangedI", "TextChangedP"},
        {
            callback = function()
                local line = vim.api.nvim_get_current_line()
                local cursor = vim.api.nvim_win_get_cursor(0)[2]

                local current = string.sub(line, cursor, cursor + 1)
                if after_line == "" or current == "#" then require "cmp".complete() end
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
    map(bufnr, "n", "K", "<cmd>lua lb.hover()<cr>", opts)
    map(bufnr, "n", "gi", "<cmd>lua lb.implementation()<cr>", opts)
    map(bufnr, "n", "<leader>[", "<cmd>lua lb.signature_help()<cr>", opts)

    map(bufnr, "n", "<leader>rn", ":IncRename ", opts)
    map(bufnr, "n", "gr", "<cmd>lua lb.references()<cr>", opts)
    map(bufnr, "n", "<leader>ga", function()
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        local range = {
            start = { line = 1, character = 1 },
            end = { line = line_count, character = 1 }
        }
        lb.code_action { range = range.range }
    end, opts)

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

    map(bufnr, "n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
    map(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

    vim.cmd [[ command! Format execute "lua lb.format({async = true })" ]]
end

local lsp_signature = require "lsp_signature"

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
    
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    
    lsp_signature.on_attach { floating_window = false, timer_interval = 500 }
end

local capabilities = require "plugins.lsp.capability"
local cmp = require "cmp_nvim_lsp"

-- See :h deprecated
-- update_capabilities is deprecated, use default_capabilities instead.
M.capabilities = cmp.default_capabilities(capabilities)
M.capabilities.textDocument.semanticHighlighting = true
M.capabilities.offsetEncoding = "utf-8"

return M
