React = require 'react'
header = require './header'
toppage = require './toppage'
notebook = require './notebook'

module.exports = React.createClass
  displayName: 'App'
  render: ->
    React.DOM.div
      key: 'container'
    , [
      React.createElement header
      switch
        when @props.routes is '/' then React.createElement toppage
        when @props.routes.match /^\/n\//
          React.createElement notebook,
            id: @props.routes.split('/')[2]
            notes: @props.initialData.notes
    ]
