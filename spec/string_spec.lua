describe("string", function()
    it("gsub", function()
        local first = 'first string'
        assert.same(string.gsub(first, 'first', 'second'), 'second string')
        assert.same(first, 'first string')
    end)
end)