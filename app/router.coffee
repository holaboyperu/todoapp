application = require('app');

module.exports = class Router extends Backbone.Router

  routes:
    '': 'home'

  home: ->
    console.warn '/ home route called'
