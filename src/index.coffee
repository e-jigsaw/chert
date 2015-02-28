React = require 'react'
App = require './components/index'

React.render React.createElement(App, {routes: location.pathname}), document.getElementById('app')
