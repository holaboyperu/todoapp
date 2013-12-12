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

    setTimeout =>
      @goToState 'Adding a Todo'
    , 2000

  exitState: ->
    
    app.homeView.close()

app.stateChart.addState 'Adding a Todo',

  parentState: 'Todo App'

app.stateChart.addState 'Deleting a Todo',

  parentState: 'Todo App'

app.stateChart.addState 'Update an existing Todo',

  parentState: 'Todo App'
