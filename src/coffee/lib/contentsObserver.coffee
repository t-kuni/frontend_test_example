$ = require 'jquery'

Contents = require 'contents.coffee'
jade = require 'contentsObserver.jade'
require 'contentsObserver.sass'

module.exports = class ContentsObserver

  getContents: ->
    @contents

  setContents: (contents) ->
    @contents = contents
    @

  hasZindex: ->
    typeof @zindex isnt 'undefined'

  getZindex: ->
    @zindex

  setZindex: (zindex) ->
    @zindex = zindex
    @

  updateZindex: ->
    if @hasZindex
      @getContents().css
        'z-index': @zindex

      @getContents().children '.contents-observer-item'
        .each (index, elem) =>
          $(elem).css
            'z-index': @zindex + index + 1
    @

  constructor: (zindex) ->
    @setContents $ jade()
      .setZindex zindex
      .updateZindex()

  append: (contents) =>
    target = contents.getContents()
      .addClass 'contents-observer-item'
    @getContents().append target
    @updateZindex()
    @

  remove: (contents) =>
    contents.getContents().remove()
    @updateZindex()
    @
