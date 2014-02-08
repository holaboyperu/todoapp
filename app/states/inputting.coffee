# The first time you open the app you will be given the option of input

app.stateChart.addState 'Input State',

  initialSubstate: 'Input State > Form Empty'

  enterState: ->
    # create a view that renders a form
    {InputLayoutView} = require 'views/form_view'
    app.inputLayoutView = new InputLayoutView

    app.inputLayoutView.render()
    $('body').html app.inputLayoutView.el

  exitState: ->
    # close the view that you created
    app.inputLayoutView.close()


app.stateChart.addState 'Input State > Form Empty',

  parentState: 'Input State'

  enterState: ->
    console.warn 'mambo'
    {TodoList} = require 'models/models' 
    OurTodos = new TodoList

    {TodoItem} = require 'models/models' 
    SingleTodo = new TodoItem

    # create a view that renders a form
    {InputFormView} = require 'views/form_view'
    app.inputFormView = new InputFormView
      model: OurTodos

    app.inputFormView.on 'todo:new', (todoMessage) ->
      console.warn 'got a new todo: ' + todoMessage

      OurTodos.create({
        content: todoMessage
        order: OurTodos.nextOrder()
        done: no
      })

    app.inputLayoutView.inputRegion.show app.inputFormView

  exitState: ->
    # close the view that you created
    app.inputFormView.close()
