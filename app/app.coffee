module.exports = Application =

  initialize: ->
    window.DEBUG_MODE = yes
    @stateChart = Stativus.createStatechart()

    # require 'states/app'
    require 'states/inputting'
    

    @stateChart.initStates('Input State');
