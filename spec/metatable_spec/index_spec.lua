describe('metatable index', function()
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

    -- function
    mtparent.getName = function()
      return 'mtparent'
    end

    assert.True(mtparent.getName() == 'mtparent')
    assert.True(mt.getName() == 'mtparent')
    assert.True(t.getName() == 'mtparent')

    mt.getName = function()
      return 'mt'
    end

    assert.True(mtparent.getName() == 'mtparent')
    assert.True(mt.getName() == 'mt')
    assert.True(t.getName() == 'mt')

    t.getName = function()
      return 't'
    end

    assert.True(mtparent.getName() == 'mtparent')
    assert.True(mt.getName() == 'mt')
    assert.True(t.getName() == 't')
  end)

  it('newindex', function()
      local a = {}
      local mt = {}
      local cache = {}

      mt.__newindex = function(t, k, v)
        mt[k] = v * v
      end
      mt.__index = mt

      setmetatable(a, mt)

      a.key = 3
      assert.True(a.key == 9)
  end)
end)