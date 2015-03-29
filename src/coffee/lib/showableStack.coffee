$ = require 'jquery'

Showable = require 'showable.coffee'
jade = require 'showableStack.jade'
require 'showableStack.sass'

module.exports = class ShowableStack extends Showable

  hasZindex: ->
    return typeof @zindex isnt 'undefined'

  getZindex: ->
    return @zindex

  setZindex: (zindex) ->
    @zindex = zindex
    @getContents().css
      'z-index': @zindex

    $.each @stack, (index, obj) =>
      obj.css
        'z-index': @zindex + index + 1

    return @

  nextZindex: ->
    return @zindex + @stack.length + 1

  constructor: (zindex) ->
    @stack = []
    @
      .setContents $ jade()
      .setNotifyShowing @push
      .setNotifyHiding @pop

    if typeof zindex isnt 'undefined'
      @setZindex zindex

  push: (showable) =>
    target = showable.getContents()
      .css
        'z-index': @nextZindex()
    @stack.push target
    @contents.append target
    return @

  pop: =>
    @stack.pop().remove()
