$ = require 'jquery'
html = require 'modal.html'
require 'modal.sass'

module.exports =
  open: ->
    $ 'body'
      .append html
      .find '#modal'
      .hide()
      .fadeIn 2000
