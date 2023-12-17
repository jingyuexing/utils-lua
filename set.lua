-- @Author: Jingyuexing
-- @Date:   2023-12-16 22:58:08
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-16 23:06:07

local Set = {
    value = {}
}

-- 判断集合中是否包含某个元素
function Set:include(element)
    return self.values[element] ~= nil
end

-- 向集合中添加元素
function Set:add(element)
    if not self:include(element) then
        self.values[element] = true
    end
end

-- 从集合中移除元素
function Set:remove(element)
    if self:include(element) then
        self.values[element] = nil
    end
end

-- 判断集合中是否包含某个元素
function Set:contains(element)
    return self.include(self, element)
end

-- 返回集合中的所有元素
function Set:container()
    local elements = {}
    for element, _ in pairs(self.values) do
        table.insert(elements, element)
    end
    return elements
end

return {
    Set = Set
}
