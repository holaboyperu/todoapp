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

  {TodoList} = require 'models/models' 
  OurTodos = new TodoList

  # At initialization we bind to the relevant events on the `OurTodos`
  # collection, when items are added or changed. Kick things off by
  # loading any preexisting todos that might be saved in *localStorage*.
  initialize: =>
    @input = this.$("#input-todo")

    # OurTodos.on("add", @addOne)
    # OurTodos.on("reset", @addAll)
    # OurTodos.on("all", @render)

    # OurTodos.fetch()

  # Generate the attributes for a new TodoItem item.
  newAttributes: ->
    return {
      content: @input.val(),
      order:   OurTodos.nextOrder(),
      done:    false
    }

  # If you hit return in the main input field, create new **TodoItem** model,
  # persisting it to *localStorage*.
  createOnEnter: (e) ->
    return if (e.keyCode != 13)
    OurTodos.create( @newAttributes() )
    @input.val('')

  # Clear all done todo items, destroying their models.
  clearCompleted: ->
    _.each(OurTodos.done(), (todo) ->
      todo.clear()
    )
    return false

  # Generate the attributes for a new TodoItem item.
  newAttributes: ->
    return {
      content: @input.val(),
      order:   OurTodos.nextOrder(),
      done:    false
    }

  # Lazily show the tooltip that tells you to press `enter` to save
  # a new todo item, after one second.
  showTooltip: (e) ->
    tooltip = this.$(".ui-tooltip-top")
    val = @input.val()
    tooltip.fadeOut()
    clearTimeout(@tooltipTimeout) if (@tooltipTimeout)
    return if (val is '' || val is @input.attr("placeholder"))
    
    show = () ->
      tooltip.show().fadeIn()
    @tooltipTimeout = _.delay(show, 1000)
