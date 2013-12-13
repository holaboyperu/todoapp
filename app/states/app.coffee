##
## First time in the app

app.stateChart.addState 'Todo App',

  initialSubstate: 'Todo App > Todo List'

  enterState: ->
    console.warn 'entered'


app.stateChart.addState 'Todo App > Todo List',

  parentState: 'Todo App'

  enterState: ->

    #Router = require('router')
    #router = new Router()
    {HomeView} = require 'views/home_view'
    app.homeView = new HomeView()
    app.homeView.render()

    $('body').html app.homeView.el

  exitState: ->
    
    app.homeView.close()

app.stateChart.addState 'Todo App > Adding a Todo',

  parentState: 'Todo App'

  enterState: ->
    # here where I create a function that add a todo
  exitState: ->

app.stateChart.addState 'Todo App > Deleting a Todo',

  parentState: 'Todo App'

app.stateChart.addState 'Todo App > Update an existing Todo',

  parentState: 'Todo App'
