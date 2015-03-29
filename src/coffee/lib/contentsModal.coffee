$ = require 'jquery'

jade = require 'contentsModal.jade'
require 'contentsModal.sass'
Contents = require 'contents.coffee'

module.exports = class ContentsModal extends Contents

  constructor: (source) ->
    @source = source
    # contents生成

  setContents: (contents) ->
    @source.setContents contents
    # setContentsをラップしてやる必要あり
    #

  getContents: ->
    if typeof @cache is 'undefined'
      @cache = $ jade()
      contents = @source.getContents()
        .addClass 'contents-modal-item'
        .css
          'margin-top': $(window).scrollTop()
      @cache.append contents
      # contentsの位置のみ更新？
    @cache
