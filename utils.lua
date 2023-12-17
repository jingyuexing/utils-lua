-- @Author: Jingyuexing
-- @Date:   2023-12-16 22:18:15
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-17 01:11:58

local table = require 'table'
local string = require 'string'
local math = require 'math'
local utils = {}

function utils.reduce(arr, func, initialValue)
    local accumulator = initialValue

    for i = 1, #arr do
        accumulator = func(accumulator, arr[i], i, arr)
    end

    return accumulator
end

function utils.filter(arr, predicate)
    local filtered = {}

    for i = 1, #arr do
        if predicate(arr[i], i, arr) then
            table.insert(filtered, arr[i])
        end
    end

    return filtered
end

---@param str string the target string
---@param delimiter string the delimiter
---@return string[]
function utils.split(str, delimiter)
    if delimiter == nil then
        delimiter = "%s"
    end
    local t = {}
    for _str in string.gmatch(str, "([^" .. delimiter .. "]+)") do
        table.insert(t, _str)
    end
    return t
end

---@param str string
---@param replace string
function utils.replace(str, replace)
    -- body
end

---@param arr T[] the target table
---@param size integer the chunk size
function utils.chunk(arr, size)
    local chunks = {}
    local index = 1

    for i = 1, #arr, size do
        local chunk = {}
        for j = i, math.min(i + size - 1, #arr) do
            chunk[#chunk + 1] = arr[j]
        end
        chunks[index] = chunk
        index = index + 1
    end

    return chunks
end

--- @param arr T[]
--- @param cb fun(prev,cur,init):T[][]
function utils.groupBy(arr, cb)
    local grouped = {}

    for i = 1, #arr do
        local key = cb(arr[i], i, arr)
        if not grouped[key] then
            grouped[key] = {}
        end
        table.insert(grouped[key], arr[i])
    end

    return grouped
end

---
---```lua
--- local a = {
---     b = {
---         c = {
---             f = 42
---         }
---     }
--- }
--- local value = accessNested(a, "b.c.f")
--- -- will return 42
---```
---@param obj table
---@param path string
function utils.accessNested(obj, path)
    local keys = utils.split(path, ".")

    local value = utils.reduce(keys, function(acc, key)
        if type(acc) == "table" and acc[key] then
            return acc[key]
        else
            return nil -- 如果路径无效或对象不存在，返回nil
        end
    end, obj)

    return value
end

---@param str string the target string
---@param length number the padding length
---@param char string the padding char
function utils.padStart(str, length, char)
    if #str >= length then
        return str
    end

    local padding = string.rep(char, length - #str)
    return padding .. str
end

---
---@param str string the target string
---@param length number the padding length
---@param char string the padding char
function utils.padEnd(str, length, char)
    if #str >= length then
        return str
    end

    local padding = string.rep(char, length - #str)
    return str .. padding
end

--- Constructs a function chain that sequentially executes a series of functions provided as arguments and returns a function.
-- @param ... A series of functions to be executed
-- @return A function that takes an input and passes it through each function in sequence, returning the final processed result
function utils.pipeline(...)
    local funcs = { ... }

    return function(input)
        local result = input
        for _, func in ipairs(funcs) do
            result = func(result)
        end
        return result
    end
end

--- Composes a new function by chaining multiple functions together from right to left.
-- @param ... A series of functions to compose
-- @return A new function that represents the composition of provided functions
function utils.compose(...)
    local funcs = { ... }

    return function(...)
        local result = funcs[#funcs](...)

        for i = #funcs - 1, 1, -1 do
            result = funcs[i](result)
        end

        return result
    end
end

---@param obj table
function utils.keys(obj)
    local _keys = {}
    for key, _ in ipairs(obj) do
        table.insert(_keys, key)
    end
    return _keys
end

---@param str string
---@param template table
---@param templateStr string
function utils.template(str, template, templateStr)
    local copy = str
    for key, val in pairs(template) do
        local replaceKey = ""
        if templateStr == "{}" then
            replaceKey = "{" .. key .. "}"
        elseif templateStr == ":" then
            replaceKey = ":" .. key
        elseif templateStr == "$" then
            replaceKey = "$" .. key
        elseif templateStr == nil then
            return
        end
        copy = string.gsub(copy, replaceKey, val)
    end
    return copy
end

function utils.join(array, delimiter)
    delimiter = delimiter or ","
    local result = ""

    for i, v in ipairs(array) do
        if i > 1 then
            result = result .. delimiter
        end
        result = result .. tostring(v)
    end

    return result
end

return utils
