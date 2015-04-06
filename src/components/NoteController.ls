require! {
  react: {Component, DOM}
  \../adapters.config : config
}

module.exports = class NoteController extends Component
  (props)->
    @state =
      isExpand: props.isExpand

  displayName: \noteController
  styles:
    container:
      position: \relative
    select:
      marginRight: \.4em
    toggleExpand:
      position: \absolute
      right: \.8em
      font-size: \1.5em
      cursor: \pointer

  adapters: ->
    Object.keys config
      .map (key)~>
        DOM.option do
          key: "#{@props.id}-note-controller-select-#{key}"
          value: key
          config[key].name

  toggleExpand: ~>
    @setState do
      isExpand: !@state.isExpand
      ~> @props.toggleExpand!

  render: ->
    DOM.div do
      key: "#{@props.id}-note-controller-container"
      className: \pure-form
      style: @styles.container
      [
        DOM.select do
          key: "#{@props.id}-note-controller-select"
          style: @styles.select
          onChange: @props.typeChange
          defaultValue: @props.type
          @adapters!
        DOM.button do
          key: "#{@props.id}-note-controller-run"
          className: 'pure-button pure-button-primary'
          onClick: @props.run
          \▶Run
        DOM.i do
          key: "#{@props.id}-note-controller-expand"
          className: if @state.isExpand then 'fa fa-compress' else 'fa fa-expand'
          style: @styles.toggleExpand
          onClick: @toggleExpand
      ]
