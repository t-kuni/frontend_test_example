require 'bind-polyfill.js'
$ = require 'jquery'
Contents = require 'contents.coffee'

describe 'Contentsクラス', ->

  describe 'new', ->

    it '引数なし', ->
      new Contents()

  describe '.append', ->

    it 'コールバックが呼び出されるか', ->
      callback = sinon.spy()
      new Contents()
        .setObserver
          append: callback
        .append()
      assert.isTrue callback.called, true

  describe '.remove', ->

    it 'コールバックが呼び出されるか', ->
      callback = sinon.spy()
      new Contents()
        .setObserver
          remove: callback
        .remove()
      assert.isTrue callback.called, true

  describe '.setContents, .getContents', ->
    it 'jQueryオブジェクトをセット、ゲットできるか', ->
      jobj = $ '<div>'
      contents = new Contents()
        .setContents jobj
      assert.strictEqual contents.getContents(), jobj

    it 'jQueryオブジェクト以外をセットした時に例外が発生するか', ->
      assert.throw ->
        new Contents()
          .setContents 'test'
