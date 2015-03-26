$ = require 'jquery'

Modal = require 'modal.coffee'
require 'helloModal.sass'

module.exports = class HelloModal extends Modal

  constructor: ->
    super()
    @obj.find 'button'
      .click ->
        child = new HelloModal
        $ 'body'
          .append child.obj

  getHtml: ->
    jade = require 'helloModal.jade'
    jade()
