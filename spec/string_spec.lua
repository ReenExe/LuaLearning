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
  
    it('concat', function()
        assert.same(1 .. 1, '11')
        assert.same('this' .. ' is ' .. 'it', 'this is it')
    end)
    
    it('long', function()
        local value = [[
            <html></html>
        ]]
    end)
end)