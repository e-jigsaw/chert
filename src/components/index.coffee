React = require 'react'
header = require './header'
toppage = require './toppage'

module.exports = React.createClass
  displayName: 'App'
  render: ->
    React.DOM.div
      key: 'container'
    , [
      React.createElement header
      switch
        when @props.routes is '/' then React.createElement toppage
    ]
