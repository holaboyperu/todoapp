
class exports.HomeView extends Backbone.Marionette.ItemView

  id: 'home-view'

  template: require '/views/templates/home'


class Todo extends Backbone.Model

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


class TodoList extends Backbone.Marionette.CollectionView

  model: Todo

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


class exports.TodoView extends Backbone.Marionette.ItemView

 	id: 'todo-view'

 	template: require '/views/templates/todo'

 	events:
    'click .check': 'toggleDone',
    'dblclick div.todo-content': 'edit',
    'click span.todo-destroy': 'clear',
    'keypress .todo-input': 'updateOnEnter'

  modelEvents:
    'change': 'render'

  onShow: ->
    @setContent()

  setContent: ->
    content = @model.get('content')
    this.$('.todo-content').text(content)
    @input = this.$('.todo-input');
    @input.bind('blur', @close);
    @input.val(content);

  toggleDone: ->
    @model.toggle()

  edit: ->
    this.$(@el).addClass("editing")
    @input.focus()

  close: ->
    @model.save({ content: @input.val() })
    $(@el).removeClass("editing")

  updateOnEnter: (e) ->
    @close() if e.keyCode is 13

  remove: ->
    $(@el).remove()

  clear: ->
    @model.clear()

class AppView extends Backbone.Marionette.ItemView

  el_tag = "#todoapp"
  el: $(el_tag)

  statsTemplate: _.template( $("#stats-template").html() )

  events:
    'keypress #new-todo' : 'createOnEnter'
    'click .todo-clear a' : 'clearCompleted'

  initialize: =>
    @input = this.$("#new-todo")

    Todos.on('add', @addOne)
    Todos.on('reset', @addAll)
    Todos.on('all', @render)

    Todos.fetch()

  render: =>
    this.$('#todo-stats').html( @statsTemplate({
      total: Todos.length,
      done: Todos.done().length,
      remaining: Todos.remaining().length
      }))

  addOne: (todo) =>
    view  = new TodoView( {model: todo} )
    this.$('#todo-list').append( view.render().el )

  addAll: =>
    Todos.each( @addOne );

  newAttributes: ->
    return {
      content: @input.val(),
      order: Todos.nextOrder(),
      done: false
    }

  createOnEnter: (e) ->
    return if (e.keyCode != 13)
    Todos.create( @newAttributes() )
    @input.val('')

  clearCompleted: ->
    _.each(Todos.done(), (todo) ->
      todo.clear()
    )
    return false

Todos = new TodoList
App = new AppView()