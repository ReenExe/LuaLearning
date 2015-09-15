-- http://stackoverflow.com/questions/1426954/split-string-in-lua
-- http://lua-users.org/wiki/SplitJoin -- Compatibility: Lua-5.0
local function explode(delimeter, source)
    -- Eliminate bad cases...
    if string.find(source, delimeter) == nil then
        return { source }
    end
    local result = {}
    local pattern = "(.-)" .. delimeter .. "()"
    local lastPos
    for part, pos in string.gfind(source, pattern) do
        table.insert(result, part)
        lastPos = pos
    end
    -- Handle the last field
    if lastPos then
        table.insert(result, string.sub(source, lastPos))
    end
    return result
end

describe('explode', function()
    it('explode', function()
        assert.same(explode(',', ''), {''})
        assert.same(explode(',', '1,2'), {'1', '2'})
    end)
end)