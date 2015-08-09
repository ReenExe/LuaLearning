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
    assert.True(#table == 3)
  end)

  it('as stack', function()
      local t = {}

      table.insert(t, 'a');
      assert.True(t[1] == 'a')

      table.insert(t, 'b');
      assert.True(t[2] == 'b')

      assert.True(#t == 2)

      assert.True(table.remove(t) == 'b')
      assert.True(table.remove(t) == 'a')
      assert.True(#t == 0)
  end)

  it('concat', function()
      assert.True(table.concat({'a', 'b', 'c'}) == 'abc')
      assert.True(table.concat({'a', 'b', 'c'}, '-') == 'a-b-c')
      assert.True(table.concat{'a', 'b', 'c'} == 'abc')
  end)
end)