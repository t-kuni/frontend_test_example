index = require 'index.coffee'

module.exports =
  twice: (val) ->
    index.add val, val
