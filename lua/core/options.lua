local options = 
{
    --encoding = "utf-8",
    --backup = false,                          -- creates a backup file
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    --cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    --conceallevel = 0,                        -- so that `` is visible in markdown files
    --fileencoding = "utf-8",                  -- the encoding written to a file
    
    --hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "",                              -- allow the mouse to be used in neovim
    --pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    --showtabline = 0,                         -- always show tabs
    --smartcase = true,                        -- smart case
    smarttab = true,                         -- smart tab
    --smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    --swapfile = false,                        -- creates a swapfile
    --termguicolors = true,                    -- set term gui colors (most terminals support this)
    --timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
    --undofile = true,                         -- enable persistent undo
    --updatetime = 100,                        -- faster completion (4000ms default)
    --writebackup = true,                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    
    --expandtab = false,                       -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 4 spaces for a tab
    softtabstop = 4,                         -- insert 4 spaces for a tab in mode insert
    --cursorline = false,                      -- highlight the current line
    --laststatus = 0,                          -- the value of this option influences when the last window will have a status line
    --showcmd = false,                         -- show (partial) command in the last line of the screen
    --ruler = false,                           -- show the line and column number of the cursor position, separated by a comma
    relativenumber = true,                   -- set relative numbered lines
    --numberwidth = 4,                         -- set number column width to 4 {default 4}
    --signcolumn = "no",                       -- always show the sign column, otherwise it would shift the text each time
    --wrap = false,                            -- display lines as one long line
    --scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
    --sidescrolloff = 8,                       -- the minimal number of screen columns to keep to the left and to the right of the cursor if "nowrap" is set
    --guifont = "monospace:h17",               -- the font used in graphical neovim applications
    
    --title = true,                            -- when on, the title of the window will be set to the value of "titlestring"
    colorcolumn = "120",                     -- is a comma-separated list of screen columns that are highlighted with ColorColumn
    --number = false,                          -- print the line number in front of each line
    --history = 1000,                          -- a history of ":" commands, and a history of previous search patterns is remembered
    guicursor = "i:block-Cursor-blinkwait250-blinkoff200-blinkon200",
                                             -- configures the cursor style for each mode. Works in the GUI and many terminals
    --autoindent = true,                       -- copy indent from current line when starting a new line
    --showmatch = true,                        -- when a bracket is inserted, briefly jump to the matching one
    --inccommand = "split"                     -- preview substitutions live, as you type
}

--vim.opt.fillchars += "eob: "
--vim.opt.fillchars:append { stl = " " }
--vim.opt.shortmess:append "c"

for k, v in pairs(options) do vim.opt[k] = v end

--vim.cmd "set whichwrap+=<,>,[,],h,l"
--vim.cmd [[set iskeyword+=-]]
--vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

--vim.filetype.add { extension = { conf = "dosini" } }
