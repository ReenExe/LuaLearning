describe("types", function()
    it("types", function()
        assert.True(type(1) == "number")
        assert.True(type("text") == "string")
        assert.True(type(true) == "boolean")
        assert.True(type(type) == "function")
        assert.True(type(print) == "function")
        assert.True(type(nil) == "nil")
        assert.True(type({}) == "table")

        -- also exist `userdata`, `thread`
    end)
end)
