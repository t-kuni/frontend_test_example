require 'bind-polyfill.js'
$ = require 'jquery'
ShowableStack = require 'showableStack.coffee'
Showable = require 'showable.coffee'

describe 'ShowableStackクラス', ->

  describe 'new', ->

    it 'z-indexを指定しない場合、styleが付与されないか', ->
      zindex = new ShowableStack()
        .getContents()
        .css 'z-index'
      assert.strictEqual zindex, ''

    it 'z-indexを指定した場合、styleが付与されるか', ->
      zindex = new ShowableStack 0
        .getContents()
        .css 'z-index'
      assert.strictEqual zindex, '0'

    it 'spawnしたShowableをshowしてcontentsに追加されるか', ->
      stack = new ShowableStack()
      child = stack.spawn new Showable
        .setContents $ '<div id="test-child">'
        .show()
      length = stack.getContents()
        .find '#test-child'
        .length
      assert.strictEqual length, 1

  describe '.setZindex, .getZindex', ->

    it '0を設定して0が取得できるか', ->
      zindex = new ShowableStack()
        .setZindex 0
        .getZindex()
      assert.strictEqual zindex, 0

    it '0を設定したあとにpushして1が設定されているか', ->
      child = new Showable()
        .setContents $ '<div id="test-child">'
      zindex = new ShowableStack()
        .setZindex 0
        .push child
        .getContents()
        .find '#test-child'
        .css 'z-index'
      assert.strictEqual zindex, '1'

  describe '.nextZindex', ->

    it '0を設定して1が取得できるか', ->
      zindex = new ShowableStack()
        .setZindex 0
        .nextZindex()
      assert.strictEqual zindex, 1

  describe '.push', ->

    it '単純に呼び出し', ->
      new ShowableStack 0
        .push new Showable()

    it 'contentsに追加されているか', ->
      child = new Showable()
        .setContents $ '<div id="test-child">'
      length = new ShowableStack 0
        .push child
        .getContents()
        .find '#test-child'
        .length
      assert.strictEqual length, 1

    it 'z-indexに1000を指定して、pushした要素に1001が付与されるか', ->
      child = new Showable()
        .setContents $ '<div>'
      new ShowableStack 1000
        .push child
      zindex = child.getContents()
        .css 'z-index'
      assert.strictEqual zindex, '1001'

    it '内部で保持しているstackの長さが1になるか', ->
      stack = new ShowableStack 0
        .push new Showable()
      assert.strictEqual stack.stack.length, 1

  describe '.pop', ->

    it '単純に呼び出し', ->
      new ShowableStack 0
        .push new Showable()
        .pop()

    it 'contentsから削除されているか', ->
      child = new Showable()
        .setContents $ '<div id="test-child">'
      stack = new ShowableStack 0
        .push child
      stack.pop()
      length = stack.getContents()
        .find '#test-child'
        .length
      assert.strictEqual length, 0

    it '内部で保持しているstackの長さが0になるか', ->
      stack = new ShowableStack 0
        .push new Showable()
      stack.pop()
      assert.strictEqual stack.stack.length, 0
