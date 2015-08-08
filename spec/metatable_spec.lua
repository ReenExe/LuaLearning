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

  it('compare', function()
      local mt = {
        __lt = function(a, b)
          return a.value < b.value
        end
      }

      local a = {}
      local b = {}

      setmetatable(a, mt)
      setmetatable(b, mt)

      a.value = 1
      b.value = 2

      assert.True(a < b)
  end)
end)