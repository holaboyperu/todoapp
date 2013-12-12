
class exports.HomeView extends Backbone.Marionette.ItemView

  id: 'home-view'

  template: require '/views/templates/home'





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