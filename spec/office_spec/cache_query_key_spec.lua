local function httpBuildQuery(map)
    local keyValueList = {}

    for key, value in pairs(map) do
        table.insert(keyValueList, key .. '=' .. value)
    end

    return table.concat(keyValueList, "&")
end

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

local function getQueryFilterKey(getParameters, cookieParameters)
    local function getCookie(key)
        return cookieParameters['cookie_' .. key]
    end

    local function getPage()
        if (getParameters.page) then
            local page = tonumber(getParameters.page)

            if (page > 0) then
                return page
            end
        end

        return 1
    end

    local result = {
        page = getPage(),
        sort = getCookie('sort') or 'views'
    }

    local getKeys = { 'n', 'b', 't', 's', 'o', 'a', 'c', 'p' }
    for i = 1, #getKeys do
        local key = getKeys[i]
        if getParameters[key] then
            local aliases = explode(',', getParameters[key])
            if (#aliases > 0) then
                table.sort(aliases)
                result[key] = table.concat(aliases, ',')
            end
        end
    end

    return '?' .. httpBuildQuery(result)
end

describe('query filter key', function()
    it('http build query',function()
        assert.same(httpBuildQuery{}, '')
        assert.same(httpBuildQuery{a = 1}, 'a=1')
        assert.same(httpBuildQuery{a = 1, b = 2}, 'a=1&b=2')
    end)

    it('explode', function()
        assert.same(explode(',', ''), {''})
        assert.same(explode(',', '1,2'), {'1', '2'})
    end)

    it('do', function()
        assert.same(getQueryFilterKey({}, {}), '?page=1&sort=views')
    end)
end)