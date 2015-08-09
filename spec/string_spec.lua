describe("string", function()
    it("gsub", function()
        local first = 'first string'
        assert.same(string.gsub(first, 'first', 'second'), 'second string')
        assert.same(first:gsub('first', 'second'), 'second string')
        assert.same(first, 'first string')
    end)

    it('sub', function()
        assert.True(string.sub('abc', 1) == 'abc')
        assert.True(string.sub('abc', 1, 3) == 'abc')
        assert.True(string.sub('abc', 1, 100) == 'abc')
        assert.True(string.sub('abc', 1, 1) == 'a')
        assert.True(string.sub('abc', 1, 2) == 'ab')
        assert.True(string.sub('abc', 2) == 'bc')
        assert.True(string.sub('abc', 2, 2) == 'b')
    end)

    it('length', function()
        assert.same(#'some value', 10)
        local value = 'value';
        assert.same(#value, 5)
        assert.same(value:len(), 5)
        assert.same(string.len(value), 5)
    end)
  
    it('concat', function()
        assert.same(1 .. 1, '11')
        assert.same('this' .. ' is ' .. 'it', 'this is it')
    end)

    it('case', function()
        assert.True(string.upper('name') == 'NAME')
        assert.True(('name'):upper() == 'NAME')
        assert.True(('NAME'):upper() == 'NAME')

        assert.True(string.lower('NAME') == 'name')
        assert.True(('NAME'):lower() == 'name')
        assert.True(('name'):lower() == 'name')
    end)

    it('reverse', function()
        assert.True(string.reverse('abc') == 'cba')
    end)

    it('char', function()
      assert.True(string.char(65) == 'A')
      assert.True(string.char(65, 66, 67) == 'ABC')
    end)

    it('byte', function()
        assert.True(string.byte('A') == 65)
        assert.True(string.byte('A', 1) == 65)

        local a, b, c = string.byte('ABC', 1, 3)
        assert.True(a == 65)
        assert.True(b == 66)
        assert.True(c == 67)
    end)

    it('format', function()
      assert.True(string.format('%d %d %d', 1, 2, 3) == '1 2 3')
      assert.True(('%d %d %d'):format(1, 2, 3) == '1 2 3')
    end)

    it('repeat', function()
        assert.True(string.rep('Lua', 1) == 'Lua')
        assert.True(string.rep('Lua', '1') == 'Lua')
        assert.True(string.rep('Lua ', 3) == 'Lua Lua Lua ')
        assert.True(string.rep('Lua ', '3') == 'Lua Lua Lua ')
        assert.True(('Lua '):rep(3) == 'Lua Lua Lua ')
    end)

    it('find', function()
        local start, finish = string.find('Hello Lua', 'Lua')
        assert.True(start == 7 and finish == 9)

        start, finish = string.find('Hello Lua', 'Lapis')
        assert.True(start == nil and finish == nil)

        start, finish = string.find('Start Lua, Start C', 'Start')
        assert.True(start == 1 and finish == 5)

        start, finish = string.find('Start Lua, Start C', 'Start', 2) -- start + 1
        assert.True(start == 12 and finish == 16)

        start, finish = string.find('Start Lua, Start C', 'Start', 16)
        assert.True(start == nil and finish == nil)
    end)

    it('metatable', function()
        local mt = getmetatable('')
        assert.truthy(mt)

        assert.True(getmetatable('a') == getmetatable('b'))
    end)

    it('long', function()
        local value = [[
            <html></html>
        ]]
    end)
end)