React = require 'react'
Controller = require './noteController'
Result = require './noteResult'

module.exports = React.createClass
  displayName: 'note'
  styles:
    container:
      border: '1px solid #b6b6b6'
      borderRadius: '5px'
      padding: '.3em'
    editor:
      height: '300px'

  getInitialState: ->
    type: @props.type

  run: ->
    @props.run
      data:
        id: @props.id
        type: @state.type
        body: @editor.getValue()
      config:
        cursor: @editor.getCursorPosition()

  ace: (opt)->
    @editor = ace.edit "#{@props.id}-note-body"
    @editor.setTheme 'ace/theme/chrome'
    @editor.getSession().setMode 'ace/mode/markdown'
    @editor.setValue @props.body
    @editor.clearSelection()
    @editor.moveCursorToPosition @props.cursor
    @editor.focus() if opt.focus
    @editor.commands.addCommand
      name: 'run'
      bindKey:
        mac: 'Command-Enter'
        wind: 'Ctrl-Enter'
      exec: => @run()

  componentDidMount: ->
    @ace
      focus: false

  componentDidUpdate: ->
    @ace
      focus: true

  render: ->
    React.DOM.div
      key: "#{@props.id}-note-container"
      style: @styles.container
    , [
      React.createElement Controller,
        key: "#{@props.id}-note-controller"
        id: @props.id
        run: @run
        type: @state.type
        typeChange: @typeChange
      React.DOM.div
        key: "#{@props.id}-note-body"
        id: "#{@props.id}-note-body"
        style: @styles.editor
      React.createElement Result,
        key: "#{@props.id}-note-result"
        id: @props.id
        data: @props.result
        type: @state.type
    ]
