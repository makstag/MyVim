local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system
    {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd
[[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init
{
    -- snapshot = "july-24",
    snapshot_path = fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display =
    {
        open_fn = function() return require "packer.util".float { border = "rounded" } end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Plugin Mangager
    use { "lewis6991/impatient.nvim", config = [[require "impatient".enable_profile()]] }
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- Lua Development
    use "nvim-lua/popup.nvim"
    use "folke/neodev.nvim"

    -- LSP
    use
    {
        "neovim/nvim-lspconfig",
        requires =
        {
            "nvimdev/lspsaga.nvim",
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        config = [[require "config.lsp"]]
    }

    -- Completion
    use
    {
        "hrsh7th/nvim-cmp",
        requires =
        {
            { "tzachar/cmp-tabnine", run = "./install.sh" },
            { "L3MON4D3/LuaSnip",    tag = "v2.*",        run = "make install_jsregexp" },
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip"
        },
        config = [[require "config.cmp"]]
    }

    -- Syntax/Treesitter
    use
    {
        "nvim-treesitter/nvim-treesitter",
        requires = "JoosepAlviste/nvim-ts-context-commentstring", -- TODO: examine
        event = "BufEnter",
        run = function() require "nvim-treesitter.install".update { with_sync = true } end,
        config = [[require "config.treesitter"]]
    }

    -- Colorschemes
    use { "maxmx03/fluoromachine.nvim", config = [[require "config.colorscheme"]] }

    -- Debugging
    use
    {
        "mfussenegger/nvim-dap",
        requires =
        {
            { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
            { "rcarriga/nvim-dap-ui",            module = { "dapui" } },
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function() require "config.dap".setup {} end
    } -- TODO: examine

    -- GUI
    use
    {
        "nvim-lualine/lualine.nvim",
        config = function() require "lualine".setup { options = { theme = "retrowave" } } end
    }
    use
    {
        "akinsho/bufferline.nvim",
        event = "VimEnter",
        tag = "*",
        cond = firenvim_not_active,
        requires = "nvim-tree/nvim-web-devicons",
        config = [[require "config.bufferline"]]
    }

    -- File Explorer
    use
    {
        "kyazdani42/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        tag = "nightly",
        config = [[require "config.tree"]]
    }

    -- Preview
    use
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        requires = "nvim-tree/nvim-web-devicons",
        config = [[require "config.dashboard"]]
    }

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "*", config = [[require "config.toggleterm"]] }

    -- Telescope
    use
    {
        "nvim-telescope/telescope.nvim",
        tag = "*",
        requires =
        {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim", -- TODO: examine
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
            }
        },
        config = [[require "config.telescope"]]
    }

    -- Project
    use { "nvim-pack/nvim-spectre", config = [[require "config.spectre"]] } -- TODO: examine

    -- Quickfix
    use
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require "bqf".setup { auto_resize_height = false, preview = { auto_preview = false } }
        end
    }

    -- Git
    use { "lewis6991/gitsigns.nvim", config = [[require "config.gitsigns"]] } -- TODO: examine

    -- WhichKey
    use
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        module = { "which-key" },
        disable = false
    } -- TODO: examine

    -- Editing Support
    use { "windwp/nvim-autopairs", config = [[require "config.autopairs"]] }

    use { "karb94/neoscroll.nvim", config = [[require "config.neoscroll"]] } -- TODO: examine

    -- Utility
    use
    {
        "j-hui/fidget.nvim",
        after = "nvim-lspconfig",
        config = function() require "fidget".setup {} end
    }                                                                           -- TODO: examine

    use { "rmagatti/goto-preview", config = [[require "config.goto-preview"]] } -- TODO: examine

    use
    {
        "nvimdev/guard.nvim",
        requires = "nvimdev/guard-collection",
        event = "BufReadPre",
        config = [[require "config.guard"]]
    }

    --AI
    use
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function() require "copilot".setup {} end
    }
    use
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function() require "copilot_cmp".setup {} end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require "packer".sync()
    end
end)
