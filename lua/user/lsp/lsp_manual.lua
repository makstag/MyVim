local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 
  'rust_analyzer', 
  'pyright', 
  'tsserver', 
  'ccls', 
  'gdscript', 
  'lua_ls',
  'cssls',
  'jsonls',
  'bashls',
  'cmake',
  'dockerls'
}

for _, server in ipairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
