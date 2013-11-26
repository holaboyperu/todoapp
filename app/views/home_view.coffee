
class exports.HomeView extends Backbone.View

  id: 'home-view'
  HomeTemplate = require ('/views/templates/home')

  render: ->
  	
    @$el.html HomeTemplate()
    @
