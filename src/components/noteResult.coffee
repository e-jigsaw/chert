React = require 'react'

module.exports = React.createClass
  displayName: 'noteResult'
  styles:
    container:
      minHeight: '300px'

  generate: ->
    switch @props.type
      when 'md'
        [
          React.DOM.div
            key: "#{@props.id}-note-result-body"
            dangerouslySetInnerHTML:
              __html: @props.data
        ]

  render: ->
    React.DOM.div
      key: "#{@props.id}-note-result-container"
      style: @styles.container
    , @generate()
