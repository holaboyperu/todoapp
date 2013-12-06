##
## First time in the app

app.todoAppStatechart.addState 'Todo List',

  enterState: ->

    console.warn 'entered Home View sTATE LALA'

    #Router = require('router')
    #router = new Router()
    console.warn 'jeje'
    {HomeView} = require 'views/home_view'
    app.homeView = new HomeView()
    app.homeView.render()

    $('body').html app.homeView.el
