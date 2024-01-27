
local fm = require "fluoromachine"

function overrides(c)
    return 
    {
        TelescopeResultsBorder = { fg = c.alt_bg, bg = c.alt_bg },
        TelescopeResultsNormal = { bg = c.alt_bg },
        TelescopePreviewNormal = { bg = c.bg },
        TelescopePromptBorder = { fg = c.alt_bg, bg = c.alt_bg },
        TelescopeTitle = { fg = c.fg, bg = c.comment },
        TelescopePromptPrefix = { fg = c.purple },
    }
end

fm.setup 
{
    glow = true,
    theme = 'retrowave',
    overrides = overrides,
    transparent = 'full',
    colors = function(_, d)
        return {
            bg = '#190920',
            alt_bg = d('#190920', 20),
            cyan = '#49eaff',
            red = '#ff1e34',
            yellow = '#ffe756',
            orange = '#f38e21',
            pink = '#ffadff',
            purple = '#9544f7',
        }
    end,
}

vim.cmd.colorscheme "fluoromachine"
