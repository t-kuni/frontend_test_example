$ = require 'jquery'
jade = require 'index.jade'

Contents = require 'contents.coffee'
ContentsObserver = require 'contentsObserver.coffee'
ContentsModal = require 'contentsModal.coffee'

$ ->
  observer = new ContentsObserver()
  hello = new Contents()
    .setContents $ '<h1>Contents!!</h1>'
  modalHello = new ContentsModal hello
    .setContents $ '<h1>aaAAAAAAAAA!!</h1>'
    .setObserver observer
    .append()

  $ 'body'
    .append observer.getContents()
  
  # $ 'button'
  #   .click ->
