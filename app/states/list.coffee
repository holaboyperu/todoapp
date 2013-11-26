##
## First time in the app

app.todoAppStatechart.addState 'Todo List',

  enterState: ->

    console.warn 'entered Home View sTATE LALA'

    #Router = require('router')
    #router = new Router()
    console.warn 'jeje'
    HomeView = require('views/home_view')
    app.views.homeView = new HomeView()

    $('body').html app.views.homeView.render().el
