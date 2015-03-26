$ = require 'jquery'

jade = require 'modal.jade'
require 'modal.sass'

module.exports = class Modal
  _zindex = 2015

  obj: null

  getHtml: ->
    return ''

  onClickCover: ->
    @obj.remove()

  constructor: ->
    @obj = $ jade()
      .css
        'z-index': _zindex += 1
        'margin-top': $(window).scrollTop()

    @obj.find '.modal-cover'
      .click =>
        @onClickCover()

    @obj.find '.modal-contents-cover'
      .click ->
        console.log 'onclick'

    html = @getHtml()
    @obj.find '.modal-contents'
      .append html

