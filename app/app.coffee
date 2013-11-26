module.exports = Application =

  initialize: ->

    @.todoAppStatechart = Stativus.createStatechart()

    require 'states/list'

    @.todoAppStatechart.initStates('Todo List');
