describe("metatable", function()
  it('get and set', function()
    local table = {}

    assert.True(getmetatable(table) == nil)

    local metatable = {}

    setmetatable(table, metatable)

    assert.True(getmetatable(table) == metatable)
  end)

	it("simple tostring", function()
    local metatable = {
      __tostring = function()
        return 'value'
      end
    }

    local table = {}

    setmetatable(table, metatable)

    assert.True(tostring(table) == 'value');
	end)
end)