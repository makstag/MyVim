local M = {}

function M.setup()
    local dap = require "dap"
    local install_root_dir = vim.fn.stdpath "data" .. "/cpptools"
    local extension_path = install_root_dir .. "/extension/debugAdapters/bin"
    local cppdbg_path = extension_path .. "/OpenDebugAD7"

    dap.adapters.cppdbg = 
    {
        id = "cppdbg",
        type = "executable",
        command = cppdbg_path,
    }

    dap.configurations.cpp = 
    {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            MIMode = 'gdb',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/gdb',
            cwd = '${workspaceFolder}',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

return M
