$ = require 'jquery'

module.exports = class Contents

  contents: $ ''

  getContents: ->
    @contents

  setContents: (contents)->
    if not (contents instanceof $)
      throw new Error '引数はjQueryオブジェクトである必要があります'
    @contents = contents
    @

  setObserver: (observer) ->
    @observer = observer
    @

  append: ->
    @observer.append @
    @

  remove: ->
    @observer.remove @
    @
