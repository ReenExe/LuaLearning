describe("converting", function()
    it("number", function()
        assert.same(tonumber('1'), 1)
    end)
  
    it("string", function()
        assert.same(tostring(1), '1')
    end)
end)