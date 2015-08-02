describe("string", function()
    it("gsub", function()
        local first = 'first string'
        assert.same(string.gsub(first, 'first', 'second'), 'second string')
        assert.same(first, 'first string')
    end)
  
    it('length', function()
        assert.same(#'some value', 10)
        local value = 'value';
        assert.same(#value, 5)
    end)
    
    it('long', function()
        local value = [[
            <html></html>
        ]]
    end)
end)