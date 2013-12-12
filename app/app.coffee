module.exports = Application =

  initialize: ->

    @stateChart = Stativus.createStatechart()

    require 'states/app'

    @stateChart.initStates('Todo App');
