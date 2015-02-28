React = require 'react'

module.exports = React.createClass
  displayName: 'noteController'
  styles:
    select:
      marginRight: '.4em'

  render: ->
    React.DOM.div
      key: "#{@props.id}-note-controller-container"
      className: 'pure-form'
    , [
      React.DOM.select
        key: "#{@props.id}-note-controller-select"
        style: @styles.select
      , [
        React.DOM.option
          key: "#{@props.id}-note-controller-select-md"
        , 'Markdown'
      ]
      React.DOM.button
        key: "#{@props.id}-note-controller-run"
        className: 'pure-button pure-button-primary'
        onClick: @props.run
      , '▶Run'
    ]
