
class exports.HomeView extends Backbone.View

  id: 'home-view'
  HomeTemplate = require '/views/templates/home'

  render: ->
  	
    @$el.html HomeTemplate()
    @

class exports.TodoView extends Backbone.View

 	id: 'todo-view'
 	ListTemplate = require '/views/templates/todo'

 	events:
 		'click .check' : 'toggleDone',
 		'dblclick div.todo-content' : 'edit',
		'click span.todo-destroy'   : 'clear',
		'keypress .todo-input'      : 'updateOnEnter'

  initialize: ->
		@model.bind('change', this.render);
		@model.view = this;

  render: ->
    this.$(@el).html( @template(@model.toJSON()) )
    @setContent()
    return this

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