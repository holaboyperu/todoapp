### TodoItem Model ###

# Our basic **TodoItem** model has `content`, `order`, and `done` attributes.
class exports.TodoItem extends Backbone.Model
  # Default attributes for the todo.
  defaults:
    content: "empty todo..."
    done: false

  # Ensure that each todo created has `content`.
  initialize: ->
    if !@get("content")
        @set({ "content": @defaults.content })

  # Toggle the `done` state of this todo item.
  toggle: ->
    @save({ done: !@get("done") })

  # Remove this TodoItem from *localStorage* and delete its view.
  clear: ->
    @destroy()
    @view.remove()

### Todo Collection ###

class exports.TodoList extends Backbone.Collection

  # Reference to this collection's model.
  model: exports.TodoItem

  # Save all of the todo items under the `"todos"` namespace.
  localStorage: new Store("todos")

  # Attribute getter/setter
  getDone = (todo) ->
    return todo.get("done")

  # Filter down the list of all todo items that are finished.
  done: ->
    return @filter( getDone )

  # Filter down the list to only todo items that are still not finished.
  remaining: ->
    return @without.apply( this, @done() )

  # We keep the OurTodos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    return 1 if !@length
    return @last().get('order') + 1

  # OurTodos are sorted by their original insertion order.
  comparator: (todo) ->
    return todo.get("order")
