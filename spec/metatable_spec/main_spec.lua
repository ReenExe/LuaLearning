describe("metatable", function()
  it('get and set', function()
    local table = {}

    assert.True(getmetatable(table) == nil)

    local metatable = {}

    setmetatable(table, metatable)

    assert.True(getmetatable(table) == metatable)
  end)

	it('simple __tostring', function()
    local metatable = {
      __tostring = function()
        return 'value'
      end
    }

    local table = {}

    setmetatable(table, metatable)

    assert.True(tostring(table) == 'value');

    assert.True(table.value == nil)
    table[table] = true
    assert.True(table.value == nil)
	end)

  it('add method after set', function()
    local t = {}
    local mt = {}
    setmetatable(t, mt)
    mt.__tostring = function()
      return 'value'
    end

    assert.False(tostring(table) == 'value');
  end)
end)