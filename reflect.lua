-- @Author: Jingyuexing
-- @Date:   2023-12-16 23:11:24
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-16 23:11:46
local Reflect = {}

-- 获取表中的所有键
function Reflect.getKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

-- 获取表中的所有函数
function Reflect.getFunctions(tbl)
    local functions = {}
    for key, value in pairs(tbl) do
        if type(value) == "function" then
            functions[key] = value
        end
    end
    return functions
end

-- 修改表中的值
function Reflect.setValue(tbl, key, newValue)
    tbl[key] = newValue
end

return {
    Reflect
}