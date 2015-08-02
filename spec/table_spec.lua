describe("table", function()
	it("key", function()
		local table = {}
		table[1] = 1
		table["1"] = "one"

		assert.True(table[1] == 1)	
		assert.True(table["1"] == "one")	
	end)

	it("id", function()
		local table = {
			[1] = 1,
			[5] = 25,
		}
	end)
end)
