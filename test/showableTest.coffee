require 'bind-polyfill.js'
$ = require 'jquery'
Showable = require 'showable.coffee'
ShowableStack = require 'showableStack.coffee'

describe 'Showableクラス', ->

  describe 'new', ->

    it '引数なし', ->
      new Showable()

  describe '.show', ->

    it 'コールバックが呼び出されるか', ->
      callback = sinon.spy()
      new Showable()
        .setNotifyShowing callback
        .show()
      assert.isTrue callback.called, true

  describe '.hide', ->

    it 'コールバックが呼び出されるか', ->
      callback = sinon.spy()
      new Showable()
        .setNotifyHiding callback
        .hide()
      assert.isTrue callback.called, true

  describe '.spawn', ->

    it 'spawnしたオブジェクトからshow, hideを行って、コールバックが呼び出されるか', ->
      cbShow = sinon.spy()
      cbhide = sinon.spy()
      parent = new Showable()
        .setNotifyShowing cbShow
        .setNotifyHiding cbhide
      parent.spawn(new Showable())
        .show()
        .hide()
      assert.isTrue cbShow.called
      assert.isTrue cbhide.called

  describe '.setContents, .getContents', ->
    it 'jQueryオブジェクトをセット、ゲットできるか', ->
      jobj = $ '<div>'
      showable = new Showable()
        .setContents jobj
      assert.strictEqual showable.getContents(), jobj

    it 'jQueryオブジェクト以外をセットした時に例外が発生するか', ->
      assert.throw ->
        new Showable()
          .setContents 'test'
