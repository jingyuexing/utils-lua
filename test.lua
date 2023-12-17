-- @Author: Jingyuexing
-- @Date:   2023-12-17 00:09:12
-- @Last Modified by:   Jingyuexing
-- @Last Modified time: 2023-12-17 19:40:13
local utils = require('./utils')
local unit = require('./unit').unit

local unitTest = unit:new()

unitTest:test("test template",function()
    unitTest:Equal(utils.template("hello {next}",{next="world"},"{}"),"hello world")
    unitTest:Equal(utils.template("/name/:id",{id="world"},":"),"/name/world")
    unitTest:Equal(utils.template("/name/$id",{id="world"},"$"),"/name/world")
end)

unitTest:test("test a is not equal b",function()
    unitTest:NotEqual(1,2)
end)

unitTest:test("test two string is equal",function()
    unitTest:Equal("2","2")
end)

unitTest:test("test utils accessNested function",function()
    local x = {
        s = {
            k = 32
        }
    }
    unitTest:Equal(utils.accessNested(x,"s.k"),32)
end)



unitTest:report()
