-- @Author: Jingyuexing
-- @Date:   2023-12-17 00:17:20
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-17 19:42:16
local unit = {
    pass = 0,
    failed = 0,
    testCase = 0,
    testFunction = {}
}

local color = require("./colors")

local M = {
    unit = unit
}
--- Checks if two values are equal.
---@param a any
---@param b any
---@param message? string Optional error message
function unit:Equal(a, b, message)
    message = message or ("Expected " .. tostring(a) .. " to be equal " .. tostring(b))
    assert(a == b, message)
end

--- Checks if two values are not equal.
---@param a any
---@param b any
---@param message? string Optional error message
function unit:NotEqual(a, b, message)
    message = message or ("Expected " .. tostring(a) .. "to be not equal " .. tostring(b))
    assert(a ~= b, message)
end

--- Checks if value a is more than value b.
---@param a number
---@param b number
---@param message? string Optional error message
function unit:MoreThan(a, b, message)
    message = message or ("Expected " .. tostring(a) .. " to be more than " .. tostring(b))
    assert(a > b, message)
end

--- Checks if value a is less than value b.
---@param a number
---@param b number
---@param message? string Optional error message
function unit:LessThan(a, b, message)
    message = message or ("Expected " .. tostring(a) .. " to be less than " .. tostring(b))
    assert(a < b, message)
end

---@param unitName string Name of the test unit
---@param func function Test function
function unit:test(unitName, func)
    self.testCase = self.testCase + 1
    local success, err = pcall(func)
    if success then
        self.pass = self.pass + 1
        self.testFunction[unitName] = true
        print(color.background(color.terminal(" " .. unitName .. " ", "white"), "blue") ..
            "\n" .. color.terminal("test passed", "green"))
    else
        self.testFunction[unitName] = false
        self.failed = self.failed + 1
        print(color.background(color.terminal(" " .. unitName .. " ", "black"), "yellow") ..
            "\nfailed with error: " .. color.terminal(err, "red"))
    end
end

function unit:report()
    print(color.terminal("tested passed", "cyan") .. " : " .. color.terminal(self.pass, "green"))
    print(color.terminal("tested failed", "cyan") .. " : " .. color.terminal(self.failed, "red"))
end

function unit:new()
    -- 创建一个新对象
    local obj = {
        pass = 0,
        failed = 0,
        testCase = 0,
        testFunction = {}
    }
    obj = setmetatable(obj, self) -- 将当前类设为新对象的元表
    self.__index = self
    return obj
end

return M
