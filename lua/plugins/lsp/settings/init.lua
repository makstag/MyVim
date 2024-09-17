-- lsp-config
-- https://github.com/neovim/nvim-lspconfig
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

local lspconfig = require "lspconfig"

local lsp_flags = { debounce_text_changes = 150 }

local on_attach = require "config.lsp.handlers".on_attach
local capabilities = require "config.lsp.handlers".capabilities

-- language servers config

-- cmake
lspconfig.cmake.setup
{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}

-- cpp
local clangd_opts = require "config.lsp.settings.clangd"
lspconfig.clangd.setup
{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    clangd_opts
}

-- make
--[[
lspconfig.autotools_ls.setup
{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}
]]

-- assembly

lspconfig.asm_lsp.setup
{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}
