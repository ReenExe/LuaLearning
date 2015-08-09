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
      key = 'value',
    }
    
    assert.True(table[1] == 1)
    assert.True(table[5] == 25)
    assert.True(table.key == 'value')
    assert.True(table['key'] == 'value')
  end)

  it('table as key', function()
    local table = {}

    assert.True(table[table] == nil)
    table[table] = true;
    assert.True(table[table] == true)
  end)

  it('as list', function()
    local table = {'a', 'b', 'c'}
    assert.True(table[1] == 'a')
    assert.True(table[2] == 'b')
    assert.True(table[3] == 'c')
  end)
end)
