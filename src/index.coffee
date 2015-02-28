React = require 'react'
App = require './components/index'

React.render React.createElement(App,
  routes: location.pathname
  initialData: JSON.parse document.getElementById('initialData').getAttribute('data-json')
), document.getElementById('app')
