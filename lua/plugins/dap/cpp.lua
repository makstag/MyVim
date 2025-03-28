local M = {}

function M.setup()
    local dap = require("dap")
    local install_root_dir = vim.fn.stdpath "config" .. "/dap"
    local cppdbg = install_root_dir .. "/extension/debugAdapters/bin/OpenDebugAD7"

    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = cppdbg,
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
            setupCommands = {  
                { 
                    text = "-enable-pretty-printing",
                    description =  "enable pretty printing",
                    ignoreFailures = false 
                }
            }
        }
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.cc = dap.configurations.cpp
end

return M
