{Component, createElement, DOM} = require \react
Immutable = require \immutable
require! \./Note
Name = require \./noteName

module.exports = class Notebook extends Component
  displayName: 'notebook'
  styles:
    container:
      padding: '.5em 1em .5em 1em'
    newButton:
      fontSize: \1.5em
      padding: '.1em .8em .1em .8em'

  componentDidMount: ->
    @socket = io!
    @socket.on \created , (message)->
      console.log message
    @socket.on \updated , (data)~>
      @setState do
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
    name: @props.name

  new: ->
    @socket.emit \new ,
      id: @props.id

  run: (updatedNote)->
    @setState do
      notes: @state.notes.map (note)->
        if note._id is updatedNote.data._id then updatedNote else note
      , ~> @socket.emit \update , updatedNote.data

  changeName: (newName)->
    @socket.emit \changeName ,
      id: @props.id
      name: newName
    @setState do
      name: newName

  notes: -> @state.notes.map (note)~>
    createElement Note,
      key: "#{note.data._id}"
      id: note.data._id
      type: note.data.type
      body: note.data.body
      result: note.data.result
      cursor: note.config.cursor
      run: @run

  render: ->
    DOM.div do
      key: \notebook-container
      style: @styles.container
      , [
        createElement Name,
          key: "#{@props.id}-name"
          data: @state.name
          changeName: @changeName
        DOM.div
          key: \notebook-notes-container
          , @notes!.toArray!
        DOM.button
          key: \notebook-new-note-button
          className: 'pure-button pure-button-primary'
          style: @styles.newButton
          onClick: @new
          , \+
      ]
