{Component, DOM, createElement} = require \react
require! \./Header
require! \./Toppage
require! \./Notebook

module.exports = class App extends Component
  displayName: \App

  render: ->
    DOM.div do
      key: \container
      , [
        createElement Header
        switch
          when @props.routes is \/
            createElement Toppage,
              key: \toppage-element
              notebooks: @props.initialData
          when @props.routes.match /^\/n\//
            createElement Notebook,
              key: \notebook-element
              id: @props.routes.split('/')[2]
              name: @props.initialData.name
              notes: @props.initialData.notes
      ]
