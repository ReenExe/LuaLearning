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

    local getKeys = { 't', 's', 'b', 'o', 'a', 'm', 'r', 'p' }
    for i = 1, #getKeys do
        local key = getKeys[i]
        local value = getParameters[key]
        if value and value ~= '' and type(value) == 'string' then
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
        assert.same(getQueryFilterKey({a = '1', b = {'a'}}, {}), '?page=1&sort=views&a=1')
        assert.same(getQueryFilterKey({a = '1', b = 'a,b'}, {}), '?page=1&sort=views&b=a,b&a=1')

        assert.same(getQueryFilterKey({b = 'puma'}, {}), '?page=1&sort=views&b=puma')
        assert.same(getQueryFilterKey({b = 'puma', page = 3}, {}), '?page=3&sort=views&b=puma')
        assert.same(getQueryFilterKey({b = 'puma', page = 3}, {cookie_sort = 'zprice'}), '?page=3&sort=zprice&b=puma')
    end)
end)
