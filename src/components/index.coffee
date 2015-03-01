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
        when @props.routes is '/'
          React.createElement toppage,
            key: 'toppage-element'
            notebooks: @props.initialData
        when @props.routes.match /^\/n\//
          React.createElement notebook,
            key: 'notebook-element'
            id: @props.routes.split('/')[2]
            name: @props.initialData.name
            notes: @props.initialData.notes
    ]
