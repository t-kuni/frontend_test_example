$ = require 'jquery'

module.exports = class Showable

  contents: $ ''

  getContents: ->
    return @contents

  setContents: (contents)->
    if not (contents instanceof $)
      throw new Error '引数はjQueryオブジェクトである必要があります'
    @contents = contents
    return @

  notifyShowing: ->

  notifyHiding: ->

  setNotifyShowing: (notifyShowing) ->
    @notifyShowing = notifyShowing
    return @

  setNotifyHiding: (notifyHiding) ->
    @notifyHiding = notifyHiding
    return @

  show: ->
    @notifyShowing @
    return @

  hide: ->
    @notifyHiding @
    return @

  spawn: (showable) ->
    return showable
      .setNotifyShowing @notifyShowing
      .setNotifyHiding @notifyHiding
