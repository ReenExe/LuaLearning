describe("metatable", function()
  it('get and set', function()
    local table = {}

    assert.True(getmetatable(table) == nil)

    local metatable = {}

    setmetatable(table, metatable)

    assert.True(getmetatable(table) == metatable)
  end)

	it('simple __tostring', function()
    local metatable = {
      __tostring = function()
        return 'value'
      end
    }

    local table = {}

    setmetatable(table, metatable)

    assert.True(tostring(table) == 'value');

    assert.True(table.value == nil)
    table[table] = true
    assert.True(table.value == nil)
	end)

  it('add method after set', function()
    local t = {}
    local mt = {}
    setmetatable(t, mt)
    mt.__tostring = function()
      return 'value'
    end

    assert.False(tostring(table) == 'value');
  end)

  it('compare <', function()
    local mt = {
      __lt = function(a, b)
        return a.value < b.value
      end
    }

    local a = {}
    local b = {}

    setmetatable(a, mt)
    setmetatable(b, mt)

    a.value = 1
    b.value = 2

    assert.True(a < b)
    assert.True(b > a)
    assert.False(a > b)
    assert.False(b < a)
  end)

  it('compare <=', function()
    local mt = {
      __le = function(a, b)
        return a.value <= b.value
      end
    }

    local a = {}
    local b = {}

    setmetatable(a, mt)
    setmetatable(b, mt)

    a.value = 1
    b.value = 2

    assert.True(a <= b)
    assert.True(b >= a)
    assert.False(a >= b)
    assert.False(b <= a)

    a.value = 1
    b.value = 1

    assert.True(a <= b)
    assert.True(b >= a)
    assert.True(a >= b)
    assert.True(b <= a)
  end)

  it('compare ==', function()
    local mt = {
      __eq = function(a, b)
        return a.value == b.value
      end
    }

    local a = {}
    local b = {}

    setmetatable(a, mt)
    setmetatable(b, mt)

    a.value = 1
    b.value = 2

    assert.False(a == b)
    assert.True(b ~= a)

    a.value = 1
    b.value = 1

    assert.True(a == b)
  end)

  it('compare all', function()
    local mt = {
      __eq = function(a, b)
        return a.value % 3 ==  b.value % 3
      end,
      __lt = function(a, b)
        return a.value * a.multi < b.value * b.multi
      end,
      __le = function(a, b)
        return a < b or a == b
      end,
    }

    local a = {}
    local b = {}

    setmetatable(a, mt)
    setmetatable(b, mt)

    a.value = 7
    b.value = 10
    assert.True(a == b)

    a.value = 1;
    a.multi = 1;
    b.value = 3;
    b.multi = 3;

    assert.True(a < b)
    assert.True(b > a)

    a.value = 2
    b.value = 5
    a.multi = 1
    b.multi = 0
    assert.True(a == b)
    assert.False(a < b)
    assert.True(a <= b)

    mt.__eq = function() return false end
    mt.__le = function() return true end
    mt.__lt = function() return true end

    assert.False(a == b)
    assert.True(a <= b)
    -- how about that?
    assert.True(a < b and a > b)
  end)

  it('__index function', function()
    local t = {}
    local mt = {}

    setmetatable(t, mt)

    assert.True(t[1] == nil)

    -- AFTER SET!
    mt.__index = function(_, key)

      assert.True(_ == t)

      return tonumber(key) * 2
    end

    assert.True(t[1] == 2)
    assert.True(t[5] == 10)

    t[1] = 8
    assert.True(t[1] == 8)
    assert.True(t[5] == 10)
  end)

  it('__index table', function()
    local t = {}
    local mt = {}

    setmetatable(t, mt)
    mt.__index = mt;

    assert.True(t.value == nil)

    mt.value = 'mt'
    assert.True(t.value == 'mt')

    t.value = 't'
    assert.True(t.value == 't')
    
    t.value = nil
    assert.True(t.value == 'mt')

    local index = {}
    mt.__index = index
    assert.True(t.value == nil)

    index.value = 'index'
    assert.True(t.value == 'index')
  end)

  it('__index extend', function()
    local t = {}
    local mt = {}
    local mtparent = {}

    setmetatable(mt, mtparent)
    setmetatable(t, mt)

    assert.True(t.value == nil)
    assert.True(mt.value == nil)
    assert.True(mtparent.value == nil)

    mt.__index = mt
    mtparent.__index = mtparent

    mtparent.value = 'mtparent'
    assert.True(mtparent.value == 'mtparent')
    assert.True(mt.value == 'mtparent')
    assert.True(t.value == 'mtparent')

    mt.value = 'mt'
    assert.True(mtparent.value == 'mtparent')
    assert.True(mt.value == 'mt')
    assert.True(t.value == 'mt')

    t.value = 't'
    assert.True(mtparent.value == 'mtparent')
    assert.True(mt.value == 'mt')
    assert.True(t.value == 't')
  end)
end)