require 'bind-polyfill.js'
$ = require 'jquery'
ContentsObserver = require 'contentsObserver.coffee'
Contents = require 'contents.coffee'

describe 'ContentsObserverクラス', ->

  describe 'new', ->

    it 'z-indexを指定しない場合、styleが付与されないか', ->
      zindex = new ContentsObserver()
        .getContents()
        .css 'z-index'
      assert.strictEqual zindex, ''

    it 'z-indexを指定した場合、styleが付与されるか', ->
      zindex = new ContentsObserver 0
        .getContents()
        .css 'z-index'
      assert.strictEqual zindex, '0'

  describe '.setZindex, .getZindex', ->

    it '0を設定して0が取得できるか', ->
      zindex = new ContentsObserver()
        .setZindex 0
        .getZindex()
      assert.strictEqual zindex, 0

  describe '.append', ->

    it '単純に呼び出し', ->
      new ContentsObserver 0
        .append new Contents()

    it 'contentsに追加されているか', ->
      child = new Contents()
        .setContents $ '<div id="test-child">'
      length = new ContentsObserver 0
        .append child
        .getContents()
        .find '#test-child'
        .length
      assert.strictEqual length, 1

    it 'z-indexに1000を指定して、appendした要素に1001が付与されるか', ->
      child = new Contents()
        .setContents $ '<div>'
      new ContentsObserver 1000
        .append child
      zindex = child.getContents()
        .css 'z-index'
      assert.strictEqual zindex, '1001'

    it 'z-indexに1000を指定して、2つappendしたあと2つめの要素に1002が付与されるか', ->
      child = new Contents()
        .setContents $ '<div>'
      child2 = new Contents()
        .setContents $ '<div>'
      new ContentsObserver 1000
        .append child
        .append child2
      zindex = child2.getContents()
        .css 'z-index'
      assert.strictEqual zindex, '1002'

    it 'z-indexに1000を指定して、2つappendしたあと1つめの要素に1001が付与されるか', ->
      child = new Contents()
        .setContents $ '<div>'
      child2 = new Contents()
        .setContents $ '<div>'
      new ContentsObserver 1000
        .append child
        .append child2
      zindex = child.getContents()
        .css 'z-index'
      assert.strictEqual zindex, '1001'

  describe '.remove', ->

    it '単純に呼び出し', ->
      child = new Contents()
      new ContentsObserver 0
        .append child
        .remove child

    it 'contentsから削除されているか', ->
      child = new Contents()
        .setContents $ '<div id="test-child">'
      observer = new ContentsObserver 0
        .append child
        .remove child
      length = observer.getContents()
        .find '#test-child'
        .length
      assert.strictEqual length, 0

    it 'z-indexに1000を指定して、2つappendしたあと1つめをremove,2つめの要素に1001が付与されるか', ->
      child = new Contents()
        .setContents $ '<div>'
      child2 = new Contents()
        .setContents $ '<div>'
      new ContentsObserver 1000
        .append child
        .append child2
        .remove child
      zindex = child2.getContents()
        .css 'z-index'
      assert.strictEqual zindex, '1001'
