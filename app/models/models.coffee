class exports.TodoItem extends Backbone.Model

  defaults:
    content: 'empty todo..'
    done: false

  initialize: ->
    if !@get('content')
      @set({ 'content' : @defaults.content})

  toggle: ->
    @save({ done: !@get( 'done' ) })

  clear: ->
    @destroy()
    @view.remove()


class exports.TodoList extends Backbone.Marionette.CollectionView

  model: TodoItem

  localStorage: new Store('todos')

  getDone = (todo) ->
    return todo.get('done')

  done: ->
    return @filter ( getDone )

  remaining: ->
    return @without.apply( this, @done() )

  nextOrder: ->
    return 1 if !@length
    return @last().get('order') + 1

  comparator: (todo) ->
    return todo.get('order')