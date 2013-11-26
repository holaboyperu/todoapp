window.app = require './app'

$ ->
  window.app.initialize()

  Backbone.history.start()
