describe("metatable", function()
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