require! {
  react: {Component, DOM, createElement}
  \./noteController : Controller
  \./noteResult : Result
  \../adapters.config : config
}

module.exports = class Note extends Component
  (props)->
    @state =
      type: props.type

  displayName: \note
  styles:
    container:
      border: '1px solid #b6b6b6'
      borderRadius: \5px
      padding: \.3em
      marginBottom: \2em
    editor:
      height: \300px

  run: ~>
    @props.run do
      data:
        id: @props.id
        type: @state.type
        body: @editor.getValue!
      config:
        cursor: @editor.getCursorPosition!

  typeChange: (event)~>
    @setState do
      type: event.target.value
      , ~> @ace!

  ace: (opt)->
    @editor = ace.edit "#{@props.id}-note-body"
    @editor.setTheme \ace/theme/chrome
    @editor.getSession!.setMode config[@state.type].theme
    @editor.setValue @props.body
    @editor.clearSelection!
    @editor.moveCursorToPosition @props.cursor
    @editor.focus!
    @editor.commands.addCommand do
      name: \run
      bindKey:
        mac: \Command-Enter
        wind: \Ctrl-Enter
      exec: ~> @run!

  componentDidMount: ->
    @ace!

  render: ->
    DOM.div do
      key: "#{@props.id}-note-container"
      style: @styles.container
      , [
        createElement Controller,
          key: "#{@props.id}-note-controller"
          id: @props.id
          run: @run
          type: @state.type
          typeChange: @typeChange
        DOM.div do
          key: "#{@props.id}-note-body"
          id: "#{@props.id}-note-body"
          style: @styles.editor
        createElement Result,
          key: "#{@props.id}-note-result"
          id: @props.id
          data: @props.result
          type: @state.type
      ]
