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
      isExpand: props.isExpand
      height: \300px

  displayName: \note
  styles:
    container:
      border: '1px solid #b6b6b6'
      borderRadius: \5px
      padding: \.3em
      marginBottom: \2em

  run: ~>
    @props.run do
      data:
        id: @props.id
        type: @state.type
        body: @editor.getValue!
      config:
        cursor: @editor.getCursorPosition!

  toggleExpand: ~>
    @setState do
      isExpand: !@state.isExpand
      ~>
        @props.toggleExpand @props.id

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
    @editor.on \change, @resizeHeight
    @editor.setOption \maxLines, Infinity
    @editor.commands.addCommand do
      name: \run
      bindKey:
        mac: \Command-Enter
        wind: \Ctrl-Enter
      exec: ~> @run!

  resizeHeight: ~>
    lines = document.getElementsByClassName \ace_line
    height = lines[0].clientHeight
    @setState do
      height: "#{@editor.session.getLength! * height}px"

  editorStyle: ->
    if @state.isExpand
      height: @state.height
    else
      display: \none

  componentDidMount: ->
    @ace!

  render: ->
    DOM.div do
      key: "#{@props.id}-note-container"
      style: @styles.container
      createElement do
        Controller
        key: "#{@props.id}-note-controller"
        id: @props.id
        run: @run
        type: @state.type
        typeChange: @typeChange
        isExpand: @props.isExpand
        toggleExpand: @toggleExpand
      DOM.div do
        key: "#{@props.id}-note-body"
        id: "#{@props.id}-note-body"
        style: @editorStyle!
      createElement do
        Result
        key: "#{@props.id}-note-result"
        id: @props.id
        data: @props.result
        type: @state.type
