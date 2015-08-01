describe("operation", function()
	it("math", function() 
		assert.same(1 + 1, 2)
		assert.same(3 - 2, 1)
		assert.same(5 * 5, 25)
		assert.same(5 / 5, 1)
		assert.same(5 % 3, 2)

	end)

	it("compare", function()
		assert.True(1 == 1)
	end)
end)
