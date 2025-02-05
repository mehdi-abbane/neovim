local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section

gl.short_line_list = { 'NvimTree', 'vista', 'dbui' } -- Shortened statusline for these buffers

gls.left[1] = {
    ViMode = {
        provider = function()
            local mode_colors = {
                n = 'Green', i = 'Blue', v = 'Yellow', c = 'Red',
                R = 'Magenta', s = 'Cyan', t = 'White'
            }
            vim.cmd('hi GalaxyViMode guifg=' .. mode_colors[vim.fn.mode()])
            return '   '
        end,
        highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, 'NONE' },
    },
}

gls.left[2] = {
    FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = { 'White', 'NONE' },
    },
}

gls.right[1] = {
    LineInfo = {
        provider = 'LineColumn',
        highlight = { 'White', 'NONE' },
    },
}

gls.right[2] = {
    PerCent = {
        provider = 'LinePercent',
        highlight = { 'White', 'NONE' },
    },
}

