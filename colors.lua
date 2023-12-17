-- @Author: Jingyuexing
-- @Date:   2023-12-17 00:44:44
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-17 01:18:49
local utils = require('./utils')

local colors = {}

---@param message string
---@param color number
function colors.message(message, hexColor)
    local red = bit32.rshift(bit32.band(hexColor, 0xFF0000), 16)
    local green = bit32.rshift(bit32.band(hexColor, 0x00FF00), 8)
    local blue = bit32.band(hexColor, 0x0000FF)
    return utils.template("\x1b[38;2;{R};{G};{B}m{info}\x1b[0m", {
        R = red,
        G = green,
        B = blue,
        info = message
    }, "{}")
end

function colors.terminal(message, colorName)
    local colorTable = {
        black = 30,
        red = 31,
        green = 32,
        yellow = 33,
        blue = 34,
        magenta = 35,
        cyan = 36,
        white = 37
    }

    local colorCode = colorTable[colorName] or 0 -- 默认为 0，表示不设置颜色

    return utils.template("\27[{color}m{info}\27[0m", {
        color = colorCode,
        info = message
    }, "{}")
end

function colors.background(message, colorName)
    -- \27[41mThis text has a red background.\27[0m
    local colorTable = {
        black = 40,
        red = 41,
        green = 42,
        yellow = 43,
        blue = 44,
        magenta = 45,
        cyan = 46,
        white = 47
    }
    local colorCode = colorTable[colorName] or 0 -- 默认为 0，表示不设置颜色
    return utils.template("\27[{BG}m{info}\27[0m", {
        BG = colorCode,
        info = message,
    }, "{}")
end

function colors.stop(message)
    return message .. "\27[0m"
end

return colors
