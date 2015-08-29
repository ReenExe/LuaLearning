local function httpBuildQuery(map)
    local keyValueList = {}

    for key, value in pairs(map) do
        table.insert(keyValueList, key .. '=' .. value)
    end

    return table.concat(keyValueList, "&")
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

    local function explode(separator, value)
        -- TODO
        return {}
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
        assert.same(httpBuildQuery{a=1}, 'a=1')
    end)

    it('do', function()
        assert.same(getQueryFilterKey({}, {}), '?page=1&sort=views')
    end)
end)