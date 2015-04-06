require! {
  react: {Component, createElement, DOM}
  immutable: Immutable
  \./Note
  \./noteName : Name
}

module.exports = class Notebook extends Component
  (props)->
    @state =
      notes: props.notes.map (data)->
        data: data
        config:
          cursor:
            row: 0
            column: 0
      |> Immutable.List
      name: props.name

  displayName: 'notebook'
  styles:
    container:
      padding: '.5em 1em .5em 1em'
    newButton:
      fontSize: \1.5em
      padding: '.1em .8em .1em .8em'

  componentDidMount: ->
    @socket = io!
    @socket.on \notebook:created, (message)->
      console.log message
    @socket.on \note:updated, (data)~>
      @setState do
        notes: @state.notes.map (note)->
          if note.data._id is data._id
            note.data = data
            note
          else note

  new: ~>
    @socket.emit \notebook:new,
      id: @props.id

  run: (updatedNote)~>
    @socket.emit \note:update, updatedNote.data

  changeName: (newName)->
    @socket.emit \notebook:changeName,
      id: @props.id
      name: newName

    @setState do
      name: newName

  toggleExpand: (id)~>
    @socket.emit \note:toggleExpand, id: id

  notes: -> @state.notes.map (note)~>
    createElement Note,
      key: "#{note.data._id}"
      id: note.data._id
      type: note.data.type
      body: note.data.body
      result: note.data.result
      isExpand: note.data.isExpand
      cursor: note.config.cursor
      run: @run
      toggleExpand: @toggleExpand

  render: ->
    DOM.div do
      key: \notebook-container
      style: @styles.container
      [
        createElement Name,
          key: "#{@props.id}-name"
          data: @state.name
          changeName: @changeName
        DOM.div do
          key: \notebook-notes-container
          @notes!.toArray!
        DOM.button do
          key: \notebook-new-note-button
          className: 'pure-button pure-button-primary'
          style: @styles.newButton
          onClick: @new
          \+
      ]
