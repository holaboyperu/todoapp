class exports.InputLayoutView extends Backbone.Marionette.Layout

  template: require 'views/templates/inputlayout'

  regions:
    inputRegion: '#input-form'
    reviewRegion: '#review-link'

class exports.InputFormView extends Backbone.Marionette.ItemView

  template: require 'views/templates/inputform'

  # Delegated events for creating new items, and clearing completed ones.
  events:
    "keypress #input-todo"  : "createOnEnter",
    "keyup #input-todo"     : "showTooltip",
    "click .todo-clear a" : "clearCompleted"

  #collectionEvents:
  #  'add': 'addOne'
  #  'reset': 'addAll'
  #  'all': 'render'

  ui:
    input: '#input-todo'

  # If you hit return in the main input field, create new **TodoItem** model,
  # persisting it to *localStorage*.
  createOnEnter: (e) ->
    console.warn 'tango'
    return if (e.keyCode != 13)
    e.preventDefault()
    @trigger 'todo:new', @ui.input.val()

    #@model.create( @newAttributes() )
    @ui.input.val('')

  # Clear all done todo items, destroying their models.

  clearCompleted: ->
    _.each(@model.done(), (todo) ->
      todo.clear()
    )
    return false

  # Lazily show the tooltip that tells you to press `enter` to save
  # a new todo item, after one second.

  # showTooltip: (e) ->
  #   tooltip = this.$(".ui-tooltip-top")
  #   val = @input.val()
  #   tooltip.fadeOut()
  #   clearTimeout(@tooltipTimeout) if (@tooltipTimeout)
  #   return if (val is '' || val is @input.attr("placeholder"))
    
  #   show = () ->
  #     tooltip.show().fadeIn()
  #   @tooltipTimeout = _.delay(show, 1000)
