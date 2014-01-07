class exports.InputLayoutView extends Backbone.Marionette.Layout

  template: require('/views/templates/inputlayout')

  regions:
    inputForm: '#input-form'
    reviewLink: '#review-link'


class exports.InputFormView extends Backbone.Marionette.ItemView

	id: 'input-view'

	template: require '/views/templates/inputform'

	el_tag = "#app-wrapper"
	el: $(el_tag)

  events:
    "keypress #input-todo"  : "createOnEnter",
    "keyup #input-todo"     : "showTooltip",
    "click .todo-clear a" : "clearCompleted"


	# statsTemplate: _.template( $("#stats-template").html() )

	events:
		'keypress #new-todo' : 'createOnEnter'
		'click .todo-clear a' : 'clearCompleted'

  # initialize: =>
	 #  @input = this.$("#new-todo")

	 #  Todos.on('add', @addOne)
	 #  Todos.on('reset', @addAll)
	 #  Todos.on('all', @render)

	 #  Todos.fetch()

	# #this will render the list of  todos (this should be in the review)
 #  render: =>
 #    this.$('#todo-stats').html( @statsTemplate({
 #      total: Todos.length,
 #      done: Todos.done().length,
 #      remaining: Todos.remaining().length
 #      }))



	# addOne: (todo) =>
	#   view  = new TodoView( {model: todo} )
	#   this.$('#todo-list').append( view.render().el )

 #  addAll: =>
 #    Todos.each( @addOne );

 #  newAttributes: ->
 #    return {
 #      content: @input.val(),
 #      order: Todos.nextOrder(),
 #      done: false
 #    }

 #  createOnEnter: (e) ->
 #    return if (e.keyCode != 13)
 #    Todos.create( @newAttributes() )
 #    @input.val('')

 #  clearCompleted: ->
 #    _.each(Todos.done(), (todo) ->
 #      todo.clear()
 #    )
 #    return false



# Im not sure where these sould be
# Todos = new TodoList
# App = new InputFormView()