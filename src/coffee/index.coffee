$ = require 'jquery'
jade = require 'index.jade'

$ ->
  $ 'body'
    .append jade
      text: 'data binding here!'
