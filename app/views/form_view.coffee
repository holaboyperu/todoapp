class exports.InputLayoutView extends Backbone.Marionette.Layout

  template: require 'views/templates/inputlayout'

  regions:
    inputRegion: '#input-form'
    reviewRegion: '#review-link'


class exports.InputFormView extends Backbone.Marionette.ItemView

  # WHY IS THIS TEMPLATE NOT RENDERING
  template: require 'views/templates/inputform'
  onShow: ->
    console.warn 'hello'

  onRender: ->
    console.warn 'hi Render is first I guess'

