local function getQueryFilterKey(getParameters, cookieParameters)
    local result = {}

    local function push(key, value)
        table.insert(result, key .. '=' .. value)
    end

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

    push('page', getPage())
    push('sort', getCookie('sort') or 'views')

    local getKeys = { 'n', 'b', 't', 's', 'o', 'a', 'c', 'p' }
    for i = 1, #getKeys do
        local key = getKeys[i]
        local value = getParameters[key]
        if value and value ~= '' then
            push(key, value)
        end
    end

    return '?' .. table.concat(result, '&')
end

describe('query filter key', function()
    it('do', function()
        assert.same(getQueryFilterKey({}, {}), '?page=1&sort=views')

        assert.same(getQueryFilterKey({a = '1'}, {}), '?page=1&sort=views&a=1')
        assert.same(getQueryFilterKey({a = '1', b = ''}, {}), '?page=1&sort=views&a=1')
    end)
end)