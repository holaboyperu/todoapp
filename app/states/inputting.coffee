# The first time you opn the app you will be given the option of input

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
		# create a view that renders a form
		{InputFormView} = require 'views/form_view'
		app.inputFormView = new InputFormView

		app.inputFormView.render()

		app.inputLayoutView.regions.inputForm app.inputFormView.el

  exitState: ->
  	# close the view that you created
  	app.inputFormView.close()