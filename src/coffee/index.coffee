$ = require 'jquery'
jade = require 'index.jade'
Modal = require 'modal.coffee'
HelloModal = require 'helloModal.coffee'

$ ->
  # $ 'body'
    # .append jade
    #   text: 'data binding here!'

  $ 'button'
    .click ->
      helloModal = new HelloModal()
      $ 'body'
        .append helloModal.obj
