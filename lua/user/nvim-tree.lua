local function custom_callback(callback_name)
    return string.format(":lua require('user.treeutils').%s()<CR>", callback_name)
end

local nvim_tree = require "nvim-tree"
local nvim_tree_config = require "nvim-tree.config"
local icons = require "user.icons"
local utils = require "nvim-tree.utils"

---@diagnostic disable-next-line: unused-local
local function notify_level(level)
  return function(msg)
    vim.schedule(function()
      vim.api.nvim_echo({ { msg, "WarningMsg" } }, false, {})
    end)
  end
end

utils.notify.warn = notify_level(vim.log.levels.WARN)
utils.notify.error = notify_level(vim.log.levels.ERROR)
utils.notify.info = notify_level(vim.log.levels.INFO)
utils.notify.debug = notify_level(vim.log.levels.DEBUG)

nvim_tree.setup {
  hijack_directories = {
    enable = false,
  },
  -- update_to_buf_dir = {
  --   enable = false,
  -- },
  -- disable_netrw = true,
  -- hijack_netrw = true,
  -- open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  filters = {
    custom = { ".git" },
    exclude = { ".gitignore" },
  },
  -- auto_close = true,
  -- open_on_tab = false,
  -- hijack_cursor = false,
  update_cwd = true,
  -- update_to_buf_dir = {
  --   enable = true,
  --   auto_open = true,
  -- },
  -- --   error
  -- --   info
  -- --   question
  -- --   warning
  -- --   lightbulb
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":t",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = icons.ui.ArrowOpen,
          arrow_closed = icons.ui.ArrowClosed,
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Information,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  -- system_open = {
  --   cmd = nil,
  --   args = {},
  -- },
  -- filters = {
  --   dotfiles = false,
  --   custom = {},
  -- },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    hide_root_folder = false,
    side = "left",
    -- auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
	{ key = "<c-f>", cb = custom_callback "launch_find_files" },
        { key = "<c-g>", cb = custom_callback "launch_live_grep" },
	{ key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all }
      },
    },
    number = false,
    relativenumber = false,
  },
  actions = {
    open_file = {
        quit_on_open = false
    }
  }
}