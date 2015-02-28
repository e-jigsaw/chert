React = require 'react'
Immutable = require 'immutable'
Note = require './note'

module.exports = React.createClass
  displayName: 'notebook'
  styles:
    container:
      padding: '.5em 1em .5em 1em'
    newButton:
      fontSize: '1.5em'
      padding: '.1em .8em .1em .8em'

  componentDidMount: ->
    @socket = io()
    @socket.on 'created', (message)->
      console.log message
    @socket.on 'updated', (data)=>
      @setState
        notes: @state.notes.map (note)->
          if note.data.id is data._id
            note.data = data
            note
          else note

  getInitialState: ->
    notes = @props.notes.map (data)->
      data: data
      config:
        cursor:
          row: 0
          column: 0
    notes: Immutable.List notes

  new: ->
    @socket.emit 'new',
      id: @props.id

  run: (updatedNote)->
    @setState
      notes: @state.notes.map (note)->
        if note._id is updatedNote.data._id then updatedNote else note
    , => @socket.emit 'update', updatedNote.data

  notes: -> @state.notes.map (note)=>
    React.createElement Note,
      key: "#{note.data._id}"
      id: note.data._id
      type: note.data.type
      body: note.data.body
      result: note.data.result
      cursor: note.config.cursor
      run: @run

  render: ->
    React.DOM.div
      key: 'notebook-container'
      style: @styles.container
    , [
      React.DOM.div
        key: 'notebook-notes-container'
      , @notes().toArray()
      React.DOM.button
        key: 'notebook-new-note-button'
        className: 'pure-button pure-button-primary'
        style: @styles.newButton
        onClick: @new
      , '+'
    ]
