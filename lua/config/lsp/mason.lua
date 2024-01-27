-- Default configuration https://github.com/williamboman/mason.nvim#default-configuration
require "mason".setup
{
    ui = 
    {
        icons = 
        {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}
