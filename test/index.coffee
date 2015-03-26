index = require 'index.coffee'

suite 'index.coffeeのテスト', ->
  suite '関数addのテスト', ->
    test 'add(10, 20)', ->
      assert.equal(index.add(10, 20), 30)
